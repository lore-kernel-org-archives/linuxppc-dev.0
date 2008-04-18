Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 87BB7DE3C7
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 07:50:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/5] [v2][POWERPC] refactor dcr code
Date: Fri, 18 Apr 2008 14:49:58 -0700
In-reply-to: <1206914576.10388.132.camel@pasglop>
References: <1206401313-1625-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080328162616.61AEF15006B@mail199-sin.bigfish.com>
	<1206914576.10388.132.camel@pasglop>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <benh@kernel.crashing.org>
Message-Id: <20080418215000.38B12250051@mail200-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ben,

I'd like to get the first two patches tested and queued up for mainline
(although it's probably too late for this merge window, I suppose).  I'm
going to punt on the ppc patches and put off fixing the tft driver until
ARCH=3Dppc goes away.

I've fixed a typo in patch description: The dcr-access-method attribute
is on the dcr-controller, not the dcr slave.

Steve

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Sunday, March 30, 2008 3:03 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/5] [v2][POWERPC] refactor dcr code
>=20
>=20
> On Fri, 2008-03-28 at 09:23 -0700, Stephen Neuendorffer wrote:
> > Previously, dcr support was configured at compile time to either
using
> > MMIO or native dcr instructions.  Although this works for most
> > platforms, it fails on FPGA platforms:
> >
> > 1) Systems may include more than one dcr bus.
> > 2) Systems may be native dcr capable and still use memory mapped dcr
interface.
> >
> > This patch provides runtime support based on the device trees for
the
> > case where CONFIG_PPC_DCR_MMIO and CONFIG_PPC_DCR_NATIVE are both
> > selected.  Previously, this was a poorly defined configuration,
which
> > happened to provide NATIVE support.  The runtime selection is made
> > based on the dcr slave device having a 'dcr-access-method' attribute
> > in the device tree.  If only one of the above options is selected,
> > then the code uses #defines to select only the used code in order to
> > avoid interoducing overhead in existing usage.
> >
> > Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
>=20
> Looks good. Haven't had a chance to test it yet, but tentatively
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Initially, I thought about using function pointers but the if/else
will
> probably end up being more efficient. The only thing maybe to ponder
> is whether we could avoid the dcr-generic.h file completely, and have
> the generic wrappers be inline, though considering how slow DCRs are,
> it may not be that useful in practice and less clean...
>=20
> Cheers,
> Ben.
>=20
>=20
> > ---
> >  arch/powerpc/sysdev/dcr.c         |   91
++++++++++++++++++++++++++++++++-----
> >  include/asm-powerpc/dcr-generic.h |   49 ++++++++++++++++++++
> >  include/asm-powerpc/dcr-mmio.h    |   20 +++++---
> >  include/asm-powerpc/dcr-native.h  |   16 ++++---
> >  include/asm-powerpc/dcr.h         |   36 ++++++++++++++-
> >  5 files changed, 186 insertions(+), 26 deletions(-)
> >  create mode 100644 include/asm-powerpc/dcr-generic.h
> >
> > diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
> > index 437e48d..d3de0ff 100644
> > --- a/arch/powerpc/sysdev/dcr.c
> > +++ b/arch/powerpc/sysdev/dcr.c
> > @@ -23,6 +23,68 @@
> >  #include <asm/prom.h>
> >  #include <asm/dcr.h>
> >
> > +#if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
> > +
> > +bool dcr_map_ok_generic(dcr_host_t host)
> > +{
> > +	if (host.type =3D=3D INVALID)
> > +		return 0;
> > +	else if (host.type =3D=3D NATIVE)
> > +		return dcr_map_ok_native(host.host.native);
> > +	else
> > +		return dcr_map_ok_mmio(host.host.mmio);
> > +}
> > +EXPORT_SYMBOL_GPL(dcr_map_ok_generic);
> > +
> > +dcr_host_t dcr_map_generic(struct device_node *dev,
> > +			   unsigned int dcr_n,
> > +			   unsigned int dcr_c)
> > +{
> > +	dcr_host_t host;
> > +	const char *prop =3D of_get_property(dev, "dcr-access-method",
NULL);
> > +
> > +	if (!strcmp(prop, "native")) {
> > +		host.type =3D NATIVE;
> > +		host.host.native =3D dcr_map_native(dev, dcr_n, dcr_c);
> > +	} else if (!strcmp(prop, "mmio")) {
> > +		host.type =3D MMIO;
> > +		host.host.mmio =3D dcr_map_mmio(dev, dcr_n, dcr_c);
> > +	} else
> > +		host.type =3D INVALID;
> > +
> > +	return host;
> > +}
> > +EXPORT_SYMBOL_GPL(dcr_map_generic);
> > +
> > +void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c)
> > +{
> > +	if (host.type =3D=3D NATIVE)
> > +		dcr_unmap_native(host.host.native, dcr_c);
> > +	else
> > +		dcr_unmap_mmio(host.host.mmio, dcr_c);
> > +}
> > +EXPORT_SYMBOL_GPL(dcr_unmap_generic);
> > +
> > +u32 dcr_read_generic(dcr_host_t host, unsigned int dcr_n)
> > +{
> > +	if (host.type =3D=3D NATIVE)
> > +		return dcr_read_native(host.host.native, dcr_n);
> > +	else
> > +		return dcr_read_mmio(host.host.mmio, dcr_n);
> > +}
> > +EXPORT_SYMBOL_GPL(dcr_read_generic);
> > +
> > +void dcr_write_generic(dcr_host_t host, unsigned int dcr_n, u32
value)
> > +{
> > +	if (host.type =3D=3D NATIVE)
> > +		dcr_write_native(host.host.native, dcr_n, value);
> > +	else
> > +		dcr_write_mmio(host.host.mmio, dcr_n, value);
> > +}
> > +EXPORT_SYMBOL_GPL(dcr_write_generic);
> > +
> > +#endif /* defined(CONFIG_PPC_DCR_NATIVE) &&
defined(CONFIG_PPC_DCR_MMIO) */
> > +
> >  unsigned int dcr_resource_start(struct device_node *np, unsigned
int index)
> >  {
> >  	unsigned int ds;
> > @@ -47,7 +109,7 @@ unsigned int dcr_resource_len(struct device_node
*np, unsigned int index)
> >  }
> >  EXPORT_SYMBOL_GPL(dcr_resource_len);
> >
> > -#ifndef CONFIG_PPC_DCR_NATIVE
> > +#ifdef CONFIG_PPC_DCR_MMIO
> >
> >  static struct device_node * find_dcr_parent(struct device_node *
node)
> >  {
> > @@ -101,18 +163,19 @@ u64 of_translate_dcr_address(struct
device_node *dev,
> >  	return ret;
> >  }
> >
> > -dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
> > -		   unsigned int dcr_c)
> > +dcr_host_mmio_t dcr_map_mmio(struct device_node *dev,
> > +			     unsigned int dcr_n,
> > +			     unsigned int dcr_c)
> >  {
> > -	dcr_host_t ret =3D { .token =3D NULL, .stride =3D 0, .base =3D =
dcr_n };
> > +	dcr_host_mmio_t ret =3D { .token =3D NULL, .stride =3D 0, .base =
=3D
dcr_n };
> >  	u64 addr;
> >
> >  	pr_debug("dcr_map(%s, 0x%x, 0x%x)\n",
> >  		 dev->full_name, dcr_n, dcr_c);
> >
> >  	addr =3D of_translate_dcr_address(dev, dcr_n, &ret.stride);
> > -	pr_debug("translates to addr: 0x%lx, stride: 0x%x\n",
> > -		 addr, ret.stride);
> > +	pr_debug("translates to addr: 0x%llx, stride: 0x%x\n",
> > +		 (unsigned long long) addr, ret.stride);
> >  	if (addr =3D=3D OF_BAD_ADDR)
> >  		return ret;
> >  	pr_debug("mapping 0x%x bytes\n", dcr_c * ret.stride);
> > @@ -124,11 +187,11 @@ dcr_host_t dcr_map(struct device_node *dev,
unsigned int dcr_n,
> >  	ret.token -=3D dcr_n * ret.stride;
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(dcr_map);
> > +EXPORT_SYMBOL_GPL(dcr_map_mmio);
> >
> > -void dcr_unmap(dcr_host_t host, unsigned int dcr_c)
> > +void dcr_unmap_mmio(dcr_host_mmio_t host, unsigned int dcr_c)
> >  {
> > -	dcr_host_t h =3D host;
> > +	dcr_host_mmio_t h =3D host;
> >
> >  	if (h.token =3D=3D NULL)
> >  		return;
> > @@ -136,7 +199,11 @@ void dcr_unmap(dcr_host_t host, unsigned int
dcr_c)
> >  	iounmap(h.token);
> >  	h.token =3D NULL;
> >  }
> > -EXPORT_SYMBOL_GPL(dcr_unmap);
> > -#else	/* defined(CONFIG_PPC_DCR_NATIVE) */
> > +EXPORT_SYMBOL_GPL(dcr_unmap_mmio);
> > +
> > +#endif /* defined(CONFIG_PPC_DCR_MMIO) */
> > +
> > +#ifdef CONFIG_PPC_DCR_NATIVE
> >  DEFINE_SPINLOCK(dcr_ind_lock);
> > -#endif	/* !defined(CONFIG_PPC_DCR_NATIVE) */
> > +#endif	/* defined(CONFIG_PPC_DCR_NATIVE) */
> > +
> > diff --git a/include/asm-powerpc/dcr-generic.h
b/include/asm-powerpc/dcr-generic.h
> > new file mode 100644
> > index 0000000..0ee74fb
> > --- /dev/null
> > +++ b/include/asm-powerpc/dcr-generic.h
> > @@ -0,0 +1,49 @@
> > +/*
> > + * (c) Copyright 2006 Benjamin Herrenschmidt, IBM Corp.
> > + *                    <benh@kernel.crashing.org>
> > + *
> > + *   This program is free software;  you can redistribute it and/or
modify
> > + *   it under the terms of the GNU General Public License as
published by
> > + *   the Free Software Foundation; either version 2 of the License,
or
> > + *   (at your option) any later version.
> > + *
> > + *   This program is distributed in the hope that it will be
useful,
> > + *   but WITHOUT ANY WARRANTY;  without even the implied warranty
of
> > + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > + *   the GNU General Public License for more details.
> > + *
> > + *   You should have received a copy of the GNU General Public
License
> > + *   along with this program;  if not, write to the Free Software
> > + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA
> > + */
> > +
> > +#ifndef _ASM_POWERPC_DCR_GENERIC_H
> > +#define _ASM_POWERPC_DCR_GENERIC_H
> > +#ifdef __KERNEL__
> > +#ifndef __ASSEMBLY__
> > +
> > +enum host_type_t {MMIO, NATIVE, INVALID};
> > +
> > +typedef struct {
> > +	enum host_type_t type;
> > +	union {
> > +		dcr_host_mmio_t mmio;
> > +		dcr_host_native_t native;
> > +	} host;
> > +} dcr_host_t;
> > +
> > +extern bool dcr_map_ok_generic(dcr_host_t host);
> > +
> > +extern dcr_host_t dcr_map_generic(struct device_node *dev, unsigned
int dcr_n,
> > +			  unsigned int dcr_c);
> > +extern void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c);
> > +
> > +extern u32 dcr_read_generic(dcr_host_t host, unsigned int dcr_n);
> > +
> > +extern void dcr_write_generic(dcr_host_t host, unsigned int dcr_n,
u32 value);
> > +
> > +#endif /* __ASSEMBLY__ */
> > +#endif /* __KERNEL__ */
> > +#endif /* _ASM_POWERPC_DCR_GENERIC_H */
> > +
> > +
> > diff --git a/include/asm-powerpc/dcr-mmio.h
b/include/asm-powerpc/dcr-mmio.h
> > index 08532ff..acd491d 100644
> > --- a/include/asm-powerpc/dcr-mmio.h
> > +++ b/include/asm-powerpc/dcr-mmio.h
> > @@ -27,20 +27,26 @@ typedef struct {
> >  	void __iomem *token;
> >  	unsigned int stride;
> >  	unsigned int base;
> > -} dcr_host_t;
> > +} dcr_host_mmio_t;
> >
> > -#define DCR_MAP_OK(host)	((host).token !=3D NULL)
> > +static inline bool dcr_map_ok_mmio(dcr_host_mmio_t host)
> > +{
> > +	return host.token !=3D NULL;
> > +}
> >
> > -extern dcr_host_t dcr_map(struct device_node *dev, unsigned int
dcr_n,
> > -			  unsigned int dcr_c);
> > -extern void dcr_unmap(dcr_host_t host, unsigned int dcr_c);
> > +extern dcr_host_mmio_t dcr_map_mmio(struct device_node *dev,
> > +				    unsigned int dcr_n,
> > +				    unsigned int dcr_c);
> > +extern void dcr_unmap_mmio(dcr_host_mmio_t host, unsigned int
dcr_c);
> >
> > -static inline u32 dcr_read(dcr_host_t host, unsigned int dcr_n)
> > +static inline u32 dcr_read_mmio(dcr_host_mmio_t host, unsigned int
dcr_n)
> >  {
> >  	return in_be32(host.token + ((host.base + dcr_n) *
host.stride));
> >  }
> >
> > -static inline void dcr_write(dcr_host_t host, unsigned int dcr_n,
u32 value)
> > +static inline void dcr_write_mmio(dcr_host_mmio_t host,
> > +				  unsigned int dcr_n,
> > +				  u32 value)
> >  {
> >  	out_be32(host.token + ((host.base + dcr_n) * host.stride),
value);
> >  }
> > diff --git a/include/asm-powerpc/dcr-native.h
b/include/asm-powerpc/dcr-native.h
> > index be6c879..67832e5 100644
> > --- a/include/asm-powerpc/dcr-native.h
> > +++ b/include/asm-powerpc/dcr-native.h
> > @@ -26,14 +26,18 @@
> >
> >  typedef struct {
> >  	unsigned int base;
> > -} dcr_host_t;
> > +} dcr_host_native_t;
> >
> > -#define DCR_MAP_OK(host)	(1)
> > +static inline bool dcr_map_ok_native(dcr_host_native_t host)
> > +{
> > +	return 1;
> > +}
> >
> > -#define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){ .base =3D (dcr_n)
})
> > -#define dcr_unmap(host, dcr_c)		do {} while (0)
> > -#define dcr_read(host, dcr_n)		mfdcr(dcr_n + host.base)
> > -#define dcr_write(host, dcr_n, value)	mtdcr(dcr_n + host.base,
value)
> > +#define dcr_map_native(dev, dcr_n, dcr_c) \
> > +	((dcr_host_native_t){ .base =3D (dcr_n) })
> > +#define dcr_unmap_native(host, dcr_c)		do {} while (0)
> > +#define dcr_read_native(host, dcr_n)		mfdcr(dcr_n +
host.base)
> > +#define dcr_write_native(host, dcr_n, value)	mtdcr(dcr_n +
host.base, value)
> >
> >  /* Device Control Registers */
> >  void __mtdcr(int reg, unsigned int val);
> > diff --git a/include/asm-powerpc/dcr.h b/include/asm-powerpc/dcr.h
> > index 9338d50..6b86322 100644
> > --- a/include/asm-powerpc/dcr.h
> > +++ b/include/asm-powerpc/dcr.h
> > @@ -20,14 +20,47 @@
> >  #ifndef _ASM_POWERPC_DCR_H
> >  #define _ASM_POWERPC_DCR_H
> >  #ifdef __KERNEL__
> > +#ifndef __ASSEMBLY__
> >  #ifdef CONFIG_PPC_DCR
> >
> >  #ifdef CONFIG_PPC_DCR_NATIVE
> >  #include <asm/dcr-native.h>
> > -#else
> > +#endif
> > +
> > +#ifdef CONFIG_PPC_DCR_MMIO
> >  #include <asm/dcr-mmio.h>
> >  #endif
> >
> > +#if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
> > +
> > +#include <asm/dcr-generic.h>
> > +
> > +#define DCR_MAP_OK(host)	dcr_map_ok_generic(host)
> > +#define dcr_map(dev, dcr_n, dcr_c) dcr_map_generic(dev, dcr_n,
dcr_c)
> > +#define dcr_unmap(host, dcr_c) dcr_unmap_generic(host, dcr_c)
> > +#define dcr_read(host, dcr_n) dcr_read_generic(host, dcr_n)
> > +#define dcr_write(host, dcr_n, value) dcr_write_generic(host,
dcr_n, value)
> > +
> > +#else
> > +
> > +#ifdef CONFIG_PPC_DCR_NATIVE
> > +typedef dcr_host_native_t dcr_host_t;
> > +#define DCR_MAP_OK(host)	dcr_map_ok_native(host)
> > +#define dcr_map(dev, dcr_n, dcr_c) dcr_map_native(dev, dcr_n,
dcr_c)
> > +#define dcr_unmap(host, dcr_c) dcr_unmap_native(host, dcr_c)
> > +#define dcr_read(host, dcr_n) dcr_read_native(host, dcr_n)
> > +#define dcr_write(host, dcr_n, value) dcr_write_native(host, dcr_n,
value)
> > +#else
> > +typedef dcr_host_mmio_t dcr_host_t;
> > +#define DCR_MAP_OK(host)	dcr_map_ok_mmio(host)
> > +#define dcr_map(dev, dcr_n, dcr_c) dcr_map_mmio(dev, dcr_n, dcr_c)
> > +#define dcr_unmap(host, dcr_c) dcr_unmap_mmio(host, dcr_c)
> > +#define dcr_read(host, dcr_n) dcr_read_mmio(host, dcr_n)
> > +#define dcr_write(host, dcr_n, value) dcr_write_mmio(host, dcr_n,
value)
> > +#endif
> > +
> > +#endif /* defined(CONFIG_PPC_DCR_NATIVE) &&
defined(CONFIG_PPC_DCR_MMIO) */
> > +
> >  /*
> >   * On CONFIG_PPC_MERGE, we have additional helpers to read the DCR
> >   * base from the device-tree
> > @@ -41,5 +74,6 @@ extern unsigned int dcr_resource_len(struct
device_node *np,
> >  #endif /* CONFIG_PPC_MERGE */
> >
> >  #endif /* CONFIG_PPC_DCR */
> > +#endif /* __ASSEMBLY__ */
> >  #endif /* __KERNEL__ */
> >  #endif /* _ASM_POWERPC_DCR_H */
>=20
