In-Reply-To: <38F0DD9A.E5DA1AEB@dana.ucc.nau.edu>
Date: Mon, 10 Apr 2000 00:32:54 +0200
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Remaining Pismo issues
Message-Id: <20000410003254.010360@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Apr 9, 2000, Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU> wrote:

>-  Power management in Linux is not so good.  In comparison with the
>MacOS (bad comparison, I know), the battery on my Pismo seems to last
>about an hour less.  If I understand correctly, Apple used a new kind of
>PMU in the new laptops.  Is this correct, and if so, how well is the new
>chip supported?

The PMU is partially supported by some tools, I think. Once I get a
Pismo, I'll try to improve things ;) But the PMU is not the only piece of
the puzzle.

MacOS is quite good at monitoring CPU activity and reducing dynamically
the power consumtion of the machine depending on it's activity. It will
lower the brightness and reduce CPU speed after short periods of
inactivity, it can cut power to some devices when they are not used, does
more aggressive use of USB suspend feature, etc...

Linux has some power management features (like DOZE'ing the CPU in the
idle thread) but some more general work on power management is needed to
really improve things. The sound chip could be shut down optionally when
the driver is not opened (well, eventually disabling the console beep),
the hard disk could be completely powered off instead of just spun down,
and the overall CPU activity could be monitored by a deamon and the CPU
speed adjusted dynamically.

All this need time and a developer to implement them however. If you have
some time, you are welcome ;)

>- Somewhat related to power management problem, the laptop gets much
>hotter when using Linux.  The internal fan runs almost constantly.
>Plus, the computer will often hit the shutdown point of the
>motherboard.  This causes the operating system to freeze, because the
>computer can't operate at such high temperatures.  Has anyone seen this
>problem before and found a way around it?

That's annoying. I beleive currently, linux has almost every single piece
of hardware of this machine powered on all the time. I'll try to improve
things once I get one of these powerbooks. You can try adjusting the hard
disk sleep time to improve things a bit.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
