Return-Path: <kaos@sgi.com>
Received: from mail.ocs.com.au (mail.ocs.com.au [202.147.117.210])
	by ozlabs.org (Postfix) with ESMTP id EDA1868A73
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2006 23:20:01 +1100 (EST)
From: Keith Owens <kaos@sgi.com>
To: mita@miraclelinux.com (Akinobu Mita)
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h 
In-reply-to: Your message of "Wed, 25 Jan 2006 20:32:06 +0900."
	<20060125113206.GD18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Jan 2006 22:54:43 +1100
Message-ID: <24086.1138190083@ocs3.ocs.com.au>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>, linuxsh-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akinobu Mita (on Wed, 25 Jan 2006 20:32:06 +0900) wrote:
>o generic {,test_and_}{set,clear,change}_bit() (atomic bitops)
...
>+static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>+{
>+	unsigned long mask = BITOP_MASK(nr);
>+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
>+	unsigned long flags;
>+
>+	_atomic_spin_lock_irqsave(p, flags);
>+	*p  |= mask;
>+	_atomic_spin_unlock_irqrestore(p, flags);
>+}

Be very, very careful about using these generic *_bit() routines if the
architecture supports non-maskable interrupts.

NMI events can occur at any time, including when interrupts have been
disabled by *_irqsave().  So you can get NMI events occurring while a
*_bit fucntion is holding a spin lock.  If the NMI handler also wants
to do bit manipulation (and they do) then you can get a deadlock
between the original caller of *_bit() and the NMI handler.

Doing any work that requires spinlocks in an NMI handler is just asking
for deadlock problems.  The generic *_bit() routines add a hidden
spinlock behind what was previously a safe operation.  I would even say
that any arch that supports any type of NMI event _must_ define its own
bit routines that do not rely on your _atomic_spin_lock_irqsave() and
its hash of spinlocks.
