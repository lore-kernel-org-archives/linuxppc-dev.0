Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32F251A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 20:40:15 +1100 (AEDT)
Message-ID: <1426585198.4770.23.camel@kernel.crashing.org>
Subject: Re: [RFC, v2] powerpc/powernv: Introduce kernel param to control
 fastsleep workaround behavior
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 17 Mar 2015 20:39:58 +1100
In-Reply-To: <20150317085708.7102714017B@ozlabs.org>
References: <20150317085708.7102714017B@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-17 at 19:57 +1100, Michael Ellerman wrote:
> 
> So my first preference is that you just bite the bullet and decide to either
> always apply the workaround, or just stick with the current behaviour. That's a
> trade-off between (I think) better idle latency but a risk of checkstops, vs.
> slower idle latency but less (how much less?) risk of checkstops.
> 
> I think the reason you're proposing a kernel parameter is because we aren't
> willing to make that decision, ie. we're saying that users should decide. Is
> that right?

Correct. More specifically, a fairly high profile user that I will not
name here has expressed interest in such a feature...

> I'm not a big fan of kernel parameters. They are a pain to use, and are often
> just pushing a decision down one layer for no reason. What I mean is that
> individual users are probably just going to accept whatever the default value
> is from their distro.

Right. This is quite an obscure tunable.

> But anyway, that's a bit of a rant.
> 
> As far as this patch is concerned, I don't think it actually needs to be a
> kernel parameter.
> 
> >From what I can see below, the decision as to whether you apply the workaround
> or not doesn't affect the list of idle states. So this could just as well be a
> runtime parameter, ie. a sysfs file, which can then be set by the user whenever
> they like? They might do it in a boot script, but that's up to them.

Right, that would work too.

> For simplicity I think it would also be fine to make it a write-once parameter,
> ie. you don't need to handle undoing it.

It would be easy enough to make it rw using stop machine I think... 

> I think the only complication that would add is that you'd need to be a little
> careful about the order in which you nop out the calls vs applying the
> workaround, in case some threads are idle when you're called.

I wouldn't bother with NOP'ing in that case, a runtime test will probably be noise
in the measurement.

Cheers,
Ben.
