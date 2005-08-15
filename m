Return-Path: <nacc@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.133])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F88267F3D
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 04:24:07 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7FINwn7510818
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2005 14:24:00 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id
	j7FIO03q103132
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2005 12:24:00 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j7FINwKc026903
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2005 12:23:58 -0600
Date: Mon, 15 Aug 2005 11:23:57 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: benh@kernel.crashing.org
Message-ID: <20050815182357.GZ2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: [-mm PATCH 23/32] drivers/macintosh: fix-up schedule_timeout() usage
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Description: Use schedule_timeout_interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 arch/m68k/atari/time.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -urpN 2.6.13-rc5-mm1/drivers/macintosh/therm_pm72.c 2.6.13-rc5-mm1-dev/drivers/macintosh/therm_pm72.c
--- 2.6.13-rc5-mm1/drivers/macintosh/therm_pm72.c	2005-08-07 09:57:58.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/drivers/macintosh/therm_pm72.c	2005-08-08 15:06:08.000000000 -0700
@@ -1678,10 +1678,9 @@ static int main_control_loop(void *x)
 		}
 
 		// FIXME: Deal with signals
-		set_current_state(TASK_INTERRUPTIBLE);
 		elapsed = jiffies - start;
 		if (elapsed < HZ)
-			schedule_timeout(HZ - elapsed);
+			schedule_timeout_interruptible(HZ - elapsed);
 	}
 
  out:
