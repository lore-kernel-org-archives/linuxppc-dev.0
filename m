In-Reply-To: <v03110701b4edaa5c1f3e@[129.100.29.243]>
Date: Fri, 10 Mar 2000 10:40:38 +0100
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: IDE problems with 2.3.49?- same with 2.2.15pre3
Message-Id: <20000310104038.012318@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 9, 2000, Kevin B. Hendricks <khendricks@ivey.uwo.ca> wrote:

>1. Where can I get the yaboot-0.5 version as a MacOS app that can be used
>from zip
>
>2.  I do not want to again repartition.  Is booting from a zip using the
>o-f keys my only choice now?  Instead of using a zip, could I burn a cd-rom
>with yaboot on it that I put in when I want to of boot and then restart and
>hold down the c key?  Would it be better to put your of-booting script on
>the cdrom?

If you used BootX, then I beleive you already have an HFS or HFS+
partition. Just put yaboot there along with a yaboot.conf file, and set
the OF "boot-device" path to point to it. If you want to dual boot MacOS
and Linux, copy also the dual boot OF script I posted some time ago (it's
also in the ybin package from Ethan Benson) and set OF to boot this
script (and don't forget to edit the OF path inside the script). Then,
use the space bar at boot to choose which OS you want.

>Also, is there any chance BootX will be fixed to work with these machines
>or am I SOL (I spend as much time using MacOS as LinuxPPC and liked the
>control of simple dual booting without messing with of).

There are more chances that we finally make a tool to configure OF and
yaboot easily than for BootX to be fixed. The BootX problem with the
iMacDV is not simple since MacOS actualy shuts down some hardware devices
completely (apparently, the clock of the ATI controller seems to be
switched off) before I take control. With other machines, we would have
to find a way to stop all devices that may do bus mastering and reset
them to a known state.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
