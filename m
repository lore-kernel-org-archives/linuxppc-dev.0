Message-Id: <5.2.1.1.0.20030825151326.020aa220@mail.etinc.com>
Date: Mon, 25 Aug 2003 15:13:59 -0400
To: "zhongqx-local" <zhongqx@guoguang.com.cn>
From: Sales <sales@etinc.com>
Subject: Re: Fw: linux Bridge: out of memory!!
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	<alan@lxorguk.ukuu.org.uk>
In-Reply-To: <001601c36877$452d27d0$7301a8c0@zhongqx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We dont use the LINUX bridge code, we have our own.

At 02:33 AM 08/22/2003, zhongqx-local wrote:

>----- Original Message -----
>From: zhongqx-local
>To: dennis@etinc.com
>Cc: linuxppc-embedded@lists.linuxppc.org ; alan@lxorguk.ukuu.org.uk
>Sent: Friday, August 22, 2003 2:32 PM
>Subject: linux Bridge: out of memory!!
>
>
>Sir,
>     Read you problem from internet, I also meet the same problem with
> you, have you already
>solved the linux memory issue with net bridge ? if so can you tell me how
>to deal with it?
>thank you advanced !!!
>     what version of linux are you use? I can not use mark_bh(NET_BH)
> which NET_BH is not defined in the kernel 2.4.4.what is the instead the
> NET_BH in 2.4.4?
>
>     I describe the problem in the following:
>
>
>     I am developing a BRIDGE with in MPC860 and linux kernel 2.4.4(denx
> linux-2.4.4-2002-02-14).I make a bridge BR0 with eth1(100M FEC) and eth0
> (10M scc1),my total ram is 16M ,I used a 6M ramdisk.When I boot
>the kernel I find the free memory is about 5M,But when I ftp a large files
>through the bridge,I find that
>the free memory become fewer and fewer,at last the free memory is about
>500K ,then the kernel killed all process and restart itself like the following:
>
>
>#
># | STATE_BRID_I1: retransmission; will wait 10s for response time 1
>br0: port 2(eth1) entering learning state
>br0: port 1(eth0) entering learning state
>br0: received tcn bpdu on port 2(eth1)
>br0: topology change detected, propagating
>| STATE_BRID_I1: retransmission; will wait 10s for response time 2
>br0: port 2(eth1) entering forwarding state
>br0: topology change detected, propagating
>br0: port 1(eth0) entering forwarding state
>br0: topology change detected, propagating
>| it seens Center ID is illegal
>| STATE_BRID_I1: retransmission; will wait 10s for response time 3
>| add center 192.168.1.242 public key sucessly
>send work key to bridge c0a801f2
>total drop skb 1 packet!
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>__alloc_pages: 0-order allocation failed.
>eth0: Memory squeeze, dropping packet.
>eth1: Memory squeeze, dropping packet.
>__alloc_pages: 0-order allocation failed.
>eth1: Memory squeeze, dropping packet.
>Out of Memory: Killed process 21 (sh).
>Terminated
>Out of Memory: Killed process 7 (linuxrc).
>
>The system is going down NOW !!
>Sending SIGTERM to all processes.
>klips_debug:pfkey_remove_socket: succeeded.
>klips_debug:pfkey_destroy_socket: destroyed.
>klips_debug:pfkey_release: succeeded.
>Sending SIGKILL to all processes.
>Please stand by while rebooting the system.
>Restarting syst
>
>PPCBoot 1.1.5 (Mar 26 2003 - 10:24:01)
>
>CPU:   XPC860xxZPnnD4 at 50.00 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
>Board: Embedded Linux development kits for MPC8xx se
>ries...
>DRAM:  16 MB
>In:    serial
>Out:   serial
>Err:   serial
>
>'Type "run flash_nfs" to mount root filesystem over NFS'
>
>Hit any key to stop autoboot:  0
>BOOTP broadcast 1
>
>
>
>
>
>
>
>
>
>At 10:23 PM 09/07/2000 +0100, Alan Cox wrote:
> >> >Your explanation doesn't fit your observations. I suspect #2 may have
> some
> >> >significance but that would be unrelated to the rate of resource usage.
> >>
> >> Then why does inserting a "mark_bh" after a kfree_skb alleviate the
> problem
> >> somewhat? it certainly doesnt add to the performance.
> >
> >The mark_bh is already there. it sounds ot me like you are changing timing
> >patterns by causing a cpu stall on the memory bus
> >
>
>
>No, its not.
>
>
>I know you are busy, but it would be helpful if you actually read what I
>wrote before you answer.
>
>
>We have modifyed to ethernet driver to check the address before queuing the
>packet. There is virtually no overhead. Plus, when packets ARENT freed
>(such as when they are forwarded) a much more cpu intensive operation of
>cloning the packet and queuing it is done instead, and there are no
>problems doing > 100K pps. so its not causing any cpu stalls.
>
>
>
>Here's a test that even the college freshmen can understand:
>
>
>1) Set up a box with an eepro100 as a second card and modify the driver by
>simply replacing netif_rx() with kfree_skb(). My system is a 200Mhz Pentium
>
>
>skb->protocol.....
>kfree_skb(skb);
>sp->stats.rx_packets++
>yada, yada, yada....
>
>
>2) give the card an address with an ifconfig in rc.local
>3) wire the box to another box or hub/switch @ 100Mb/s
>4) setup a traffic generater on the wire and force the mac address to
>either broadcast or the mac address of the eepro card ie "arp -s
>207.11.14.1 ff:ff:ff:ff:ff:ff" so that the card will get the packets. You
>can check the rxpacket count with ifconfig to verify that the card is
>receiving the packets.
>5) fire packets at the eepro100 card...my test was about 4000pps.
>6) reboot the linux box
>
>
>virtually every time, the eepro driver will complain about "no resources"
>before the login prompt is displayed.
>
>
>7) now, modify the driver to include a mark_bh()
>
>
>skb->protocol.....
>kfree_skb(skb);
>mark_bh(NET_BH);
>sp->stats.rx_packets++
>yada, yada, yada....
>
>
>the complaints are noticably less.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
