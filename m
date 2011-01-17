Return-Path: <jesper.nilsson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by ozlabs.org (Postfix) with ESMTP id 2C355B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 01:09:43 +1100 (EST)
Date: Mon, 17 Jan 2011 14:58:53 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
Message-ID: <20110117135852.GI9874@axis.com>
References: <1295262433.30950.53.camel@laptop>
	<20110117112637.GA18599@n2100.arm.linux.org.uk>
	<1295263884.30950.54.camel@laptop>
	<1295264509.30950.59.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295264509.30950.59.camel@laptop>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Hirokazu Takata <takata@linux-m32r.org>, "x86@kernel.org" <x86@kernel.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	"virtualization@lists.osdl.org" <virtualization@lists.osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>,
	"user-mode-linux-devel@lists.sourceforge.net"
	<user-mode-linux-devel@lists.sourceforge.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>,
	Mikael Starvik <starvik@axis.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	"user-mode-linux-user@lists.sourceforge.net"
	<user-mode-linux-user@lists.sourceforge.net>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
	Tony Luck <tony.luck@intel.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	linux-cris-kernel <linux-cris-kernel@axis.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	"linux390@de.ibm.com" <linux390@de.ibm.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 17, 2011 at 12:41:49PM +0100, Peter Zijlstra wrote:
> Index: linux-2.6/arch/cris/arch-v32/kernel/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/cris/arch-v32/kernel/smp.c
> +++ linux-2.6/arch/cris/arch-v32/kernel/smp.c
> @@ -340,15 +340,18 @@ irqreturn_t crisv32_ipi_interrupt(int ir
> 
>         ipi = REG_RD(intr_vect, irq_regs[smp_processor_id()], rw_ipi);
> 
> +       if (ipi.vector & IPI_SCHEDULE) {
> +               scheduler_ipi();
> +       }
>         if (ipi.vector & IPI_CALL) {
> -                func(info);
> +               func(info);
>         }
>         if (ipi.vector & IPI_FLUSH_TLB) {
> -                    if (flush_mm == FLUSH_ALL)
> -                        __flush_tlb_all();
> -                    else if (flush_vma == FLUSH_ALL)
> +               if (flush_mm == FLUSH_ALL)
> +                       __flush_tlb_all();
> +               else if (flush_vma == FLUSH_ALL)
>                         __flush_tlb_mm(flush_mm);
> -                    else
> +               else
>                         __flush_tlb_page(flush_vma, flush_addr);
>         }
> 

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
