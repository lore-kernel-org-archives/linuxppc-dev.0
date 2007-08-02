Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id D220BDDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 15:58:34 +1000 (EST)
Date: Thu, 2 Aug 2007 07:58:30 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] lite5200b: flash definition in dts
Message-ID: <20070802055830.GM4529@moe.telargo.com>
References: <20070619095408.GK23294@moe.telargo.com>
	<20070801065203.GK4529@moe.telargo.com>
	<fa686aa40708010541n4d4900cfv7042d6ca685416d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40708010541n4d4900cfv7042d6ca685416d1@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 01/08/07 06:41 -0600, Grant Likely wrote:
> On 8/1/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > Add flash definition for to lite5200b dts, and while at it
> > fix "ranges" for soc node.
> >
...
> > +++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> > @@ -52,7 +52,8 @@
> >                 revision = "";                  // from bootloader
> >                 #interrupt-cells = <3>;
> >                 device_type = "soc";
> > -               ranges = <0 f0000000 f0010000>;
> > +               ranges = <00000000 f0000000 00010000
> > +                         fe000000 fe000000 02000000>;
> 
> I don't think this is the right approach.  I think the SoC node is
> intended for describing the on-chip devices, and the ranges property
> reflects that.  Shouldn't flash nodes be up 1 level?
> 

That would make sense, however, it does not work, probably because:
arch/powerpc/kernel/of_platform.c:

 32 /*
 33  * The list of OF IDs below is used for matching bus types in the
 34  * system whose devices are to be exposed as of_platform_devices.
 35  *
 36  * This is the default list valid for most platforms. This file provides
 37  * functions who can take an explicit list if necessary though
 38  *
 39  * The search is always performed recursively looking for children of
 40  * the provided device_node and recursively if such a children matches
 41  * a bus type in the list
 42  */
 43 
 44 static struct of_device_id of_default_bus_ids[] = {
 45         { .type = "soc", },
 46         { .compatible = "soc", },
 47         { .type = "spider", },
 48         { .type = "axon", },
 49         { .type = "plb5", },
 50         { .type = "plb4", },
 51         { .type = "opb", },
 52         { .type = "ebc", },
 53         {},
 54 };


Suggestions?
BTW. phy's are also not on chip, but are usualy listed under "soc"
(ie. mpc885ads.dts). Or rtc chip connected to i2c in kuroboxHD.dts.


	Domen
