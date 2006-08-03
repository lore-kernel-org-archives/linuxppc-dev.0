Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E1EB679FC
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 05:36:50 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k73JajjO004058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 15:36:45 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k73JaiuL199726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 13:36:44 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k73JaiZc026027
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 13:36:44 -0600
Date: Thu, 3 Aug 2006 14:36:43 -0500
To: akpm@osdl.org, hollisbl@us.ibm.com
Subject: [PATCH] pSeries  hvsi char driver janitorial cleanup.
Message-ID: <20060803193643.GA10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Andrew, 
Please apply.

A set of tty line discipline cleanup patches were introduced 
before the dawn of time, in kernel version 2.4.21. This patch
performs that cleanup for the hvsi driver.

The hvsi driver is used only on IBM pSeries PowerPC boxes.
The driver was originally written by Hollis Blanchard, who 
has delegated maintainership to me. So this my first and
maybe only patch in this official new role, because this 
driver is otherwise bug-free :-)

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/char/hvsi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.18-rc3-git1/drivers/char/hvsi.c
===================================================================
--- linux-2.6.18-rc3-git1.orig/drivers/char/hvsi.c	2006-08-01 14:26:38.000000000 -0500
+++ linux-2.6.18-rc3-git1/drivers/char/hvsi.c	2006-08-01 15:03:12.000000000 -0500
@@ -986,10 +986,7 @@ static void hvsi_write_worker(void *arg)
 		start_j = 0;
 #endif /* DEBUG */
 		wake_up_all(&hp->emptyq);
-		if (test_bit(TTY_DO_WRITE_WAKEUP, &hp->tty->flags)
-				&& hp->tty->ldisc.write_wakeup)
-			hp->tty->ldisc.write_wakeup(hp->tty);
-		wake_up_interruptible(&hp->tty->write_wait);
+		tty_wakeup(hp->tty);
 	}
 
 out:
