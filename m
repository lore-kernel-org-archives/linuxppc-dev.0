Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sRz66k1zDqf0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:39 +1000 (AEST)
In-Reply-To: <1470725741-26118-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, gpiccoli@linux.vnet.ibm.com
Subject: Re: powerpc/pci: Fix endian bug in fixed PHB numbering
Message-Id: <3s7sRz247bz9t1q@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-08 at 06:55:41 UTC, Michael Ellerman wrote:
> The recent commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number
> based on device-tree properties"), added code to read a 64-bit property
> from the device tree, and if not found read a 32-bit property (reg).
> 
> There was a bug in the 32-bit case, on big endian machines, due to the
> use of the 64-bit value to read the 32-bit property. The cast of &prop
> means we end up writing to the high 32-bit of prop, leaving the low
> 32-bits containing whatever junk was on the stack.
> 
> If that junk value was non-zero, and < MAX_PHBS, we would end up using
> it as the PHB id. This results in users seeing what appear to be random
> PHB ids.
> 
> Fix it by reading into a u32 property and then assigning that to the
> u64 value, letting the CPU do the correct conversions for us.
> 
> Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/61e8a0d5a0270b91581f6c7150

cheers
