Return-Path: <mqbitsko@gmail.com>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217]) by ozlabs.org (Postfix) with ESMTP id 6AFF5B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 02:48:32 +1000 (EST)
Received: by gxk9 with SMTP id 9so2226235gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 04 May 2010 09:48:30 -0700 (PDT)
MIME-Version: 1.0
Sender: mqbitsko@gmail.com
Date: Tue, 4 May 2010 11:48:30 -0500
Message-ID: <o2u7ee95fff1005040948s29c5113el18d43c4a59045621@mail.gmail.com>
Subject: fs_enet/mac-fcc: RMII, 10Mb Ethernet not clocking right
From: Ken MacLeod <ken@bitsko.slc.ut.us>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Short version:

Can anyone confirm 10Mb Ethernet works with fs_enet/mac-fcc? with
RMII? with a KS8721 PHY?

Long version:

I have an MPC8247 connected via an externally clocked RMII to a Micrel
KS8721 PHY using the Generic PHY driver, running either MontaVista
2.6.18+ or mainline 2.6.30 (I don't see any relevant changes up to
current mainline).  100Mb Ethernet works fine.

When I use a 10Mb hub (not switch), the PHY registers, mii-tool, and
ethtool all report 10baseT-HD, no autonegotiation.  mac-fcc, restart()
sets the FCC GFEMR CLK bit and clears the FCC FPSMR FDE and LPB bits
(the FCC FPSMR RMII bit is set in all cases).

>From that perspective, it looks like everything is set up correctly to
work at 10Mb.  However, no outgoing packets are received by other
hosts and I see a 1:1 count of incoming errors for the ARP requests
sent by my other host (frame errors, reported as RxBD[NO] nonoctet
aligned errors).

When I connect a scope to the transmit line, I'm seeing the same
timing for both 10Mb and 100Mb.  I would have expected the 10Mb to be
10x longer.

The MPC8272 Reference Manual is confusing on this point, for the FCC
GFEMR CLK field it says "RMII reference clock rate for 50-MHz input
clock from external oscillator (Ethernet mode): 0 == 50MHz (for Fast
Ethernet), 1 == 5MHz (for 10BaseT)"  The RMII spec and the KS8721
datasheet both say REF_CLK should be 50MHz at all times, but I don't
see anything other than the CLK bit to indicate 10Mb cycle timing for
the RMII.

Am I missing something?  What next to try?

Thanks,

  -- Ken
