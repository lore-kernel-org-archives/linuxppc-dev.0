Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0102.outbound.protection.outlook.com [157.56.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11E0A1A078B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2015 03:07:19 +1000 (AEST)
Message-ID: <1437152821.2993.191.camel@freescale.com>
Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board
 support
From: Scott Wood <scottwood@freescale.com>
To: Jain Priyanka-B32167 <Priyanka.Jain@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 17 Jul 2015 12:07:01 -0500
In-Reply-To: <BY1PR0301MB08536BC13A64047CB7062442EC980@BY1PR0301MB0853.namprd03.prod.outlook.com>
References: <1436952655-14910-1-git-send-email-Priyanka.Jain@freescale.com>
 <1436982433.2993.81.camel@freescale.com>
 <BY1PR0301MB0853E5011D37FE78E3A9B78FEC990@BY1PR0301MB0853.namprd03.prod.outlook.com>
 <1437075349.2993.105.camel@freescale.com>
 <BY1PR0301MB08536BC13A64047CB7062442EC980@BY1PR0301MB0853.namprd03.prod.outlook.com>
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

On Fri, 2015-07-17 at 01:17 -0500, Jain Priyanka-B32167 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, July 17, 2015 1:06 AM
> > To: Jain Priyanka-B32167
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH][v2] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB
> > board support
> > 
> > > > +                i2c@118100{
> > > > +                      mux@77{
> > > > +                             compatible = "nxp,pca9546";
> > > > +                             reg = <0x77>;
> > > > +                             #address-cells = <1>;
> > > > +                             #size-cells = <0>;
> > > > +                     };
> > > > +             };
> > > 
> > > A mux with no nodes under it (and yet it has #address-cells/#size-
> > > cells)?
> > > What is it multiplexing?
> > > [Priyanka]: PCA9546 is i2c mux device , to which other i2c devices
> > > (up-to 8
> > > ) can be further connected on output channels On T104xD4RDB,  channel
> > > 0, 1, 3 line are connected to PEX device, Channel 2 to hdmi interface
> > > (initialization is done in u-boot only), other channels are grounded.
> > > So, as such Linux is not using the second level I2C devices connected
> > > on this MUX device. So, I have not shown next level hierarchy.
> > > Should I replace 'mux' with some other name? . Please suggest.
> > 
> > The device tree describes the hardware, not just what Linux uses... but 
> > what
> > I don't understand is why you describe the mux at all if you're not going 
> > to
> > describe what goes underneath it.
> > 
> [Jain Priyanka-B32167] : Is below looks OK?
> i2c@118100{
>  +                      i2c@77{
>  +                             compatible = "nxp,pca9546";
>  +                             reg = <0x77>;
>  +                             #address-cells = <1>;
>  +                             #size-cells = <0>;
>  +                     };
>  +             };

Where in my above comment did it appear that I was complaining about the node 
name?

-Scott
