Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t10633p0FzDvd9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 09:02:35 +1100 (AEDT)
In-Reply-To: <1466182408-17884-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com
Subject: Re: powerpc/mm: Prevent unlikely crash in copro_calculate_slb()
Message-Id: <3t10631vn6z9t0p@ozlabs.org>
Date: Sat, 22 Oct 2016 09:02:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-17-06 at 16:53:28 UTC, Frederic Barrat wrote:
> If a cxl adapter faults on an invalid address for a kernel context, we
> may enter copro_calculate_slb() with a NULL mm pointer (kernel
> context) and an effective address which looks like a user
> address. Which will cause a crash when dereferencing mm. It is clearly
> an AFU bug, but there's no reason to crash either. So return an error,
> so that cxl can ack the interrupt with an address error.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d2cf909cda5f8c5609cb7ed6cda816

cheers
