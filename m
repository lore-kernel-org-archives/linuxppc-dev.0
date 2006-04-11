Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8143D67A6C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 07:31:35 +1000 (EST)
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <20060410103929.9664238d.moilanen@austin.ibm.com>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
	<17454.15223.929530.985654@cargo.ozlabs.ibm.com>
	<20060401165723.ab77c81f.moilanen@austin.ibm.com>
	<20060410103929.9664238d.moilanen@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 07:31:06 +1000
Message-Id: <1144791067.19353.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I was able to validate that these patches do work, and we are receiving
> MSI interrupts correctly.
> 
> Is it too late to get into 2.6.17?

Yes and it's totally broken anyway. The whole idea of "hiding" MSIs as
if they were LSIs is totally irrealistic in practice. Our firmware might
do it but we have to undo it.

Linux defines the semantics of a driver probe() routine to be called
with MSIs disabled by default.

This is very important as for a lot of devices (I'd say the vast
majority of the devices that claim to be MSI capable), enabling MSI is
either broken (various HW bugs related to using them, mostly ordering
issues) or requires all sort of additional tweaking on the device side
in addition to the standard config space stuffs.

Thus, we need to help whoever is currently ripping off the
drivers/pci/msi.c code which is way too Intel-centric (there's an SGI
guy working on it already) and implement an arch specific implementation
that undoes what the firmware did, and then re-assign MSIs as requested
by drviers.

Some of the Boeblingen folks have already been looking into it as part
of some bare-metal/bringup effort, but that doesn't include PAPR
implementation.

Ben.
