Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EEE2DE271
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 23:23:49 +1000 (EST)
Date: Wed, 6 Aug 2008 14:06:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, devilbis@us.ibm.com, boutcher@us.ibm.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH]: Remove bogons from the iSeries console
Message-ID: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The iSeries driver calls into the n_tty ldisc code directly for some
bizarre reason. I previously tagged this with a query but this actually
does need fixing as n_tty methods when you have a different ldisc set are
not a good thing to call.

In n_tty mode this change should have no effect, the core tty layer has
always called the ldisc ioctl method *anyway* and will call the one for
the right ldisc.

Signed-off-by: Alan Cox <alan@redhat.com>

---

 drivers/char/viocons.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)


diff --git a/drivers/char/viocons.c b/drivers/char/viocons.c
index 65fb848..f48892b 100644
--- a/drivers/char/viocons.c
+++ b/drivers/char/viocons.c
@@ -705,10 +705,6 @@ static int viotty_ioctl(struct tty_struct *tty, struct file *file,
 	case KDSKBLED:
 		return 0;
 	}
-	/* FIXME: WTF is this being called for ??? */
-	lock_kernel();
-	ret =  n_tty_ioctl(tty, file, cmd, arg);
-	unlock_kernel();
 	return ret;
 }
 
