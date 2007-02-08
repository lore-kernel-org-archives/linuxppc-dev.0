Return-Path: <cem.isik@karel.com.tr>
Message-ID: <45CAF4C4.7030002@karel.com.tr>
Date: Thu, 08 Feb 2007 12:00:36 +0200
From: Cem Vedat ISIK <cem.isik@karel.com.tr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Mpc875 Ethernet does not work under linux.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
Sorry for duplicate posting, since I'm not sure about the topic.

I'm having a problem using ethernet with denx-provided kernel:
linuxppc_2_4_devel-2006-04-06-1735 on mpc875 (a member of mpc885 family).

Ethernet just works (tftpboot and ping are functional) under U-Boot
1.1.6 with mpc875. U-Boot boots with tftpboot, kernel starts (seems
correct-with no error messages) and ifconfig displays,

~ $ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:08:D1:02:06:00
          inet addr:192.168.2.135  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:5540 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:1 dropped:0 overruns:0 carrier:1
          collisions:0 txqueuelen:1000
          RX bytes:583298 (569.6 KiB)  TX bytes:42 (42.0 B)
          Base address:0xe00

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
$

where, the MAC addr is same as in U-Boot ( U-Boot correctly hands the
mac addr to linux kernel).

The mpc875 is situated on a daughter card, plugged onto the main board,
that contains a single phy (lxt972a). We already have a mpc852 based
daughter board which only has a single MII interface that works with the
mainboard hardware and with linuxppc_2_4_devel-2006-04-06-1735 kernel. I
mean, the difference is only the cpu type. The same mainboard/kernel
configuration for mpc852 works fine.

For some real-time patches and considerations, I have to use 2.4.25
kernel (linuxppc_2_4_devel-2006-04-06-1735). Therefore, need an idea on
using ethernet with this kernel.

Despite identifying the eth0 correctly ( which pings itself and
127.0.0.1 ), ping (and wget also) does not work, not only in pinging out
but also in replying pings.

(Pinging PC, from mpc875)
~ $ ping 192.168.2.108
No response from 192.168.2.108
~ $

Pinging the other way around (mpc875 from PC), I get "Destination
Unreachable", that is,

root@cem-kubuntu:/opt/kernel# ping 192.168.2.135
PING 192.168.2.135 (192.168.2.135) 56(84) bytes of data.
>From 192.168.2.108 icmp_seq=1 Destination Host Unreachable
root@cem-kubuntu:/opt/kernel#

At this time, on the serial console of mpc875 I get,

~ $ NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
Ring data dump: cur_tx c3070108, tx_free 0, dirty_tx c3070108, cur_rx
c3070018
 tx: 16 buffers
  c3070100: 9c00 002a 00eb9aa2
  c3070108: 9c00 002a 00eb9322
  c3070110: 9c00 002a 00eb93a2
  c3070118: 9c00 002a 00eb9422
  c3070120: 9c00 002a 00eb94a2
  c3070128: 9c00 002a 00eb9522
  c3070130: 9c00 002a 00eb95a2
  c3070138: 9c00 002a 00eb9622
  c3070140: 9c00 002a 00eb96a2
  c3070148: 9c00 002a 00eb9722
  c3070150: 9c00 002a 00eb97a2
  c3070158: 9c00 002a 00eb9822
  c3070160: 9c00 002a 00eb98a2
  c3070168: 9c00 002a 00eb9922
  c3070170: 9c00 002a 00eb99a2
  c3070178: bc00 002a 00eb9a22
 rx: 32 buffers
  c3070000: 8880 0072 0025c000
  c3070008: 8880 0040 0025c800
  c3070010: 8880 0040 0025b000
  c3070018: 8880 0072 0025b800
  c3070020: 8880 0060 0025a000
  c3070028: 8880 0140 0025a800
  c3070030: 8880 0072 00259000
  c3070038: 8880 0040 00259800
  c3070040: 8880 0072 00258000
  c3070048: 8880 0040 00258800
  c3070050: 8880 0072 00257000
  c3070058: 8880 0072 00257800
  c3070060: 8880 0072 00256000
  c3070068: 8880 005c 00256800
  c3070070: 8880 005c 00255000
  c3070078: 8880 0072 00255800
  c3070080: 8880 0072 00254000
  c3070088: 8880 0072 00254800
  c3070090: 8880 0072 00253000
  c3070098: 8880 0040 00253800
  c30700a0: 8880 0040 00252000
  c30700a8: 8880 0059 00252800
  c30700b0: 8880 0062 00251000
  c30700b8: 8880 0072 00251800
  c30700c0: 8880 0072 00250000
  c30700c8: 8880 0065 00250800
  c30700d0: 8880 0068 0024f000
  c30700d8: 8880 0040 0024f800
  c30700e0: 8880 0072 0024e000
  c30700e8: 8880 0072 0024e800
  c30700f0: 8880 0072 0024d000
  c30700f8: a880 0072 0024d800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.

What can I do, to get ethernet up and working?

I appreciate your help, thank you very much.

--
Cem Vedat ISIK
cem.isik@karel.com.tr


-----------------------------------------------------------------------
Bu mesaj Karel MailScanner ile tehlikeli icerik ve virus kontrolunden gecirilmistir.
KAREL A.S. - Bilgi Teknolojileri Bolumu
This message has been scanned for viruses and dangerous content by Karel MailScanner, and is believed to be clean.
KAREL A.S. - Information Technologies Department
