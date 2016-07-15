Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTv94lrbzDqyc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:25 +1000 (AEST)
In-Reply-To: <1468444634-1866-12-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [11/15] cxl: Add support for interrupts on the Mellanox CX4
Message-Id: <3rrTv935SZz9snm@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:10 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The Mellanox CX4 in cxl mode uses a hybrid interrupt model, where
> interrupts are routed from the networking hardware to the XSL using the
> MSIX table, and from there will be transformed back into an MSIX
> interrupt using the cxl style interrupts (i.e. using IVTE entries and
> ranges to map a PE and AFU interrupt number to an MSIX address).
> 
> We want to hide the implementation details of cxl interrupts as much as
> possible. To this end, we use a special version of the MSI setup &
> teardown routines in the PHB while in cxl mode to allocate the cxl
> interrupts and configure the IVTE entries in the process element.
> 
> This function does not configure the MSIX table - the CX4 card uses a
> custom format in that table and it would not be appropriate to fill that
> out in generic code. The rest of the functionality is similar to the
> "Full MSI-X mode" described in the CAIA, and this could be easily
> extended to support other adapters that use that mode in the future.
> 
> The interrupts will be associated with the default context. If the
> maximum number of interrupts per context has been limited (e.g. by the
> mlx5 driver), it will automatically allocate additional kernel contexts
> to associate extra interrupts as required. These contexts will be
> started using the same WED that was used to start the default context.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a2f67d5ee8d950caaa7a6144cf

cheers
