Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx027.isp.belgacom.be (outmx027.isp.belgacom.be
	[195.238.4.208])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADDC868926
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 02:43:08 +1100 (EST)
Received: from outmx027.isp.belgacom.be (localhost [127.0.0.1])
	by outmx027.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k12FgrvH015059
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Feb 2006 16:42:54 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: Accessing the CPM2 on an MPC82xx : CPM_MAP_ADDR or cpm2_immr ?
Date: Thu, 2 Feb 2006 16:42:49 +0100
References: <200602021458.26623.laurent.pinchart@tbox.biz>
	<20060202170753.2a805189@vitb.ru.mvista.com>
In-Reply-To: <20060202170753.2a805189@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602021642.49282.laurent.pinchart@tbox.biz>
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

> > I noticed that the CPM2 module is accessed both through CPM_MAP_ADDR
> > (physical address) and cpm2_immr (ioremap()ed address). For instance, the
> > fec_enet driver configures the IO ports using (cpm2_map_t*)CPM_MAP_ADDR.
>
> Mentioned driver is deprecated.

It has been replaced by drivers/net/fs_enet, right ? The new driver doesn't 
support the LXT971/LXT971A PHY chipsets yet, so I'm still using the old one.

> > What's the correct way to access the CPM2 module ? Does ioremap() map
> > CPM_MAP_ADDR to itself so that both ways are correct ?
>
> Even direct cpm2_immr usage is not a good thing, but I cannot tell more
> without knowing your concerns. Can you please describe what you are
> planning to implement, prolly we can advice how to do that proper way.

I'm currently just hacking IDMA transfers to make sure the signals we plan to 
use on a custom design work as expected. I will later work on the USB host 
controller driver.

The new fs_enet driver internally maps CPM_MAP_ADDR. Should every driver 
create an internal CPM mapping ? Why was the old fec_enet driver able to 
access the CPM through CPM_MAP_ADDR without ioremap()ing it first ?

Laurent Pinchart
