Subject: Re: problem using both mpc857dsl fec and scc1
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Dennis Khoo <dkhoo@atmxdsl.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <003f01c3b9fa$c66e0f10$7ec7c7c7@dkhoo>
References: <019501c3b9c5$b339a060$0400a8c0@eurostudio.local>
	 <003f01c3b9fa$c66e0f10$7ec7c7c7@dkhoo>
Content-Type: text/plain
Message-Id: <1070622713.28153.5.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Fri, 05 Dec 2003 12:11:53 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I would say to double check your parallel port I/O settings

Jaap-Jan

On Thu, 2003-12-04 at 01:08, Dennis Khoo wrote:
> Hi all,
>
> I'm having a peculiar problem.
>
> Briefly, my platform is MPC857DSL IAD board from Motorola.  I'm using U-boot
> 0.4.8 to bootp the kernel(2.4.18 and 2.4.22)  through SCC1 and then load
> NFS.   If I configure the kernel with only SCC1, then everything works
> well(NFS works and ping through eth0 works).  If I configure the kernel with
> only FEC (in fec.c PDPAR[UT]=0,UTMOD[SPLIT]=1,ENCTRL[FEC_PIN_MUX]=1), then
> everything works well through FEC which is hooked up to a RealTek RTL8305S
> switch.
>
> But if I configure the kernel to use both SCC1 and FEC, SCC1 works and FEC
> doesn't.  NFS and ping run well through SCC1(eth0).  But when I try to ping
> out through FEC(eth1), I get ring buffer dumps and no ping response:
>
> NETDEV WATCHDOG: eth1: transmit timed out
> eth1: transmit timed out.
> Ring data dump: cur_tx c1fa8100, tx_free 0, dirty_tx c1fa8100, cur_rx
> c1fa8020
>  tx: 16 buffers
>   c1fa8100: 9c00 002a 01f868c2
>   c1fa8108: 9c00 002a 01f86842
>   c1fa8110: 9c00 002a 01f867c2
>   c1fa8118: 9c00 002a 01f86742
>   c1fa8120: 9c00 002a 01f866c2
>   c1fa8128: 9c00 002a 01f86642
>   c1fa8130: 9c00 002a 01f865c2
>   c1fa8138: 9c00 002a 01f86542
>   c1fa8140: 9c00 002a 01f864c2
>   c1fa8148: 9c00 002a 01f86442
>   c1fa8150: 9c00 002a 01f863c2
>   c1fa8158: 9c00 002a 01f86342
>   c1fa8160: 9c00 002a 01f862c2
>   c1fa8168: 9c00 002a 01dafbe2
>   c1fa8170: 9c00 002a 01dafb62
>   c1fa8178: bc00 002a 01dafce2
>  rx: 32 buffers
>   c1fa8000: 8880 0252 01fa7000
>   c1fa8008: 8880 0040 01fa7800
>   c1fa8010: 8880 0162 01fa6000
>   c1fa8018: 8880 0040 01fa6800
>   c1fa8020: 8000 0000 01fa5000
>   c1fa8028: 8000 0000 01fa5800
>   c1fa8030: 8000 0000 01fa4000
>   c1fa8038: 8000 0000 01fa4800
>   c1fa8040: 8000 0000 01fa3000
>   c1fa8048: 8000 0000 01fa3800
>   c1fa8050: 8000 0000 01fa2000
>   c1fa8058: 8000 0000 01fa2800
>   c1fa8060: 8000 0000 01fa1000
>   c1fa8068: 8000 0000 01fa1800
>   c1fa8070: 8000 0000 01fa0000
>   c1fa8078: 8000 0000 01fa0800
>   c1fa8080: 8000 0000 01f9f000
>   c1fa8088: 8000 0000 01f9f800
>   c1fa8090: 8000 0000 01f9e000
>   c1fa8098: 8000 0000 01f9e800
>   c1fa80a0: 8000 0000 01f9d000
>   c1fa80a8: 8000 0000 01f9d800
>   c1fa80b0: 8000 0000 01f9c000
>   c1fa80b8: 8000 0000 01f9c800
>   c1fa80c0: 8000 0000 01f9b000
>   c1fa80c8: 8000 0000 01f9b800
>   c1fa80d0: 8000 0000 01f9a000
>   c1fa80d8: 8000 0000 01f9a800
>   c1fa80e0: 8000 0000 01f99000
>   c1fa80e8: 8000 0000 01f99800
>   c1fa80f0: 8000 0000 01f98000
>   c1fa80f8: a000 0000 01f98800
>
>
> Doing an ifconfig gives me......(TX errors continue to accumulate
> indefinitely even after I stop ping)
>
> eth0      Link encap:Ethernet  HWaddr 00:02:87:55:66:77
>           inet addr:199.199.199.129  Bcast:199.199.199.255
> Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:1538 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:698 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:1787601 (1.7 Mb)  TX bytes:102816 (100.4 kb)
>           Base address:0x3c00
>
> eth1      Link encap:Ethernet  HWaddr 00:02:87:D5:66:77
>           inet addr:192.168.2.129  Bcast:192.168.2.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:4 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:5 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:1076 (1.0 kb)  TX bytes:672 (672.0 b)
>           Base address:0xe00
>
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:21 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:21 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:2352 (2.2 kb)  TX bytes:2352 (2.2 kb)
>
>
> Any help is deeply appreciated.
>
> Thanks,
> Dennis Khoo
> Software Engineer
> Adapcom, INC.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
