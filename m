Return-Path: <stcheng@celestica.com>
Received: from mailgateway1.celestica.com (mail2.celestica.com [205.233.28.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.mail.celestica.com",
	Issuer "mail2.mail.celestica.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 583EA67B1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 19:56:10 +1000 (EST)
Received: from clsgw04.ca-chq.celestica.com ([10.39.8.68])
	by mailgateway1.celestica.com (8.12.10/8.12.11) with ESMTP id
	k5T9u1ss000743
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 Jun 2006 05:56:06 -0400
To: linuxppc-embedded@ozlabs.org
Subject: 8541 FCC transmit timed out
MIME-Version: 1.0
Message-ID: <OF72E76B73.9EE69DFA-ON4825719C.0034B838-4825719C.0036908E@celestica.com>
From: Stephen Cheng <stcheng@celestica.com>
Date: Thu, 29 Jun 2006 17:55:58 +0800
Content-Type: multipart/alternative;
	boundary="=_alternative 0036908B4825719C_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0036908B4825719C_=
Content-Type: text/plain; charset="US-ASCII"

Hi the community,

I encountered the "transmit timed out" problem when I try to bring up the 
FCC on an mpc8541 based board.
I found there are a lot of such issues posted in the list, unfortunately, 
I didn't find a workaround could solve my problem.

The FCC port works fine under U-boot, I can ping the host and download 
files from TFTP server, so the tx/rx clk route should be no problem. The 
command line U-boot transfer to Linux Kernel should be fine too, because 
kernel startup message says: IP-Config Complete ...

When I tried to ping the host after Linux is up, I got the following 
dumped messages:

PING 192.168.1.2 (192.168.1.2) from 192.168.1.192 : 56(84) bytes of data.
>From 192.168.1.192: Destination Host Unreachable
>From 192.168.1.192: Destination Host Unreachable
>From 192.168.1.192: Destination Host Unreachable
>From 192.168.1.192: Destination Host Unreachable
>From 192.168.1.192: Destination Host Unreachable
>From 192.168.1.192: Destination Host Unreachable
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx c0218100 tx_free 0 cur_rx c0218000.
 Tx @base c0218100 :
1c01 0062 0039e962
1c01 0062 0039e662
1c01 0062 0039e862
1c01 0062 0039ea62
5c01 002a 07f45de2
5c01 002a 07f45e62
5c01 002a 07f45ee2
5c01 002a 07f45f62
5c01 002a 07a2b0a2
5c01 002a 07a2b122
5c01 002a 07a2b1a2
5c01 002a 07a2b222
5c01 002a 07a2b2a2
5c01 002a 07a2b322
5c01 002a 07a2b3a2
7c01 002a 07a2b422
 Rx @base c0218000 :
1c80 0040 07706000
1c80 0040 07706800
1c80 0040 07705000
1c00 0040 07705800
1c00 0040 07704000
1c00 0040 07704800
1c00 0040 07703000
1c00 0040 07703800
1c00 0040 07702000
1c00 0040 07702800
1c00 0040 07701000
1c00 0040 07701800
1c00 0040 07700000
1c00 0040 07700800
1c00 0040 003ff000
9000 0000 003ff800
9000 0000 003fe000
9000 0000 003fe800
9000 0000 003fd000
9000 0000 003fd800
9000 0000 003fc000
9000 0000 003fc800
9000 0000 003fb000
9000 0000 003fb800
9000 0000 003fa000
9000 0000 003fa800
9000 0000 003f9000
9000 0000 003f9800
9000 0000 003f8000
9000 0000 003f8800
9000 0000 003f7000
b000 0000 003f7800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
......

The last bit of TxBD_CSR is 1, which means "Carrier Sense Lost", I have no 
idea about why this could happen.

I captured the package at the host side, the host had received the ARP 
request package and had also sent the ARP reply package, however, no ICMP 
package followed.

The Linux version is 2.4.20.

Any comment will be appreciated!

(PS: sorry for my poor English.)

Thanks & Best Regards,
Stephen C.
--=_alternative 0036908B4825719C_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi the community,</font>
<br>
<br><font size=2 face="sans-serif">I encountered the &quot;transmit timed
out&quot; problem when I try to bring up the FCC on an mpc8541 based board.</font>
<br><font size=2 face="sans-serif">I found there are a lot of such issues
posted in the list, unfortunately, I didn't find a workaround could solve
my problem.</font>
<br>
<br><font size=2 face="sans-serif">The FCC port works fine under U-boot,
I can ping the host and download files from TFTP server, so the tx/rx clk
route should be no problem. The command line U-boot transfer to Linux Kernel
should be fine too, because kernel startup message says: IP-Config Complete
...</font>
<br>
<br><font size=2 face="sans-serif">When I tried to ping the host after
Linux is up, I got the following dumped messages:</font>
<br>
<br><font size=2 face="sans-serif">PING 192.168.1.2 (192.168.1.2) from
192.168.1.192 : 56(84) bytes of data.</font>
<br><font size=2 face="sans-serif">From 192.168.1.192: Destination Host
Unreachable</font>
<br><font size=2 face="sans-serif">From 192.168.1.192: Destination Host
Unreachable</font>
<br><font size=2 face="sans-serif">From 192.168.1.192: Destination Host
Unreachable</font>
<br><font size=2 face="sans-serif">From 192.168.1.192: Destination Host
Unreachable</font>
<br><font size=2 face="sans-serif">From 192.168.1.192: Destination Host
Unreachable</font>
<br><font size=2 face="sans-serif">From 192.168.1.192: Destination Host
Unreachable</font>
<br><font size=2 face="sans-serif">NETDEV WATCHDOG: eth0: transmit timed
out</font>
<br><font size=2 face="sans-serif">eth0: transmit timed out.</font>
<br><font size=2 face="sans-serif">&nbsp;Ring data dump: cur_tx c0218100
tx_free 0 cur_rx c0218000.</font>
<br><font size=2 face="sans-serif">&nbsp;Tx @base c0218100 :</font>
<br><font size=2 face="sans-serif">1c01 0062 0039e962</font>
<br><font size=2 face="sans-serif">1c01 0062 0039e662</font>
<br><font size=2 face="sans-serif">1c01 0062 0039e862</font>
<br><font size=2 face="sans-serif">1c01 0062 0039ea62</font>
<br><font size=2 face="sans-serif">5c01 002a 07f45de2</font>
<br><font size=2 face="sans-serif">5c01 002a 07f45e62</font>
<br><font size=2 face="sans-serif">5c01 002a 07f45ee2</font>
<br><font size=2 face="sans-serif">5c01 002a 07f45f62</font>
<br><font size=2 face="sans-serif">5c01 002a 07a2b0a2</font>
<br><font size=2 face="sans-serif">5c01 002a 07a2b122</font>
<br><font size=2 face="sans-serif">5c01 002a 07a2b1a2</font>
<br><font size=2 face="sans-serif">5c01 002a 07a2b222</font>
<br><font size=2 face="sans-serif">5c01 002a 07a2b2a2</font>
<br><font size=2 face="sans-serif">5c01 002a 07a2b322</font>
<br><font size=2 face="sans-serif">5c01 002a 07a2b3a2</font>
<br><font size=2 face="sans-serif">7c01 002a 07a2b422</font>
<br><font size=2 face="sans-serif">&nbsp;Rx @base c0218000 :</font>
<br><font size=2 face="sans-serif">1c80 0040 07706000</font>
<br><font size=2 face="sans-serif">1c80 0040 07706800</font>
<br><font size=2 face="sans-serif">1c80 0040 07705000</font>
<br><font size=2 face="sans-serif">1c00 0040 07705800</font>
<br><font size=2 face="sans-serif">1c00 0040 07704000</font>
<br><font size=2 face="sans-serif">1c00 0040 07704800</font>
<br><font size=2 face="sans-serif">1c00 0040 07703000</font>
<br><font size=2 face="sans-serif">1c00 0040 07703800</font>
<br><font size=2 face="sans-serif">1c00 0040 07702000</font>
<br><font size=2 face="sans-serif">1c00 0040 07702800</font>
<br><font size=2 face="sans-serif">1c00 0040 07701000</font>
<br><font size=2 face="sans-serif">1c00 0040 07701800</font>
<br><font size=2 face="sans-serif">1c00 0040 07700000</font>
<br><font size=2 face="sans-serif">1c00 0040 07700800</font>
<br><font size=2 face="sans-serif">1c00 0040 003ff000</font>
<br><font size=2 face="sans-serif">9000 0000 003ff800</font>
<br><font size=2 face="sans-serif">9000 0000 003fe000</font>
<br><font size=2 face="sans-serif">9000 0000 003fe800</font>
<br><font size=2 face="sans-serif">9000 0000 003fd000</font>
<br><font size=2 face="sans-serif">9000 0000 003fd800</font>
<br><font size=2 face="sans-serif">9000 0000 003fc000</font>
<br><font size=2 face="sans-serif">9000 0000 003fc800</font>
<br><font size=2 face="sans-serif">9000 0000 003fb000</font>
<br><font size=2 face="sans-serif">9000 0000 003fb800</font>
<br><font size=2 face="sans-serif">9000 0000 003fa000</font>
<br><font size=2 face="sans-serif">9000 0000 003fa800</font>
<br><font size=2 face="sans-serif">9000 0000 003f9000</font>
<br><font size=2 face="sans-serif">9000 0000 003f9800</font>
<br><font size=2 face="sans-serif">9000 0000 003f8000</font>
<br><font size=2 face="sans-serif">9000 0000 003f8800</font>
<br><font size=2 face="sans-serif">9000 0000 003f7000</font>
<br><font size=2 face="sans-serif">b000 0000 003f7800</font>
<br><font size=2 face="sans-serif">NETDEV WATCHDOG: eth0: transmit timed
out</font>
<br><font size=2 face="sans-serif">eth0: transmit timed out.</font>
<br><font size=2 face="sans-serif">......</font>
<br>
<br><font size=2 face="sans-serif">The last bit of TxBD_CSR is 1, which
means &quot;Carrier Sense Lost&quot;, I have no idea about why this could
happen.</font>
<br>
<br><font size=2 face="sans-serif">I captured the package at the host side,
the host had received the ARP request package and had also sent the ARP
reply package, however, no ICMP package followed.</font>
<br>
<br><font size=2 face="sans-serif">The Linux version is 2.4.20.</font>
<br>
<br><font size=2 face="sans-serif">Any comment will be appreciated!</font>
<br>
<br><font size=2 face="sans-serif">(PS: sorry for my poor English.)</font>
<br>
<br><font size=2 face="sans-serif">Thanks &amp; Best Regards,<br>
Stephen C.</font>
--=_alternative 0036908B4825719C_=--
