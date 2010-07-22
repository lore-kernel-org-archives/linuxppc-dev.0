Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id 2116E1007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 05:26:10 +1000 (EST)
Received: from mail50-db3 (localhost.localdomain [127.0.0.1])	by
	mail50-db3-R.bigfish.com (Postfix) with ESMTP id 4CB00970304	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 19:26:06 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.245])	by
	mail50-db3.bigfish.com (Postfix) with ESMTP id D459F18D0050	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 19:26:05 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6MJPtf6001916	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 12:25:55 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6MJd75N026606	for <linuxppc-dev@ozlabs.org>;
	Thu, 22 Jul 2010 14:39:07 -0500 (CDT)
Date: Thu, 22 Jul 2010 14:25:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI
	EDAC regspace
Message-ID: <20100722142552.1e01dba8@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTikX8An80SMZiypoO63Be8MKyCsmNzviwqR6syQd@mail.gmail.com>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
	<566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
	<AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
	<20100722132548.6eef941b@schlenkerla.am.freescale.net>
	<95F6CFEA-DC74-4CF6-A195-4CBFABAAB7F0@kernel.crashing.org>
	<AANLkTikX8An80SMZiypoO63Be8MKyCsmNzviwqR6syQd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jul 2010 23:03:03 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> Hello,
> 
> On Thu, Jul 22, 2010 at 10:40 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On Jul 22, 2010, at 1:25 PM, Scott Wood wrote:
> >> How about keeping the error stuff as a separate device from Linux's
> >> perspective, but have the main Freescale PCI code create it as a
> >> platform device instead of putting it in the device tree?
> >
> > I'd be good with that solution.
> 
> Then we come back to the question that was raised before (during initial
> review of edac driver): as PCI code is probbed long before other parts
> of the kernel and mpc85xx_edac code can be compiled as module,
> it's not possible to directly call mpc85xx_edac code from fsl_pci.c

Right, that's why I suggested creating a platform device rather than
just a function call.

> Two initial suggestions were:
> 1) creating special platform device
> 2) creating special of_platform device from dts
> 
> Which approach should I choose? Did i miss any other opportunities?

#1, as it keeps the split out of the device tree.

Besides the theoretical/aesthetic issues of putting Linux
implementation concerns into the device tree, #2 would mean that the
edac driver wouldn't work when Linux is booted with an old device tree.

-Scott
