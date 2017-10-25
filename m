Return-Path: <srs0=9ens=by=au1.ibm.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMYmV2QRBzDqln
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:22:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yMYmV0SqVz8tBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:22:50 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yMYmT3vY5z9t2c
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2017 02:22:48 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9PFHFgO007491
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2017 11:22:46 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dtua6f997-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2017 11:22:46 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <npiggin@au1.ibm.com>;
 Wed, 25 Oct 2017 16:22:44 +0100
Date: Thu, 26 Oct 2017 01:22:37 +1000
From: Nicholas Piggin <npiggin@au1.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH] powerpc: Fix check for copy/paste instructions in
 alignment handler
In-Reply-To: <OFF18C8ACF.135B0A8D-ON002581C4.002803F5@notes.na.collabserv.com>
References: <OFF18C8ACF.135B0A8D-ON002581C4.002803F5@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20171026012237.0320e540@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 25 Oct 2017 18:16:53 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> Commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
> when possible", 2017-06-09) changed the definition of PPC_INST_COPY
> and in so doing inadvertently broke the check for copy/paste
> instructions in the alignment fault handler.  The check currently
> matches no instructions.
> 
> This fixes it by ANDing both sides of the comparison with the mask.

Thanks for fixing it. Any reason not to change the mask to 0xfc2006fe
to include the 'last' bit that is now mandatory?

Thanks,
Nick

> 
> Fixes: 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
> when possible")
> Reported-by: Markus Trippelsdorf <markus@trippelsdorf.de>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
> Should go to 4.13 stable as well, and will probably apply there
> with fuzz.
> 
>  arch/powerpc/kernel/align.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index 43ef251..3e6c074 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -332,7 +332,7 @@ int fix_alignment(struct pt_regs *regs)
>  	 * when pasting to a co-processor. Furthermore, paste_last is the
>  	 * synchronisation point for preceding copy/paste sequences.
>  	 */
> -	if ((instr & 0xfc0006fe) == PPC_INST_COPY)
> +	if ((instr & 0xfc0006fe) == (PPC_INST_COPY & 0xfc0006fe))
>  		return -EIO;
>  
>  	r = analyse_instr(&op, regs, instr);
