Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s12.bay0.hotmail.com (bay0-omc3-s12.bay0.hotmail.com
	[65.54.246.212]) by ozlabs.org (Postfix) with ESMTP id 12566DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Feb 2007 02:25:33 +1100 (EST)
Message-ID: <BAY110-F2794FF16F3A122FD2309AFB2920@phx.gbl>
In-Reply-To: <Pine.LNX.4.61.0702091527440.32063@imrek.org>
From: "Ming Liu" <eemingliu@hotmail.com>
To: imrek@atomki.hu
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Sun, 11 Feb 2007 15:25:29 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Jozsef,
Thank you so much for your hints. After your telling, I tried as you told 
me. Here I list the script file and result.

#! /bin/sh
insmod ./pktgen.ko

PGDEV=/proc/net/pktgen/pg0

pgset() {
    local result

    echo $1 > $PGDEV

    result=`cat $PGDEV | fgrep "Result: OK:"`
    if [ "$result" = "" ]; then
         cat $PGDEV | fgrep Result:
    fi
}

pg() {
    echo inject > $PGDEV
    cat $PGDEV
}

pgset "odev eth0"
pgset "dst 192.168.0.3"
pgset "pkt_size 8500"
pg

My board IP is 192.168.0.5 and my PC is 192.168.0.3. Also in my linux, 
Jumbo-frame size of 8500 is supported (max is 8982) and then I set the 
pkt_size as 8500. Here goes the result:

pktgen.c: v1.4: Packet Generator for packet performance testing.
pktgen version 1.32
Params: count 100000  pkt_size: 8500  frags: 0  ipg: 0  clone_skb: 0 odev 
"eth0"
     dst_min: 192.168.0.3  dst_max:   src_min:   src_max:
     src_mac: 00:00:00:00:00:00  dst_mac: 00:00:00:00:00:00
     udp_src_min: 9  udp_src_max: 9  udp_dst_min: 9  udp_dst_max: 9
     src_mac_count: 0  dst_mac_count: 0
     Flags:
Current:
     pkts-sofar: 100000  errors: 0
     started: 3555387ms  stopped: 3562242ms  now: 3562242ms  idle: 
1267914442ns
     seq_num: 100000  cur_dst_mac_offset: 0  cur_src_mac_offset: 0
     cur_saddr: 0xc0a80005  cur_daddr: 0xc0a80003  cur_udp_dst: 9  
cur_udp_src: 9
Result: OK: 6824904(c2584388+d4240516) usec, 100000 (8504byte,0frags)
  14652pps 996Mb/sec (996804864bps) errors: 0
#

In the end, it shows 996Mb/sec, which means the throughput is 
996Mbps(almost gigabit), right?

However I don't think this result is so meaningful because it bypass the 
processing for TCP/UDP packets. In the practical implementation, that's not 
possible. The TCP/UDP packets have to been processed, right?  In fact, this 
almost gigabit speed is just a representation of the Gigabit ethernet 
capability while the bottleneck of the system is not there. So I still need 
to solve my practical unsatisfying performance in my design. :(

Anyway thanks for your hints and welcome to a deeper discussion.

BR
Ming

>From: jozsef imrek <imrek@atomki.hu>
>To: linuxppc-embedded@ozlabs.org
>CC: rick.moleres@xilinx.com
>Subject: RE: Speed of plb_temac 3.00 on ML403
>Date: Fri, 9 Feb 2007 15:57:15 +0100 (CET)
>
>On Fri, 9 Feb 2007, Ming Liu wrote:
>
> > Now with my system(plb_temac and hard_temac v3.00 with all features 
enabled
> > to improve the performance, Linux 2.6.10, 300Mhz ppc, netperf), I can 
achieve
> > AT MOST 213.8Mbps for TCP TX and 277.4Mbps for TCP RX, when jumbo-frame 
is
> > enabled as 8500. For UDP it is 350Mbps for TX, also 8500 jumbo-frame is
> > enabled.
> > So it looks that my results are still much less than yours from
> > Xilinx(550Mbps TCP TX). So I am trying to find the bottleneck and 
improve the
> > performance.
>
>
>when testing network performance you might want to use the packet
>generator included in the 2.6 linux kernel (in menuconfig go to
>Networking -> Networking options -> Network testing -> Packet Generator).
>
>with this tool you can bypass the ip stack, user space/kernel space
>barrier, etc, and measure the speed of the hardware itself using UDP-like
>packets.
>
>using pktgen i have seen data rates close to gigabit. (the hardware i'm
>working with is a memec minimodule with V4FX12. i'm using plb_temac with
>s/g dma, plb running at 100MHz, and our custom core accessed via IPIF's
>address range. sw is linux 2.6.19, xilinx tools are EDK 8.2i)
>
>
>
>another hint: when transfering bulk amount of data TCP is probably an
>overkill, especially on dedicated intranets and given the reliability
>of the network devices available today. just use UDP if you can.
>
>
>--
>mazsi
>
>----------------------------------------------------------------
>strawberry fields forever!                       imrek@atomki.hu
>----------------------------------------------------------------
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
