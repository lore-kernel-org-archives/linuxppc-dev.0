From: "Andy Hawkins" <a.hawkins@cabletime.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Problem booting MontaVista kernel on PPChameleonEVB
Date: Wed, 25 Feb 2004 13:52:19 -0000
Message-ID: <001b01c3fba6$95fc03d0$333335bf@cabletime.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

We're trying to get the MontaVista kernel to boot on our
PPChameleonEVB. The closes supported board to the Chameleon in the
MontaVista tree is the evb405ep.

I've made changes to the bd_info structure in the MontaVista kernel,
so that the u-boot parameters are being passed correctly. However, it
never makes it into the start_kernel function.

As far as I can tell from some debugging with the BDI2000, we're
getting a timer interrupt before the time_init function is being
called. This leads to an infinite loop in the interrupt handler.

With the kernel that came from the board (from the DENK tree), we can
get it to boot with no problems. In this instance the time_init
function is called before the timer interrupt first fires.

Can anyone point me to where in the kernel source tree I should be
looking to work out why this is happening? I presume that either the
interrupts aren't being disabled at the start of the kernel, or
perhaps they're being re-enabled too soon?

Any advice would be much appreciated.

Many thanks.

Andy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
