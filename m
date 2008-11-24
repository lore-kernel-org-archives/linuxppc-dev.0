Return-Path: <walsh.benj@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 2132DDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 07:35:53 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so856185ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Nov 2008 12:35:52 -0800 (PST)
From: "Benjamin Walsh" <walsh.benj@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <DF6C7BC3780EE44B83430A9F756D43B6086F5441@SJEXCH03.ds.jdsu.net>
	<113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
Subject: NMI and AMD8131/8111 on Maple board
Date: Mon, 24 Nov 2008 15:35:49 -0500
Message-ID: <012201c94e74$3dbb55b0$e693e080@corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I've written EDAC support for the AMD8131/8111 chips that are present on a
Maple board (PPC970FX with IBM CPC925 memory controller/bridge), currently
running in poll mode. I am now trying to get this to work in interrupt mode.
These two chipsets have a feature that enables triggering an NMI when an
error is detected (PERR and SERR). How can this be hooked into the interrupt
system on a PPC board ?

>From what I understand from the doc for these chipsets, the NMI will
delivered as a HT message to the CPC925 on this board. What I don't get is
how will this be delivered to the CPU, and on what interrupt line ? The HT
message sent to the CPC925 is the following:

MT = NMI
TM = edge
DM = physical
INTRDEST = 'hFF (all)
VECTOR = 'h00 (does not matter)

Any help appreciated.

Thanks,
Ben
