Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kq4QDZzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:27 +1000 (AEST)
In-Reply-To: <1467305440-23492-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [v2] cxl: Fix bug where AFU disable operation had no effect
Message-Id: <3rp1Kq0WDwz9t1C@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-30-06 at 16:50:40 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The AFU disable operation has a bug where it will not clear the enable
> bit and therefore will have no effect. To date this has likely been
> masked by fact that we perform an AFU reset before the disable, which
> also has the effect of clearing the enable bit, making the following
> disable operation effectively a noop on most hardware. This patch
> modifies the afu_control function to take a parameter to clear from the
> AFU control register so that the disable operation can clear the
> appropriate bit.
> 
> This bug was uncovered on the Mellanox CX4, which uses an XSL rather
> than a PSL. On the XSL the reset operation will not complete while the
> AFU is enabled, meaning the enable bit was still set at the start of the
> disable and as a result this bug was hit and the disable also timed out.
> 
> Because of this difference in behaviour between the PSL and XSL, this
> patch now makes the reset dependent on the card using a PSL to avoid
> waiting for a timeout on the XSL. It is entirely possible that we may be
> able to drop the reset altogether if it turns out we only ever needed it
> due to this bug - however I am not willing to drop it without further
> regression testing and have added comments to the code explaining the
> background.
> 
> This also fixes a small issue where the AFU_Cntl register was read
> outside of the lock that protects it.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5e7823c9bc44965c2e7d1d755b

cheers
