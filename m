Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB7A2DE089
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 20:34:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3NAY9k0027763
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:34:09 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3NAYe55050290
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:34:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3NAYehT024048
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:34:40 -0600
Date: Thu, 23 Apr 2009 06:33:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: upstream tree build failure
Message-ID: <20090423103336.GA3825@zod.rchland.ibm.com>
References: <20090423160656.fac84e3f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090423160656.fac84e3f.sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 04:06:56PM +1000, Stephen Rothwell wrote:
>Hi all,
>
>[I am now using gcc version 4.4.0 ...]
>
>Today's linux-next build (powerpc ppc44x_defconfig) failed like this:
>
>arch/powerpc/mm/tlb_nohash_low.S:206:6: error: #elif with no expression
>
>Previous gcc versions didn't notice this because one of the preceding
>#ifs always evaluated to true.  I have applied the following patch for today.
>
>-- 
>Cheers,
>Stephen Rothwell                    sfr@canb.auug.org.au
>http://www.canb.auug.org.au/~sfr/
>
>From: Stephen Rothwell <sfr@canb.auug.org.au>
>Date: Thu, 23 Apr 2009 16:00:47 +1000
>Subject: [PATCH] powerpc: fix for long standing bug noticed by gcc 4.4.0
>
>Previous gcc versions didn't notice this because one of the preceding
>
>gcc 4.4.0 produced this error:
>
>arch/powerpc/mm/tlb_nohash_low.S:206:6: error: #elif with no expression
>
>Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Your changelog got truncated in the first sentence.  No big deal.

I have a gcc 4.4.0 system as well.  I'll try a bunch of various builds to see
if it catches anything else.  This fix looks good to me in the meantime.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh

>---
> arch/powerpc/mm/tlb_nohash_low.S |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
>index 45fed36..21e1b9a 100644
>--- a/arch/powerpc/mm/tlb_nohash_low.S
>+++ b/arch/powerpc/mm/tlb_nohash_low.S
>@@ -203,6 +203,6 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
> 	isync
> 1:	wrtee	r10
> 	blr
>-#elif
>+#else
> #error Unsupported processor type !
> #endif
