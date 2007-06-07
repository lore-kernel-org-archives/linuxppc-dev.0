Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE023DDEBD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 19:05:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5795HVZ015460
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 02:05:17 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5795Fx6021246
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 04:05:16 -0500 (CDT)
Subject: Re: [PATCH]: Add 8548 pcie bus number workaround
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <D373FFB6-49B6-414B-AEEB-65AB62EB5AD5@kernel.crashing.org>
References: <1181186378.10296.41.camel@localhost.localdomain>
	<D373FFB6-49B6-414B-AEEB-65AB62EB5AD5@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181207084.11479.15.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 07 Jun 2007 17:04:45 +0800
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

On Thu, 2007-06-07 at 14:48, Kumar Gala wrote:
> On Jun 6, 2007, at 10:19 PM, Zang Roy-r61911 wrote:
> 
> >
> > From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
> >
> > Remove legacy pcie support for 8641 chip.
> > General PCI code can fully support 8641 Rev2.0 chip.
> > For 8548 PEX controller, PCIE host controller configure
> > space can only be accessed as "bus->number = 0" in
> > the PCI architecture. So "bus->number == hose->bus_offset"
> > judgment is added.
> 
> Uugh, I'm completely confused.  Does 8548 rev 2.x have some errata  
> (or 'feature') that 8641 doesn't have?
NO! I do not think so!
It is a story about the 85xx/86xx pcie road map.
Originally, fsl_pcie.c is based on the pcie support code for 86xx (1.x
or later).

Jdl and I separate this part of code for the purpose to support both
85xx/86xx pcie. So this part of code contains some garbage code for
legacy 86xx pcie support or debug information. I have discussed this
with the original developer.

So in this patch I remove the unused code. Is it wrong?
Now this file is target to support 8548 rev 1.x and 2.x pcie controller.
Now, I am working to put some common code to support 85xx/86xx pcie in
this file, such as atmu init and link status check.

Moer patches will be posted to provide a completely pcie support for
85xx/86xx.

Thanks.
Roy 
 
 
