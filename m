Subject: Re: pismo upgraded to 750fx not detected correctly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Terry Greeniaus <tgree@phys.ualberta.ca>
Cc: Chris Studholme <cvs@cs.utoronto.ca>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10306221552510.7619-100000@pneuma.phys.ualberta.ca>
References: 
	 <Pine.LNX.4.10.10306221552510.7619-100000@pneuma.phys.ualberta.ca>
Content-Type: text/plain
Message-Id: <1056348070.9610.2.camel@gaston>
Mime-Version: 1.0
Date: 23 Jun 2003 08:01:10 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Currently we don't ship any LinuxPPC software with the upgrades.  The
> hardware is strapped so that its built-in PLL comes up at the maximum
> speed of the upgrade (usually 900 MHz).  This allows software to
> determine the range of allowed PLL settings.  The user can attempt to
> overclock by running the software in "advanced" mode, but that isn't
> documented or supported really.  The software we ship allows the user to
> manually configure the CPU speed by switching the PLLs, if that's what
> you're asking I can post some code to do that, but I thought LinuxPPC
> already had something similar.  We don't downclock the CPU when it is
> idle, but that would probably be a nice power saver.

We do have code to switch between PLL0 and PLL1, but that code assumes
that PLL1 was already set to an arbitrary "low speed", typically 400Mhz,
by the firmware (we could also lower the core voltage when switching
to low speed on some ibooks but I haven't implemented that yet).

So unless we have some code to detect that PLL1 isn't initialized and
then set it up properly, the user should disable that powersave_lowspeed
code or the kernel will try to switch to PLL1

Ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
