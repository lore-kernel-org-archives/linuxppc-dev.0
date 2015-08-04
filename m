Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CCEF1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 06:31:24 +1000 (AEST)
Message-ID: <1438720268.2097.94.camel@freescale.com>
Subject: Re: GPMC in device tree
From: Scott Wood <scottwood@freescale.com>
To: Ran Shalit <ranshalit@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 4 Aug 2015 15:31:08 -0500
In-Reply-To: <CAJ2oMhLzck9SxgzcXpEXVk_Yf0KoM=D4cOToizoOUPQFZ4JjWA@mail.gmail.com>
References: <CAJ2oMhJgnPGUPKRGBXZALYcrn+sL8Nt0A6gfPN+Ei_c+06mUPg@mail.gmail.com>
 <1438714472.2097.89.camel@freescale.com>
 <CAJ2oMhLzck9SxgzcXpEXVk_Yf0KoM=D4cOToizoOUPQFZ4JjWA@mail.gmail.com>
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

On Tue, 2015-08-04 at 23:26 +0300, Ran Shalit wrote:
> On Tue, Aug 4, 2015 at 9:54 PM, Scott Wood <scottwood@freescale.com> wrote:
> > On Tue, 2015-08-04 at 18:29 +0300, Ran Shalit wrote:
> > > Hello,
> > > 
> > > I would please like to ask if describing flash nor used with GPMC,
> > > whould be done as described in:
> > > https://www.kernel.org/doc/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
> > > It is described in the above link as "TI's GPMC", so I'm not sure if
> > > it is relevent for powerpc too.
> > 
> > That binding is for TI GPMC.
> > 
> > Are you saying you have some PPC chip that has a flash controller called 
> > GPMC?
> > 
> > -Scott
> > 
> 
> Hi Scott,
> 
> Thanks, I've worked with TI's chips, so I now understand that I made
> here some confusion...
> It is GPCM , not GPMC, my mistake.
> We already configured it in u-boot, but on doing read/write from
> kernel it doesn not work.
> It seems that for the linux to use the correct driver, we need to
> define the nor in the device tree.
> Is there any example how to define nor GPCM in device tree ? Is it
> possible not to override the existing GPCM configuration ?

Pretty much all of the mpc8xxx/qoriq device trees have GPCM NOR defined.  See 
Documentation/devicetree/bindings/powerpc/fsl/lbc.txt and examples such as 
arch/powerpc/boot/dts/p4080ds.dts (part of the lbc node is in 
arch/powerpc/boot/dts/fsl/p4080si-post.dtsi).

Linux will not change the GPCM configuration.

-Scott
