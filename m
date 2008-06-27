Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 1/3 v2] hvc_console: rework setup to replace irq functions
	with callbacks
Date: Fri, 27 Jun 2008 15:27:51 +1000
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806201524.08237.borntraeger@de.ibm.com>
In-Reply-To: <200806201524.08237.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806271527.52321.rusty@rustcorp.com.au>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Yajin <zyj001et@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 20 June 2008 23:24:08 Christian Borntraeger wrote:
> I also kept hvc_struct defined in hvc_console.h so that hvc_irq.c can
> access the irq_requested element.

Added this fix:

=46ix compile of hvc_rtas.c

Moving the struct definition out to the header had bad effect under one
ppc64 config that I tried:

drivers/char/hvc_console.h:59: error: field =E2=80=98kref=E2=80=99 has inco=
mplete type

So move the include of kref.h too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r f382d8f562a8 drivers/char/hvc_console.c
=2D-- a/drivers/char/hvc_console.c	Fri Jun 27 15:17:49 2008 +1000
+++ b/drivers/char/hvc_console.c	Fri Jun 27 15:24:15 2008 +1000
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/kbd_kern.h>
 #include <linux/kernel.h>
=2D#include <linux/kref.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff -r f382d8f562a8 drivers/char/hvc_console.h
=2D-- a/drivers/char/hvc_console.h	Fri Jun 27 15:17:49 2008 +1000
+++ b/drivers/char/hvc_console.h	Fri Jun 27 15:24:15 2008 +1000
@@ -26,6 +26,7 @@
=20
 #ifndef HVC_CONSOLE_H
 #define HVC_CONSOLE_H
+#include <linux/kref.h>
=20
 /*
  * This is the max number of console adapters that can/will be found as
