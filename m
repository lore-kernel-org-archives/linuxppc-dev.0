Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id AF68768A9A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 03:14:44 +1100 (EST)
Date: Thu, 26 Jan 2006 17:14:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Message-ID: <20060126161426.GA1709@elf.ucw.cz>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125112857.GB18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060125112857.GB18584@miraclelinux.com>
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

Hi!

> While working on these patch set, I found several possible cleanup
> on x86-64 and ia64.

It is probably not your fault, but...

> Index: 2.6-git/include/asm-x86_64/mmu_context.h
> ===================================================================
> --- 2.6-git.orig/include/asm-x86_64/mmu_context.h	2006-01-25 19:07:15.000000000 +0900
> +++ 2.6-git/include/asm-x86_64/mmu_context.h	2006-01-25 19:13:59.000000000 +0900
> @@ -34,12 +34,12 @@
>  	unsigned cpu = smp_processor_id();
>  	if (likely(prev != next)) {
>  		/* stop flush ipis for the previous mm */
> -		clear_bit(cpu, &prev->cpu_vm_mask);
> +		cpu_clear(cpu, prev->cpu_vm_mask);
>  #ifdef CONFIG_SMP
>  		write_pda(mmu_state, TLBSTATE_OK);
>  		write_pda(active_mm, next);
>  #endif
> -		set_bit(cpu, &next->cpu_vm_mask);
> +		cpu_set(cpu, next->cpu_vm_mask);
>  		load_cr3(next->pgd);
>  
>  		if (unlikely(next->context.ldt != prev->context.ldt)) 

cpu_set sounds *very* ambiguous. We have thing called cpusets, for
example. I'd not guess that is set_bit in cpu endianity (is it?).

								Pavel
-- 
Thanks, Sharp!
