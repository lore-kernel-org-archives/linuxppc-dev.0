Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id D0FD8DE1EE
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 12:30:05 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so216870anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 19:30:04 -0700 (PDT)
Message-ID: <fa686aa40804181930s724b2e11we01943236ec0b8a7@mail.gmail.com>
Date: Fri, 18 Apr 2008 20:30:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/2] [v3][POWERPC] refactor dcr code
In-Reply-To: <20080418215513.ACA0C17F007A@mail131-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1206914576.10388.132.camel@pasglop>
	<20080418215513.ACA0C17F007A@mail131-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 3:55 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> Previously, dcr support was configured at compile time to either using
>  MMIO or native dcr instructions.  Although this works for most
>  platforms, it fails on FPGA platforms:
>
>  1) Systems may include more than one dcr bus.
>  2) Systems may be native dcr capable and still use memory mapped dcr interface.
>
>  This patch provides runtime support based on the device trees for the
>  case where CONFIG_PPC_DCR_MMIO and CONFIG_PPC_DCR_NATIVE are both
>  selected.  Previously, this was a poorly defined configuration, which
>  happened to provide NATIVE support.  The runtime selection is made
>  based on the dcr controller having a 'dcr-access-method' attribute
>
> in the device tree.  If only one of the above options is selected,
>  then the code uses #defines to select only the used code in order to
>  avoid introducing overhead in existing usage.

I'm not really qualified to ack this patch, but it looks right to me;
except for one comment below (sorry I didn't get to looking at this
earlier).


>  diff --git a/include/asm-powerpc/dcr.h b/include/asm-powerpc/dcr.h
>  index 9338d50..6b86322 100644
>  --- a/include/asm-powerpc/dcr.h
>  +++ b/include/asm-powerpc/dcr.h
>  @@ -20,14 +20,47 @@
>   #ifndef _ASM_POWERPC_DCR_H
>   #define _ASM_POWERPC_DCR_H
>   #ifdef __KERNEL__
>  +#ifndef __ASSEMBLY__
>   #ifdef CONFIG_PPC_DCR
>
>   #ifdef CONFIG_PPC_DCR_NATIVE
>   #include <asm/dcr-native.h>
>  -#else
>  +#endif
>  +
>  +#ifdef CONFIG_PPC_DCR_MMIO
>   #include <asm/dcr-mmio.h>
>   #endif
>
>  +#if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
>  +
>  +#include <asm/dcr-generic.h>
>  +
>  +#define DCR_MAP_OK(host)       dcr_map_ok_generic(host)
>  +#define dcr_map(dev, dcr_n, dcr_c) dcr_map_generic(dev, dcr_n, dcr_c)
>  +#define dcr_unmap(host, dcr_c) dcr_unmap_generic(host, dcr_c)
>  +#define dcr_read(host, dcr_n) dcr_read_generic(host, dcr_n)
>  +#define dcr_write(host, dcr_n, value) dcr_write_generic(host, dcr_n, value)
>  +
>  +#else
>  +
>  +#ifdef CONFIG_PPC_DCR_NATIVE
>  +typedef dcr_host_native_t dcr_host_t;
>  +#define DCR_MAP_OK(host)       dcr_map_ok_native(host)
>  +#define dcr_map(dev, dcr_n, dcr_c) dcr_map_native(dev, dcr_n, dcr_c)
>  +#define dcr_unmap(host, dcr_c) dcr_unmap_native(host, dcr_c)
>  +#define dcr_read(host, dcr_n) dcr_read_native(host, dcr_n)
>  +#define dcr_write(host, dcr_n, value) dcr_write_native(host, dcr_n, value)
>  +#else
>  +typedef dcr_host_mmio_t dcr_host_t;
>  +#define DCR_MAP_OK(host)       dcr_map_ok_mmio(host)
>  +#define dcr_map(dev, dcr_n, dcr_c) dcr_map_mmio(dev, dcr_n, dcr_c)
>  +#define dcr_unmap(host, dcr_c) dcr_unmap_mmio(host, dcr_c)
>  +#define dcr_read(host, dcr_n) dcr_read_mmio(host, dcr_n)
>  +#define dcr_write(host, dcr_n, value) dcr_write_mmio(host, dcr_n, value)
>  +#endif
>  +
>  +#endif /* defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO) */
>  +

By current conventions; these should probably be static functions (but
don't make them inline).  The compiler will do the right thing with
them.  Functions are easier to validate by the compiler and sparse
than #defines.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
