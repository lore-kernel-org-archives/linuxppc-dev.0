Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 942DD1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 22:05:00 +1000 (AEST)
In-Reply-To: <1441587178-5581-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com, dja@axtens.net
Subject: Re: [v2] cxl: abort cxl_pci_enable_device_hook() if PCI channel is
 offline
Message-Id: <20150908120500.75BD3140187@ozlabs.org>
Date: Tue,  8 Sep 2015 22:05:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-09 at 00:52:58 UTC, Andrew Donnellan wrote:
> cxl_pci_enable_device_hook() is called when attempting to enable an AFU
> sitting on a vPHB. At present, the state of the underlying CXL card's PCI
> channel is only checked when it calls cxl_afu_check_and_enable() at the
> very end, after it has already set DMA options and initialised a default
> context.
> 
> Check the CXL card's link status before setting DMA options or initialising
> a default context. If the link is down, print a warning and return
> immediately.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7d1647dc4ba0a61fec5381c1

cheers
