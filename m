Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6C69BDDECC
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 12:04:36 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m2414BCR018576
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 12:04:11 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2414Z9U4276390
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 12:04:35 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2414Ykw027155
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 12:04:35 +1100
Date: Tue, 4 Mar 2008 11:59:22 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Bamboo PCI interrupt issues
Message-ID: <20080304005922.GB1393@localhost.localdomain>
References: <1204588953.7921.13.camel@basalt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204588953.7921.13.camel@basalt>
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 03, 2008 at 06:02:33PM -0600, Hollis Blanchard wrote:
> I'm having two problems with PCI interrupts as described in bamboo.dts.
> Here is are the properties in question:
> 
> 	/* Bamboo has all 4 IRQ pins tied together per slot */
> 	interrupt-map-mask = <f800 0 0 0>;
> 	interrupt-map = <
> 		/* IDSEL 1 */
> 		0800 0 0 0 &UIC0 1c 8
> 
> 		/* IDSEL 2 */
> 		1000 0 0 0 &UIC0 1b 8
> 
> 		/* IDSEL 3 */
> 		1800 0 0 0 &UIC0 1a 8
> 
> 		/* IDSEL 4 */
> 		2000 0 0 0 &UIC0 19 8
> 	>;
> 
> 
> First, the 440EP[1] and Bamboo[2] user manuals indicate that PCI IRQ 0-3
> -> board IRQ 2-5 -> UIC IRQ 25-28. However, the device tree has that
> reversed, so PCI IRQ 0 appears as UIC IRQ 28 (0x1c).
> 
> Second, the sensitivity seems to be wrong. All these interrupts have the
> sensitivity encoded as 8, which means "high to low edge" in the OpenPIC
> binding. Now, 440EP has a UIC, rather than an OpenPIC, but there is no
> UIC binding AFAICS.

Uh.. there's no binding written down, it's just encoded into uic.c.
But UIC doesn't use OpenPIC sensitivity encoding.  Like FSL's IPIC, it
uses Linux IRQ_TYPE values from include/linux/irq.h which makes 8
"level sensitive, active-low".

> When I change the 8 to a 4 ("active high level"), I see the proper
> values in the UIC polarity register, and PCI interrupts start working in
> KVM.
> 
> Is anybody using Bamboo PCI support right now? Does it actually work?
> 
> [1]
> https://www.amcc.com/MyAMCC/retrieveDocument/PowerPC/440EP/PPC440EP_UM2000.pdf
> [2] Seems to have been deleted from the web. Thanks, AMCC.
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
