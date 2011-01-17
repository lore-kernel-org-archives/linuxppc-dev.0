Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [206.83.70.70])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "usmamail.tilera.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80C78B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 00:58:16 +1100 (EST)
Message-ID: <4D344995.80701@tilera.com>
Date: Mon, 17 Jan 2011 08:52:21 -0500
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
References: <1295262433.30950.53.camel@laptop>	
	<20110117112637.GA18599@n2100.arm.linux.org.uk>	
	<1295263884.30950.54.camel@laptop>
	<1295264509.30950.59.camel@laptop>
In-Reply-To: <1295264509.30950.59.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, "James E.J.
	Bottomley" <jejb@parisc-linux.org>, virtualization@lists.osdl.org,
	Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>,
	user-mode-linux-devel@lists.sourceforge.net,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jeff Dike <jdike@addtoit.com>, Mikael Starvik <starvik@axis.com>,
	xen-devel@lists.xensource.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	user-mode-linux-user@lists.sourceforge.net,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	"David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/17/2011 6:41 AM, Peter Zijlstra wrote:
> Index: linux-2.6/arch/tile/kernel/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/tile/kernel/smp.c
> +++ linux-2.6/arch/tile/kernel/smp.c
> @@ -184,12 +184,8 @@ void flush_icache_range(unsigned long st
>  /* Called when smp_send_reschedule() triggers IRQ_RESCHEDULE. */
>  static irqreturn_t handle_reschedule_ipi(int irq, void *token)
>  {
> -       /*
> -        * Nothing to do here; when we return from interrupt, the
> -        * rescheduling will occur there. But do bump the interrupt
> -        * profiler count in the meantime.
> -        */
>         __get_cpu_var(irq_stat).irq_resched_count++;
> +       scheduler_ipi();
>
>         return IRQ_HANDLED;
>  }

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
