Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CDBC1A098F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 01:28:20 +1000 (AEST)
Message-ID: <1437751681.2993.235.camel@freescale.com>
Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board
 support
From: Scott Wood <scottwood@freescale.com>
To: Jain Priyanka-B32167 <Priyanka.Jain@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 24 Jul 2015 10:28:01 -0500
In-Reply-To: <BY1PR0301MB0853E43544A9D9F36D2B31B9EC830@BY1PR0301MB0853.namprd03.prod.outlook.com>
References: <1436952655-14910-1-git-send-email-Priyanka.Jain@freescale.com>
 <1436982433.2993.81.camel@freescale.com>
 <BY1PR0301MB0853E5011D37FE78E3A9B78FEC990@BY1PR0301MB0853.namprd03.prod.outlook.com>
 <1437075349.2993.105.camel@freescale.com>
 <BY1PR0301MB08536BC13A64047CB7062442EC980@BY1PR0301MB0853.namprd03.prod.outlook.com>
 <1437152821.2993.191.camel@freescale.com>
 <BY1PR0301MB0853E43544A9D9F36D2B31B9EC830@BY1PR0301MB0853.namprd03.prod.outlook.com>
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

On Wed, 2015-07-22 at 05:49 -0500, Jain Priyanka-B32167 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, July 17, 2015 10:37 PM
> > To: Jain Priyanka-B32167
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB
> > board support
> > 
> > On Fri, 2015-07-17 at 01:17 -0500, Jain Priyanka-B32167 wrote:
> > > 
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Friday, July 17, 2015 1:06 AM
> > > > To: Jain Priyanka-B32167
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add
> > > > T1040D4RDB/T1042D4RDB board support
> > > > 
> > > > > > +                i2c@118100{
> > > > > > +                      mux@77{
> > > > > > +                             compatible = "nxp,pca9546";
> > > > > > +                             reg = <0x77>;
> > > > > > +                             #address-cells = <1>;
> > > > > > +                             #size-cells = <0>;
> > > > > > +                     };
> > > > > > +             };
> > > > > 
> > > > > A mux with no nodes under it (and yet it has #address-cells/#size-
> > > > > cells)?
> > > > > What is it multiplexing?
> > > > > [Priyanka]: PCA9546 is i2c mux device , to which other i2c devices
> > > > > (up-to 8
> > > > > ) can be further connected on output channels On T104xD4RDB,
> > > > > channel 0, 1, 3 line are connected to PEX device, Channel 2 to
> > > > > hdmi interface (initialization is done in u-boot only), other 
> > > > > channels are
> > grounded.
> > > > > So, as such Linux is not using the second level I2C devices
> > > > > connected on this MUX device. So, I have not shown next level
> > hierarchy.
> > > > > Should I replace 'mux' with some other name? . Please suggest.
> > > > 
> > > > The device tree describes the hardware, not just what Linux uses...
> > > > but what I don't understand is why you describe the mux at all if
> > > > you're not going to describe what goes underneath it.
> > > > 
> > > [Jain Priyanka-B32167] : Is below looks OK?
> > > i2c@118100{
> > >  +                      i2c@77{
> > >  +                             compatible = "nxp,pca9546";
> > >  +                             reg = <0x77>;
> > >  +                             #address-cells = <1>;
> > >  +                             #size-cells = <0>;
> > >  +                     };
> > >  +             };
> > 
> > Where in my above comment did it appear that I was complaining about the
> > node name?
> > 
> [Jain Priyanka-B32167]
> From what I understand:
> PCA9546 is a mux device and it would be good if we were able to present the 
> I2C devices on output lines as subnodes like in case of B4qds board and 
> then 'mux' name would have make more sense.

The name "mux" makes more sense regardless.

> But in case of T1040D4RDB board, output i2c lines are going to PEX slots, 
> PCI connector. I am not aware of how to represents them as sub-nodes in dts.

OK, so you're saying the i2c devices are pluggable (and I'm assuming by "PEX 
slots" you just mean that the physical slot is repurposed, not that the PCI 
express protocol is involved)?  Making a non-runtime-enumerable bus be 
pluggable seems like a bad idea, but if that's really what has been done, 
there needs to be a device tree that represents the entire system, not just 
the motherboard.  This could be done either via a dts file that /include/s 
the motherboard dts, or via firmware dtb edits.  The dts for the motherboard 
should include the mux node with a comment explaining what the situation is.

-Scott
