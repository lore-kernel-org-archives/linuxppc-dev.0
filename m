Message-Id: <200303041446.AA02363@kishinami.cs.fujitsu.co.jp>
From: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
Date: Tue, 04 Mar 2003 23:46:17 +0900
To: Mark Wisner <markwiz@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405GP Networking issue
In-Reply-To: <OF81D7CF16.F89A8DA5-ON87256CDB.00561B6D@us.ibm.com>
References: <OF81D7CF16.F89A8DA5-ON87256CDB.00561B6D@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Mark

--- On Sat, 1 Mar 2003 00:41:29 +0900 Mark Wisner<markwiz@us.ibm.com> -san wrote:

>
>Kishinami,
>You are correct, the 405GP's EMAC will discard any bad packets or packets
>that do not meet it's address match mechanism. There is one exception. If
>the packet received gets a good address match and the packet is large but
>has an FCS error, it may pass the bad packet to the MAL. The MAL will
>create an EOB interrupt and the RX_EOB routine should then look at the
>descriptors status bits to see that it is a bad packet.  This is determined
>by the RX threshold value. Once the EMAC starts to send a packet to the MAL
>it will continue to send it, even though it fails the FCS check at the end
>of the packet. Once it starts a packet it runs to completion. SW then needs
>to detect the bad packet by the status bits.
>

I understand the detection mechanism of bad packet. However I think
almost bad packet does not include a FCS error because only ten or
more ping packets or some broadcast address meet custom board's address.
The number of bad packets detected by SW is more than what we sent by
using ping command or broadcast by investigating LAN protocol analyzer.
By the way, is RX threshold a programmed value or related to hard? I wonder
the EMAC0_TRTR meets or not.

>The real question is, why are you receiving what the EMAC thinks are bad
>packets?
>

I don't know. For now, this case can be duplicated only one place. The
condition is as follows.
- Repeater hub which is connected to backbone LAN and many PCs work.
- Line condition is much loaded.

Therefore we think something is wrong with in such a special case.

>If you can isolate the board on a hub with only the ping traffic in
>question it will make things easier to debug. Most of the time when this
>type of thing happens, you have noise between the PHY and the EMAC on the
>MII bus. Here is the way I shoot these types of things.
>1) Put the EMAC in promiscous mode, enable the reception of every bad
>packet it can. You do this by setting the RMR reg. Look at the open routine
>for the device. I think the RMR reg is set there.
>2) Go to the RX_EOB routine where it checks the status bits in the
>descriptor. If it detects a bad packet, print the packet out. Look for any
>odd bit patterns. You may have a noisy bit.
>

The 4 bytes short packet what we once captured is 0x000000f0 pattern.
However, promiscous mode was disabled. Is this data effective? If so,
do you think noisy bit is included?

>Remember, if the MII itnerface is so messed up that the preamble does not
>get deteceted correctly the EMAC will not see the packet at all. When I
>have it this type of problem, I pull out the Smartbit tester and embed data
>patterns in the packet that may fake the EMAC to think it has a preamble.
>For example, if I think I am dropping bit 0, I will send in a pattern of
>all 5's in the packet for a while and then a F.  By using different data
>paterns you can determing the problem bit or bits. I have also seen where
>there was to much load on a line so it did not switch as it should.
>

The ping flood test by using ping -f command under 100Mbps and
full duplex by connecting custom board and PC directory was almost
good. How do you think about this test result?

>You should send your problem to PPCSUPP@us.ibm.com, IBM support. Send them
>a shapshot of what you captured on the MII interface. Also, a scope capture
>showing the RX_DV( I think that is the name of the MII signal that marks
>the beginning of a RX packet)  line and a data line so they can see how
>they switch together. If the ctl line is late or the data line is early,
>you can get some weird results.
>
>Mark K. Wisner
>Advisory Software Engineer
>IBM Microelectronics
>3039 Cornwallis Rd
>RTP, NC 27709
>Tel. 919-254-7191
>Fax 919-543-7575

Regards, Kishinami


