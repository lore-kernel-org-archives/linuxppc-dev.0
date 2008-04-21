Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2AF92DE6CA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 02:51:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Xilinx network trouble (mostly solved)
Date: Mon, 21 Apr 2008 09:50:47 -0700
In-reply-to: <05d401c8a3cb$0b3cc640$ad289e86@LPSC0173W>
References: <03fc01c8a072$67280110$ad289e86@LPSC0173W><20080417155609.9061E1D000B0@mail147-sin.bigfish.com><04c001c8a162$242e7330$ad289e86@LPSC0173W><20080418161454.E9E0C44009E@mail114-dub.bigfish.com>
	<05d401c8a3cb$0b3cc640$ad289e86@LPSC0173W>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>,
	"Rick Moleres" <moleres@xilinx.com>, <linuxppc-dev@ozlabs.org>
Message-Id: <20080421165049.EC56317E0171@mail103-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The easiest way is to edit the .mhs by hand.

Steve

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of
Guillaume Dargaud
> Sent: Monday, April 21, 2008 9:16 AM
> To: Rick Moleres; linuxppc-dev@ozlabs.org
> Subject: Re: Xilinx network trouble (mostly solved)
>=20
> Hi Rick,
>=20
> > You might try v1.00a of the xps_ll_temac core.  There are a couple
of
> > issues with v1.00b (posted previously on this list) that may (or may
> > not) be causing the problem you see.
>=20
> Thanks for the answer... but I can't figure out how to revert to
1.00a. Is
> the option accessible from xps ?
>=20
> As for the EmacLite, it works rather imperfectly:
> ping -s 2952 works
> ping -s 2953 doesn't...:
> [ 2340.664293] Badness at net/core/skbuff.c:317
> [ 2340.668479] NIP: c015bd24 LR: c015b3f4 CTR: 00000000
> [ 2340.673410] REGS: c7d0fd20 TRAP: 0700   Not tainted
(2.6.24-rc8-xlnx)
> [ 2340.679876] MSR: 00029030 <EE,ME,IR,DR>  CR: 28000048  XER:
20000000
> [ 2340.686189] TASK =3D c7c35810[243] 'ping' THREAD: c7d0e000
> [ 2340.691279] GPR00: 00000001 c7d0fdd0 c7c35810 c7d318e0 80000009
00000004
> c027bd38 00000200
> [ 2340.699571] GPR08: c7d0fdb8 c7d0e000 c027bd1c c0159910 c7d0fdb8
100b46f4
> ffffffff 00000000
> [ 2340.707864] GPR16: 10090000 100bd6e0 100b0000 100b0000 00000c11
7fbcf9a0
> 00000000 10004634
> [ 2340.716158] GPR24: 1007d370 7fbced90 10003fbc 100adf18 00000000
00000000
> c7c9e000 c7d318e0
> [ 2340.724625] NIP [c015bd24] skb_release_all+0x6c/0x94
> [ 2340.729551] LR [c015b3f4] __kfree_skb+0x18/0xc0
> [ 2340.734042] Call Trace:
> [ 2340.736465] [c7d0fdd0] [c0161b6c] netif_rx+0x124/0x158 (unreliable)
> [ 2340.742684] [c7d0fde0] [c015b3f4] __kfree_skb+0x18/0xc0
> [ 2340.747866] [c7d0fdf0] [c01466a0] SendHandler+0x44/0x94
> [ 2340.753050] [c7d0fe10] [c0147284]
XEmacLite_InterruptHandler+0x12c/0x140
> [ 2340.759702] [c7d0fe20] [c0146078] xemaclite_interrupt+0x20/0x34
> [ 2340.765577] [c7d0fe30] [c003c98c] handle_IRQ_event+0x4c/0xa0
> [ 2340.771193] [c7d0fe50] [c003ca94] __do_IRQ+0xb4/0x130
> [ 2340.776203] [c7d0fe70] [c0006990] do_IRQ+0x6c/0xa4
> [ 2340.780954] [c7d0fe80] [c000329c] ret_from_except+0x0/0x18
> [ 2340.786397] [c7d0ff40] [c0002c50] ret_from_syscall+0x0/0x3c
> [ 2340.791923] Instruction dump:
> [ 2340.794865] 3000ffff 7c005a2c 7c00592d 40a2fff0 817f006c 54290024
> 2f8b0000 419e0024
> [ 2340.802549] 8009000c 5400011e 7c0000d0 54000ffe <0f000000> 7fe3fb78
> 7d6903a6 4e800421
>  (192.168.1.185): 2953 data bytes
> --
> Guillaume Dargaud
> http://www.gdargaud.net/
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
