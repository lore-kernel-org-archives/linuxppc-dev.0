Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C38C12C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 23:40:31 +1100 (EST)
Date: Thu, 26 Dec 2013 13:40:23 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v6 4/5] dma: mpc512x: register for device tree
 channel lookup
Message-ID: <20131226124023.GJ8064@book.gsilab.sittig.org>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
 <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 24, 2013 at 16:06 +0400, Alexander Popov wrote:
> 
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> @@ -0,0 +1,55 @@
> +* Freescale MPC512x DMA Controller
> +
> +[ ... ]
> +
> +DMA controller node properties:
> +
> +Required properties:
> +- compatible:		should be "fsl,mpc5121-dma"
> +- reg:			address and size of the DMA controller's register set
> +- interrupts:		interrupt spec for the DMA controller
> +
> +Optional properties:
> +- #dma-cells:		must be <1>, describes the number of integer cells
> +			needed to specify the 'dmas' property in client nodes,
> +			strongly recommended since common client helper code
> +			uses this property

Given how time has passed and that we learned something in the
meantime, I guess the device tree documentation would look
different today than what was written back then.

- I'd reference the generic interrupt bindings as well, so DTS
  authors need not guess what an interrupt spec looks like
- the #dma-cells would become less confusing is it referenced the
  generic DMA binding, and just say that the value is "the length
  of the DMA specifier" for this provider
- the property's being recommended should not get hidden in the
  description but should reflect in the group's caption
- the binding doc shold not reference implementation details of
  one specific user (common client helper code)


[ device tree binding doc policy? ]

That one Linux driver handles both MPC5121 and MPC8308 hardware
and implements the same binding in both cases should get
reflected in the documentation as well.  But I'm not certain
whether adding MPC8308 into an MPX5121 document is better than
duplicating MPC5121 information in another MPC8308 document.  But
it might be the lesser evil.

Are there opinions, established preferences?  Is an exhaustive
list of compatible strings good enough since text search will
match regardless of the document's filename in this case?

There must have been this situation before of a component being
used in one SoC and getting re-used in another SoC later, too.
What's the best document to "get inspired from", i.e. how to best
put this into binding document wording as well as filenames?

> +[ ... ]
> +Client node properties:
> +
> +Required properties:
> +- dmas:			list of DMA specifiers, consisting each of a handle
> +			for the DMA controller and integer cells to specify
> +			the channel used within the DMA controller
> +- dma-names:		list of identifier strings for the DMA specifiers,
> +			client device driver code uses these strings to
> +			have DMA channels looked up at the controller

This certainly is wrong (it was before, I just wasn't aware back
then).  The phandle is not part of the specifier.  And the
binding should not discuss what driver code does.  Since the DMA
controller implements the semantics of the common DMA binding,
it's unwise to duplicate the information here.


Let me see how I can improve this document.  Alex, it may be
useful to split the code update and the binding document into
separate patches.  The current status already mixes the code
extension and the binding update with the introduction of the
document which was missing in the first place.  That's why the
binding doc patch is that late in the series.  (Yes, my RFC
"template" was rather dirty, which is why I flagged it as "RFC"
in the first place.)

I guess that I may have to introduce a binding doc reflecting the
given current status, and update it later as new features become
available.

Or -- given that the hardware remains, all the knowledge is there
already, just the implementations' capabilities change -- I might
as well introduce a binding document including OF based DMA
lookup.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
