Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id E593DDDE0C
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 17:46:09 +1000 (EST)
Date: Tue, 11 Sep 2007 17:46:08 +1000
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Fix "no_sync_cmos_clock"  logic inversion in kernel/time/ntp.c
Message-ID: <20070911074608.GD9814@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: zach@vmware.com, John Stultz <johnstul@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

Seems to me that this timer will only get started on platforms that say
they don't want it?

 kernel/time/ntp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: working/kernel/time/ntp.c
===================================================================
--- working.orig/kernel/time/ntp.c	2007-09-11 17:34:44.000000000 +1000
+++ working/kernel/time/ntp.c	2007-09-11 17:34:55.000000000 +1000
@@ -226,7 +226,7 @@ static void sync_cmos_clock(unsigned lon
 
 static void notify_cmos_timer(void)
 {
-	if (no_sync_cmos_clock)
+	if (!no_sync_cmos_clock)
 		mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
