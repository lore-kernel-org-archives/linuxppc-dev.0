Message-Id: <200304141044.AA02585@kishinami.cs.fujitsu.co.jp>
From: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
Date: Mon, 14 Apr 2003 19:44:02 +0900
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405GP Networking issue
In-Reply-To: <200303051037.AA02365@kishinami.cs.fujitsu.co.jp>
References: <200303051037.AA02365@kishinami.cs.fujitsu.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Before, we have experienced a failure that the about 60% ping
commands were lost at the below condition.
- custom board designed based on the 405GP
- kernel 2.4.18
- 2.4.21 pre3 ibm_ocp LAN device driver and ported it to
  work on kernel 2.4.18
- repeater hub(10Mbps, half duplex)
- line is much loaded

We investigated the another product designed based on the 405GP
which is not occurred the same failure on the same condition and
we've found the difference and modified the LAN device driver.

[Cause]
- Receive Mode Register(EMAC0_RMR) was not set to receive the
  Runt packet and FCS error packet.
- Even if the above mode is set at the open process(ppc405_enet_open),
  the value was cleared at the multicast configuration process
  (ppc405_enet_set_multicast_list).

[Conclusion]
- In Receive Mode Register(EMAC0_RMR) initialization at the open
  process, allow receiving the runt packet(RRP) and FCS error
  packet(RFP).
  Ex.
	/* enable broadcast and individual address */
	out_be32(&emacp->em0rmr, EMAC_RMR_IAE | EMAC_RMR_BAE);
  ---->
        unsigned long rcv_err_packet=EMAC_RMR_ARRP | EMAC_RMR_ARP;
	/* enable broadcast and individual address */
	out_be32(&emacp->em0rmr,
	 rcv_err_packet | EMAC_RMR_IAE | EMAC_RMR_BAE);

- In ppc405_enet_set_multicast_list(), one of the resolutions is
  to set receiving the error packet in each program line what is
  to be set.
  Ex. (case multicast configuration)
      unsigned long rcv_err_packet=EMAC_RMR_ARRP | EMAC_RMR_ARP;
      out_be32(&emacp->em0rmr,
      rcv_err_packet | EMAC_RMR_IAE | EMAC_RMR_BAE | EMAC_RMR_MAE);

After modification, no frame error was found by ifconfig cmd and no
BAD packet was found in the log file and all ping was succeeded.
We don't understand why such configuration is effective, because
we understand the 405GP's EMAC will discard any bad packets and
managing bad packet by software is not required.
By the way, the reason of another product's LAN device driver is
set to receiving the bad packet is related to the period of development.
At this time(1999), LAN device driver was debugged with engineering
version of 405GP, therefore some error management was covered by
software and this configuration has been kept leaving because no such
failure has occurred as yet.
Sorry not to inform quickly.

Regards. Kishinami

-----
KISHINAMI Masaya
Fujitsu Limited (Japan)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
