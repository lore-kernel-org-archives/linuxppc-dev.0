Return-Path: <SRS0=7wTx=7R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FBC433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 20:43:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C301A204EF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C0D4Ai1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C301A204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49dHmw5X9nzDqtt
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 06:43:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=merlin.20170209 header.b=C0D4Ai1a; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49dHkX4yQczDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2020 06:41:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RRQblA+6bnMhS+1SeeEZEKS/yygoKGFKeYypCO41S+w=; b=C0D4Ai1alqr8n5EZ4NTgLMZNjz
 FhgjMiyvs2pElhVDljwJfczLn/lUbRXtxNiNgZlQ26DdYPKuvFDQcj+WPlebJAlKW13CQib6OpZLB
 O1sZhbeGkYwrCro0S/96SpLGo/EuJX6bmfFEoZa5VHq8RJezHp0KiwdqcnzPWh0OsALyAC696r4WF
 KFFKqcdLiszkPv3L5bz9uK35dmbij3evt7cNScCz5vIyUO4HFM2UrJHrzBx9PWKR8di8Vplku1MgN
 SxxLVmSByLs94EzRvfh+cnSMfBhSuBFGd7BD4rgxW7dW+yiGBZd/CEjmVOt3k2WfWqjeEn0c6vLKh
 8tRyt0dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgwfv-0002aT-Rn; Thu, 04 Jun 2020 20:41:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 578649838B9; Thu,  4 Jun 2020 22:41:16 +0200 (CEST)
Date: Thu, 4 Jun 2020 22:41:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH v3 1/5] sparc64: Fix asm/percpu.h build error
Message-ID: <20200604204116.GD4496@worktop.programming.kicks-ass.net>
References: <20200529213550.683440625@infradead.org>
 <20200529214203.673108357@infradead.org>
 <20200529.162917.1970892823680223252.davem@davemloft.net>
 <20200604165703.GG3976@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604165703.GG3976@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bigeasy@linutronix.de, x86@kernel.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, a.darwish@linutronix.de,
 sparclinux@vger.kernel.org, tglx@linutronix.de, will@kernel.org,
 mingo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 04, 2020 at 06:57:03PM +0200, Peter Zijlstra wrote:

> I think I see, what happens is that these headers end up in the VDSO
> build, and that doesn't have these CFLAGS, because userspace.
> 
> Let me see what to do about that.

I feel like the below is cheating, but it's the best I could find :/
VDSO including kernel headers and the utter maze that our kernel headers
are makes it really hard to untangle :/

This builds sparc64-defconfig and sparc64-all{no,mod}config.

Dave, does this work for you, or should I try hardder?

---
 arch/sparc/include/asm/percpu_64.h  | 2 ++
 arch/sparc/include/asm/trap_block.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/percpu_64.h b/arch/sparc/include/asm/percpu_64.h
index 32ef6f05cc565..a8786a4b90b6b 100644
--- a/arch/sparc/include/asm/percpu_64.h
+++ b/arch/sparc/include/asm/percpu_64.h
@@ -4,7 +4,9 @@

 #include <linux/compiler.h>

+#ifndef BUILD_VDSO
 register unsigned long __local_per_cpu_offset asm("g5");
+#endif

 #ifdef CONFIG_SMP

diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 0f6d0c4f66838..ace0d48e837e5 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_TRAP_BLOCK_H
 #define _SPARC_TRAP_BLOCK_H

+#include <linux/threads.h>
+
 #include <asm/hypervisor.h>
 #include <asm/asi.h>


