Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0108.outbound.protection.outlook.com [65.55.169.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B159A1A0DB0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 08:14:52 +1000 (AEST)
Message-ID: <1438208074.2993.343.camel@freescale.com>
Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board
 support
From: Scott Wood <scottwood@freescale.com>
To: Jain Priyanka-B32167 <Priyanka.Jain@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 29 Jul 2015 17:14:34 -0500
In-Reply-To: <BY1PR0301MB08531E965109B9F1EDB7A292EC8C0@BY1PR0301MB0853.namprd03.prod.outlook.com>
References: <1436952655-14910-1-git-send-email-Priyanka.Jain@freescale.com>
 <1436982433.2993.81.camel@freescale.com>
 <BY1PR0301MB0853E5011D37FE78E3A9B78FEC990@BY1PR0301MB0853.namprd03.prod.outlook.com>
 <1437075349.2993.105.camel@freescale.com>
 <BY1PR0301MB08536BC13A64047CB7062442EC980@BY1PR0301MB0853.namprd03.prod.outlook.com>
 <1437152821.2993.191.camel@freescale.com>
 <BY1PR0301MB0853E43544A9D9F36D2B31B9EC830@BY1PR0301MB0853.namprd03.prod.outlook.com>
 <1437751681.2993.235.camel@freescale.com>
 <BY1PR0301MB08531E965109B9F1EDB7A292EC8C0@BY1PR0301MB0853.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-29 at 04:07 -0500, Jain Priyanka-B32167 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, July 24, 2015 8:58 PM
> > To: Jain Priyanka-B32167
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB
> > board support
> > 
> > OK, so you're saying the i2c devices are pluggable (and I'm assuming by 
> > "PEX
> > slots" you just mean that the physical slot is repurposed, not that the 
> > PCI
> > express protocol is involved)?  Making a non-runtime-enumerable bus be
> > pluggable seems like a bad idea, but if that's really what has been done,
> > there needs to be a device tree that represents the entire system, not 
> > just
> > the motherboard.  This could be done either via a dts file that 
> > /include/s the
> > motherboard dts, or via firmware dtb edits.  The dts for the motherboard
> > should include the mux node with a comment explaining what the situation
> > is.
> > 
> [Jain Priyanka-B32167] Is the below comment looks OK?
> "Output I2C data, clock lines (SDO/SC0,SD1/SC1 , SD2/SC2, SD3/SC3) are 
> going mini PCI connector slot1, mini PCI connector slot2, HDMI connector, 
> PEX slot respectively
>  The sub-nodes will depend upon the device that will be connected on these 
> slots"

How about:

"Child nodes depend on which i2c devices are connected via the mini PCI 

connector slot1, the mini PCI connector slot2, the HDMI connector, and the 

PEX slot.  Systems with such devices attached should provide a wrapper .dts 
file that includes this one, and adds those nodes."

-Scott
