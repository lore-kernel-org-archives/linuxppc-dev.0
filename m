Return-Path: <fweisbec@gmail.com>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by ozlabs.org (Postfix) with ESMTP id 1257CB7D6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 22:32:15 +1000 (EST)
Received: by wwb34 with SMTP id 34so1070191wwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 05:32:12 -0700 (PDT)
Date: Fri, 16 Apr 2010 14:32:12 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: PowerPC WARN_ON_ONCE() after merge of the final
	tree (tip related)
Message-ID: <20100416123208.GA5162@nowhere>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
	<20100415064940.GA9240@elte.hu> <20100415130032.GA6789@nowhere>
	<20100415140358.GA19981@elte.hu> <20100415171551.GA5069@nowhere>
	<1271414323.4807.1931.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1271414323.4807.1931.camel@twins>
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

On Fri, Apr 16, 2010 at 12:38:43PM +0200, Peter Zijlstra wrote:
> On Thu, 2010-04-15 at 19:15 +0200, Frederic Weisbecker wrote:
> > > that looks rather ugly. Why not do a raw:
> > > 
> > >       this_cpu_inc(lockdep_stats.redundant_hardirqs_on);
> > > 
> > > which basically open-codes debug_atomic_inc(), but without the warning?
> > 
> > 
> > Because that would open a race against interrupts that might
> > touch lockdep_stats.redundant_hardirqs_on too.
> 
> 
> How so, its a pure per-cpu variable right? so either the increment
> happens before the interrupts hits, or after, in either case there
> should not be a race with interrupts.


In x86 yeah, I guess the compiler simply loads the address
and does an inc directly, which is atomic wrt interrupts.

But what about another arch that would need an intermediate
load of the value:

load val, reg
add reg, 1
		<---interrupt here
store reg, val
