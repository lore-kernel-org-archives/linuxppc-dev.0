Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48E551A004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Sep 2014 13:28:12 +1000 (EST)
Message-ID: <1409714855.24184.110.camel@snotra.buserror.net>
Subject: Re: [PATCH] Freescale Frame Manager Device Tree binding document
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Tue, 2 Sep 2014 22:27:35 -0500
In-Reply-To: <1409485760-18844-1-git-send-email-igal.liberman@freescale.com>
References: <1409485760-18844-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Emilian.Medve@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-08-31 at 14:49 +0300, Igal.Liberman wrote:
> +- cell-index
> +		Usage: required
> +		Value type: <u32>
> +		Definition: Specifies the index of the FMan unit.
> +
> +		The cell-index value may be used, for example, to disable or
> +		enable the FMan via "Device disable register 2"
> +		(DCFG_DEVDISR2, located at the SoC reference manual under
> +		"Device Configuration and Pin Control Memory Map").

OK, but what is the specific cell-index value?  I don't think it's the
bit position within DEVDISR2.  Is this used anywhere other than DEVDISR2
and similar registers like IPPDEXPCR?  I'm not sure how helpful this is
for those registers, as you generally need to know enough about the
specific SoC to use them that you'd be able to make the correspondence
based on register address.

> +- fsl,qman-channel-range
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: Specifies the ranges of the available dedicated
> +		channels in the FMan. 

s/ranges/range/ unless it's possible to list multiple ranges.

> +=============================================================================
> +FMan MURAM Node
> +
> +DESCRIPTION
> +
> +FMan Internal memory - shared between all the FMan modules.
> +It contains data structures that are common and written to or read by
> +the modules.
> +FMan internal memory is split into the following parts:
> +	Packet buffering (Tx/Rx FIFOs)
> +	Frames internal context
> +
> +PROPERTIES
> +
> +- compatible
> +		Usage: required
> +		Value type: <stringlist>
> +		Definition: Must include "fsl,fman-muram"
> +
> +- ranges
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: A standard property. Specifies the physical
> +		address and length of the FMan memory space

It's the offset within FMan, not the physical address.  As with other
nodes, just say that there is one reg region describing the multi-user
memory.

> +- cell-index
> +		Usage: required
> +		Value type: <u32>
> +		Definition: Specifies the MAC id.
> +		This value is used to identify the MAC id in some registers
> +		in the FMan memory map, for example:
> +		The FMan Error Pending Interrupt Register (FM_EPI) -
> +		This register holds a bit for each MAC.

I don't see a bit for each MAC in FM_EPI in DPAARM -- and in any case,
as with DEVDISR2, this doesn't tell me how to turn that register
description into a cell-index value.

> +=============================================================================
> +Example
> +
> +fman@400000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	cell-index = <1>;
> +	compatible = "fsl,fman"
> +	ranges = <0 0x400000 0x100000>;
> +	reg = <0x480000 0x00400
> +	       0x480400 0x00400
> +	       0x4c2000 0x01000
> +	       0x4c3000 0x01000
> +	       0x4c4000 0x01000
> +	       0x4c7000 0x01000>;

You've got six regions here but you only documented five.

I'm wondering if there's any value to splitting these regions out,
versus having reg cover the entire thing (and overlap with the child
regs).

-Scott
