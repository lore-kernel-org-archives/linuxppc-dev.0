Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85631DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 11:19:54 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add a device_initcall to
	call	of_platform_bus_probe on all fsl SoCs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <45887F65.1020603@freescale.com>
References: <20061219153102.20ab3345.kim.phillips@freescale.com>
	<1166569246.19254.86.camel@localhost.localdomain>
	<20061219172202.29ef9b1d.kim.phillips@freescale.com>
	<1166571629.19254.90.camel@localhost.localdomain>
	<45887F65.1020603@freescale.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 11:19:46 +1100
Message-Id: <1166573986.19254.99.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-19 at 18:10 -0600, Scott Wood wrote:
> Benjamin Herrenschmidt wrote:
> > What cores do those chip use ? Any reason why one couldn't build a
> > kernel that boots those chips -and- chrp,pmac,etc... in one image ?
> > 
> > If that is the case, then your initcall will incorrectly be called on
> > platforms that don't need it.
> 
> It won't do anything, though, unless it finds a node that matches 
> of_default_bus_ids.  Are there any platforms on which "soc" nodes (or 
> others in the default list) shouldn't be probed?  If not, perhaps make a 
> generic initcall to of_platform_bus_probe(), so that it won't be called 
> multiple times by different SoC types that are in the same kernel?

There is none right now that shouldn't be probed but I haven't been too
happy about having a default list in the first place (despite me writing
that code :-)

> Otherwise, perhaps the SoCs could be given "fsl-soc" in their compatible 
> field, and have fsl_publish_devices() pass that as a match struct.

Might be a better option.

I'd rather keep things well separate for now.

Ben.
