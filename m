Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 4790BDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 12:33:20 +1000 (EST)
Date: Wed, 12 Sep 2007 12:33:19 +1000
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] powerpc: add new required termio functions
Message-ID: <20070912023319.GG9814@bakeyournoodle.com>
References: <8018.1189562679@neuling.org>
	<alpine.LFD.0.999.0709111915350.16478@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LFD.0.999.0709111915350.16478@woody.linux-foundation.org>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@redhat.com>, akpm@linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 07:17:42PM -0700, Linus Torvalds wrote:
 
> Really?
> 
> It shouldn't. The use of kernel_termios_to_user_termios_1() is conditional 
> on the architecture having a define for TCGETS2, and I think they match 
> up. I see:
> 
> 	[torvalds@woody linux]$ git grep -l kernel_termios_to_user_termios_1 include | wc -l
> 	10
> 	[torvalds@woody linux]$ git grep -l TCGETS2 include | wc -l
> 	10
> 
> and in neither case is ppc in that list of architecures.
> 
> So maybe you just read the patch without actually testing whether it 
> actually broke powerpc?
> 
> Or is something subtler going on?

As far as I can see TIOCSLCKTRMIOS and TIOCGLCKTRMIOS aren't protected
by TCGETS2 guards.  Do they need to be ...  Perhaps


From: Tony Breeds <tony@bakeyournoodle.com>

Add Guards around TIOCSLCKTRMIOS and TIOCGLCKTRMIOS.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 drivers/char/tty_ioctl.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/char/tty_ioctl.c b/drivers/char/tty_ioctl.c
index 4a8969c..3ee73cf 100644
--- a/drivers/char/tty_ioctl.c
+++ b/drivers/char/tty_ioctl.c
@@ -795,6 +795,19 @@ int n_tty_ioctl(struct tty_struct * tty, struct file * file,
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
@@ -806,6 +819,7 @@ int n_tty_ioctl(struct tty_struct * tty, struct file * file,
 			if (user_termios_to_kernel_termios_1(real_tty->termios_locked, (struct termios __user *) arg))
 				return -EFAULT;
 			return 0;
+#endif
 
 		case TIOCPKT:
 		{

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
