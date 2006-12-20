Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3DB92DDF42
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 11:10:20 +1100 (EST)
Message-ID: <45887F65.1020603@freescale.com>
Date: Tue, 19 Dec 2006 18:10:13 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add a device_initcall to
	call	of_platform_bus_probe on all fsl SoCs
References: <20061219153102.20ab3345.kim.phillips@freescale.com>	<1166569246.19254.86.camel@localhost.localdomain>	<20061219172202.29ef9b1d.kim.phillips@freescale.com>
	<1166571629.19254.90.camel@localhost.localdomain>
In-Reply-To: <1166571629.19254.90.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> What cores do those chip use ? Any reason why one couldn't build a
> kernel that boots those chips -and- chrp,pmac,etc... in one image ?
> 
> If that is the case, then your initcall will incorrectly be called on
> platforms that don't need it.

It won't do anything, though, unless it finds a node that matches 
of_default_bus_ids.  Are there any platforms on which "soc" nodes (or 
others in the default list) shouldn't be probed?  If not, perhaps make a 
generic initcall to of_platform_bus_probe(), so that it won't be called 
multiple times by different SoC types that are in the same kernel?

Otherwise, perhaps the SoCs could be given "fsl-soc" in their compatible 
field, and have fsl_publish_devices() pass that as a match struct.

> I think what we need to do is to define a mecanism for board initcalls.
> 
> Something like board_xxx_initcall(boardname, function);

It's not really a board-level issue, though -- at most, it's SoC-level.

-Scott
