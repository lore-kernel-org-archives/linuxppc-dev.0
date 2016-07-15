Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTtz4qGLzDqyT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:15 +1000 (AEST)
In-Reply-To: <1468444634-1866-8-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [07/15] powerpc/powernv: Add support for the cxl kernel api on
 the real phb
Message-Id: <3rrTtz2Tb7z9sCj@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:06 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This adds support for the peer model of the cxl kernel api to the
> PowerNV PHB, in which physical function 0 represents the cxl function on
> the card (an XSL in the case of the CX4), which other physical functions
> will use for memory access and interrupt services. It is referred to as
> the peer model as these functions are peers of one another, as opposed
> to the Virtual PHB model which forms a hierarchy.
> 
> This patch exports APIs to enable the peer mode, check if a PCI device
> is attached to a PHB in this mode, and to set and get the peer AFU for
> this mode.
> 
> The cxl driver will enable this mode for supported cards by calling
> pnv_cxl_enable_phb_kernel_api(). This will set a flag in the PHB to note
> that this mode is enabled, and switch out it's controller_ops for the
> cxl version.
> 
> The cxl version of the controller_ops struct implements it's own
> versions of the enable_device_hook and release_device to handle
> refcounting on the peer AFU and to allocate a default context for the
> device.
> 
> Once enabled, the cxl kernel API may not be disabled on a PHB. Currently
> there is no safe way to disable cxl mode short of a reboot, so until
> that changes there is no reason to support the disable path.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4361b03430d685610e5feea3ec

cheers
