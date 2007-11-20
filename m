Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] fix scaled time accounting possible divide by zero
Date: Tue, 20 Nov 2007 14:25:41 +1100
Message-ID: <9965.1195529141@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a problem noticed by Balbir Singh

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Paulus: can we send this up for 2.6.24?

 arch/powerpc/kernel/time.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/time.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/time.c
@@ -244,8 +244,9 @@ void account_system_vtime(struct task_st
 		/* deltascaled includes both user and system time.
 		 * Hence scale it based on the purr ratio to estimate
 		 * the system time */
-		deltascaled = deltascaled * get_paca()->system_time /
-		(get_paca()->system_time + get_paca()->user_time);
+		if (get_paca()->user_time)
+			deltascaled = deltascaled * get_paca()->system_time /
+			(get_paca()->system_time + get_paca()->user_time);
 		delta += get_paca()->system_time;
 		get_paca()->system_time = 0;
 	}
