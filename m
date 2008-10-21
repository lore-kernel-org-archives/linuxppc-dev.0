Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D8951DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 02:25:58 +1100 (EST)
Date: Tue, 21 Oct 2008 17:26:07 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <20081021151648.GA20757@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0810211723520.5867@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
	<Pine.LNX.4.64.0810192347250.21665@axis700.grange>
	<9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
	<Pine.LNX.4.64.0810200022040.21665@axis700.grange>
	<20081021151648.GA20757@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Oct 2008, Scott Wood wrote:

> On Mon, Oct 20, 2008 at 12:28:09AM +0200, Guennadi Liakhovetski wrote:
> > On Sun, 19 Oct 2008, Jon Smirl wrote:
> > > That should match:
> > > 
> > > 		i2c@80003000 {
> > > 			#address-cells = <1>;
> > > 			#size-cells = <0>;
> > > 			cell-index = <0>;
> > > 			compatible = "fsl-i2c";
> > > 			reg = <0x80003000 0x1000>;
> > > 			interrupts = <5 2>;
> > > 			interrupt-parent = <&mpic>;
> > > 
> > > 			rtc@32 {
> > > 				device_type = "rtc";
> > > 				compatible = "ricoh,rs5c372a";
> > > 				reg = <0x32>;
> > > 			};
> > > 		};
> > 
> > It should, but it doesn't.
> 
> Is the parent of the i2c node covered by the list passed to
> of_platform_bus_probe() on this board?

You mean something like this:

static __initdata struct of_device_id storcenter_of_bus[] = {
        { .name = "soc", },
        {},
};

static int __init storcenter_device_probe(void)
{
        of_platform_bus_probe(NULL, storcenter_of_bus, NULL);
        return 0;
}
machine_device_initcall(storcenter, storcenter_device_probe);

? No, linkstation doesn't do that. Somehow, as this API has been 
introduced, linkstation has been left aside:-(

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
