Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5010EDDD08
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 15:45:33 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5D5jSpE011696
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 22:45:28 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5D5jQpw026572
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 00:45:27 -0500 (CDT)
Subject: Re: [PATCH v3]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<1181639293.8953.7.camel@localhost.localdomain>
	<f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181713501.9397.10.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 13:45:02 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 12:44, Segher Boessenkool wrote:
> > +             global-utilities@e0000 {        //global utilities reg
> > +                     compatible = "fsl,mpc8548-guts";
> > +                     reg = <e0000 1000>;
> > +                     fsl,has-rstcr;
> > +             };
> 
> Looks good.
> 
> > +     np = of_find_node_by_name(NULL, "global-utilities");
> > +     if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {
> > +             const u32 *prop = of_get_property(np, "reg", NULL);
> > +             if (prop) {
> > +             /* map reset control register
> > +              * 0xE00B0 is offset of reset control register
> > +              */
> > +                     rstcr = ioremap(get_immrbase() + *prop + 0xB0,
> 0xff);
> > +                     if (!rstcr)
> > +                             printk (KERN_EMERG "Error: reset
> control register not mapped, 
> > spinning!\n");
> > +             }
> > +     else
> > +             printk (KERN_INFO "rstcr compatible register does not
> exist!\n");
> > +     }
> 
> This needs an of_node_put(np).  Oh and the indenting
> is off.
It is my oversight!
I had thought to add of_node_put(), but forget.
I just checkout the code and decide to have a small revise.

Thanks.
Roy
