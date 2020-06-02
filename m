Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23792C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:08:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D4B206C3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hLGYTNnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D4B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bwRT5CQZzDqWm
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 01:08:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bwN66StxzDqRw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 01:05:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=f1hzBB9KLB4tTNevjYrU1xXXmkoQCWVmDif8LyRXXio=; b=hLGYTNnNEFXKolZCdEaei3+P8R
 +uQGS8GDO+kejobjNymilQIbCqxMfkA4ydydJxoEvTMLJsc8GsR5VZJRmyqZdS7IKMKBdyoGGKR/c
 7nOmnue+mzQBzwLuV13NM0EEItcXekkQ0FmmPjtmD34nElrgGZ8oNOqXJ1WhsfcG/SiQKSTOUTNFw
 IHDK4+RBbwh84NLF70gUlR1reQMpYo6AjmnSKBG/SaDZnhTt6I2FugncCTv118JE4ZPcir9Dvn8XU
 lH5An/anJQHDy/ePfKDuD12Ghw9b6j5YTWlRFIqW8ZyqRXD8Brf0zSpRqiYnSBcnSr8C7hPWfe0yB
 m5n5Yq7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg8Ta-0005qW-TU; Tue, 02 Jun 2020 15:05:15 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20C1830081A;
 Tue,  2 Jun 2020 17:05:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 0997C202436EC; Tue,  2 Jun 2020 17:05:11 +0200 (CEST)
Date: Tue, 2 Jun 2020 17:05:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 11/14] x86/entry: Clarify irq_{enter,exit}_rcu()
Message-ID: <20200602150511.GH706478@hirez.programming.kicks-ass.net>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.359433429@infradead.org>
 <20200602144235.GA1129@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602144235.GA1129@lca.pw>
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
Cc: daniel.thompson@linaro.org, andrew.cooper3@citrix.com,
 bigeasy@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
 sean.j.christopherson@intel.com, luto@amacapital.net,
 Lai Jiangshan <laijs@linux.alibaba.com>, rostedt@goodmis.org,
 a.darwish@linutronix.de, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 02, 2020 at 10:42:35AM -0400, Qian Cai wrote:

> Reverted this commit fixed the POWER9 boot warning,

ARGH, I'm an idiot. Please try this instead:


diff --git a/kernel/softirq.c b/kernel/softirq.c
index a3eb6eba8c41..c4201b7f42b1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -438,7 +438,7 @@ void irq_exit_rcu(void)
  */
 void irq_exit(void)
 {
-	irq_exit_rcu();
+	__irq_exit_rcu();
 	rcu_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();


