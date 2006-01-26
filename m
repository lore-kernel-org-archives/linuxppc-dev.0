Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id 401F068AD3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 13:13:13 +1100 (EST)
Date: Thu, 26 Jan 2006 11:13:18 +0900
To: Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060126021318.GB6648@miraclelinux.com>
References: <20060125113206.GD18584@miraclelinux.com>
	<24086.1138190083@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24086.1138190083@ocs3.ocs.com.au>
From: mita@miraclelinux.com (Akinobu Mita)
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

On Wed, Jan 25, 2006 at 10:54:43PM +1100, Keith Owens wrote:
> Be very, very careful about using these generic *_bit() routines if the
> architecture supports non-maskable interrupts.
> 
> NMI events can occur at any time, including when interrupts have been
> disabled by *_irqsave().  So you can get NMI events occurring while a
> *_bit fucntion is holding a spin lock.  If the NMI handler also wants
> to do bit manipulation (and they do) then you can get a deadlock
> between the original caller of *_bit() and the NMI handler.
> 
> Doing any work that requires spinlocks in an NMI handler is just asking
> for deadlock problems.  The generic *_bit() routines add a hidden
> spinlock behind what was previously a safe operation.  I would even say
> that any arch that supports any type of NMI event _must_ define its own
> bit routines that do not rely on your _atomic_spin_lock_irqsave() and
> its hash of spinlocks.

At least cris and parisc are using similar *_bit function on SMP.
I will add your advise in comment.

--- ./include/asm-generic/bitops.h.orig	2006-01-26 10:56:00.000000000 +0900
+++ ./include/asm-generic/bitops.h	2006-01-26 11:01:28.000000000 +0900
@@ -50,6 +50,16 @@ extern raw_spinlock_t __atomic_hash[ATOM
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
+/*
+ * NMI events can occur at any time, including when interrupts have been
+ * disabled by *_irqsave().  So you can get NMI events occurring while a
+ * *_bit fucntion is holding a spin lock.  If the NMI handler also wants
+ * to do bit manipulation (and they do) then you can get a deadlock
+ * between the original caller of *_bit() and the NMI handler.
+ *
+ * by Keith Owens
+ */
+
 static __inline__ void set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BITOP_MASK(nr);