>---------------------- Forwarded by Mark Wisner/Raleigh/IBM on 02/28/2003
>10:36 AM ---------------------------
>
>Mark Wisner
>02/28/2003 09:10 AM
>
>To:    kishinami@cs.fujitsu.com.jp
>cc:
>From:  Mark Wisner/Raleigh/IBM@IBMUS
>Subject:    405GP Networking issue
>
>
>Kishinami,
>You are correct, the 405GP's EMAC will discard any bad packets or packets
>that do not meet it's address match mechanism. There is one exception. If
>the packet received gets a good address match and the packet is large but
>has an FCS error, it may pass the bad packet to the MAL. The MAL will
>create an EOB interrupt and the RX_EOB routine should then look at the
>descriptors status bits to see that it is a bad packet.  This is determined
>by the RX threshold value. Once the EMAC starts to send a packet to the MAL
>it will continue to send it, even though it fails the FCS check at the end
>of the packet. Once it starts a packet it runs to completion. SW then needs
>to detect the bad packet by the status bits.
>
>The real question is, why are you receiving what the EMAC thinks are bad
>packets?
>
>If you can isolate the board on a hub with only the ping traffic in
>question it will make things easier to debug. Most of the time when this
>type of thing happens, you have noise between the PHY and the EMAC on the
>MII bus. Here is the way I shoot these types of things.
>1) Put the EMAC in promiscous mode, enable the reception of every bad
>packet it can. You do this by setting the RMR reg. Look at the open routine
>for the device. I think the RMR reg is set there.
>2) Go to the RX_EOB routine where it checks the status bits in the
>descriptor. If it detects a bad packet, print the packet out. Look for any
>odd bit patterns. You may have a noisy bit.
>
>Remember, if the MII itnerface is so messed up that the preamble does not
>get deteceted correctly the EMAC will not see the packet at all. When I
>have it this type of problem, I pull out the Smartbit tester and embed data
>patterns in the packet that may fake the EMAC to think it has a preamble.
>For example, if I think I am dropping bit 0, I will send in a pattern of
>all 5's in the packet for a while and then a F.  By using different data
>paterns you can determing the problem bit or bits. I have also seen where
>there was to much load on a line so it did not switch as it should.
>
>You should send your problem to PPCSUPP@us.ibm.com, IBM support. Send them
>a shapshot of what you captured on the MII interface. Also, a scope capture
>showing the RX_DV( I think that is the name of the MII signal that marks
>the beginning of a RX packet)  line and a data line so they can see how
>they switch together. If the ctl line is late or the data line is early,
>you can get some weird results.
>
>Mark K. Wisner
>Advisory Software Engineer
>IBM Microelectronics
>3039 Cornwallis Rd
>RTP, NC 27709
>Tel. 919-254-7191
>Fax 919-543-7575
>---------------------- Forwarded by Mark Wisner/Raleigh/IBM on 02/28/2003
>08:34 AM ---------------------------
>
>Ralph Blach
>02/28/2003 08:22 AM
>
>To:    Mark Wisner/Raleigh/IBM@IBMUS
>cc:
>From:  Ralph Blach/Raleigh/IBM@IBMUS
>Subject:    405GP Networking issue
>
>
>
>---------------------- Forwarded by Ralph Blach/Raleigh/IBM on 02/28/2003
>08:22 AM ---------------------------
>
>KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>@lists.linuxppc.org on
>02/28/2003 07:27:56 AM
>
>Sent by:    owner-linuxppc-embedded@lists.linuxppc.org
>
>
>To:    linuxppc-embedded@lists.linuxppc.org
>cc:
>Subject:    405GP Networking issue
>
>
>
>
>Dear all, it's first time to post.
>
>We are debugging a custom board designed based on the 405GP
>(200MHz) and have a problem not being sent ECHO REPLY ping
>packet from custom board to our PC via repeater hub on the
>heavy traffic under 10Mbps and half duplex condition.
>We used the latest version of ibm_ocp LAN device driver at
>that time from kernel 2.4.21-pre3 and ported it to work on
>the kernel 2.4.18 because it costs many time to boot our
>custom board on the latest one. The board works fine unless
>not be such a case.
>
>Following are the our simplest duplication process and the
>results.
>
>1. Connect the repeater hub to backbone LAN.
>2. Connect custom board, test PC to ping and other PCs to the
>   repeater hub to the full. This case, 10 or more PCs are
>   connected to repeater hub and each PC works normally by
>   using network.
>3. Increase the traffic by using ftp command. The ftp data was
>   never addressed to the custom board.
>4. Ping from our PC to custom board at one time.
>5. The 60% pings were lost such condition.
>6. We investigated the ping lost case.
>   - LAN protocol analyzer captured the ECHO REQUEST which was
>     address to custom board. It shows ECHO REQUEST was issued
>     from our PC to LAN cable.
>   - Logic analyzer captured the same ping packet which was
>     already been captured by LAN analyzer between PHY(Intel
>     LXT971A) and EMAC. It shows ECHO REQUEST was reached just
>     before the EMAC.
>   - The LAN device driver's receive buffer did not receive the
>     ECHO REQUEST by using printk command. We suspected that the
>     ECHO REQUEST was not issued to the MAL(Memory Access Layer),
>     therefore ECHO REQUEST was not translated to the receive
>     buffer.
>
>At the same time, many 4 byte short packet(0x000000f0) which was
>not addressed to custom board was received to the LAN device driver's
>receive buffer with error status. According to 405GP manual, EMAC
>discards the packet which is not of its own.
>
>Have anyone experienced a problem like this?
>Any help would be appreciated.
>
>Regards, Kishinami.
>
>-----
>KISHINAMI Masaya
>Fujitsu Limited (Japan)
>
>
>
>

-----
KISHINAMI Masaya
Fujitsu Limited (Japan)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
