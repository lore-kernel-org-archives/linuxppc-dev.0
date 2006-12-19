Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 693AADDF53
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 10:40:36 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add a device_initcall to call
	of_platform_bus_probe on all fsl SoCs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20061219172202.29ef9b1d.kim.phillips@freescale.com>
References: <20061219153102.20ab3345.kim.phillips@freescale.com>
	<1166569246.19254.86.camel@localhost.localdomain>
	<20061219172202.29ef9b1d.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 10:40:28 +1100
Message-Id: <1166571629.19254.90.camel@localhost.localdomain>
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


> it's not characteristic of FSL _boards_ per se.  It's characteristic of FSL
> powerpc SoC chips, and it resides in a file that will only be built for that
> case.  This is a legitimate way to support multiple platforms in a single
> image without incurring multiple device_initcall()s with the same parameter.

> I didn't see an appropriate ppc_md. function to use; are you suggesting we add
> one just for this?  wouldn't that be fsl specific also, but reside in common code?

What cores do those chip use ? Any reason why one couldn't build a
kernel that boots those chips -and- chrp,pmac,etc... in one image ?

If that is the case, then your initcall will incorrectly be called on
platforms that don't need it.

I think what we need to do is to define a mecanism for board initcalls.

Something like board_xxx_initcall(boardname, function);

Ben.
