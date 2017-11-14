Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFv2hRXzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:03 +1100 (AEDT)
In-Reply-To: <1506321782.13257.4.camel@hbabu-laptop>
To: Haren Myneni <haren@linux.vnet.ibm.com>, herbert@gondor.apana.org.au,
 ddstreet@ieee.org, mikey@neuling.org, suka@us.ibm.com, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: Re: [1/2] crypto/nx: Use percpu send window for NX requests
Message-Id: <3yblFv25bsz9sPr@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-09-25 at 06:43:02 UTC, Haren Myneni wrote:
> [PATCH 1/2] crypto/nx: Use percpu send window for NX requests
> 
> For P9 NX, the send window is opened for each crypto session and closed
> upon free. But VAS supports 64K windows per chip for all coprocessors
> including in user space support. So there is a possibility of not
> getting the window for kernel requests.
> 
> This patch reserves windows for each coprocessor type (NX842) and are
> available forever for kernel requests, Opens each window for each CPU
> on the corresponding chip during driver initialization. So then use the
> percpu txwin for NX requests depends on the CPU on which the process
> is executing.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/976dd6490b1b45727733a3ee1e25e1

cheers
