Date: Tue, 16 May 2000 17:02:28 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: m8xx_gorom - where are the arguments?
Message-ID: <Pine.LNX.4.21.0005161629550.19166-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

The kernel that we used to use before switching to the official Montavista
kernel declared (in arch/ppc/kernel/mbx_setup.c) m8xx_gorom() as a
function with two arguments:

void
m8xx_restart(char *cmd)
{
        extern void m8xx_gorom(bd_t *bd, uint addr);

        m8xx_gorom((bd_t *)res, 0xfff00100);
}

The MontaVista kernel hhl-kernel-2.2.13-7.src.rpm declares m8xx_gorom() as
a function that takes no arguments.

The kernel hhl-kernel-2.2.14-3.src.rpm renames m8xx_gorom() to
MBX_gorom() but it still takes no arguments.

The implementation of m8xx_gorom() is the same. From what I can see, r4
(second argument, right?) is really used as a jump address.

This means that the MontaVista kernel jumps to a random place. The patch
below fixes "reboot" both for RPX/Lite and LICCE boards.

Regards,
Pavel Roskin

==== cut here ====
Index: m8xx_setup.c
===================================================================
RCS file: /home/6cmr/kernel/arch/ppc/kernel/m8xx_setup.c,v
retrieving revision 1.6
diff -u -r1.6 m8xx_setup.c
--- m8xx_setup.c	2000/04/24 23:38:12	1.6
+++ m8xx_setup.c	2000/05/16 20:27:17
@@ -278,9 +278,9 @@
 void
 m8xx_restart(char *cmd)
 {
-	extern void m8xx_gorom(void);
+	extern void m8xx_gorom(bd_t *bd, uint addr);

-	m8xx_gorom();
+	m8xx_gorom((bd_t *)res, 0xfff00100);
 }

 void
==== cut here ====


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
