Subject: Re: Wake-on-LAN on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Allen <gallen@arlut.utexas.edu>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <p05200f0bba801e39a47c@[10.8.16.89]>
References: <p05200f0bba801e39a47c@[10.8.16.89]>
Content-Type: text/plain
Message-Id: <1046116715.608.0.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 24 Feb 2003 20:58:36 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-02-24 at 20:45, Greg Allen wrote:
> I have a PowerBook G4, 1GHz. Wake-on-LAN works fine under MacOS X,
> but seems to be ignored on Linux.
>
> My guess is that this belongs in
>     drivers/macintosh/via-pmu.c, at about line 2070:
>
>    /* Tell PMU what events will wake us up */
> ....
>    pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_SET_WAKEUP_EVENTS,
>      0, PMU_PWR_WAKEUP_KEY |
>      (option_lid_wakeup ? PMU_PWR_WAKEUP_LID_OPEN : 0));
>
> Several other options for wakeup are listed in include/linux/pmu.h,
> but Wake-on-LAN is not one of them.
>
> I'd like to make this work and am willing to try, but need more info.
> Questions:
>
> Is this the right place, and there's just a PMU_PWR_WAKEUP_LAN bit missing?
> Does anyone know what that bit is? Perhaps Apple doesn't tell us.
> Is there a MacOSX program that dumps this PMU register, so I can
> twiddle the setting and see if a PMU bit changes?

I don't know if it's related to that PMU command or not. There is definitely
some code to add to sungem driver's PHY management (compare it to what
AppleGMACEthernet does).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
