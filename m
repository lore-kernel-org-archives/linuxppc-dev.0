Date: Sun, 22 Jun 2003 15:58:49 -0600 (MDT)
From: Terry Greeniaus <tgree@phys.ualberta.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chris Studholme <cvs@cs.utoronto.ca>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo upgraded to 750fx not detected correctly
In-Reply-To: <1056275365.3808.49.camel@gaston>
Message-ID: <Pine.LNX.4.10.10306221552510.7619-100000@pneuma.phys.ualberta.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22 Jun 2003, Benjamin Herrenschmidt wrote:

> Note that the kernel doesn't use the device tree to detect the
> CPU type. It rather runs the PVR through a table in
> arch/ppc/kernel/cputable.c. There is currently no hook you could
> use to 'fix' that. Ideally, you should make sure the CPU is properly
> detected before the fixups are done or you may "lose" some 750fx
> specific code.
>
> Terry: do you setup PLL1 ? I assume it's set to a low freq by
> the firmware and switch to it during idle among others...
>
> If PLL1 isn't set, you should probably not set powersave_lowspeed
> in arch/ppc/platforms/pmac_feature.c.

Currently we don't ship any LinuxPPC software with the upgrades.  The
hardware is strapped so that its built-in PLL comes up at the maximum
speed of the upgrade (usually 900 MHz).  This allows software to
determine the range of allowed PLL settings.  The user can attempt to
overclock by running the software in "advanced" mode, but that isn't
documented or supported really.  The software we ship allows the user to
manually configure the CPU speed by switching the PLLs, if that's what
you're asking I can post some code to do that, but I thought LinuxPPC
already had something similar.  We don't downclock the CPU when it is
idle, but that would probably be a nice power saver.

TG


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
