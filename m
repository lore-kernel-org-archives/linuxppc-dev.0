Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 94DE1DDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 14:25:51 +1100 (EST)
Date: Mon, 12 Nov 2007 14:25:50 +1100
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Demote clockevent printk to KERN_DEBUG.
Message-ID: <20071112032550.GB24243@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These don't need to be seen by eveyone on every boot.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4beb632..c0d7772 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -829,7 +829,7 @@ static void register_decrementer_clockevent(int cpu)
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of_cpu(cpu);
 
-	printk(KERN_INFO "clockevent: %s mult[%lx] shift[%d] cpu[%d]\n",
+	printk(KERN_DEBUG "clockevent: %s mult[%lx] shift[%d] cpu[%d]\n",
 	       dec->name, dec->mult, dec->shift, cpu);
 
 	clockevents_register_device(dec);
-- 
1.5.3.5

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
