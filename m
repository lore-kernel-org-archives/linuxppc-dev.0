Return-Path: <ego@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9YKC37SvzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 00:26:23 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 19 May 2016 08:26:21 -0600
Date: Thu, 19 May 2016 19:54:56 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 paulus@ozlabs.org, linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 2/9] powerpc/kvm: make hypervisor state restore a
 function
Message-ID: <20160519142456.GA913@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-3-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160518062542.GB3939@in.ibm.com>
 <573C14CC.20307@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <573C14CC.20307@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On Wed, May 18, 2016 at 12:37:56PM +0530, Shreyas B Prabhu wrote:

[..snip..]
> >> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> >> index 7716ceb..7ebfbb0 100644
> >> --- a/arch/powerpc/kernel/exceptions-64s.S
> >> +++ b/arch/powerpc/kernel/exceptions-64s.S
> >> @@ -107,25 +107,8 @@ BEGIN_FTR_SECTION
> >>  	beq	9f
> >>
> >>  	cmpwi	cr3,r13,2
> >> +	bl	power7_restore_hyp_resource
> >>
> >> -	/*
> >> -	 * Check if last bit of HSPGR0 is set. This indicates whether we are
> >> -	 * waking up from winkle.
> >> -	 */
> >> -	GET_PACA(r13)
> >> -	clrldi	r5,r13,63
> >> -	clrrdi	r13,r13,1
> >> -	cmpwi	cr4,r5,1
> >> -	mtspr	SPRN_HSPRG0,r13
> >> -
> >> -	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
> >> -	cmpwi   cr2,r0,PNV_THREAD_NAP
> >> -	bgt     cr2,8f				/* Either sleep or Winkle */
> >> -
> >> -	/* Waking up from nap should not cause hypervisor state loss */
> >> -	bgt	cr3,.
> >> -
> >> -	/* Waking up from nap */
> >>  	li	r0,PNV_THREAD_RUNNING
> >>  	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
> >>
> >> @@ -143,13 +126,9 @@ BEGIN_FTR_SECTION
> >>
> >>  	/* Return SRR1 from power7_nap() */
> >>  	mfspr	r3,SPRN_SRR1
> >> -	beq	cr3,2f
> >> -	b	power7_wakeup_noloss
> >> -2:	b	power7_wakeup_loss
> >> -
> >> -	/* Fast Sleep wakeup on PowerNV */
> >> -8:	GET_PACA(r13)
> > 
> > In the old code, we do a GET_PACA(r13) before invoking the
> > power7_wakeup_tb_loss. In the new code we don't. Can you explain
> > this omission ?
> 
> GET_PACA(13) is the called in the beginning of
> power7_restore_hyp_resource. So r13 contains pointer to PACA when
> power7_wakeup_tb_loss invoked later in the same function.

Ah, I see it now. So the GET_PACA(r13) at 8: was anyway redundant in
the older code.

You can add my Reviewed-by: to this patch.

--
Thanks and Regards
gautham.
