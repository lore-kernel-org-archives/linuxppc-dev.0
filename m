Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8C4A2C0B48
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:36:45 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 06:30:37 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3AD2E3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:36:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKLqF08389026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:21:52 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKaeIC006588
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:36:41 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 40/45] powerpc,
 irq: Use GFP_ATOMIC allocations in atomic context
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 02:03:11 +0530
Message-ID: <20130625203310.16593.6214.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 Li Zhong <zhong@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, xiaoguangrong@linux.vnet.ibm.com,
 sbw@mit.edu, Paul Mackerras <paulus@samba.org>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function migrate_irqs() is called with interrupts disabled
and hence its not safe to do GFP_KERNEL allocations inside it,
because they can sleep. So change the gfp mask to GFP_ATOMIC.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ea185e0..ca39bac 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -412,7 +412,7 @@ void migrate_irqs(void)
 	cpumask_var_t mask;
 	const struct cpumask *map = cpu_online_mask;
 
-	alloc_cpumask_var(&mask, GFP_KERNEL);
+	alloc_cpumask_var(&mask, GFP_ATOMIC);
 
 	for_each_irq_desc(irq, desc) {
 		struct irq_data *data;
