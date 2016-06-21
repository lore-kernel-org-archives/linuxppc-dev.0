Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRS0Mz4zDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:52 +1000 (AEST)
In-Reply-To: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: cxl: Abstract the differences between the PSL and XSL
Message-Id: <3rYTRR3cNjz9t0S@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-23-05 at 17:39:18 UTC, Ian Munsie wrote:
> From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> 
> The XSL (Translation Service Layer) is a stripped down version of the
> PSL (Power Service Layer) used in some cards such as the Mellanox CX4.
> 
> Like the PSL, it implements the CAIA architecture, but has a number of
> differences, mostly in it's implementation dependent registers. This
> adds an ops structure to abstract these differences to bring initial
> support for XSL CAPI devices.
> 
> The XSL does not implement the optional architected SERR register,
> however while it treats it as a reserved register and should work with
> no special treatment, attempting to access it will cause the XSL_FEC
> (First Error Capture) register to be filled out, preventing it from
> capturing any subsequent errors. Therefore, this patch also prevents the
> kernel from trying to set up the SERR register so that the FEC register
> may still be useful, and to save one interrupt.
> 
> The XSL also uses a special DMA cxl mode, which uses a slightly
> different init sequence for the CAPP and PHB. The kernel support for
> this will be in a future patch once the corresponding support has been
> merged into skiboot.
> 
> Co-authored-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6d382616ac2283ed65c7a6a52d

cheers
