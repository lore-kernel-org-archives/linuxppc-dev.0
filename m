Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EC674DDF33
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 08:40:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] booting-without-of: add Xilinx uart 16550.
Date: Fri, 15 Feb 2008 13:40:17 -0800
In-Reply-To: <47B5E042.9050805@ru.mvista.com>
References: <47B59631.10908@ru.mvista.com><fa686aa40802151038l7488293clb0c47da5b1b1e4fc@mail.gmail.com>
	<47B5E042.9050805@ru.mvista.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080215214018.EA724CB0046@mail174-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Instead of attempting to come up with a generic description
> > of this, I recommend just naming it after the actual device
instance;
> > something like compatible=3D"xlnx,opb-uart16550";
>=20
>     Well, that means that we'll need a to add a code which "glues" the
chip to
> 8250.c driver... well, of_serial.c could be that glue layer if we add
to it
> the ability to recognize Xilinx UART... well, legacy_serial.c could be
taught
> that trick too...
>     Well, we could also add the new compatible, but still claim
"ns16550"
> compatibility...

This actually makes more sense to me...  I'd rather have the code set
the reg-shift than have it explicitly set in the device tree anyway.
The compatibility set should include (at the least):

      opb_uart16550_v1_00_c
      opb_uart16550_v1_00_d
      opb_uart16550_v1_00_e
      plb_uart16550_v1_00_c
      xps_uart16550_v1_00_a

I think this is somewhat independent of Sergei's arguments that generic
ns16550 devices should allow having a reg-shift set....

Steve
