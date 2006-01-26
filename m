Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4263C68A8F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 03:48:17 +1100 (EST)
Date: Thu, 26 Jan 2006 16:47:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Message-ID: <20060126164744.GB27222@flint.arm.linux.org.uk>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125112857.GB18584@miraclelinux.com>
	<20060126161426.GA1709@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060126161426.GA1709@elf.ucw.cz>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>, Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net,
	linux390@de.ibm.com, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 26, 2006 at 05:14:27PM +0100, Pavel Machek wrote:
> > Index: 2.6-git/include/asm-x86_64/mmu_context.h
> > ===================================================================
> > --- 2.6-git.orig/include/asm-x86_64/mmu_context.h	2006-01-25 19:07:15.000000000 +0900
> > +++ 2.6-git/include/asm-x86_64/mmu_context.h	2006-01-25 19:13:59.000000000 +0900
> > @@ -34,12 +34,12 @@
> >  	unsigned cpu = smp_processor_id();
> >  	if (likely(prev != next)) {
> >  		/* stop flush ipis for the previous mm */
> > -		clear_bit(cpu, &prev->cpu_vm_mask);
> > +		cpu_clear(cpu, prev->cpu_vm_mask);
> >  #ifdef CONFIG_SMP
> >  		write_pda(mmu_state, TLBSTATE_OK);
> >  		write_pda(active_mm, next);
> >  #endif
> > -		set_bit(cpu, &next->cpu_vm_mask);
> > +		cpu_set(cpu, next->cpu_vm_mask);
> >  		load_cr3(next->pgd);
> >  
> >  		if (unlikely(next->context.ldt != prev->context.ldt)) 
> 
> cpu_set sounds *very* ambiguous. We have thing called cpusets, for
> example. I'd not guess that is set_bit in cpu endianity (is it?).

That's a problem for the cpusets folk - cpu_set predates them by a
fair time - it's part of the cpumask API.  See include/linux/cpumask.h

Also, since cpu_vm_mask is a cpumask_t, the above change to me looks
like a bug fix in its own right.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
