Date: Mon, 14 Feb 2000 19:10:49 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: OPOST problem solved
Message-ID: <Pine.LNX.4.21.0002141854440.1963-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I have finally solved the misterious problem with console applications not
working on the serial console.

When OPOST is not set in tty->termios->c_oflag then drivers/char/n_tty.c
uses binary `write' for the data. The data are marked as "unsafe" using
the "from_user" flag.

But arch/ppc/8xx_io/uart.c fails to check user-originated data correctly.
copy_from_user() returns 0 for success and non-zero for failure, but
rs_8xx_write() expects it to return the number of characters actually
written.

The patch below fixes the problem. Now I have Midnight Commander running
on the serial console of RPX/Lite!

Regards,
Pavel Roskin

=== cut here ===
diff -u -r1.2 uart.c
--- arch/ppc/8xx_io/uart.c	2000/01/24 21:27:13	1.2
+++ arch/ppc/8xx_io/uart.c	2000/02/14 23:50:25
@@ -970,8 +970,7 @@
 		}

 		if (from_user) {
-			if (c !=
-			    copy_from_user(__va(bdp->cbd_bufaddr), buf, c)) {
+			if (copy_from_user(__va(bdp->cbd_bufaddr), buf, c)) {
 				if (!ret)
 					ret = -EFAULT;
 				break;
=== cut here ===


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
