Return-Path: <R63238@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66640B7E08
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 19:14:11 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4E9E8OE001374
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 02:14:08 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o4E9ECmw011000
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 04:14:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
Date: Fri, 14 May 2010 17:14:05 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089B975F5@zch01exm21.fsl.freescale.net>
In-Reply-To: <1273828131.21352.604.camel@pasglop>
References: <1273221514-8683-1-git-send-email-leoli@freescale.com>
	<0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
	<1273787172.21352.198.camel@pasglop>
	<D7CCA83BB0796C49BC0BB53B6AB12089B97531@zch01exm21.fsl.freescale.net>
	<1273828131.21352.604.camel@pasglop>
From: "Liu Dave-R63238" <r63238@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jin Qing-B24347 <B24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Aaron pointed the issue on FSL BookE.
> >=20
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-January/079738.htm
> > l
>=20
> Right, but I think 64-bit BookE has the same issue. We can=20
> fix that later tho.

Ben,

We also find the _PAGE_USER is different between pte-book3e and old
fsl-booke
It is UR in old fsl-booke, and is _PAGE_BAP_UR | _PAGE_BAP_SR in
pte-book3e,
which will cause the ioremap_flags issue.

Did you have a test your commit
[ea3cc330ac0cd521ff07c7cd432a1848c19a7e92]?

Thanks, Dave
