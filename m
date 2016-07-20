Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWN045gjzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:10:24 +1000 (AEST)
In-Reply-To: <1468895615-4855-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [v2] powerpc/powernv: fix pci-cxl.c build when CONFIG_MODULES=n
Message-Id: <3rvWN02pJLz9t10@ozlabs.org>
Date: Wed, 20 Jul 2016 19:10:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-19-07 at 02:33:35 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> pnv_cxl_enable_phb_kernel_api() grabs a reference to the cxl module to
> prevent it from being unloaded after the PHB has been switched to CX4 mode.
> This breaks the build when CONFIG_MODULES=n as module_mutex doesn't exist.
> 
> However, if we don't have modules, we don't need to protect against the
> case of the cxl module being unloaded. As such, split the relevant
> code out into a function surrounded with #if IS_MODULE(CXL) so we don't try
> to compile it if cxl isn't being compiled as a module.
> 
> Fixes: 5918dbc9b4ec ("powerpc/powernv: Add support for the cxl kernel api
> on the real phb")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c2ca9f6b4cc4c45eb598b24b8b

cheers
