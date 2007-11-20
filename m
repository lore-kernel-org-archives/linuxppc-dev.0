Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
Subject: [PATCH] fix scaled time accounting possible divide by zero 
In-reply-to: <9965.1195529141@neuling.org> 
References: <9965.1195529141@neuling.org>
Date: Tue, 20 Nov 2007 15:18:40 +1100
Message-ID: <17403.1195532320@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we get no user time allocated since the last account_system_vtime,
the system to user time ratio estimate can end up dividing by zero.

This was causing a problem noticed by Balbir Singh.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Resent as the first version had whitespace corruption.  

Paulus: can we send this up for 2.6.24?

 arch/powerpc/kernel/time.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/time.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/time.c
@@ -241,8 +241,9 @@ void account_system_vtime(struct task_st
 		/* deltascaled includes both user and system time.
 		 * Hence scale it based on the purr ratio to estimate
 		 * the system time */
-		deltascaled = deltascaled * get_paca()->system_time /
-			(get_paca()->system_time + get_paca()->user_time);
+		if (get_paca()->user_time)
+			deltascaled = deltascaled * get_paca()->system_time /
+			     (get_paca()->system_time + get_paca()->user_time);
 		delta += get_paca()->system_time;
 		get_paca()->system_time = 0;
 	}
