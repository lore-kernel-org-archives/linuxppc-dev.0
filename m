Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFDA467A67
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2005 09:44:46 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
In-Reply-To: <20050417091851.GE4981@halley.zuhause>
References: <1113184854.9567.522.camel@gaston>
	<20050417091851.GE4981@halley.zuhause>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 20 Apr 2005 09:42:37 +1000
Message-Id: <1113954158.5515.352.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Status report for 2.6.12-rc2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-04-17 at 11:18 +0200, Wolfram Quester wrote:
> Hi,
> 
> I use debian on my Powerbook6,2 and recently upgraded from kernel 2.6.10
> with the patch Guido Günther provides at [1] to 2.6.12-rc2 with ben's
> tumbler/snapper patches applied.
> So far I've seen the following issues:
> 1. I tried the new nvidiafb - just because I'm curious and the help says 
>    "This driver supports graphics boards with the nVidia chips, TNT and
>    newer. For very old chipsets, such as the RIVA128, then use the
>    rivafb."
>    The kernel crashed during boot when it tried to switch to nvidiafb. I
>    could see the messages that appeared before this stage until I
>    switched the computer off. Booting with video=ofonly went well and
>    using the traditional rivafb works fine.
>    This situation reminds me to crashes I had sometime ago when I was
>    testing Guido's patches for rivafb when he tried to get proper
>    support for NV30 into rivafb

You should report that to the linux-fbdev mailing list so the maintainer
of this driver can try to figure out what's up.

> 2. Sometimes the machine crashes on suspend to disk. It only happens when I work
>    in X and it seems to freeze in the process of switching to a virtual
>    terminal. The screen shows a distorted image of the previous screen
>    (as if I had 8Bit colour depth with oversized pixels).
>    I never had such freezes with 2.6.10 and this is the issue which
>    annoys me most ATM. I don't have a way to clearly reproduce the
>    freeze. It happend in two out of perhaps 20 suspends. It only seems
>    to happen on the first suspend after boot.
>    The suspend itself is much much faster than with 2.6.10 however.

It dies at suspend time when switching to VC ? Hrm... looks like it
could be X and the framebuffer walking on eachother toes, not sure tho,
2.6.12-rc2 is supposed to have patches fixing such ...

> 3. I configured sound to use snd-powermac. Before I used
>    dmasound-{pmac,core} and it works mostly. After a
>    suspend-resume-cycle I have to kill xfce4-panel, which accesses
>    /dev/mixer0, rmmod snd-powermac, wait a second and reinsert the
>    module. 

Yes, the Alsa code isn't doing very well when sleep is triggered while
an application is playing. I may try to fix it some day, or you can
maybe report that to alsa-devel and have Takashi fix it :)

> 4. Something that is quite annoying but harmless is that after wakeup
>    the machine sometimes suspends again immediately. I had something
>    like this before. On resume the PMU seems to be some kind of
>    irritated and gives wrong information about remaining runtime.
>    If this remaining time is 0 pbbuttonsd suspends the machine again.

Possibly, I haven't really checked what's going on with suspend to disk.
I suspect we just haven't yet started polling again from the PMU and we
expose some crap to userland or something like htat ...

> Thanks,
> 
> Wolfi
> 
>   1. http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/2.6.11.6-agx0.diff
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
