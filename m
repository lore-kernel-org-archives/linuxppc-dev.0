Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F4302C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2012 10:51:10 +1100 (EST)
Message-ID: <1352073062.12271.268.camel@pasglop>
Subject: Re: RFC: book3e: DCR MMIO for IBM Blue Gene/Q
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@pobox.com>
Date: Mon, 05 Nov 2012 10:51:02 +1100
In-Reply-To: <020B0706-E2BD-4A6C-8644-D235278655ED@pobox.com>
References: <020B0706-E2BD-4A6C-8644-D235278655ED@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-11-04 at 10:32 -0600, Jimi Xenidis wrote:
> I want to use the stuff in arch/platform/sysdev/dcr.c and I have a couple of questions:
> 1) anyone have a good devtree binding for this?

Not really, I think the cell stuff was the last we looked at this.

> I'm thinking:
> 	bgq {
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 		...
> 
> 		dcr {
> 			reg = <0x3ff 0xe0000000 0x0 0x08000000>;
> 			compatible = "ibm,bgq-dcr";
> 			dcr-controller;
> 			dcr-access-method = "mmio";
> 			dcr-mmio-stride = <??>;
> 		};
> 	};
> 
> I'm not sure what stride I will use since I have yet to figure out the DCR numbering in play at the moment, which will be painful.
> Also, some clarity to the following would be nice:
> 	/* Stride is not properly defined yet, default to 0x10 for Axon */
> 	p = of_get_property(dp, "dcr-mmio-stride", NULL);
> 	stride = (p == NULL) ? 0x10 : *p;
>
> 	/* XXX FIXME: Which property name is to use of the 2 following ? */
> 	p = of_get_property(dp, "dcr-mmio-range", NULL);
> 	if (p == NULL)
> 		p = of_get_property(dp, "dcr-mmio-space", NULL);
> 	if (p == NULL)
> 		goto done;

Not sure what SLOF did back then. dcr-mmio-range sounds better to me.

> I guess my "reg" property is not useful to the code?

Right, unless the DCR "bridge" has some registers of its own. It's also
handy to have as a "standard" way of representing the memory used by the
DCR bridge, tho that does mean duplication... but then it allows you to
have a nice unit address.

> Is there a preference over dcr-mmio-range/space or in the absence of these to we should use "reg"?
> 
> 2) I need 64 bit reads and writes
> My intention is to have dcr_{read,write}_generic_{mmio,native} take an unsigned long for value all the way down.
> For the native case, this would make is similar to mtspr and mfspr.
> For the MMIO case, the selected in/out size would be based on "#ifdef __powerpc64__"

As long as it doesn't break Axon...

Cheers,
Ben.

> Thoughts?
> 
> -jx
> 
