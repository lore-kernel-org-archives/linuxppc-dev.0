To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel boot: 'Kernel command line' not getting bootargs????? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Feb 2003 11:39:39 PST."
             <995FF289C9D69747A09E42992644595405B23649@penguin.adic.com>
Date: Tue, 04 Feb 2003 23:00:37 +0100
Message-Id: <20030204220042.CC5A4C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <995FF289C9D69747A09E42992644595405B23649@penguin.adic.com> you wrote:
>
> Ebony/440GP progress update.
>
> I'm almost there ... I can smell it, I can taste it, I can hear it .... but
> I just can't see or feel it yet.

Then open your eyes, because the problem is right in front  of  them,
it seems.

> Wolfgang mentioned this in a previous post. As everyone knows, appropriate
> bootargs need to be passed for the kernel to boot with an nfs-mounted root

... which means that you have to define an envionment variable  named
"bootargs" in U-Boot.

> => printenv
> baudrate=9600
> ethaddr=00:04:AC:E3:1B:54
> serial#=ADIC-Ebony1-iSCSI
> bootcmd=bootp; setenv bootargs root=/dev/nfs rw
> nfsroot=$(serverip):$(rootpath)
> ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off; bootm
> bootdelay=5
> stdin=serial
> stdout=serial
> stderr=serial
> bootfile=/tftpboot/vmlinux.PPCBoot
> filesize=9105f
> gatewayip=172.16.77.1
> netmask=255.255.255.0
> hostname=ebony1-linux-iSCSI
> rootpath=/opt/eldk/ppc_4xx
> ipaddr=172.16.77.152
> serverip=172.16.77.151
>
> Environment size: 465/4092 bytes

But I don't see any bootargs here.

I can see that you will define such a variable if you let the initial
countdown  time  out  and  execute   the   automatic   boot   command
("bootcmd"). But you don't do this. Instead:

> => bootm
> ## Booting image at 00100000 ...
>    Image Name:   Linux-2.4.20
>    Created:      2003-02-03  18:02:31 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    593951 Bytes = 580 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK

...you manually boot the kernel. So no "bootargs" is set in U-Boot, ...

> Linux version 2.4.20 (root@ppc-dev) (gcc version 2.95.4 20010319
> (prerelease/franzo/20011204)) #1 Mon Feb 3 12:59:58 EST 2003
> IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
> On node 0 totalpages: 32768
> zone(0): 4096 pages.
> zone(1): 28672 pages.
> zone(2): 0 pages.
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>
> ****************************
> Kernel command line: ip=on * Why does this not reflect my bootarg??
> ****************************

...and none gets passed to Linux.

Pilot error, it seems.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All he had was nothing, but that was something, and now it  had  been
taken away.                             - Terry Pratchett, _Sourcery_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
