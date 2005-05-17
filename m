Return-Path: <tim.martin@viasat.com>
Received: from annex.viasat.com (eagle.viasat.com [199.106.52.54])
	by ozlabs.org (Postfix) with ESMTP id A29A9679FE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 04:01:11 +1000 (EST)
Message-ID: <846BA3AF7C8A2048937F1801FD3129C902DB594D@messenger.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: 'Wrobel Heinz-r39252' <Heinz.Wrobel@freescale.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Tue, 17 May 2005 11:01:04 -0700
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

> descriptors (BDs) from the CPM with the OV bit set (bit 14 of the RxBD
> status/control field, "Overrun. Set when a receiver overrun 
> occurs during
> reception").

> - SDRAM setup. If ORx(BIH)=1 makes the problem go away, your burst setup
or the /TA pullup is broken. NB: Neither the SCC 
> nor the SMC do bursts.

I checked my SDRAM setup.  SDRAM is the only device configured with UPMA and
it's on cs1, so I checked UPMA, OR1, BR1, MAMR configuration along with
MCR/MAR process for issuing precharge, refresh, and SDRAM mode register
config per the datasheet for the parts.  This board is a few years old, so I
wasn't able to find the datasheet the original timings were made from -
instead I looked at the datasheet for the parts we're using now, and (since
the parts we're using now are faster) our memory timings are somewhat
conservative.

I did try disabling bursts, with no luck.  Not sure what "NB" means. 

> - Did you by accident happen to enable any IDMA lines?

No

> - Did you happen to misconfigure RCCR(DRxM)?

RCCR is all zero's except RCCR[ERAM]=b11 since I have the SCC/SMC microcode
patch.  Even though IDMA is disabled, I have tried setting RCCR[DRPQ]=b10 to
make IDMA requests have the lowest priority (didn't help/hurt).  The DRxM
bits are edge sensitive.

> - Did you happen to misconfigure the SDCR?
SDCR[FRZ] = 0 (ignore the freeze signal)
SDCR[FAID] = 0 (highest priority default, although I'm not using FEC).
SDCR[RAID] = b01 (priority level 5)

>One other thing. If you have an old BDM debugger *and* if the problem
occurs *only* with the BDM debugger hooked up, you may 
>want to check for an update or replacement. Old debuggers sometimes used a
method to do BDM which could stall the DMAs in 
>the machine and cause this kind of overrun/underrun effect.

Hmm...interesting.  How old?  Does this happen when actively debugging
(setting breakpoints, etc) or just running with no breakpoints set?  I have
two different debuggers, a OCD raven wiggler and a BDM module for my
HP16702A logic analyzer.  I have to run different debugger software on each
for licensing reasons (SingleStep 7.5 on the raven and GHS MULTI4.0.5 on the
HP).  The problem occurs on both.

Heinz
 
