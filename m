Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-11.online-age.net (ext-nj2ut-11.online-age.net
	[64.14.54.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DEF08DDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 21:10:28 +1100 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-11.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n1GAAHq6000480
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 05:10:17 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n1GAADgH007779
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 05:10:17 -0500
Message-ID: <49993BA5.8080104@gefanuc.com>
Date: Mon, 16 Feb 2009 10:10:45 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix _PAGE_COHERENT support on classic ppc32 HW
References: <1234299466-17300-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1234299466-17300-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> The following commit:
> 
> commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Thu Dec 18 19:13:51 2008 +0000
> 
>     powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED
> 
> broke setting of the _PAGE_COHERENT bit in the PPC HW PTE.  Since we now
> actually set _PAGE_COHERENT in the Linux PTE we shouldn't be clearing it
> out before we propogate it to the PPC HW PTE.
> 
> Reported-by: Martyn Welch <martyn.welch@gefanuc.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/mm/hash_low_32.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
> index 67850ec..14af8ce 100644
> --- a/arch/powerpc/mm/hash_low_32.S
> +++ b/arch/powerpc/mm/hash_low_32.S
> @@ -320,7 +320,7 @@ _GLOBAL(create_hpte)
>  	and	r8,r8,r0		/* writable if _RW & _DIRTY */
>  	rlwimi	r5,r5,32-1,30,30	/* _PAGE_USER -> PP msb */
>  	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
> -	ori	r8,r8,0xe14		/* clear out reserved bits and M */
> +	ori	r8,r8,0xe04		/* clear out reserved bits */
>  	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
>  BEGIN_FTR_SECTION
>  	rlwinm	r8,r8,0,~_PAGE_COHERENT	/* clear M (coherence not required) */

This does indeed resolve the problem I was having.

Sorry for not replying sooner - bad weather here in the UK unexpectedly extended a planned holiday.

Thank you for resolving this issue,

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
