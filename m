Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id D2A98DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 04:29:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar tx-babbling-errors
Date: Thu, 19 Feb 2009 12:29:11 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C0770B@CYBORG3.cyclone.com>
In-Reply-To: <12B2E46F-9CA4-4950-B58A-D02E5F3AA079@kernel.crashing.org>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
	<6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C07700@CYBORG3.cyclone.com>
	<d194b8ce0902190848hb53166cj32e7d0bd65021d2e@mail.gmail.com>
	<12B2E46F-9CA4-4950-B58A-D02E5F3AA079@kernel.crashing.org>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	<sjoyeau@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: February 19, 2009 12:04PM
> >
> > Your issue may come from data setup (or corruption) instead of code
> > path: babbling error may occurs when a TSEC TX descriptor hasn't its
> > "last frame" bit set or when the data length is greated than max
> > frame length.
> >
> > --
>=20
> Take a look at TxBD[TR] and see if its getting set ever.
>=20

I added two bug checks:

- one in gfar_clean_tx_ring() after the check for completed frames:

		/* see if any transmits were truncated */
		BUG_ON(lstatus & BD_LFLAG(TXBD_TR));

- one in gfar_start_xmit() at the end to check a flag to see if
TXBD_LAST never gets set.

Within a couple of minutes it bug checked in gfar_clean_tx_ring():

kernel BUG at drivers/net/gianfar.c:1826!
Oops: Exception in kernel mode, sig: 5 [#1]
CYC833-8568
Modules linked in:
NIP: c019a7b8 LR: c019a824 CTR: 00000000
REGS: c0307d50 TRAP: 0700   Not tainted  (2.6.27.6)
MSR: 00021000 <ME>  CR: 44044044  XER: 20000000
TASK =3D c02eb4a8[0] 'swapper' THREAD: c0306000
GPR00: 00010000 c0307e00 c02eb4a8 00000002 00000010 00000001 c030dc48
c0e003c0
GPR08: c0314e80 180107a8 00000000 efab6dd0 24044022 002ae6bc 0000007f
00000010
GPR16: ef84a800 00029000 ef84abec ef84abc0 00000000 00000001 00000073
000001cc
GPR24: 00100100 00000001 ef84abc0 00000400 efab7400 00000000 ef0f9f00
efab71c8
NIP [c019a7b8] gfar_poll+0xb0/0x408
LR [c019a824] gfar_poll+0x11c/0x408
Call Trace:
[c0307e00] [c019a824] gfar_poll+0x11c/0x408 (unreliable)
[c0307e50] [c01cb144] net_rx_action+0xc4/0x180
[c0307e80] [c0036404] __do_softirq+0x74/0xe0
[c0307ea0] [c0004a20] do_softirq+0x54/0x58
[c0307eb0] [c00362b0] irq_exit+0x94/0x98
[c0307ec0] [c0004acc] do_IRQ+0xa8/0xc8
[c0307ed0] [c000e40c] ret_from_except+0x0/0x18
[c0307f90] [c0007c88] cpu_idle+0x50/0xd8
[c0307fb0] [c024b220] __got2_end+0x58/0x68
[c0307fc0] [c02c5808] start_kernel+0x230/0x2ac
[c0307ff0] [c00003c4] skpinv+0x2ec/0x328
Instruction dump:
3a800000 817e0094 a32b0004 57291838 7d3f4a14 7f89e040 7d7b4850 7d295f1e
81290000 2f890000 419c0160 552003de <0f000000> 813f0000 2f190000
55290084
Kernel panic - not syncing: Fatal exception in interrupt



___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________
