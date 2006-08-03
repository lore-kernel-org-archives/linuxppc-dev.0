Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6CF567B63
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 06:13:05 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k73KD2tL020136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 16:13:02 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k73KD2HU160036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 14:13:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k73KD16p015646
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 14:13:02 -0600
Date: Thu, 3 Aug 2006 15:13:01 -0500
To: akpm@osdl.org, hollisbl@us.ibm.com
Subject: [PATCH] pSeries hvsi char driver null pointer deref
Message-ID: <20060803201300.GB10638@austin.ibm.com>
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

Under certain rare circumstances, it appears that there can be
be a NULL-pointer deref when a user fiddles with terminal
emeulation programs while outpu is being sent to the console.
This patch checks for and avoids a NULL-pointer deref.

Signed-off-by: Hollis Blanchard <hollisbl@austin.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/char/hvsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc3-git1/drivers/char/hvsi.c
===================================================================
--- linux-2.6.18-rc3-git1.orig/drivers/char/hvsi.c	2006-08-03 14:50:00.000000000 -0500
+++ linux-2.6.18-rc3-git1/drivers/char/hvsi.c	2006-08-03 14:51:46.000000000 -0500
@@ -311,7 +311,8 @@ static void hvsi_recv_control(struct hvs
 				/* CD went away; no more connection */
 				pr_debug("hvsi%i: CD dropped\n", hp->index);
 				hp->mctrl &= TIOCM_CD;
-				if (!(hp->tty->flags & CLOCAL))
+				/* If userland hasn't done an open(2) yet, hp->tty is NULL. */
+				if (hp->tty && !(hp->tty->flags & CLOCAL))
 					*to_hangup = hp->tty;
 			}
 			break;
