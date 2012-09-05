Return-Path: <paulus@ozlabs.org>
Date: Wed, 5 Sep 2012 18:26:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V7 04/12] arch/powerpc: Convert virtual address to vpn
Message-ID: <20120905082629.GB22688@bloggs.ozlabs.ibm.com>
References: <1346749289-16986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346749289-16986-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346749289-16986-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2012 at 02:31:21PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This patch convert different functions to take virtual page number
> instead of virtual address. Virtual page number is virtual address
> shifted right by VPN_SHIFT (12) bits. This enable us to have an
> address range of upto 76 bits.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

A few comments below...

> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
> index 1c65a59..d3a1139 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -15,6 +15,10 @@
>  #include <asm/asm-compat.h>
>  #include <asm/page.h>
>  
> +#ifndef __ASSEMBLY__
> +#include <linux/bug.h>
> +#endif
> +

This is unnecessary, since you haven't added any BUG_ONs or WARN_ONs
in this file.

> @@ -233,13 +276,19 @@ static inline unsigned long hpt_va(unsigned long ea, unsigned long vsid,
>  static inline unsigned long hpt_hash(unsigned long va, unsigned int shift,
>  				     int ssize)
>  {
> +	int mask;
>  	unsigned long hash, vsid;
>  
> +	/* VPN_SHIFT can be atmost 12 */
>  	if (ssize == MMU_SEGSIZE_256M) {
> -		hash = (va >> 28) ^ ((va & 0x0fffffffUL) >> shift);
> +		mask = (1ul << (SID_SHIFT - VPN_SHIFT)) - 1;
> +		hash = ((va >> (SID_SHIFT - VPN_SHIFT)) & 0x0000007fffffffff) ^

You have added the "& 0x0000007fffffffff" part, which is unnecessary
since the result is anded with that same value before being returned.

> +			(((va & mask) >> (shift - VPN_SHIFT)) & 0xffff);

Similarly the "& 0xffff" is completely redundant, since you have anded
the va (really vpn) with the mask already.

>  	} else {
> -		vsid = va >> 40;
> -		hash = vsid ^ (vsid << 25) ^ ((va & 0xffffffffffUL) >> shift);
> +		mask = (1ul << (SID_SHIFT_1T - VPN_SHIFT)) - 1;
> +		vsid = va >> (SID_SHIFT_1T - VPN_SHIFT);
> +		hash = (vsid & 0xffffff) ^ ((vsid << 25) & 0x7fffffffff) ^

Here the "vsid & 0xffffff" is actually wrong, since the architecture
says that this term takes the whole VSID, not just the bottom 24 bits.
I realise you were copying what happened before, where the VSID was
restricted to 24 bits anyway because the VA was restricted to 64 bits,
but now that you are extending the VA size you need to include the
whole VSID.

As in the previous case, the "& 0x7fffffffff" part is redundant.

Also, it's very confusing to review this patch with variables called
"va" containing vpns.  It would actually be easier to review if you
combined this patch and the following one (that renames va to vpn).

> +			(((va & mask) >> (shift - VPN_SHIFT)) & 0xfffffff);

Once again the "& 0xfffffff" is redundant because the "& mask" has
already removed any bits that the second and would remove.

Paul.
