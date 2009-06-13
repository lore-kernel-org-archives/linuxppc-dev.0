Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 93A09B710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 07:11:35 +1000 (EST)
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 245E9DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 07:11:34 +1000 (EST)
Date: Sat, 13 Jun 2009 22:56:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
Message-ID: <20090613205611.GA21498@elte.hu>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
	<alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
Cc: akpm@linux-foundation.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 13 Jun 2009, Linus Torvalds wrote:
> > 
> > On Sat, 13 Jun 2009, Paul Mackerras wrote:
> > >
> > > Linus, Andrew: OK if this goes in via the powerpc tree?
> > 
> > Ok by me.
> 
> Btw, do 32-bit architectures really necessarily want 64-bit 
> performance counters?
> 
> I realize that 32-bit counters will overflow pretty easily, but I 
> do wonder about the performance impact of doing things like hashed 
> spinlocks for 64-bit counters. Maybe the downsides of 64-bit perf 
> counters on such architectures might outweight the upsides?

We account all sorts of non-hw bits via atomic64_t as well - for 
example time related counters in nanoseconds - which wrap 32 bits at 
4 seconds.

There's also security/stability relevant bits:

        counter->id             = atomic64_inc_return(&perf_counter_id);

We dont really want that ID to wrap ever - it could create a leaking 
of one PMU context into another. (We could rewrite it by putting a 
global lock around it, but still - this is a convenient primitive.)

In select places we might be able to reduce the use of atomic64_t 
(that might make performance sense anyway) - but to get rid of all 
of them would be quite painful. We initially started with a 32-bit 
implementation and it was quite painful with fast-paced units.

So since Paul has already coded the wrappers up ... i'd really 
prefer that, unless there's really compelling reasons not to do it.

	Ingo
