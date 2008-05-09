Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8644ADDED8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 19:27:13 +1000 (EST)
In-Reply-To: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c6e4b0f3534e38db766d76fd6450f163@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 V2] booting-without-of for Freescale MSI
Date: Fri, 9 May 2008 11:26:46 +0200
To: Jason Jin <Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jason,

Some more comments...

> +    - compatible : set as "fsl,86xx-MSI" for 86xx cpu, "fsl,85xx-MSI" 
> for 85xx
> +      cpu and "fsl,83xx-MSI" for 83xx cpu.

Don't use "xx", use real device names instead.  If for example the 
oldest
86xx device that implements this is 8600, and you write a tree for the 
8699,
you'd write  compatible = "fsl,8699-msi", "fsl,8600-msi";  and the 
driver
will look for "fsl,8600-msi" only usually, but it can take some special
actions for 8699 if it needs to.

If these MSI devices work really identical for 83xx, 85xx, 86xx, there 
is
no need to distinguish between them for probing either -- you want to 
use
the same driver for all, anyway.

Oh, and the norm is to write compatible values in lower case.

> +    - msi-available-ranges: use <start count> style section to define 
> which
> +      msi interrupt can be used in the 256 msi interrupts.

Please make this property optional, default to "all available".


Segher
