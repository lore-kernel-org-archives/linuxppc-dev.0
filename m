Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E07F4140089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 06:50:25 +1000 (EST)
Date: Wed, 16 Apr 2014 22:44:10 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v11 5/6] dma: mpc512x: add device tree binding document
Message-ID: <20140416204410.GP3528@book.gsilab.sittig.org>
References: <1397559250-17680-1-git-send-email-a13xp0p0v88@gmail.com>
 <1397559250-17680-6-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397559250-17680-6-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Anatolij Gustschin <agust@denx.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-15 at 14:54 +0400, Alexander Popov wrote:
> 
> Introduce a device tree binding document for the MPC512x DMA controller
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>

I'm not certain whether the attribution is right.  Is the S-o-b
appropriate when the patch is not "from" me?  As I've stated
before, it's OK if you pick up and extend what I provide, but
please don't pretend that I wrote what you did, and don't pretend
that I ACKed or passed along your submission when I didn't.


This binding certainly needs further improvement to become a good
one.  As I've communicated in the past, I was rather ignorant
"back then" when I wrote v1 and v2 of the RFC.  We have learned
something in the meantime.  Though I admit having gone silent
after several review iterations.  Assumed you would pick up
information that showed up several times on public lists.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> @@ -0,0 +1,51 @@
> +* Freescale MPC512x and MPC8308 DMA Controller
> +
> +The DMA controller in the Freescale MPC512x and MPC8308 SoCs can move
> +blocks of memory contents between memory and peripherals or
> +from memory to memory.
> +
> +Refer to the "Generic DMA Controller and DMA request bindings" in
> +the dma/dma.txt file for a more detailed description of binding.
> +
> +* DMA controller
> +
> +Required properties:
> +- compatible: Should be one of
> +	"fsl,mpc5121-dma"
> +	"fsl,mpc8308-dma", "fsl,mpc5121-dma"

is this a duplicate?  looks funny, needs a fix

or is it a requirement that for MPC8308 you need to provide both
compatible strings?  that would be wrong, as MPC8308 certainly is
not an MPC5121

a quick search reveals: the drivers/dma/mpc512x_dma.c Linux
driver implementation is wrong, it should match on both strings;
expecting the MPC8308 to disguise as an MPC5121 when it's not is
inappropriate (and only went unnoticed because of missing
bindings, I guess)

> +- reg: Address and size of the DMA controller's register set
> +- interrupts: Interrupt for the DMA controller. Generic interrupt client node
> +	is described in interrupt-controller/interrupts.txt

'interrupts' only works in combinations with 'interrupt-parent',
that actual .dts files don't have the latter in the nodes is an
implementation detail but not a binding's requirement

and an alternative method of specifying interrupts was introduced
recently, a reference to the common binding without naming one
specific property name could be most appropriate

> +
> +Optional properties:
> +- #dma-cells: The length of the DMA specifier, must be <1> since
> +	the DMA controller uses a fixed assignment of request lines
> +	per channel. Refer to dma/dma.txt for the detailed description
> +	of this property

I'm afraid that a generic/common document does not and cannot
describe the specific semantics of this provider's cells

this binding should explicitly mention that the number of cells
needs to be one, and that this one cell is the DMA channel (which
translates to "peripheral request line"), because these
assigments are fixed in hardware

> +
> +Example:
> +
> +	dma0: dma@14000 {
> +		compatible = "fsl,mpc5121-dma";
> +		reg = <0x14000 0x1800>;
> +		interrupts = <65 0x8>;
> +		#dma-cells = <1>;
> +	};
> +
> +* DMA client

the DMA provider's binding probably need not discuss client
specs, a reference to the common binding should suffice if it's
appropriate at all


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
