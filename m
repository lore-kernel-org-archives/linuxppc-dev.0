To: ahoerandl@gmx.at
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: new uart on MPC8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Jun 2001 10:36:49 +0200."
             <01062510364900.00667@linuxhoe>
Date: Mon, 25 Jun 2001 10:54:58 +0200
Message-Id: <20010625085503.6B3BE10072@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <01062510364900.00667@linuxhoe> you wrote:
>
> I was checking the new uart (got the kernel from
> ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-05-12.tar.bz2 )
>
> I tried to use some pins on port b for handshake and it refuses to compile:
> The problem is in uart.c around line 80:
...
> Has anyone got a patch to correct this ?

Yes, of course: I have a patch :-)

> ps: is this list the right place to report such troubles ?

Well, probably yes. But you could have asked me directly, too ...

Please see the patch attached below - I hope it works, since the code
has changed a lot inbetween (we've added  configuration  options  for
the  number  and  size of the I/O buffers); let me know when you have
problems, or are interested in our current version (although it's not
formally "released" yet).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Never underestimate the power of human stupidity  when  it  comes  to
using technology they don't understand.

Index: arch/ppc/8xx_io/uart.c
===================================================================
RCS file: /cvsroot/linux-2.4/arch/ppc/8xx_io/uart.c,v
retrieving revision 1.17
retrieving revision 1.18
diff -u -r1.17 -r1.18
--- arch/ppc/8xx_io/uart.c	2001/05/20 19:55:13	1.17
+++ arch/ppc/8xx_io/uart.c	2001/05/23 12:27:44	1.18
@@ -79,9 +79,9 @@
 #define PORT_DTR1_DIR immap->im_ioport.iop_padir
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC1 == PORT_B)
-#define PORT_DTR1_PAR immap->im_ioport.iop_pbpar
-#define PORT_DTR1_DAT immap->im_ioport.iop_pbdat
-#define PORT_DTR1_DIR immap->im_ioport.iop_pbdir
+#define PORT_DTR1_PAR immap->im_cpm.cp_pbpar
+#define PORT_DTR1_DAT immap->im_cpm.cp_pbdat
+#define PORT_DTR1_DIR immap->im_cpm.cp_pbdir
 #define DTR1_PIN (1 << (31 - CONFIG_DTR1_PIN))
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC1 == PORT_C)
@@ -100,9 +100,9 @@
 #define PORT_DTR2_DIR immap->im_ioport.iop_padir
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC2 == PORT_B)
-#define PORT_DTR2_PAR immap->im_ioport.iop_pbpar
-#define PORT_DTR2_DAT immap->im_ioport.iop_pbdat
-#define PORT_DTR2_DIR immap->im_ioport.iop_pbdir
+#define PORT_DTR2_PAR immap->im_cpm.cp_pbpar
+#define PORT_DTR2_DAT immap->im_cpm.cp_pbdat
+#define PORT_DTR2_DIR immap->im_cpm.cp_pbdir
 #define DTR2_PIN (1 << (31 - CONFIG_DTR2_PIN))
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC2 == PORT_C)
@@ -121,9 +121,9 @@
 #define PORT_DTR3_DIR immap->im_ioport.iop_padir
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC3 == PORT_B)
-#define PORT_DTR3_PAR immap->im_ioport.iop_pbpar
-#define PORT_DTR3_DAT immap->im_ioport.iop_pbdat
-#define PORT_DTR3_DIR immap->im_ioport.iop_pbdir
+#define PORT_DTR3_PAR immap->im_cpm.cp_pbpar
+#define PORT_DTR3_DAT immap->im_cpm.cp_pbdat
+#define PORT_DTR3_DIR immap->im_cpm.cp_pbdir
 #define DTR3_PIN (1 << (31 - CONFIG_DTR3_PIN))
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC3 == PORT_C)
@@ -142,9 +142,9 @@
 #define PORT_DTR4_DIR immap->im_ioport.iop_padir
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC4 == PORT_B)
-#define PORT_DTR4_PAR immap->im_ioport.iop_pbpar
-#define PORT_DTR4_DAT immap->im_ioport.iop_pbdat
-#define PORT_DTR4_DIR immap->im_ioport.iop_pbdir
+#define PORT_DTR4_PAR immap->im_cpm.cp_pbpar
+#define PORT_DTR4_DAT immap->im_cpm.cp_pbdat
+#define PORT_DTR4_DIR immap->im_cpm.cp_pbdir
 #define DTR4_PIN (1 << (31 - CONFIG_DTR4_PIN))
 #endif
 #if (CONFIG_UART_DTR_CONTROL_SCC4 == PORT_C)
@@ -3023,20 +3023,20 @@
 	 */
 #if defined(CPM_UART_HANDSHAKING)
 #if (CONFIG_UART_RTS_CONTROL_SCC1 == PORT_B)
-	immap->im_ioport.iop_pbpar |= (1 << (31 - CONFIG_RTS1_PIN));
-	immap->im_ioport.iop_pbdir |= (1 << (31 - CONFIG_RTS1_PIN));
+	immap->im_cpm.cp_pbpar |= (1 << (31 - CONFIG_RTS1_PIN));
+	immap->im_cpm.cp_pbdir |= (1 << (31 - CONFIG_RTS1_PIN));
 #endif
 #if (CONFIG_UART_RTS_CONTROL_SCC2 == PORT_B)
-	immap->im_ioport.iop_pbpar |= (1 << (31 - CONFIG_RTS2_PIN));
-	immap->im_ioport.iop_pbdir |= (1 << (31 - CONFIG_RTS2_PIN));
+	immap->im_cpm.cp_pbpar |= (1 << (31 - CONFIG_RTS2_PIN));
+	immap->im_cpm.cp_pbdir |= (1 << (31 - CONFIG_RTS2_PIN));
 #endif
 #if (CONFIG_UART_RTS_CONTROL_SCC3 == PORT_B)
-	immap->im_ioport.iop_pbpar |= (1 << (31 - CONFIG_RTS3_PIN));
-	immap->im_ioport.iop_pbdir |= (1 << (31 - CONFIG_RTS3_PIN));
+	immap->im_cpm.cp_pbpar |= (1 << (31 - CONFIG_RTS3_PIN));
+	immap->im_cpm.cp_pbdir |= (1 << (31 - CONFIG_RTS3_PIN));
 #endif
 #if (CONFIG_UART_RTS_CONTROL_SCC4 == PORT_B)
-	immap->im_ioport.iop_pbpar |= (1 << (31 - CONFIG_RTS4_PIN));
-	immap->im_ioport.iop_pbdir |= (1 << (31 - CONFIG_RTS4_PIN));
+	immap->im_cpm.cp_pbpar |= (1 << (31 - CONFIG_RTS4_PIN));
+	immap->im_cpm.cp_pbdir |= (1 << (31 - CONFIG_RTS4_PIN));
 #endif
 #if (CONFIG_UART_RTS_CONTROL_SCC1 == PORT_C)
 	immap->im_ioport.iop_pcpar |=  (1 << (15 - CONFIG_RTS1_PIN));

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
