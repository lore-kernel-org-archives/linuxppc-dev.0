Message-ID: <40AE288A.5040803@ru.mvista.com>
Date: Fri, 21 May 2004 20:04:26 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Shamile Khan <shamile@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Xilinx EMAC - cannot ping
References: <20040519232252.10109.qmail@web11604.mail.yahoo.com>
In-Reply-To: <20040519232252.10109.qmail@web11604.mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Shamile,

 >           TX packets:7 errors:0 dropped:0 overruns:0
...
 > 4) interrupts
 > bash-2.05# cat /proc/interrupts
 >            CPU0
 >  30:       8046     Xilinx INTC  Level  serial
 >  31:          7     Xilinx INTC  Level  eth0
 > BAD:          0
 >
 > 5) Running ethereal on host which I am pinging to, I can
 > see ARP requests from my linux target sent to the host but
 > nothing is sent back to target.
 >

 From the diagnostic results cited above it looks like the
problem is in your host: the tagret sends 7 ARP requests
which are decoded correctly (I assume this because neither
you nor you host complain about ARP requests contents), but
host doesn't respond to them.

I would check the ARP requests contents and then your host settings.

Best regards,
Andrei

Shamile Khan wrote:
> Hi,
>
> I have a Memec FG456 evaluation board with P160 module. I
> am using Xilinx ethernet core (with default configuration
> in mhs file) and the open source linux driver for Xilinx
> EMAC. It seems that the ethernet device is detected
> correctly but I cannot seem to ping any machine in my
> network. I can ping myself though. Here are some diagnostic
> results.
>
> 1) insmod the driver
> bash-2.05# insmod a.out
> eth0: Xilinx EMAC #0 at 0xFEFE8000 mapped to 0xC3008000,
> irq=31
>
> 2)  ifconfig
> bash-2.05# ifconfig eth0 192.168.0.55
> bash-2.05# ifconfig -a
> eth0      Link encap:Ethernet  HWaddr 00:60:08:27:11:7B
>           inet addr:192.168.0.55  Bcast:192.168.0.255
> Mask:255.255.255.0
>           inet6 addr: fe80::260:8ff:fe27:117b/10 Scope:Link
>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0
> frame:0
>           TX packets:7 errors:0 dropped:0 overruns:0
> carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:0 (0.0 b)  TX bytes:414 (414.0 b)
>           Interrupt:31
>
> lo        Link encap:Local Loopback
>           LOOPBACK  MTU:16436  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0
> frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0
> carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>
> sit0      Link encap:IPv6-in-IPv4
>           NOARP  MTU:1480  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0
> frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0
> carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>
> 3) bash-2.05# mii-tool -v
> eth0: negotiated 100baseTx-FD flow-control, link ok
>   product info: vendor 00:10:18, model 30 rev 4
>   basic mode:   autonegotiation enabled
>   basic status: autonegotiation complete, link ok
>   capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD
> 10baseT-HD
>   advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD
> 10baseT-HD flow-control  link partner: 100baseTx-FD
> 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
>
> 4) interrupts
> bash-2.05# cat /proc/interrupts
>            CPU0
>  30:       8046     Xilinx INTC  Level  serial
>  31:          7     Xilinx INTC  Level  eth0
> BAD:          0
>
> 5) Running ethereal on host which I am pinging to, I can
> see ARP requests from my linux target sent to the host but
> nothing is sent back to target.
>
> Any ideas on the source of the problem?
>
> Regards,
> Shamile
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
