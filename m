Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AD7482C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 18:58:38 +1100 (EST)
Message-ID: <1388217509.4373.19.camel@pasglop>
Subject: Re: [PATCH 11/39] powerpc: endian safe trampoline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Date: Sat, 28 Dec 2013 18:58:29 +1100
In-Reply-To: <CAOesGMgKjAe5VR9waKCboK+mRwVfde89x+6gew9wjiCf8mAd8A@mail.gmail.com>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
 <1379901913-5945-12-git-send-email-anton@samba.org>
 <CAOesGMgKjAe5VR9waKCboK+mRwVfde89x+6gew9wjiCf8mAd8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 chzigotzky@xenosoft.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Fri, 2013-12-27 at 23:24 -0800, Olof Johansson wrote:
> 
> So, I'm really quite baffled right now. Any ideas would be welcome,
> I'm sort of stumped. In particular since pasemi_defconfig boots fine.

So you are coming in with "good" endian... what if you stick an
isync in there just for fun ? I wonder if it prefetches the "bad"
instructions and somewhat gets itself confused.

Also did you try sticking a b . around 0x700 see if that's where it's
going and what condition gets set ?

Cheers,
Ben.
