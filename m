Subject: Re: pismo upgraded to 750fx not detected correctly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: Terry Greeniaus <tgree@phys.ualberta.ca>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.44.0306211127030.29956-100000@stoa.dhs.org>
References: <Pine.LNX.4.44.0306211127030.29956-100000@stoa.dhs.org>
Content-Type: text/plain
Message-Id: <1056275365.3808.49.camel@gaston>
Mime-Version: 1.0
Date: 22 Jun 2003 11:49:25 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-06-21 at 17:58, Chris Studholme wrote:
> Terry,
>
> Thanks for the code snippet and all the info.  I hope to add this check
> immediately after the device-tree is copied to ram and then I'll modify
> the in ram version to reflect the properties of a 750fx.  I'll post a
> patch here when I get something working.

Note that the kernel doesn't use the device tree to detect the
CPU type. It rather runs the PVR through a table in
arch/ppc/kernel/cputable.c. There is currently no hook you could
use to 'fix' that. Ideally, you should make sure the CPU is properly
detected before the fixups are done or you may "lose" some 750fx
specific code.

Terry: do you setup PLL1 ? I assume it's set to a low freq by
the firmware and switch to it during idle among others...

If PLL1 isn't set, you should probably not set powersave_lowspeed
in arch/ppc/platforms/pmac_feature.c.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
