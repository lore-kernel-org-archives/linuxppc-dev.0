Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sRHjw4wgKzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Sep 2016 00:02:12 +1000 (AEST)
In-Reply-To: <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
References: <CAKMK7uEuqLLf2bCyB-sAuu5WvVA1Kp7Jvc33k3um5DfdQr4eyg@mail.gmail.com>
 <20160902104619.GD9355@localhost>
 <CA+55aFwSpNrOuOzaR5hh0A1XvuTu0=xVbE_CV1RVf9GMrTPDNQ@mail.gmail.com>
 <7359509.5sppVSLXcK@wuerfel>
 <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [Ksummit-discuss] [CORE TOPIC] (group) maintainership models
From: Michael Ellerman <michael@ellerman.id.au>
Date: Sun, 04 Sep 2016 00:02:04 +1000
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 ksummit-discuss@lists.linuxfoundation.org, Dave Airlie <airlied@linux.ie>,
 "Nikula, Jani" <jani.nikula@linux.intel.com>,
 Grant Likely <grant.likely@linaro.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1B7B3351-2578-4096-8B55-B623E606D2EC@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 3 September 2016 06:26:08 GMT+10:00, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, Sep 2, 2016 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> When I once looked, I thought all drivers using NO_IRQ were specific
>> to powerpc or one of the less common architectures.
>
>powerpc definitely does seem to be the biggest case, with about half
>the instances of NO_IRQ being under arch/powerpc/ (and a few more in
>ppc-specific drivers).
>
>Adding the powerpc maintainers to the list - because it would really
>be nice to get rid of it, or at least make it *so* rare that we don't
>have people re-introducing it again because they thought it was the
>right thing to do.
>
>A fair amount of of it could even be done by some trivial scripting.
>Something like
>
>  git grep -wl NO_IRQ arch/powerpc/ | while read a
>  do
>      sed 's/(\([a-z_]*irq\) != NO_IRQ)/(\1)/' < $a > $a.new
>      sed 's/(\([a-z_]*irq\) == NO_IRQ)/(!\1)/' < $a.new > $a
>  done
>
>does fix at least a few of the cases. It still leaves several
>assignments and "return NO_IRQ;" statements, but a few more
>sed-scripts would take care of most of it. Then remove the #define,
>and do a full build to find any straggling cases.
>
>Michael? Ben?

Yeah sounds good. I'll do a patch on Monday and push it through the build farm.

cheers

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
