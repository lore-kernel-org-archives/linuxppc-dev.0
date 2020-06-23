Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AC5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 08:56:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BCC20723
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DA9fkdE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BCC20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rgBX6CsZzDqSD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 18:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=DA9fkdE3; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rfpX5VQBzDqRH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 18:39:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=ab0jxe5bKfD6GeppZDuw9sanZscYluyoJpWAvdwL/58=; b=DA9fkdE343TQ8rp5o1qud+GVm/
 SiHjXIQsaorYUouTtxlXycQjfGwBraurie9evaBzRd+u2ksI8+RMEjBv06/BrgM+rksZ0l/PKj6Qr
 H0UEjAlTpKDUmorMmjHF4g2pWb1rf+veouCOp0XONqxhFZNstyd+djPwpOj59JTrO1kvWZbUNaNl5
 RUf5f7/eB8CnGzj2cimlFKQ368iZml9CWUgQUryoRM2PI9MDalwRCI2FmEDr2R1QMNCqbl+2NSbQS
 gRYjk236WdLfaiLXvLlvjU8l7z2R+vpye3v7prbdnzVZzEQ5it5Sn6w4Cp7c/1Opkv/WlhS7z1fPO
 9d/hasVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jneS3-0000fs-5z; Tue, 23 Jun 2020 08:38:43 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC93D307943;
 Tue, 23 Jun 2020 10:38:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id EAFF4237095FC; Tue, 23 Jun 2020 10:38:39 +0200 (CEST)
Message-ID: <20200623083721.396143816@infradead.org>
User-Agent: quilt/0.66
Date: Tue, 23 Jun 2020 10:36:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 will@kernel.org,
 tglx@linutronix.de
Subject: [PATCH v4 5/8] s390: Break cyclic percpu include
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-s390@vger.kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
 x86@kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, linux@armlinux.org.uk, a.darwish@linutronix.de,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/include/asm/smp.h         |    1 +
 arch/s390/include/asm/thread_info.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -10,6 +10,7 @@
 
 #include <asm/sigp.h>
 #include <asm/lowcore.h>
+#include <asm/processor.h>
 
 #define raw_smp_processor_id()	(S390_lowcore.cpu_nr)
 
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -24,7 +24,6 @@
 #ifndef __ASSEMBLY__
 #include <asm/lowcore.h>
 #include <asm/page.h>
-#include <asm/processor.h>
 
 #define STACK_INIT_OFFSET \
 	(THREAD_SIZE - STACK_FRAME_OVERHEAD - sizeof(struct pt_regs))


