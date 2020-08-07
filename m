Return-Path: <SRS0=mIln=BR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEA9C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 11:14:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D0222CAE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 11:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="unE27pIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D0222CAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BNN6d5nVzzDqxH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 21:14:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BNN3L5qwLzDqNQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2020 21:11:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=H9pFCH3Moi70e7rPhQDsmelFkTpyLNVCigPJMZhbh4M=; b=unE27pINXTEXPyCzsiuOqFGJ3T
 btSDm/aYdoK9MTat9yPFqQPYM78+m2/AsFj+yr3YRQ7nLXlarKa+n2oS+9kspkv07ANWDg8VFAGsD
 BEgWU3pMKrNpE01GHlBqlEtOBjRL5kBuuinu1VHsNK70/EAhQxnjBLfuWmWwv5MvjRHhcPi/STG67
 4mxM0E/0Np9If37fkQWdHzrSl4vroNEZQn4+vfsEE1pmc2t5K04Mf/dKijKgjSScesaI7766NbMKL
 K73JIP2ASefw7evgpqCbNr/3B+U2WQNPCahBXUE2lJr211M1yPpKkTmTZPTjLgLopiPwCfz2oJzAb
 kwFckUwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k40HY-0005Qq-4Q; Fri, 07 Aug 2020 11:11:28 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9F8D304BAE;
 Fri,  7 Aug 2020 13:11:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id C01C4236DA3E1; Fri,  7 Aug 2020 13:11:26 +0200 (CEST)
Date: Fri, 7 Aug 2020 13:11:26 +0200
From: peterz@infradead.org
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200807111126.GI2674@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723105615.1268126-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


What's wrong with something like this?

AFAICT there's no reason to actually try and add IRQ tracing here, it's
just a hand full of instructions at the most.

---

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3a0db7b0b46e..6be22c1838e2 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -196,33 +196,6 @@ static inline bool arch_irqs_disabled(void)
 		arch_local_irq_restore(flags);				\
 	} while(0)
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-#define powerpc_local_irq_pmu_save(flags)			\
-	 do {							\
-		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
-	} while(0)
-#define powerpc_local_irq_pmu_restore(flags)			\
-	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
-			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
-	} while(0)
-#else
-#define powerpc_local_irq_pmu_save(flags)			\
-	do {							\
-		raw_local_irq_pmu_save(flags);			\
-	} while(0)
-#define powerpc_local_irq_pmu_restore(flags)			\
-	do {							\
-		raw_local_irq_pmu_restore(flags);		\
-	} while (0)
-#endif  /* CONFIG_TRACE_IRQFLAGS */
-
 #endif /* CONFIG_PPC_BOOK3S */
 
 #ifdef CONFIG_PPC_BOOK3E
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index bc4bd19b7fc2..b357a35672b1 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -32,9 +32,9 @@ static __inline__ void local_##op(long i, local_t *l)			\
 {									\
 	unsigned long flags;						\
 									\
-	powerpc_local_irq_pmu_save(flags);				\
+	raw_powerpc_local_irq_pmu_save(flags);				\
 	l->v c_op i;						\
-	powerpc_local_irq_pmu_restore(flags);				\
+	raw_powerpc_local_irq_pmu_restore(flags);				\
 }
 
 #define LOCAL_OP_RETURN(op, c_op)					\
@@ -43,9 +43,9 @@ static __inline__ long local_##op##_return(long a, local_t *l)		\
 	long t;								\
 	unsigned long flags;						\
 									\
-	powerpc_local_irq_pmu_save(flags);				\
+	raw_powerpc_local_irq_pmu_save(flags);				\
 	t = (l->v c_op a);						\
-	powerpc_local_irq_pmu_restore(flags);				\
+	raw_powerpc_local_irq_pmu_restore(flags);				\
 									\
 	return t;							\
 }
@@ -81,11 +81,11 @@ static __inline__ long local_cmpxchg(local_t *l, long o, long n)
 	long t;
 	unsigned long flags;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_powerpc_local_irq_pmu_save(flags);
 	t = l->v;
 	if (t == o)
 		l->v = n;
-	powerpc_local_irq_pmu_restore(flags);
+	raw_powerpc_local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -95,10 +95,10 @@ static __inline__ long local_xchg(local_t *l, long n)
 	long t;
 	unsigned long flags;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_powerpc_local_irq_pmu_save(flags);
 	t = l->v;
 	l->v = n;
-	powerpc_local_irq_pmu_restore(flags);
+	raw_powerpc_local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -117,12 +117,12 @@ static __inline__ int local_add_unless(local_t *l, long a, long u)
 	unsigned long flags;
 	int ret = 0;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_powerpc_local_irq_pmu_save(flags);
 	if (l->v != u) {
 		l->v += a;
 		ret = 1;
 	}
-	powerpc_local_irq_pmu_restore(flags);
+	raw_powerpc_local_irq_pmu_restore(flags);
 
 	return ret;
 }
