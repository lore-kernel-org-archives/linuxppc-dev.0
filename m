Return-Path: <sam.mj@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B5F61A0456
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 09:56:56 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.mj@au1.ibm.com>;
 Mon, 2 Nov 2015 08:56:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C78ED2BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 09:56:50 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA1Mugg2066022
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 09:56:50 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA1MuH4Y002767
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 09:56:18 +1100
Date: Mon, 2 Nov 2015 09:55:53 +1100
From: Sam Mendoza-Jonas <sam.mj@au1.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/3] ppc64: Avoid rfid if no need to clear MSR_LE
Message-ID: <20151101225553.GA1995@localhost.localdomain>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-2-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444172150-29493-2-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06, 2015 at 05:55:49PM -0500, Scott Wood wrote:
> Commit a304e2d82a8c3 ("ppc64: purgatory: Reset primary cpu endian to
> big-endian) changed bctr to rfid.  rfid is book3s-only and will cause a
> fatal exception on book3e.
> 
> Purgatory is an isolated environment which makes importing information
> about the subarch awkward, so instead rely on the fact that MSR_LE
> should never be set on book3e, and the rfid is only needed if MSR_LE is
> set (and thus needs to be cleared).  In theory that MSR bit is reserved
> on book3e, rather than zero, but in practice I have not seen it set.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> ---
> v2: new patch

Looks good to me, thanks for catching this!
I'll ping Michael too if you'd like his reviewed-by.

Reviewed-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

> 
>  purgatory/arch/ppc64/v2wrap.S | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
> index 179ade9..3534080 100644
> --- a/purgatory/arch/ppc64/v2wrap.S
> +++ b/purgatory/arch/ppc64/v2wrap.S
> @@ -116,9 +116,17 @@ master:
>  	stw	7,0x5c(4)	# and patch it into the kernel
>  	mr      3,16            # restore dt address
>  
> +	mfmsr	5
> +	andi.	10,5,1		# test MSR_LE
> +	bne	little_endian
> +
> +	li	5,0		# r5 will be 0 for kernel
> +	mtctr	4		# prepare branch to
> +	bctr			# start kernel
> +	
> +little_endian:			# book3s-only
>  	mtsrr0	4		# prepare branch to
>  
> -	mfmsr	5
>  	clrrdi	5,5,1		# clear MSR_LE
>  	mtsrr1	5
>  
> -- 
> 2.1.4
