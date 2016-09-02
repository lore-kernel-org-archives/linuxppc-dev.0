Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQv830HQhzDrnx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 08:34:58 +1000 (AEST)
Message-ID: <1472854611.2313.5.camel@kernel.crashing.org>
Subject: Re: [Ksummit-discuss] [CORE TOPIC] (group) maintainership models
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 ksummit-discuss@lists.linuxfoundation.org, Dave Airlie <airlied@linux.ie>,
 "Nikula, Jani" <jani.nikula@linux.intel.com>, Grant Likely
 <grant.likely@linaro.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 03 Sep 2016 08:16:51 +1000
In-Reply-To: <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
References: <CAKMK7uEuqLLf2bCyB-sAuu5WvVA1Kp7Jvc33k3um5DfdQr4eyg@mail.gmail.com>
 <20160902104619.GD9355@localhost>
 <CA+55aFwSpNrOuOzaR5hh0A1XvuTu0=xVbE_CV1RVf9GMrTPDNQ@mail.gmail.com>
 <7359509.5sppVSLXcK@wuerfel>
 <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-09-02 at 13:26 -0700, Linus Torvalds wrote:
> On Fri, Sep 2, 2016 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > 
> > When I once looked, I thought all drivers using NO_IRQ were
> > specific
> > to powerpc or one of the less common architectures.

We deprecated NO_IRQ ages ago, it's 0 like it should be, but yes we may
have forgotten to "cleanup" the old users.
 
> powerpc definitely does seem to be the biggest case, with about half
> the instances of NO_IRQ being under arch/powerpc/ (and a few more in
> ppc-specific drivers).
> 
> Adding the powerpc maintainers to the list - because it would really
> be nice to get rid of it, or at least make it *so* rare that we don't
> have people re-introducing it again because they thought it was the
> right thing to do.

Right. Originally it was -1 for us which causes the whole problem. I
changed it to be 0 after doing the whole irq domain remapping thing.
That was a loooong time ago.

> A fair amount of of it could even be done by some trivial scripting.
> Something like
> 
>   git grep -wl NO_IRQ arch/powerpc/ | while read a
>   do
>       sed 's/(\([a-z_]*irq\) != NO_IRQ)/(\1)/' < $a > $a.new
>       sed 's/(\([a-z_]*irq\) == NO_IRQ)/(!\1)/' < $a.new > $a
>   done
> 
> does fix at least a few of the cases. It still leaves several
> assignments and "return NO_IRQ;" statements, but a few more
> sed-scripts would take care of most of it. Then remove the #define,
> and do a full build to find any straggling cases.
> 
> Michael? Ben?

It can just be replaced with "0" in all powerpc related cases yes.

Cheers,
Ben.
