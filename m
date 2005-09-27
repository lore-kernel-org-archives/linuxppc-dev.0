Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 27 Sep 2005 23:15:34 +0200
To: Becky Bruce <bgill@freescale.com>
Message-ID: <20050927211534.GA32173@iram.es>
References: <Pine.LNX.4.61.0509271427090.21928@cde-tx32-ldt329.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0509271427090.21928@cde-tx32-ldt329.sps.mot.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merge byteorder.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 27, 2005 at 02:28:56PM -0500, Becky Bruce wrote:
> powerpc: Merge byteorder.h
> 
> Essentially adopts the 64-bit version of this file.  The 32-bit version had
> been using unsigned ints for arguments/return values that were actually
> only 16 bits - the new file uses __u16 for these items as in the 64-bit
> version of the header.  The order of some of the asm constraints
> in the 64-bit version was slightly different than the 32-bit version,
> but they produce identical code.  
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 
> ---
> commit 01344596fdecbe2b97e122b6a50570a19218cd2f
> tree ccdf20534198e69459d95f21b8f45aafc00e8238
> parent d407c9f3f6f3c84d9daec257f9a2550aacbd2892
> author Becky Bruce <becky.bruce@freescale.com> Tue, 27 Sep 2005 14:04:44 -0500
> committer Becky Bruce <becky.bruce@freescale.com> Tue, 27 Sep 2005 14:04:44 -0500
> 
>  include/asm-powerpc/byteorder.h |   89 +++++++++++++++++++++++++++++++++++++++
>  include/asm-ppc/byteorder.h     |   76 ---------------------------------
>  include/asm-ppc64/byteorder.h   |   86 --------------------------------------
>  3 files changed, 89 insertions(+), 162 deletions(-)
> 
> diff --git a/include/asm-powerpc/byteorder.h b/include/asm-powerpc/byteorder.h
> new file mode 100644
> --- /dev/null
> +++ b/include/asm-powerpc/byteorder.h
> @@ -0,0 +1,89 @@
> +#ifndef _ASM_POWERPC_BYTEORDER_H
> +#define _ASM_POWERPC_BYTEORDER_H
> +
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <asm/types.h>
> +#include <linux/compiler.h>
> +
> +#ifdef __GNUC__
> +#ifdef __KERNEL__
> +
> +static __inline__ __u16 ld_le16(const volatile __u16 *addr)
> +{
> +	__u16 val;
> +
> +	__asm__ __volatile__ ("lhbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
> +	return val;
> +}
> +
> +static __inline__ void st_le16(volatile __u16 *addr, const __u16 val)
> +{
> +	__asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
> +}
> +
> +static __inline__ __u32 ld_le32(const volatile __u32 *addr)
> +{
> +	__u32 val;
> +
> +	__asm__ __volatile__ ("lwbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
> +	return val;
> +}
> +
> +static __inline__ void st_le32(volatile __u32 *addr, const __u32 val)
> +{
> +	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
> +}
> +
> +static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
> +{
> +	__u16 result;
> +
> +	__asm__("rlwimi %0,%1,8,16,23"
> +	    : "=r" (result)
> +	    : "r" (value), "0" (value >> 8));
> +	return result;
> +}

This needs 2 registers where one is enough and often
adds a truncation to 16 bit of results in the generated
code. Consider instead:

	__u32 result;
	__asm__("	rlwimi %0,%0,16,8,15 # ??12->?212\n"
		: =r(result) : "0"(value));
	return (__u16)(result>>8);

GCC will combine the result>>8 with the truncation
to the lower sixteen bits, often saving one instruction.

This will likely generate worse code if you really need 
to keep both the original value and the swapped one, but 
this should not be the common case.

> +
> +static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
> +{
> +	__u32 result;
> +
> +	__asm__("rlwimi %0,%1,24,16,23\n\t"
> +	    "rlwimi %0,%1,8,8,15\n\t"
> +	    "rlwimi %0,%1,24,0,7"
> +	    : "=r" (result)
> +	    : "r" (value), "0" (value >> 24));
> +	return result;
> +}

That one can be improved too, in only needs one
rotlwi (rlwinm withou any mask) and 2 rlwimi:

__asm__("	rotlwi %0,%1,8 # 1234 -> 2341\n"
	"	rlwimi %0,%1,24,0,7          \n"
	"	rlwimi %0,%1,24,16,23        \n"
	: "=&r" (result) : r(value))

Notes:

- reformat as you like, but I prefer the tab at the
beginning of every line, otherwise the assembly output
does not look right. I always add a \n at the end
just in case (do all versions of GCC add it or not?).

- the earlyclobber (&) is really necessary otherwise
GCC might allocate the same register for input and
output for __arch_swab32.

What should really be implemented in GCC is a recognizer
for the manipulations that can easily be mapped to 
a single rlwimi instruction. But it is too complex
for the standard combiner IIRC. 

	Regards,
	Gabriel
