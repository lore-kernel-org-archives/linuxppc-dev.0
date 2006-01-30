Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id 62FEA68AC4
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2006 14:29:35 +1100 (EST)
Date: Mon, 30 Jan 2006 12:29:33 +0900
To: Hirokazu Takata <takata@linux-m32r.org>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060130032933.GB6897@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
	<20060127.215147.670306403.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060127.215147.670306403.takata.hirokazu@renesas.com>
From: mita@miraclelinux.com (Akinobu Mita)
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	spyro@f2s.com, ak@suse.de, dhowells@redhat.com,
	linuxppc-dev@ozlabs.org, gerg@uclinux.org,
	sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	ysato@users.sourceforge.jp, linuxsh-dev@lists.sourceforge.net,
	torvalds@osdl.org, ink@jurassic.park.msu.ru, rth@twiddle.net,
	chris@zankel.net, dev-etrax@axis.com, ultralinux@vger.kernel.org,
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

On Fri, Jan 27, 2006 at 09:51:47PM +0900, Hirokazu Takata wrote:
 
> Could you tell me more about the new generic {set,clear,test}_bit()
> routines?
> 
> Why do you copied these routines from parisc and employed them
>  as generic ones?
> I'm not sure whether these generic {set,clear,test}_bit() routines
> are really generic or not.

I think it is the most portable implementation.
And I'm trying not to write my own code in this patch set.

> 
> > +/* Can't use raw_spin_lock_irq because of #include problems, so
> > + * this is the substitute */
> > +#define _atomic_spin_lock_irqsave(l,f) do {	\
> > +	raw_spinlock_t *s = ATOMIC_HASH(l);	\
> > +	local_irq_save(f);			\
> > +	__raw_spin_lock(s);			\
> > +} while(0)
> > +
> > +#define _atomic_spin_unlock_irqrestore(l,f) do {	\
> > +	raw_spinlock_t *s = ATOMIC_HASH(l);		\
> > +	__raw_spin_unlock(s);				\
> > +	local_irq_restore(f);				\
> > +} while(0)
> 
> Is there a possibility that these routines affect for archs
> with no HAVE_ARCH_ATOMIC_BITOPS for SMP ?

Currently there is no architecture using this atomic *_bit() routines
on SMP. But it may be the benefit of those who are trying to port Linux.
(See the comment by Theodore Ts'o in include/asm-generic/bitops.h)

> I think __raw_spin_lock() is sufficient and local_irqsave() is 
> not necessary in general atomic routines.

If the interrupt handler also wants to do bit manipilation then
you can get a deadlock between the original caller of *_bit() and the
interrupt handler.
