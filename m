Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8B0E1A08B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:48:22 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4E31B1400EA
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 18:48:22 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 18:48:20 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5CB652CE8047
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 18:48:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8WCjH39583962
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 18:32:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B8mGiR021427
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2014 18:48:16 +1000
Subject: [PATCH 3/4] powerpc/book3s: Increment the mce counter during
 machine_check_early call.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Jun 2014 14:18:07 +0530
Message-ID: <20140611084807.9634.76881.stgit@mars.in.ibm.com>
In-Reply-To: <20140611084756.9634.82266.stgit@mars.in.ibm.com>
References: <20140611084756.9634.82266.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

We don't see MCE counter getting increased in /proc/interrupts which gives
false impression of no MCE occurred even when there were MCE events.
The machine check early handling was added for PowerKVM and we missed to
increment the MCE count in the early handler.

We also increment mce counters in the machine_check_exception call, but
in most cases where we handle the error hypervisor never reaches there
unless its fatal and we want to crash. Only during fatal situation we may
see double increment of mce count. We need to fix that. But for
now it always good to have some count increased instead of zero.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/traps.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1bd7ca2..239f1cd 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -295,6 +295,8 @@ long machine_check_early(struct pt_regs *regs)
 {
 	long handled = 0;
 
+	__get_cpu_var(irq_stat).mce_exceptions++;
+
 	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
 		handled = cur_cpu_spec->machine_check_early(regs);
 	return handled;
