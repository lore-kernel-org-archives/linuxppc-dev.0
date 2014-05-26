Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18D681A0590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 22:26:07 +1000 (EST)
Message-ID: <1401107166.23096.1.camel@concordia>
Subject: Re: Boot problems with a PA6T board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Mon, 26 May 2014 22:26:06 +1000
In-Reply-To: <53720AAC.1000100@xenosoft.de>
References: <5366649E.4030102@xenosoft.de>
 <1399268891.4600.3.camel@concordia> <53720AAC.1000100@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-13 at 14:06 +0200, Christian Zigotzky wrote:
> On 05.05.2014 07:48, Michael Ellerman wrote:
> > On Sun, 2014-05-04 at 18:02 +0200, Christian Zigotzky wrote:
> >> Hi All,
> >>
> >> The RC 1, 2, and 3 of the kernel 3.15 don't boot on my PA6T board with a
> >> Radeon HD 6870 graphics card.
> >>
> >> Screenshot:
> >> http://forum.hyperion-entertainment.biz/download/file.php?id=1060&mode=view
> >>
> >> The kernel 3.14 starts without any problems. Has anyone a tip for me,
> >> please?
> > The line that says "starting cpu hw idx 0... failed" looks a little worrying.
> > Do you see that on 3.14 as well?
> >
> > Otherwise bisection is probably your best bet.

> Hi All,
> 
> I have found out which patch is responsible for the boot problems. It's 
> patch 9000c17dc0f9c910267d2661225c9d33a227b27e. Link: 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9000c17dc0f9c910267d2661225c9d33a227b27e

Hi Christian,

I'm almost certain that is not the commit which breaks your machine. Or if it
is, something *really* weird is going on.

The code changed in that commit should never run on a PA6T.

> Experimental protocol:
> 
> git checkout -f 01d8885785a60ae8f4c37b0ed75bdc96d0fc6a44; git clean -fdx 
> (from 02/04/14) -> Kernel boots
> git checkout -f f1553174a207f68a4ec19d436003097e0a4dc405; git clean -fdx 
> (from 03/04/14) -> Kernel boots
> git checkout -f d40326f4b9f9617cdfd30f83a2db57d47e9c5bac; git clean -fdx 
> (from 04/04/14) -> Kernel boots
> git checkout -f 930b440cd8256f3861bdb0a59d26efaadac7941a; git clean -fdx 
> (from 05/04/14) -> doesn't boot (rtc error)
> git checkout -f 2b3a8fd735f86ebeb2b9d061054003000c36b654; git clean -fdx 
> (from 06/04/14) -> doesn't boot (rtc error)
> git checkout -f 26c12d93348f0bda0756aff83f4867d9ae58a5a6; git clean -fdx 
> (from 07/04/14) -> doesn't boot (rtc error)
> git checkout -f a6c8aff022d4d06e4b41455ae9b2a5d3d503bf76; git clean -fdx 
> (from 08/04/14) -> Kernel boots
> git checkout -f 035328c202d26a824b8632fd3b00635db5aee5a2; git clean -fdx 
> (from 08/04/14) -> Kernel boots
> git checkout -f 9000c17dc0f9c910267d2661225c9d33a227b27e; git clean -fdx 
> (from 08/04/14) powerpc/powernv: Fix endian issues with sensor code
> One OPAL call and one device tree property needed byte swapping. -> 
> doesn't boot (prom_init)
> git checkout -f d3d35d957a9d0733dc51f14b5abc0bff5d3c5f3a; git clean -fdx 
> (from 08/04/14) -> doesn't boot (prom_init)
> git checkout -f c4586256f0c440bc2bdb29d2cbb915f0ca785d26; git clean -fdx 
> (from 09/04/14) -> doesn't boot (prom_init)

So it looks like you manually picked commits based on the date?

That's a good start, but if you want to find the actual problem commit you need
to do a proper bisect.

> I'm not a programmer but what can I do to solve this boot problem?

To start with you can probably narrow it down a bit by testing the following
commits:

18a1a7a1d862ae0794a0179473d08a414dd49234
d8ff9cdf68fd119d491f3de90e1a612afc2f3b2b
0f5a869600141a0d5575e3190af01a050c081b07
c7e64b9ce04aa2e3fad7396d92b5cb92056d16ac
d3e144532703fe2454b56eddb56f30d2d620187b

cheers
