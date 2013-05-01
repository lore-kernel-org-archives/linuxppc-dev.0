Return-Path: <bhutchings@solarflare.com>
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "WEBMAIL.SOLARFLARE.COM",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 071F52C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 22:08:51 +1000 (EST)
Message-ID: <1367410118.5106.113.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: Ben Hutchings <bhutchings@solarflare.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 1 May 2013 13:08:38 +0100
In-Reply-To: <1367372393.22115.6.camel@pasglop>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <1367372393.22115.6.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Eric Dumazet <eric.dumazet@gmail.com>, netdev <netdev@vger.kernel.org>,
 Ambrose Feinstein <ambrose@google.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-01 at 11:39 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-04-30 at 18:12 -0700, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > 
> > Using bit fields is dangerous on ppc64, as the compiler uses 64bit
> > instructions to manipulate them. If the 64bit word includes any
> > atomic_t or spinlock_t, we can lose critical concurrent changes.
> > 
> > This is happening in af_unix, where unix_sk(sk)->gc_candidate/
> > gc_maybe_cycle/lock share the same 64bit word.
> > 
> > This leads to fatal deadlock, as one/several cpus spin forever
> > on a spinlock that will never be available again.
> > 
> > Reported-by: Ambrose Feinstein <ambrose@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > ---
> > 
> > Could ppc64 experts confirm using byte is safe, or should we really add
> > a 32bit hole after the spinlock ? If so, I wonder how many other places
> > need a change...
> 
> Wow, nice one !
> 
> I'm not even completely certain bytes are safe to be honest, though
> probably more than bitfields. I'll poke our compiler people.

There is a longstanding and hard-to-fix bug in gcc that is specific to
bitfields.  I think that the underlying type isn't propagated, so when
it comes to code generation the compiler doesn't know the natural width
for the memory access.

As for bytes - early Alphas couldn't load/store less than 32 bits, but I
doubt anyone cares any more.

> The worry is of course how many more of these do we potentially have ? 
> We might be able to automate finding these issues with sparse, I
> suppose.
> 
> Also I'd be surprised if ppc64 is the only one with that problem... what
> about sparc64 and arm64 ?

I expect they can have the same general problem, but gcc may be more or
less keen to generate 64-bit load/store instructions for bitfields on
different architectures.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
