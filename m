Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E6C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 05:43:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EB721470
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 05:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phOpZDY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EB721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qhdj4HLvzF37w
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 15:43:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="phOpZDY2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.25; helo=wout2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="phOpZDY2"; dkim-atps=neutral
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qhb26jJBzF37w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 15:41:33 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 5714EE07;
 Thu,  4 Oct 2018 01:41:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 04 Oct 2018 01:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=8Eue8LxYnAwzRT9P69MQZVBIyDtR1p/Ui513fo9uF
 Og=; b=phOpZDY2P7ZYA8qu4wTADYcOCtzuWwremDFYOuQSqvygZ+JbfakCnJkXv
 kSMciYPmZ64ZdpbadqibFrraF3zwWv4PNHMZgQs9uw/lSW3I6ieQC2f3PPg16ajW
 NjfqjYuxnVpWsBmHfVSiLShojzsm8SQKaTXhAdo6AlDar+Ms3y2jgxMpq+1eWdSM
 HWxsTfNeKm9JZUrC6hdQqjjkyjdfci4UsTlAX6dxmR8WKBhvN4BhQR55eKU+OJdm
 LL/pGvqbvG8HMumjGrADpaeVQTc7GIk5n0fkblSGCFCljnAGefFA0rC4RArYzNeH
 qqvL9epdozl3gsulDTGCZWXI0fE+A==
X-ME-Sender: <xms:Bai1W3wmr6XJpKYiZOU9U9iCwiAdiGYJeZJOq622w68ookhXsaXdAQ>
X-ME-Proxy: <xmx:Bai1W_1YDH4K-yNeRgzopvqMl7qSoq8zxdqbhh6c0CnZpb_XW-Ro1g>
 <xmx:Bai1W1CPVEfutAYDw3Uz5VE4-n0mWX5Xb_wG-HBxZwfx60r46iUi4Q>
 <xmx:Bai1W083coeKKuzaQhWZvZSqO9feOiga8BkVx5fEBguvJCyi3bg12Q>
 <xmx:Bai1W7--3Oza7psQLTukZzjuNawf_GT0ZGpIMVjnqvSuxasTDV8Dww>
 <xmx:Bai1W83Fz8HEYwm1wc4NOie5Mezi2RK0F3CcMvNnayyTSJMVNbtBNA>
 <xmx:Bqi1W_WJ3OuH6JbmjfTwiSOkSj6KU_-BgiM9v8W7zb9Xv3V94-QBjA>
Received: from snap.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 00A9E102D7;
 Thu,  4 Oct 2018 01:41:22 -0400 (EDT)
Message-ID: <32bd00f1b50f77f7c58972d72e8459a72317204b.camel@russell.cc>
Subject: Re: [PATCH] powerpc: Add doorbell tracepoints
From: Russell Currey <ruscur@russell.cc>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org, 
 paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com
In-Reply-To: <20181003002957.7711-1-anton@ozlabs.org>
References: <20181003002957.7711-1-anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Oct 2018 15:41:19 +1000
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-03 at 10:29 +1000, Anton Blanchard wrote:
> When analysing sources of OS jitter, I noticed that doorbells cannot be
> traced.
> 
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Hi Anton,

snowpatch builds failed for this patch on all 64-bit configurations (ppc64e, ppc64
and ppc64le) with the following:

arch/powerpc/kernel/dbell.c:85:9: error: undefined identifier
'trace_doorbell_entry'
arch/powerpc/kernel/dbell.c:96:9: error: undefined identifier
'trace_doorbell_exit'
./arch/powerpc/include/asm/spinlock.h:171:9: warning: context imbalance in
'key_user_put' - unexpected unlock
arch/powerpc/kernel/dbell.c: In function 'doorbell_exception':
arch/powerpc/kernel/dbell.c:85:2: error: implicit declaration of function
'trace_doorbell_entry'; did you mean 'trace_irq_entry'? [-Werror=implicit-
function-declaration]
  trace_doorbell_entry(regs);
  ^~~~~~~~~~~~~~~~~~~~
  trace_irq_entry
arch/powerpc/kernel/dbell.c:96:2: error: implicit declaration of function
'trace_doorbell_exit'; did you mean 'trace_irq_exit'? [-Werror=implicit-function-
declaration]
  trace_doorbell_exit(regs);
  ^~~~~~~~~~~~~~~~~~~
  trace_irq_exit
cc1: all warnings being treated as errors
scripts/Makefile.build:305: recipe for target 'arch/powerpc/kernel/dbell.o' failed
make[1]: *** [arch/powerpc/kernel/dbell.o] Error 1
Makefile:1060: recipe for target 'arch/powerpc/kernel' failed

So does something else need to check for CONFIG_PPC_DOORBELL maybe?

You can see the failures here: http://patchwork.ozlabs.org/patch/978088/ - output
in build_new.log (I know it's not pretty in there yet, you can search for "Error
1" to find the build failure)

- Russell


