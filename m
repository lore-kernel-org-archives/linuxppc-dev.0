Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvB3kVvzDqyr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:26 +1000 (AEST)
In-Reply-To: <1468444634-1866-13-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [12/15] cxl: Workaround PE=0 hardware limitation in Mellanox CX4
Message-Id: <3rrTvB2hz8z9sDG@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:11 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The CX4 card cannot cope with a context with PE=0 due to a hardware
> limitation, resulting in:
> 
> [   34.166577] command failed, status limits exceeded(0x8), syndrome 0x5a7939
> [   34.166580] mlx5_core 0000:01:00.1: Failed allocating uar, aborting
> 
> Since the kernel API allocates a default context very early during
> device init that will almost certainly get Process Element ID 0 there is
> no easy way for us to extend the API to allow the Mellanox to inform us
> of this limitation ahead of time.
> 
> Instead, work around the issue by extending the XSL structure to include
> a minimum PE to allocate. Although the bug is not in the XSL, it is the
> easiest place to work around this limitation given that the CX4 is
> currently the only card that uses an XSL.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f67a6722d650b864b020b19b39

cheers
