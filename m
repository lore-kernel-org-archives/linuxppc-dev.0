Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8FE7DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 21:28:43 +1000 (EST)
Date: Tue, 23 Sep 2008 13:28:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Subject: Re: [RFC][PATCH] Demultiplexing SIGTRAP signal
Message-ID: <20080923112812.GL29021@elte.hu>
References: <200809221602.32616.srinivasa@in.ibm.com>
	<200809221841.27993.srinivasa@in.ibm.com>
	<20080922145404.GC27956@elte.hu>
	<200809231523.52802.srinivasa@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809231523.52802.srinivasa@in.ibm.com>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	"H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Srinivasa Ds <srinivasa@in.ibm.com> wrote:

> On Monday 22 September 2008 20:24:04 Ingo Molnar wrote:
> > * Srinivasa Ds <srinivasa@in.ibm.com> wrote:
> > > --- linux-2.6.27-rc7.orig/arch/ia64/include/asm/siginfo.h
> > > +++ linux-2.6.27-rc7/arch/ia64/include/asm/siginfo.h
> >
> > please do not send patches that modify include/asm/ files, the
> > include/asm-x86/ file should be modified instead.
> >
> > (this problem will go away in v2.6.28 when we'll move include/asm-x86/
> > to arch/x86/include/)
> >
> 
> Ingo, Sorry if I have confused you. [...]

hah, indeed - i mis-read them as include/asm/.

> Currently a SIGTRAP can denote any one of below reasons.
> 	- Breakpoint hit
> 	- H/W debug register hit
> 	- Single step
> 	- Signal sent through kill() or rasie()
> 
> Architectures like powerpc/parisc provides infrastructure to 
> demultiplex SIGTRAP signal by passing down the information for 
> receiving SIGTRAP through si_code of siginfot_t structure. Here is an 
> attempt is generalise this infrastructure by extending it to x86 and 
> x86_64 archs.

applied to [the new topic] tip/core/signal, thanks Srinivasa! There are 
some other pending x86 signal changes already, so i based 
tip/core/signal on tip/x86/signal.

Roland, any opinion on this change?

	Ingo
