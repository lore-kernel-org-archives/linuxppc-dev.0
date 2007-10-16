Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id B99D9DDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 05:36:20 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2669857wag
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 12:36:19 -0700 (PDT)
Message-ID: <fa686aa40710161236h4cc82edbqfee328bbcb21c752@mail.gmail.com>
Date: Tue, 16 Oct 2007 13:36:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH v2] Device tree bindings for Xilinx devices
In-Reply-To: <20071016182425.DCBF0BA804F@mail41-fra.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
	<20071016182425.DCBF0BA804F@mail41-fra.bigfish.com>
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
> > +   n) Xilinx EMAC and Xilinx TEMAC
> > +
> > +   Xilinx Ethernet devices.  Uses common properties from
> > other Ethernet
> > +   devices with the following constraints:
> > +
> > +   Required properties:
> > +    - compatible : Must include one of: "xilinx,plb-temac",
> > +                   "xilinx,plb-emac", "xilinx-opb-emac"
> > +    - dma-mode : Must be one of "none", "simple", "sg" (sg
> > == scatter gather)
>
> I think it's going to be a significant headache to remap things like the
> dma-mode from the xilinx configurations to something else, and then
> interpret them correctly in the drivers.
>
> Although it lacks a bit in style, perhaps, I'd greatly prefer having
> something like:
>
>         Ethernet_MAC {
>                 xilinx,C_DMA_PRESENT = <1>;
>             ...
>       }
>
> (which happens to correspond to "none" above)

Ugh.  Can't say I'm thrilled about this....

But in this case is might be a necessity.  The IP core is already
parameterized and the best way to describe the device is to use the
existing parameter names.

I want to be careful though.  Parameters can change from one version
of an IP core to another.  The driver needs to be able to determine
what version of the IP core is used so that the parameters make sense.
 I'm also nervous about adding every possible C_ value to the device
node for each xilinx IP-core; that could make the device tree quite
large.  (on the other hand; maybe that doesn't matter... It is
probably a bigger deal for microblaze than powerpc too.).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
