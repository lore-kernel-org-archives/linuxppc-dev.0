Message-ID: <20040521211058.85313.qmail@web11601.mail.yahoo.com>
Date: Fri, 21 May 2004 14:10:58 -0700 (PDT)
From: Shamile Khan <shamile@yahoo.com>
Subject: Re: Xilinx EMAC - cannot ping
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <40AE288A.5040803@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Andrei,

After my original message, I set up system arp cache
manually for both host and target so they dont need to send
any arp requests. Using tcpdump on the host I sniffed the
ping requests and the host seems to respond to the ping
requests from target but target never receives them.

Here are my results (192.168.0.55 is the target and
192.168.0.5 the host)

Ontarget
--------
arp -s 192.168.0.135 00:0D:56:C5:8E:E2
ping 192.168.0.135

On host
-------
[root@ws054 tmp]# tcpdump icmp
tcpdump: listening on eth0
13:55:09.676075 192.168.0.55 > 192.168.0.135: icmp: echo
request (DF)
13:55:09.676153 192.168.0.135 > 192.168.0.55: icmp: echo
reply
13:55:10.677428 192.168.0.55 > 192.168.0.135: icmp: echo
request (DF)
13:55:10.677462 192.168.0.135 > 192.168.0.55: icmp: echo
reply

So it seems that TX for EMAC is working fine but there are
issues with the RX side. I would like to add that I am not
using the patch that you sent few days back.

Regards,
Shamile

--- Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Hi Shamile,
>
>  >           TX packets:7 errors:0 dropped:0 overruns:0
> ...
>  > 4) interrupts
>  > bash-2.05# cat /proc/interrupts
>  >            CPU0
>  >  30:       8046     Xilinx INTC  Level  serial
>  >  31:          7     Xilinx INTC  Level  eth0
>  > BAD:          0
>  >
>  > 5) Running ethereal on host which I am pinging to, I
> can
>  > see ARP requests from my linux target sent to the host
> but
>  > nothing is sent back to target.
>  >
>
>  From the diagnostic results cited above it looks like
> the
> problem is in your host: the tagret sends 7 ARP requests
> which are decoded correctly (I assume this because
> neither
> you nor you host complain about ARP requests contents),
> but
> host doesn't respond to them.
>
> I would check the ARP requests contents and then your
> host settings.
>
> Best regards,
> Andrei
>
> Shamile Khan wrote:
> > Hi,
> >
> > I have a Memec FG456 evaluation board with P160 module.
> I
> > am using Xilinx ethernet core (with default
> configuration
> > in mhs file) and the open source linux driver for
> Xilinx
> > EMAC. It seems that the ethernet device is detected
> > correctly but I cannot seem to ping any machine in my
> > network. I can ping myself though. Here are some
> diagnostic
> > results.
> >
> > 1) insmod the driver
> > bash-2.05# insmod a.out
> > eth0: Xilinx EMAC #0 at 0xFEFE8000 mapped to
> 0xC3008000,
> > irq=31
> >
> > 2)  ifconfig
> > bash-2.05# ifconfig eth0 192.168.0.55
> > bash-2.05# ifconfig -a
> > eth0      Link encap:Ethernet  HWaddr 00:60:08:27:11:7B
> >           inet addr:192.168.0.55  Bcast:192.168.0.255
> > Mask:255.255.255.0
> >           inet6 addr: fe80::260:8ff:fe27:117b/10
> Scope:Link
> >           UP BROADCAST RUNNING  MTU:1500  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0
> > frame:0
> >           TX packets:7 errors:0 dropped:0 overruns:0
> > carrier:0
> >           collisions:0 txqueuelen:100
> >           RX bytes:0 (0.0 b)  TX bytes:414 (414.0 b)
> >           Interrupt:31
> >
> > lo        Link encap:Local Loopback
> >           LOOPBACK  MTU:16436  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0
> > frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0
> > carrier:0
> >           collisions:0 txqueuelen:0
> >           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> >
> > sit0      Link encap:IPv6-in-IPv4
> >           NOARP  MTU:1480  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0
> > frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0
> > carrier:0
> >           collisions:0 txqueuelen:0
> >           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> >
> > 3) bash-2.05# mii-tool -v
> > eth0: negotiated 100baseTx-FD flow-control, link ok
> >   product info: vendor 00:10:18, model 30 rev 4
> >   basic mode:   autonegotiation enabled
> >   basic status: autonegotiation complete, link ok
> >   capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD
> > 10baseT-HD
> >   advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD
> > 10baseT-HD flow-control  link partner: 100baseTx-FD
> > 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
> >
> > 4) interrupts
> > bash-2.05# cat /proc/interrupts
> >            CPU0
> >  30:       8046     Xilinx INTC  Level  serial
> >  31:          7     Xilinx INTC  Level  eth0
> > BAD:          0
> >
> > 5) Running ethereal on host which I am pinging to, I
> can
> > see ARP requests from my linux target sent to the host
> but
> > nothing is sent back to target.
> >
> > Any ideas on the source of the problem?
> >
> > Regards,
> > Shamile
> >
> >
> >
> >
> >
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
