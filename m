Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F240C433C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:10:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B522619CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B522619CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97Y05zgPz3cMc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97XJ1l5Dz3bc7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97XH4lt3z9sWP; Wed, 31 Mar 2021 12:10:07 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20210219165648.2505482-1-bigeasy@linutronix.de>
References: <20210219165648.2505482-1-bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc/mm: Move the linear_mapping_mutex to the ifdef
 where it is used
Message-Id: <161715296468.226945.5751757638013929328.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 19 Feb 2021 17:56:48 +0100, Sebastian Andrzej Siewior wrote:
> The mutex linear_mapping_mutex is defined at the of the file while its
> only two user are within the CONFIG_MEMORY_HOTPLUG block.
> A compile without CONFIG_MEMORY_HOTPLUG set fails on PREEMPT_RT because
> its mutex implementation is smart enough to realize that it is unused.
> 
> Move the definition of linear_mapping_mutex to ifdef block where it is
> used.

Applied to powerpc/next.

[1/1] powerpc/mm: Move the linear_mapping_mutex to the ifdef where it is used
      https://git.kernel.org/powerpc/c/9be77e11dade414d2fa63750aa5c754fac49d619

cheers
