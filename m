Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6AC272C00B0
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 05:41:08 +1000 (EST)
Message-ID: <1346787647.3025.6.camel@pasglop>
Subject: Re: 3.5+: yaboot, Invalid memory access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 05 Sep 2012 05:40:47 +1000
In-Reply-To: <1346741491.7619.12.camel@concordia>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
 <1346741491.7619.12.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-04 at 16:51 +1000, Michael Ellerman wrote:
> 
> My guess would be we're calling that quite early and the __put_user()
> check is getting confused and failing. That means we'll have left some
> code unpatched, which then fails.
> 
> Can you try with the patch applied, but instead of returning if the
> __put_user() fails, just continue on anyway.
> 
> That will isolate if it's something in the __put_user() (I doubt it),
> or
> just that the __put_user() is failing and leaving the code unpatched.

Bah, worse.... we do the feature fixups on 32-bit while still running
unrelocated, so we need RELOC() macros everywhere. That's probably
busted.

We might be able to try replacing __put_user() with __put_user_size() to
avoid the kernel address check, which is I think what's breaking it.

That stuff has long been in my list of things to rework, ie, we do that
fixup way too early on ppc32, in fact earlier than ppc64, ie, before the
platform is probed which means the platform cannot adjust the bits.

However, iirc, we have some early setup code that relies on the fixup
being done that early so it's a bit of a chicken & egg problem that
needs to be untangled first.

Cheers,
Ben.
