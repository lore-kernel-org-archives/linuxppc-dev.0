Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id AA05DDDE39
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 12:31:10 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2783262wag
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 19:31:07 -0700 (PDT)
Message-ID: <fa686aa40710161931u51213111q6f9d54ba205e2d81@mail.gmail.com>
Date: Tue, 16 Oct 2007 20:31:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH v2] Device tree bindings for Xilinx devices
In-Reply-To: <20071016232404.5F4D51130091@mail133-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
	<20071016232404.5F4D51130091@mail133-blu.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au,
	Wolfgang Reissnegger <wre@xilinx.com>, Leonid <Leonid@a-k-a.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/16/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> It occurs to me that the 'compatible' bindings should probably be the
> name of the preferred driver for the device.
>
> > +   l) Xilinx ML300 Framebuffer
> > +    - compatible : Must include "xilinx,ml300-fb"
> Should probably be 'xilinxfb', and probably shouldn't reference ML300 at
> all.

Actually, I don't think xilinx,ml300-fb is not specific enough (as
opposed to not general enough).  Given that the device tree is
supposed to describe the hardware as uniquely as possible, compatible
should probably contain a value like "xilinx,plb-tft-cntlr-ref-1.00.c"
(<vendor>,<ip core>,<version>).

A design with a modified fb core might specify:

        compatible = "acme,super-tft-1.3","xilinx,plb-tft-cntlr-ref-1.00.c";

Which indicates that it is a different part, but it provides the same
interface as the preexisting plb-tft-cntrl-ref ip core.  Similarly, a
newer reference design which uses a new version of the tft core should
specifiy:

        compatible =
"xilinx,plb-tft-cntrl-ref-1.00.d","xilinx,plb-tft-cntlr-ref-1.00.c";

That way the exact type of device is specified; but it is *compatible*
with the older device.  If the newer device has a greater feature set,
then a driver that can match against the leftmost compatible value can
make use of the extra features.

>
> > +   n) Xilinx EMAC and Xilinx TEMAC
> > +
> > +   Xilinx Ethernet devices.  Uses common properties from
> > other Ethernet
> > +   devices with the following constraints:
> > +
> > +   Required properties:
> > +    - compatible : Must include one of: "xilinx,plb-temac",
> > +                   "xilinx,plb-emac", "xilinx-opb-emac"
> Should probably be just 'emac' and 'temac'.

Actually; looking at the available ip cores; it should probably be:

"xilinx,opb-ethernet-1.02.a" for an emac driver
"xilinx,plb-temac-3.00.a" for a temac.

We should probably use the exact names of the ip core.  Less ambiguity that way.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
