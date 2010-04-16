Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84242B7D27
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 20:38:44 +1000 (EST)
Subject: Re: linux-next: PowerPC WARN_ON_ONCE() after merge of the final
	tree (tip related)
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
In-Reply-To: <20100415171551.GA5069@nowhere>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
	<20100415064940.GA9240@elte.hu> <20100415130032.GA6789@nowhere>
	<20100415140358.GA19981@elte.hu>  <20100415171551.GA5069@nowhere>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Apr 2010 12:38:43 +0200
Message-ID: <1271414323.4807.1931.camel@twins>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-15 at 19:15 +0200, Frederic Weisbecker wrote:
> > that looks rather ugly. Why not do a raw:
> >=20
> >       this_cpu_inc(lockdep_stats.redundant_hardirqs_on);
> >=20
> > which basically open-codes debug_atomic_inc(), but without the warning?
>=20
>=20
> Because that would open a race against interrupts that might
> touch lockdep_stats.redundant_hardirqs_on too.


How so, its a pure per-cpu variable right? so either the increment
happens before the interrupts hits, or after, in either case there
should not be a race with interrupts.
