Message-ID: <39708145.63271470@wanadoo.fr>
Date: Sat, 15 Jul 2000 17:20:37 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Upgraded utils...
References: <200007141730.SAA17219@hyperion.valhalla.net> <4.3.2.7.2.20000714210226.039b37f0@mail.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
>
> At 20:54 14.07.00, Martin Costabel wrote:
> >Could be /sbin/hwclock is now a binary that was compiled with
> >util-linux. This doesn't mean it works, though. Better put the old fake
> >hwclock shell script there ("/sbin/clock -s"). Or is one now supposed to
> >create /dev/rtc and use it as on any other architecture?
>
> Yes! That's why I did CONFIG_PPC_RTC, it's such simple code, but it helps a
> lot to bring us in line with the other architectures.

For the record: Yes, it works. (On a Pmac 6400, with a 2.2.17pre11
kernel from bitkeeper; 2.4.0-test4 still doesn't want to boot, so I
can't test it).

I was too timid and had compiled PPC_RTC only as a module. Apparently
the kernel does not load this module automatically, but when I put a
line
  /sbin/modprobe rtc
just before the hwclock stuff in /etc/rc.sysinit, it works (yes
/etc/rc.sysinit; this is initscripts-5.27 which has /etc/rc.d as symlink
to /etc, so that all the rc* stuff now clutters /etc. Big progress...)

/sbin/hwclock comes from util-linux-2.10k, compiled without problems
from the RedHat SRPM.

Thanks

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
