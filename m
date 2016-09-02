Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQrHR0YxtzDrpK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 06:26:11 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id e126so2459339oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 13:26:10 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <7359509.5sppVSLXcK@wuerfel>
References: <CAKMK7uEuqLLf2bCyB-sAuu5WvVA1Kp7Jvc33k3um5DfdQr4eyg@mail.gmail.com>
 <20160902104619.GD9355@localhost>
 <CA+55aFwSpNrOuOzaR5hh0A1XvuTu0=xVbE_CV1RVf9GMrTPDNQ@mail.gmail.com>
 <7359509.5sppVSLXcK@wuerfel>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Sep 2016 13:26:08 -0700
Message-ID: <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [CORE TOPIC] (group) maintainership models
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 ksummit-discuss@lists.linuxfoundation.org, Dave Airlie <airlied@linux.ie>,
 "Nikula, Jani" <jani.nikula@linux.intel.com>,
 Grant Likely <grant.likely@linaro.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 2, 2016 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> When I once looked, I thought all drivers using NO_IRQ were specific
> to powerpc or one of the less common architectures.

powerpc definitely does seem to be the biggest case, with about half
the instances of NO_IRQ being under arch/powerpc/ (and a few more in
ppc-specific drivers).

Adding the powerpc maintainers to the list - because it would really
be nice to get rid of it, or at least make it *so* rare that we don't
have people re-introducing it again because they thought it was the
right thing to do.

A fair amount of of it could even be done by some trivial scripting.
Something like

  git grep -wl NO_IRQ arch/powerpc/ | while read a
  do
      sed 's/(\([a-z_]*irq\) != NO_IRQ)/(\1)/' < $a > $a.new
      sed 's/(\([a-z_]*irq\) == NO_IRQ)/(!\1)/' < $a.new > $a
  done

does fix at least a few of the cases. It still leaves several
assignments and "return NO_IRQ;" statements, but a few more
sed-scripts would take care of most of it. Then remove the #define,
and do a full build to find any straggling cases.

Michael? Ben?

             Linus
