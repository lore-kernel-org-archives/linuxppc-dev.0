Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011702b2928a54e303@[209.86.155.254]>
In-Reply-To: <v04011702b2914dc3594d@[209.86.156.28]>
Date: Tue, 8 Dec 1998 00:38:39 -0800
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        paulus@cs.anu.edu.au, daveray@wellsfargo.com
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Complete fix for PB 2400 16-bit video problem
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I figured out why 16-bit doesn't work in the console today.  I wasn't
checking "Advanced driver options" in the console setup screen (I use make
menuconfig).  This resulted in CONFIG_FBCON_CFB16 (I think that's the name)
not getting set, which .  Perhaps the CONFIG_FBCON_CFBxx settings should
default to Y?


Also, since I proved in my earlier message that I didn't know how to use
diff, and got told about it :), here is a better diff for
drivers/video/chipsfb.c.  This will patch it to correctly change bitdepth.


---------cut-----------------
--- chipsfb.orig.c	Mon Dec  7 00:24:13 1998
+++ chipsfb.c	Mon Dec  7 01:27:17 1998
@@ -358,6 +358,7 @@
 		if (con == currcon) {
 			write_cr(0x13, 200);		// 16 bit display
width (decimal)
 			write_xr(0x81, 0x14);		// 15 bit
(TrueColor) color mode
+			write_xr(0x82, 0x00);		// disable palettes
 			write_xr(0x20, 0x10);		// 16 bit blitter mode
 		}

@@ -379,6 +380,7 @@
 		if (con == currcon) {
 			write_cr(0x13, 100);		// 8 bit display
width (decimal)
 			write_xr(0x81, 0x12);		// 8 bit color mode
+			write_xr(0x82, 0x08);		// Graphics gamma
enable
 			write_xr(0x20, 0x00);		// 8 bit blitter mode
 		}
---------cut-----------------

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
