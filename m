Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE51EDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:01:24 +1000 (EST)
Date: Wed, 12 Sep 2007 04:01:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] powerpc: add new required termio functions
Message-Id: <20070912040109.3f6a9149.akpm@linux-foundation.org>
In-Reply-To: <20070912102032.GB7858@osiris.boeblingen.de.ibm.com>
References: <8018.1189562679@neuling.org>
	<20070912102032.GB7858@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, Alan Cox <alan@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 12 Sep 2007 12:20:32 +0200 Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Wed, Sep 12, 2007 at 12:04:39PM +1000, Michael Neuling wrote:
> > The "tty: termios locking functions break with new termios type" patch
> > (f629307c857c030d5a3dd777fee37c8bb395e171) breaks the powerpc compile.
> > [...]
> > I'm guessing other architectures are broken too?
> 
> FWIW, the above quoted patch breaks s390 as well.

Does this fix it?

diff -puN drivers/char/tty_ioctl.c~powerpc-add-new-required-termio-functions drivers/char/tty_ioctl.c
--- a/drivers/char/tty_ioctl.c~powerpc-add-new-required-termio-functions
+++ a/drivers/char/tty_ioctl.c
@@ -795,6 +795,19 @@ int n_tty_ioctl(struct tty_struct * tty,
 			if (L_ICANON(tty))
 				retval = inq_canon(tty);
 			return put_user(retval, (unsigned int __user *) arg);
+#ifndef TCGETS2
+		case TIOCGLCKTRMIOS:
+			if (kernel_termios_to_user_termios((struct termios __user *)arg, real_tty->termios_locked))
+				return -EFAULT;
+			return 0;
+
+		case TIOCSLCKTRMIOS:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EPERM;
+			if (user_termios_to_kernel_termios(real_tty->termios_locked, (struct termios __user *) arg))
+				return -EFAULT;
+			return 0;
+#else
 		case TIOCGLCKTRMIOS:
 			if (kernel_termios_to_user_termios_1((struct termios __user *)arg, real_tty->termios_locked))
 				return -EFAULT;
@@ -806,6 +819,7 @@ int n_tty_ioctl(struct tty_struct * tty,
 			if (user_termios_to_kernel_termios_1(real_tty->termios_locked, (struct termios __user *) arg))
 				return -EFAULT;
 			return 0;
+#endif
 
 		case TIOCPKT:
 		{
_
