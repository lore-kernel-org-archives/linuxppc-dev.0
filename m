Date: Fri, 29 Mar 02 15:59:44 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203292359.AA12953@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> I have other things to do so I won't be able to finish today.  In case
> someone wants to work on this over the weekend, attached is a patch of
> what I have so far.  It implements the example bi_rec's emailed before
> for the ev64260 board.  Feel free to use it or do a better job.

Looks OK except for 2 major problems:

1. You are using find_bootinfo() in EV-64260 platform_init to find the bi_recs.
This is bad, as the magic location where find_bootinfo looks for the bi_recs is
unavailable to bootloaders outside the linux source tree. Instead I have
adopted the convention (which Tom Rini has accepted for the K2 port and
implemented in the wrapper) to pass the physical address of bi_recs to the
kernel in R3. You should use r3 + KERNELBASE in platform_init to find the
bi_recs. This works with the wrapper just as well as find_bootinfo(), but is
much nicer for external bootloaders.

2. You are also using find_bootinfo() in the gt64260_eth driver to find its
bi_recs. In addition to the problems mentioned above, this has the extra
problem in that find_bootinfo's magic location, or any other bootloader's
location for that matter, has certainly been overwritten at this point. If you
want to peek at bi_recs after platform_init(), you have to have setup.c or
something copy them into memory that the kernel will retain.

Because of problem #2 your code will most certainly not work as it is right
now.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
