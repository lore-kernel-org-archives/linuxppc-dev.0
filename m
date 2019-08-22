Return-Path: <SRS0=ljjX=WS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F261DC3A59D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 10:50:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C4F206DD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 10:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C4F206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DhCJ3YzlzDqXJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 20:50:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Dh6H3TKlzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 20:46:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46Dh6H28X6z9s3Z; Thu, 22 Aug 2019 20:46:31 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46Dh6H04Gkz9sNC; Thu, 22 Aug 2019 20:46:30 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 959c5d5134786b4988b6fdd08e444aa67d1667ed
In-Reply-To: <20190813100349.GD9567@blackberry>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 kvm@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2 1/3] KVM: PPC: Book3S HV: Fix race in re-enabling XIVE
 escalation interrupts
Message-Id: <46Dh6H04Gkz9sNC@ozlabs.org>
Date: Thu, 22 Aug 2019 20:46:30 +1000 (AEST)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-08-13 at 10:03:49 UTC, Paul Mackerras wrote:
> Escalation interrupts are interrupts sent to the host by the XIVE
> hardware when it has an interrupt to deliver to a guest VCPU but that
> VCPU is not running anywhere in the system.  Hence we disable the
> escalation interrupt for the VCPU being run when we enter the guest
> and re-enable it when the guest does an H_CEDE hypercall indicating
> it is idle.
> 
> It is possible that an escalation interrupt gets generated just as we
> are entering the guest.  In that case the escalation interrupt may be
> using a queue entry in one of the interrupt queues, and that queue
> entry may not have been processed when the guest exits with an H_CEDE.
> The existing entry code detects this situation and does not clear the
> vcpu->arch.xive_esc_on flag as an indication that there is a pending
> queue entry (if the queue entry gets processed, xive_esc_irq() will
> clear the flag).  There is a comment in the code saying that if the
> flag is still set on H_CEDE, we have to abort the cede rather than
> re-enabling the escalation interrupt, lest we end up with two
> occurrences of the escalation interrupt in the interrupt queue.
> 
> However, the exit code doesn't do that; it aborts the cede in the sense
> that vcpu->arch.ceded gets cleared, but it still enables the escalation
> interrupt by setting the source's PQ bits to 00.  Instead we need to
> set the PQ bits to 10, indicating that an interrupt has been triggered.
> We also need to avoid setting vcpu->arch.xive_esc_on in this case
> (i.e. vcpu->arch.xive_esc_on seen to be set on H_CEDE) because
> xive_esc_irq() will run at some point and clear it, and if we race with
> that we may end up with an incorrect result (i.e. xive_esc_on set when
> the escalation interrupt has just been handled).
> 
> It is extremely unlikely that having two queue entries would cause
> observable problems; theoretically it could cause queue overflow, but
> the CPU would have to have thousands of interrupts targetted to it for
> that to be possible.  However, this fix will also make it possible to
> determine accurately whether there is an unhandled escalation
> interrupt in the queue, which will be needed by the following patch.
> 
> Cc: stable@vger.kernel.org # v4.16+
> Fixes: 9b9b13a6d153 ("KVM: PPC: Book3S HV: Keep XIVE escalation interrupt masked unless ceded")
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/959c5d5134786b4988b6fdd08e444aa67d1667ed

cheers
