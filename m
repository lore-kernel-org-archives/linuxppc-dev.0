In-Reply-To: <14404.17703.247016.528826@cpu.wpi.edu>
Date: Wed, 1 Dec 1999 12:39:16 +0100
To: Josh Huber <huberj@wpi.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: wallstreet power usage...
Message-Id: <19991201123916.024054@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 30, 1999, Josh Huber <huberj@wpi.edu> wrote:

>Hey, for those who know, how could I extend the battery life for my
WallStreet
>when it's both sleeping, and when it's awake...
>
>does the /proc/sys/kernel/powersave-nap setting do anything for the
wallstreet
>series machines?
>
>With Batmon, it seems that the power usage is like:
>powersave-nap      current
>0                  -1350
>1                  -1550
>
>the number varies, of course...but they appear to be about 200 off from
>eachother.
>
>Doesn't this seem a little backwards to any of you? It seems backwards
to what
>Paul is doing for the 3400 in the pwrctl script.
>
>Any other tips?  Is it possible to turn off hardware like: ethernet, sound,
>video (I know this is a little buggy...for my machine anyway)?
>
>I ask, because while the machine is sleeping, in about 6 hours 25% of the
>battery seems to be used, which is far far more than used when sleeping in
>macos.

be careful with nap mode, it will turn cache coherency OFF, and so any
device doing DMA will end up doing weird things....

Sleeping is another matter. It may still eat power because some devices
may not yet be fully powered down. In my latest kernel, I added code to
turn off the sound chip, it may help (but you need to have dmasound
module insmod'ed or insmod'ed and rmmod'ed at least once for this to work).

I'm still wondering about a strange piece of code Apple used in their own
sleep stuff, it's possible that without that hack, the PCI bridge doesn't
go to sleep. I'll try to do more experiments with that one of those days.

Video sleep should work fine as long as you have a correct mclk/pll setting.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
