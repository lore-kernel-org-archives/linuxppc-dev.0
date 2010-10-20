Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler1.mail.xerox.com (wvmler1.mail.xerox.com [13.8.138.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler1.mail.xerox.com",
	Issuer "AAA Certificate Services" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FFA8B70CB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 00:07:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Freescale P2020/ 85xx PCIe: DMA low throughtput
Date: Wed, 20 Oct 2010 13:49:19 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB90355C3CA@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <4CBEC62E.30900@extricom.com>
References: <4CBEC62E.30900@extricom.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Natalie Shapira" <natalie@extricom.com>, <galak@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>, <leoli@freescale.com>, <zw@zh-kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi,=20
>=20
> I'm working on bring up for a new board based on Freescales p2020.
> I have a programmable FPGA as a PCIe device with a buffer I can
> write to and from.
> I want to test  performence for the PCIe bus.=20
> I encountered a problem while doing a DMA between the FPGA & DDR.=20
> The whole buffer  moves  to and from  the device  with out
> mismatches but with low throughtput.=20
> The thing is that the buffer divided to many transactions of byte
> size instead of transferring it in a burst.=20
> I must mention that even a buffer of word size, divided in to byte
> transactions by the DMA (the core can read a word so it seems like
> the DMA fault.
> I tried to change the latency timer, max latency, min latency and
> cache line in the configuration space of both sides of the pcie
> bus. It didn't help.
> Do you have an idea what can it be?=20
>=20
> Thanks,
> Natalie.=20

Assuming the P2020 has the usual 85xx-style DMA engine, you may have
the Band Width Control cleared to 0. This 4-bit field (BWC) restricts
the transfer size to 2^BWC bytes, for BWC=3D0,1,..0xa. 0xb-0xe are
reserved. 0xf disables bandwidth sharing to allow uninterrupted
transfers from each channel, so if you are using several channels
one channel can completely lock out other channels. BWC=3D0x8 at reset
(2^8 =3D 256 bytes). See the P2020 manual for more details.

BWC is the field with mask 0x0f000000 in the MR (Master Reset)
register for the channel (0, 1, 2, 3), at offset 0x100, 0x180, 0x200,
0x280 relative to the base of the DMA controller.

Clive
