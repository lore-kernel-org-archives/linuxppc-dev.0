Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTv80PMtzDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:24 +1000 (AEST)
In-Reply-To: <1468444634-1866-11-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [10/15] cxl: Add preliminary workaround for CX4 interrupt
 limitation
Message-Id: <3rrTv74PRsz9sCj@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:09 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The Mellanox CX4 has a hardware limitation where only 4 bits of the
> AFU interrupt number can be passed to the XSL when sending an interrupt,
> limiting it to only 15 interrupts per context (AFU interrupt number 0 is
> invalid).
> 
> In order to overcome this, we will allocate additional contexts linked
> to the default context as extra address space for the extra interrupts -
> this will be implemented in the next patch.
> 
> This patch adds the preliminary support to allow this, by way of adding
> a linked list in the context structure that we use to keep track of the
> contexts dedicated to interrupts, and an API to simultaneously iterate
> over the related context structures, AFU interrupt numbers and hardware
> interrupt numbers. The point of using a single API to iterate these is
> to hide some of the details of the iteration from external code, and to
> reduce the number of APIs that need to be exported via base.c to allow
> built in code to call.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cbce0917e2e47d4bf5aa3b5fd6

cheers
