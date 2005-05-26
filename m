Return-Path: <tim.martin@viasat.com>
Received: from annex.viasat.com (eagle.viasat.com [199.106.52.54])
	by ozlabs.org (Postfix) with ESMTP id 8ACD2679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 May 2005 10:32:54 +1000 (EST)
Message-ID: <846BA3AF7C8A2048937F1801FD3129C902DB596D@messenger.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 25 May 2005 17:32:51 -0700
MIME-Version: 1.0
Content-Type: text/plain
Subject: RE: MPC860 CP / CPM Misbehaving
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

An update (and solution) to the problem I was having...Thanks to everyone
who sent me suggestions!

> I'm using a custom MPC860 based embedded board and having problems with
SCC1
> and SMC1 reception.  I have SCC1 setup in ethernet mode, and SMC1 setup in
> UART mode.  The general problem manifests itself as getting receive buffer
> descriptors (BDs) from the CPM with the OV bit set (bit 14 of the RxBD
> status/control field, "Overrun. Set when a receiver overrun occurs during
> reception").

I was apparently the victim of errata in the MPC860, possibly related to a
published errata CPU5 - Instruction MMU bug at page boundaries in show-all
mode.

Either one of the following fixed the problem, but I chose to stick with Fix
#2 since Fix #1 has some other errata associated with it for various MPC860
silicon versions.

Fix #1) Enable SIUMCR[DSHW] - Show address and data of all internal data
cycles.  Not entirely clear why this would have helped, and there's errata
saying NOT to do this (e.g. SIU2)

Fix #2) Disable show all mode (per CPU5), in my case set ICTRL[ISCT_SER]=011
Core is fully serialized/no show cycles is performed for fetched
instructions.

Tim
