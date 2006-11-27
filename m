Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id BE3B667CD7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:56:58 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/9] [POWERPC] move Efika support files into platforms/52xx
Date: Mon, 27 Nov 2006 22:56:43 +0100
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622073115-git-send-email-grant.likely@secretlab.ca>
	<11646622072999-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11646622072999-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611272256.44623.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 November 2006 22:16, Grant Likely wrote:
> +#ifdef CONFIG_PCI
> +/*
> + * Access functions for PCI config space using RTAS calls.
> + */
> +static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int=
 offset,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0int len, u32 * val)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct pci_controller *hose =3D bus->sysdata;
> +=A0=A0=A0=A0=A0=A0=A0unsigned long addr =3D (offset & 0xff) | ((devfn & =
0xff) << 8)
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0| (((bus->number - hose->first_busno) & 0xf=
f) << 16)
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0| (hose->index << 24);
> +=A0=A0=A0=A0=A0=A0=A0int ret =3D -1;
> +=A0=A0=A0=A0=A0=A0=A0int rval;
> +
> +=A0=A0=A0=A0=A0=A0=A0rval =3D rtas_call(rtas_token("read-pci-config"), 2=
, 2, &ret, addr, len);
> +=A0=A0=A0=A0=A0=A0=A0*val =3D ret;
> +=A0=A0=A0=A0=A0=A0=A0return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SU=
CCESSFUL;
> +}
> +
> +static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 int offset, int len, u32 val)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct pci_controller *hose =3D bus->sysdata;
> +=A0=A0=A0=A0=A0=A0=A0unsigned long addr =3D (offset & 0xff) | ((devfn & =
0xff) << 8)
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0| (((bus->number - hose->first_busno) & 0xf=
f) << 16)
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0| (hose->index << 24);
> +=A0=A0=A0=A0=A0=A0=A0int rval;
> +
> +=A0=A0=A0=A0=A0=A0=A0rval =3D rtas_call(rtas_token("write-pci-config"), =
3, 1, NULL,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ad=
dr, len, val);
> +=A0=A0=A0=A0=A0=A0=A0return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SU=
CCESSFUL;
> +}
> +

I know you're only moving this code, but shouldn't this really use the
code from arch/powerpc/kernel/rtas_pci.c? If it doesn't work out of
the box, I guess we should rather split out the pseries specific
bits from it and make the common parts more generic.

	Arnd <><
