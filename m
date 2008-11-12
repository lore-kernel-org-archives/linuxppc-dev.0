Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EFD0DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 15:38:18 +1100 (EST)
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
References: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Nov 2008 15:37:43 +1100
Message-Id: <1226464663.13515.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, yanok@emcraft.com, kvm-ppc@vger.kernel.org,
	dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-11-11 at 18:06 -0600, Hollis Blanchard wrote:
> The current CHIP11 errata truncates the device tree memory node, and subtracts
> (hardcoded) 4096 bytes. This breaks kernels with larger PAGE_SIZE, since the
> bootmem allocator assumes that total memory is a multiple of PAGE_SIZE.
> 
> Instead, use a device tree memory reservation to reserve only the 256 bytes
> actually affected by the errata, leaving the total memory size unaltered.
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

While I prefer this approach, won't it break kexec ?

I don't understand why we don't just have a bit of code in the kernel
itself that reserve that page on 44x at boot time and be done with it.

It's like we are trying to be too smart and over-engineer the solution.

Cheers,
Ben.
