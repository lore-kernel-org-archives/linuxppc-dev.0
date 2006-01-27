Return-Path: <takata@linux-m32r.org>
Received: from mail04.idc.renesas.com (mail.renesas.com [202.234.163.13])
	by ozlabs.org (Postfix) with ESMTP id 2A74568A02
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jan 2006 00:17:52 +1100 (EST)
Received: from mail04.idc.renesas.com ([127.0.0.1])
	by mail04.idc.renesas.com. (SMSSMTP 4.1.9.35) with SMTP id
	M2006012721515401040
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 21:51:54 +0900
Date: Fri, 27 Jan 2006 21:51:47 +0900 (JST)
Message-Id: <20060127.215147.670306403.takata.hirokazu@renesas.com>
To: mita@miraclelinux.com
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060125113206.GD18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	spyro@f2s.com, ak@suse.de, dhowells@redhat.com,
	linuxppc-dev@ozlabs.org, gerg@uclinux.org,
	sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	ysato@users.sourceforge.jp, takata@linux-m32r.org,
	linuxsh-dev@lists.sourceforge.net, torvalds@osdl.org,
	ink@jurassic.park.msu.ru, rth@twiddle.net, chris@zankel.net,
	dev-etrax@axis.com, ultralinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	rmk@arm.linux.org.uk, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Mita-san, and folks,

From: mita@miraclelinux.com (Akinobu Mita)
Subject: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Date: Wed, 25 Jan 2006 20:32:06 +0900
> o generic {,test_and_}{set,clear,change}_bit() (atomic bitops)
> 
> This patch introduces the C-language equivalents of the functions below:
> void set_bit(int nr, volatile unsigned long *addr);
> void clear_bit(int nr, volatile unsigned long *addr);
...
> int test_and_change_bit(int nr, volatile unsigned long *addr);
> 
> HAVE_ARCH_ATOMIC_BITOPS is defined when the architecture has its own
> version of these functions.
> 
> This code largely copied from:
> include/asm-powerpc/bitops.h
> include/asm-parisc/bitops.h
> include/asm-parisc/atomic.h

Could you tell me more about the new generic {set,clear,test}_bit()
routines?

Why do you copied these routines from parisc and employed them
 as generic ones?
I'm not sure whether these generic {set,clear,test}_bit() routines
are really generic or not.

> +/* Can't use raw_spin_lock_irq because of #include problems, so
> + * this is the substitute */
> +#define _atomic_spin_lock_irqsave(l,f) do {	\
> +	raw_spinlock_t *s = ATOMIC_HASH(l);	\
> +	local_irq_save(f);			\
> +	__raw_spin_lock(s);			\
> +} while(0)
> +
> +#define _atomic_spin_unlock_irqrestore(l,f) do {	\
> +	raw_spinlock_t *s = ATOMIC_HASH(l);		\
> +	__raw_spin_unlock(s);				\
> +	local_irq_restore(f);				\
> +} while(0)

Is there a possibility that these routines affect for archs
with no HAVE_ARCH_ATOMIC_BITOPS for SMP ?
I think __raw_spin_lock() is sufficient and local_irqsave() is 
not necessary in general atomic routines.

If the parisc's LDCW instruction required disabling interrupts,
it would be parisc specific and not generic case, I think, 
although I'm not familier with the parisc architecture...

-- Takata
