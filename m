Date: Thu, 26 Aug 2004 10:46:43 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Smith, Craig" <craig.d.smith@siemens.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: UDP packet loss (8xx/2.4.26)
Message-ID: <20040826174642.GB16665@gate.ebshome.net>
References: <EA78B62757AF1E4799828249310AC4CA04E09F3D@stca206a.bus.sc.rolm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EA78B62757AF1E4799828249310AC4CA04E09F3D@stca206a.bus.sc.rolm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 26, 2004 at 09:35:17AM -0700, Smith, Craig wrote:
>
> Hello,
> I'm having a problem with UDP packet loss (small packets, simulated
> compressed VoIP calls). The packets are being dropped in netif_rx,
> and if I increase the netdev_max_backlog to something huge I get
> no packet loss, but the delay is pretty bad resulting in terrible
> MOS scores.
>
> I'm trying to decide if my Linux kernel simply can't keep up
> with the traffic or if there's still something I can tweak to
> improve the performance (or maybe I need to try getting a 2.6
> kernel to work).

It's very unlikely 2.6 will make things better.

> Below, I've included a few more details about
> my platform and test setup. The test runs fine on the same
> board with our proprietary OS, so I know it's "physically"
> possible, I'm just evaluating Linux's performance as well.
>
> Kernel: 2.4.26 (kernel.org) w/ mpc860sar (from sourceforge.net)
> CPU: 855T @ 48MHz

This is very low-end CPU :)

> MEM: 16M SDRAM, 4M flash
> LAN: Broadcom BCM5327 10/100 8 port switch
> WAN: Conexant Bt8370 T1 (ATM using mpc860sar code)
>
> Test: 30 compressed voice calls downstream (LAN<-WAN)
> Packet size: ~64bytes IP/UDP + ATM overhead
> In a 30 second test, the test sends ~45000 packets (30 different
> streams), and about 5000 are dropped (unless I increase the
> netdev_max_backlog which just delays the inevitable dropping).
>
> I believe the T1/ATM interface is working fine, I found the source
> of the dropped packets in /proc/net/softnet_stat so that made me
> wonder if the kernel was simply not keeping up.
>
> Should I expect to see this kind of loss with a 2.4 kernel?
> Is it just a matter of tweaking some more networking related parameters?
> Should I be using another distribution of kernel source?

I think you have to work on network driver, make it use NAPI
(http://www.usenix.org/publications/library/proceedings/als01/jamal.html)
and this _may_ help. Using very slow processor without NAPI-enabled
net driver is the main cause of big packet loss on RX path.

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
