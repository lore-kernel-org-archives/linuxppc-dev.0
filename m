Message-Id: <200302281227.AA02348@kishinami.cs.fujitsu.co.jp>
From: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
Date: Fri, 28 Feb 2003 21:27:56 +0900
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405GP Networking issue
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all, it's first time to post.

We are debugging a custom board designed based on the 405GP
(200MHz) and have a problem not being sent ECHO REPLY ping
packet from custom board to our PC via repeater hub on the
heavy traffic under 10Mbps and half duplex condition.
We used the latest version of ibm_ocp LAN device driver at
that time from kernel 2.4.21-pre3 and ported it to work on
the kernel 2.4.18 because it costs many time to boot our
custom board on the latest one. The board works fine unless
not be such a case.

Following are the our simplest duplication process and the
results.

1. Connect the repeater hub to backbone LAN.
2. Connect custom board, test PC to ping and other PCs to the
   repeater hub to the full. This case, 10 or more PCs are
   connected to repeater hub and each PC works normally by
   using network.
3. Increase the traffic by using ftp command. The ftp data was
   never addressed to the custom board.
4. Ping from our PC to custom board at one time.
5. The 60% pings were lost such condition.
6. We investigated the ping lost case.
   - LAN protocol analyzer captured the ECHO REQUEST which was
     address to custom board. It shows ECHO REQUEST was issued
     from our PC to LAN cable.
   - Logic analyzer captured the same ping packet which was
     already been captured by LAN analyzer between PHY(Intel
     LXT971A) and EMAC. It shows ECHO REQUEST was reached just
     before the EMAC.
   - The LAN device driver's receive buffer did not receive the
     ECHO REQUEST by using printk command. We suspected that the
     ECHO REQUEST was not issued to the MAL(Memory Access Layer),
     therefore ECHO REQUEST was not translated to the receive
     buffer.

At the same time, many 4 byte short packet(0x000000f0) which was
not addressed to custom board was received to the LAN device driver's
receive buffer with error status. According to 405GP manual, EMAC
discards the packet which is not of its own.

Have anyone experienced a problem like this?
Any help would be appreciated.

Regards, Kishinami.

-----
KISHINAMI Masaya
Fujitsu Limited (Japan)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
