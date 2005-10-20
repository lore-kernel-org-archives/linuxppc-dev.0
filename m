Return-Path: <galak@freescale.com>
Date: Thu, 20 Oct 2005 11:43:33 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510201142580.8879@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Make sure we have an RTC before trying to adjust it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Its valid for ppc_md.set_rtc_time to be NULL.  We need to check
that its non-NULL before trying to update the RTC.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit e597837e138d9526562a68ec2f3c77a47ce1045e
tree d5f982c7881efe43276b85ece4a371cb66f64ae5
parent de6cc780f1ec6143474219697c249d7266f56120
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 20 Oct 2005 11:35:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 20 Oct 2005 11:35:28 -0500

 arch/powerpc/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -144,7 +144,7 @@ static __inline__ void timer_check_rtc(v
          * We should have an rtc call that only sets the minutes and
          * seconds like on Intel to avoid problems with non UTC clocks.
          */
-        if (ntp_synced() &&
+        if (ppc_md.set_rtc_time && ntp_synced() &&
 	    xtime.tv_sec - last_rtc_update >= 659 &&
 	    abs((xtime.tv_nsec/1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 	    jiffies - wall_jiffies == 1) {
