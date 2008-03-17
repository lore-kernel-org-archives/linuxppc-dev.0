Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id D22D5DDE0D
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 16:23:30 +1100 (EST)
Date: Mon, 17 Mar 2008 16:23:29 +1100
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2.6.26] Update wait_state_cycles in the VPA.
Message-ID: <20080317052329.GJ6887@bakeyournoodle.com>
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

The hypervisor can look at the value in wait_state_cycles for an estimate of
how busy dedicated processors are.  Currently as the kernel never touches this
field so we appear to be 100% busy.  Record the duration the kernel is in
powersave and pass that to the HV to provide a reasonable indication of
utilisation.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/pseries/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index fdb9b1c..90555a3 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -393,6 +393,7 @@ static void pseries_dedicated_idle_sleep(void)
 { 
 	unsigned int cpu = smp_processor_id();
 	unsigned long start_snooze;
+	unsigned long in_purr, out_purr;
 
 	/*
 	 * Indicate to the HV that we are idle. Now would be
@@ -400,6 +401,7 @@ static void pseries_dedicated_idle_sleep(void)
 	 */
 	get_lppaca()->idle = 1;
 	get_lppaca()->donate_dedicated_cpu = 1;
+	in_purr = mfspr(SPRN_PURR);
 
 	/*
 	 * We come in with interrupts disabled, and need_resched()
@@ -432,6 +434,8 @@ static void pseries_dedicated_idle_sleep(void)
 
 out:
 	HMT_medium();
+	out_purr = mfspr(SPRN_PURR);
+	get_lppaca()->wait_state_cycles += out_purr - in_purr;
 	get_lppaca()->donate_dedicated_cpu = 0;
 	get_lppaca()->idle = 0;
 }
-- 
1.5.4.3


Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
