Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB66C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jun 2022 23:58:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJPLQ0qmGz2xtt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jun 2022 09:58:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=nT18fRjm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJ96q0hgKz3bdj
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2022 00:47:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=rveYe0whW8HL+t/HGSaazkf4IJzq2XAc7vdeRKjh+gA=; b=nT18fRjmtv8PtOHNlSRz7z7OA3
	ocSKQvQMk90e4BYQ8FG72UOd1vXBcUYk3m24zX9nucFet4rZzw6IRnvpGNzErQ7vF6gmeSoA/I3hv
	UbyXINmvnZz3foLi4MgiuIC4OlBuTtckcjJAePYfIiJ2CqwvUU5HtHdW4N26hlwOmjLBkcG7LqG8Q
	BoJE3LoXRlBBcMZ7RvdkoEP2AdgziBJ305TMSdp+BvfA1B2vsf69NthlS94vm+wkGw/Vop/LGC4Dq
	IFK+3BYDKT97pJkb9/zTHujIgColQowacfqug2BBLzHPsqX11KJsuZ63kgKCy3HEu4aklD3cuhGeV
	CF8D6kbg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nywx3-0066CL-0a; Wed, 08 Jun 2022 14:46:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A082F302E9A;
	Wed,  8 Jun 2022 16:46:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
	id 90A2620C10ED8; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608144517.313931267@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 08 Jun 2022 16:27:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH 22/36] arm,smp: Remove trace_.*_rcuidle() usage
References: <20220608142723.103523089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailman-Approved-At: Thu, 09 Jun 2022 09:55:19 +1000
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, srivatsa@csail.mit.edu, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com, borntraeger@linux.ibm.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, paulus@samba.org, mark.rutland@arm.com, linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com, virtualizatio
 n@lists.linux-foundation.org, James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com, thierry.reding@gmail.com, kernel@xen0n.name, quic_neeraju@quicinc.com, linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, festevam@gmail.com, deller@gmx.de, daniel.lezcano@linaro.org, jonathanh@nvidia.com, mathieu.desnoyers@efficios.com, frederic@kernel.org, lenb@kernel.org, linux-xtensa@linux-xtensa.org, kernel@pengutronix.de, gor@linux.ibm.com, linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org, shorne@gmail.com, linux-arm-kernel@lists.infradead.org, chris@zankel.net, sboyd@kernel.org, dinguyen@kernel.org, bristot@redhat.com, alexander.shishkin@linux.intel.com, lpieralisi@kernel.org, linux@rasmusvillemoes.dk, joel@joelfernandes.org, will@kernel.org, boris.ostrovsky@oracle.com, khilman@kernel.org, linux-csky@vger.kernel.org, pv-drivers@vmware.com, linux-snps-arc@lists.infradea
 d.org, mgorman@suse.de, jacob.jun.pan@linux.intel.com

, Arnd Bergmann <arnd@arndb.de>, ulli.kroll@googlemail.com, vgupta@kernel.org, linux-clk@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org, rcu@vger.kernel.org, bp@alien8.de, bcain@quicinc.com, tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org, sudeep.holla@arm.com, shawnguo@kernel.org, davem@davemloft.net, dalias@libc.org, tony@atomide.com, amakhalov@vmware.com, bjorn.andersson@linaro.org, hpa@zytor.com, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, anton.ivanov@cambridgegreys.com, jonas@southpole.se, yury.norov@gmail.com, richard@nod.at, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, aou@eecs.berkeley.edu, paulmck@kernel.org, hca@linux.ibm.com, stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org, paul.walmsley@sifive.com, linux-tegra@vger.kernel.org, namhyung@kernel.org, andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com, monstr@monstr.eu, linux-mips@vger.kernel.org, palmer@dab
 belt.com, anup@brainfault.org, ink@jurassic.park.msu.ru, johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

None of these functions should ever be ran with RCU disabled anymore.

Specifically, do_handle_IPI() is only called from handle_IPI() which
explicitly does irq_enter()/irq_exit() which ensures RCU is watching.

The problem with smp_cross_call() was, per commit 7c64cc0531fa ("arm: Use
_rcuidle for smp_cross_call() tracepoints"), that
cpuidle_enter_state_coupled() already had RCU disabled, but that's
long been fixed by commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
deeper into the idle path").

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/kernel/smp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -639,7 +639,7 @@ static void do_handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
+		trace_ipi_entry(ipi_types[ipinr]);
 
 	switch (ipinr) {
 	case IPI_WAKEUP:
@@ -686,7 +686,7 @@ static void do_handle_IPI(int ipinr)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+		trace_ipi_exit(ipi_types[ipinr]);
 }
 
 /* Legacy version, should go away once all irqchips have been converted */
@@ -709,7 +709,7 @@ static irqreturn_t ipi_handler(int irq,
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	trace_ipi_raise(target, ipi_types[ipinr]);
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 


