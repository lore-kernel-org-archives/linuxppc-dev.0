Return-Path: <hollisb@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE11CDDEC3
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 11:03:17 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2405CPl014243
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 19:05:12 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2403DbX255228
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 19:03:13 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2403D68029225
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Mar 2008 19:03:13 -0500
Subject: Bamboo PCI interrupt issues
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 03 Mar 2008 18:02:33 -0600
Message-Id: <1204588953.7921.13.camel@basalt>
Mime-Version: 1.0
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm having two problems with PCI interrupts as described in bamboo.dts.
Here is are the properties in question:

	/* Bamboo has all 4 IRQ pins tied together per slot */
	interrupt-map-mask = <f800 0 0 0>;
	interrupt-map = <
		/* IDSEL 1 */
		0800 0 0 0 &UIC0 1c 8

		/* IDSEL 2 */
		1000 0 0 0 &UIC0 1b 8

		/* IDSEL 3 */
		1800 0 0 0 &UIC0 1a 8

		/* IDSEL 4 */
		2000 0 0 0 &UIC0 19 8
	>;


First, the 440EP[1] and Bamboo[2] user manuals indicate that PCI IRQ 0-3
-> board IRQ 2-5 -> UIC IRQ 25-28. However, the device tree has that
reversed, so PCI IRQ 0 appears as UIC IRQ 28 (0x1c).

Second, the sensitivity seems to be wrong. All these interrupts have the
sensitivity encoded as 8, which means "high to low edge" in the OpenPIC
binding. Now, 440EP has a UIC, rather than an OpenPIC, but there is no
UIC binding AFAICS.

When I change the 8 to a 4 ("active high level"), I see the proper
values in the UIC polarity register, and PCI interrupts start working in
KVM.

Is anybody using Bamboo PCI support right now? Does it actually work?

[1]
https://www.amcc.com/MyAMCC/retrieveDocument/PowerPC/440EP/PPC440EP_UM2000.pdf
[2] Seems to have been deleted from the web. Thanks, AMCC.

-- 
Hollis Blanchard
IBM Linux Technology Center
