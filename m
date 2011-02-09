Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEBDEB710C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 17:17:33 +1100 (EST)
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1297086859.13327.16.camel@laptop>
References: <1295262433.30950.53.camel@laptop>
	<1297034792.14982.10.camel@pasglop> <1297086859.13327.16.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Feb 2011 17:14:14 +1100
Message-ID: <1297232054.14982.346.camel@pasglop>
Mime-Version: 1.0
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, "H. Peter
	Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>,
	sparclinux@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Russell King <linux@arm.linux.org.uk>,
	Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	virtualization@lists.osdl.org, Ingo Molnar <mingo@redhat.com>,
	Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Mike Frysinger <vapier@gentoo.org>,
	user-mode-linux-devel@lists.sourceforge.net,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>,
	xen-devel@lists.xensource.com, Mikael Starvik <starvik@axis.com>,
	linux-m32r@ml.linux-m32r.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	user-mode-linux-user@lists.sourceforge.net,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Richard Henderson <rth@twiddle.net>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-am33-list@redhat.com,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 14:54 +0100, Peter Zijlstra wrote:
> On Mon, 2011-02-07 at 10:26 +1100, Benjamin Herrenschmidt wrote:
> > You missed:
> > 
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 9813605..467d122 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -98,6 +98,7 @@ void smp_message_recv(int msg)
> >                 break;
> >         case PPC_MSG_RESCHEDULE:
> >                 /* we notice need_resched on exit */
> > +               scheduler_ipi();
> >                 break;
> >         case PPC_MSG_CALL_FUNC_SINGLE:
> >                 generic_smp_call_function_single_interrupt();
> > 
> > Fold that in and add:
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Thanks Ben!

BTW. I we lurking at some of our CPU hotplug code and I think I cannot
totally guarantee that this won't be called on an offline CPU. If that's
a problem, you may want to add a test for that.

IE. The call function IPIs are normally not going to be sent to an
offlined CPU, and stop_machine should be a good enough fence here, but
we do abuse reschedule for a number of things (including in some case
to wake up a sleeping CPU that was pseudo-offlined :-)

Cheers,
Ben.
