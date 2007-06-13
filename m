Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C344DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 16:31:44 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5D6VdoZ023607
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 23:31:39 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5D6Vb3R001420
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:31:38 -0500 (CDT)
Subject: Re: [PATCH v3]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4a8562ccb7046ccde1ab81c725139878@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<1181639293.8953.7.camel@localhost.localdomain>
	<f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
	<1181715391.9397.16.camel@localhost.localdomain>
	<4a8562ccb7046ccde1ab81c725139878@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181716272.9397.25.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 14:31:12 +0800
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

On Wed, 2007-06-13 at 14:28, Segher Boessenkool wrote:
> > +     np = of_find_node_by_name(NULL, "global-utilities");
> > +     if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {
> 
> If this of_get_property fails...
> 
> > +             const u32 *prop = of_get_property(np, "reg", NULL);
> > +             if (prop) {
> > +                     /* map reset control register
> > +                      * 0xE00B0 is offset of reset control register
> > +                      */
> > +                     rstcr = ioremap(get_immrbase() + *prop + 0xB0,
> 0xff);
> > +                     if (!rstcr)
> > +                             printk (KERN_EMERG "Error: reset
> control \
> > +                                     register not mapped,
> spinning!\n");
> > +             }
> > +             of_node_put(np);
> 
> ...you still leak a reference.
You are right!!!
Roy
