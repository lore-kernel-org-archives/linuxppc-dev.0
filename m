Date: Thu, 12 Oct 2000 22:57:24 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Albrecht Dress <adress@mpifr-bonn.mpg.de>
cc: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        schmitz@opal.biophys.uni-duesseldorf.de, olh@suse.de
Subject: Re: 2.2.17pre20-ben3 + pmud-0.7-1: still kernel panic upon wakeup
In-Reply-To: <Pine.SOL.4.21.0010122241340.21571-100000@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10010122251200.6839-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Can you try Benhs latest?
> > http://penguinppc.org/~olaf/vmlinux-benh.gz
>
> Got it, this one does not panic. I'll rsync from Ben's tree asap, thanks a

Good.

> lot for your help! However, I recognised a quite odd behaviour of this
> kernel: using the trackpad, the x and y coordinates are exchanged (moving
> the trackpad up and down moves the cursor left and right and vice versa).

Fixed in the pmud-0.7-2 Debian package. All you need to do is patch
pmud.c:

--- pmud-0.7.orig/pmud.c
+++ pmud-0.7/pmud.c
@@ -1502,7 +1502,7 @@
 {
 	int nr;
 	int tries = 5;
-	unsigned char buf[9];
+	unsigned char buf[10];

 	if(adb_program(fd, id, 1) < 0)
 		return 0;
@@ -1522,7 +1522,8 @@
 		buf[2] = settings & TPS_DRAG ? 0x94 : 0x14;
 		buf[4] = settings & TPS_LOCK ? 0xff : 0xb2;

-		if(adbwrite(fd, id, 2, ADBlisten, buf, nr) <= 0)
+		/* buf+1 because the read buffer contains command byte at buf[0] */
+		if(adbwrite(fd, id, 2, ADBlisten, buf+1, nr) <= 0)
 		{
 			syslog(LOG_ERR, "set.set adbwrite: %m");
 			continue;

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
