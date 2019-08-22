Return-Path: <SRS0=ljjX=WS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264CDC3A59D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 10:48:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A24206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 10:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A24206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Dh8v3tTZzDrVT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 20:48:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Dh6H1YX4zDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 20:46:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46Dh6F6clVz9sN6; Thu, 22 Aug 2019 20:46:29 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 237aed48c642328ff0ab19b63423634340224a06
In-Reply-To: <20190806172538.5087-1-clg@kaod.org>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: XIVE: Free escalation interrupts
 before disabling the VP
Message-Id: <46Dh6F6clVz9sN6@ozlabs.org>
Date: Thu, 22 Aug 2019 20:46:29 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 =?utf-8?q?C=C3=A9dric_Le?= =?utf-8?q?_Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-08-06 at 17:25:38 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> When a vCPU is brought done, the XIVE VP is first disabled and then
> the event notification queues are freed. When freeing the queues, we
> check for possible escalation interrupts and free them also.
> 
> But when a XIVE VP is disabled, the underlying XIVE ENDs also are
> disabled in OPAL. When an END is disabled, its ESB pages (ESn and ESe)
> are disabled and loads return all 1s. Which means that any access on
> the ESB page of the escalation interrupt will return invalid values.
> 
> When an interrupt is freed, the shutdown handler computes a 'saved_p'
> field from the value returned by a load in xive_do_source_set_mask().
> This value is incorrect for escalation interrupts for the reason
> described above.
> 
> This has no impact on Linux/KVM today because we don't make use of it
> but we will introduce in future changes a xive_get_irqchip_state()
> handler. This handler will use the 'saved_p' field to return the state
> of an interrupt and 'saved_p' being incorrect, softlockup will occur.
> 
> Fix the vCPU cleanup sequence by first freeing the escalation
> interrupts if any, then disable the XIVE VP and last free the queues.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/237aed48c642328ff0ab19b63423634340224a06

cheers
