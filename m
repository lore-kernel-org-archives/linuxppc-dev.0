Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DBC91A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:54 +1100 (AEDT)
In-Reply-To: <1447646625-28854-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, imunsie@au1.ibm.com,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: cxl: Fix possible idr warning when contexts are released
Message-Id: <20151126121554.28FE3140319@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-16-11 at 04:03:45 UTC, Vaibhav Jain wrote:
> An idr warning is reported when a context is release after the capi card
> is unbound from the cxl driver via sysfs. Below are the steps to
> reproduce:
> 
> 1. Create multiple afu contexts in an user-space application using libcxl.
> 2. Unbind capi card from cxl using command of form
>    echo <capi-card-pci-addr> > /sys/bus/pci/drivers/cxl-pci/unbind
> 3. Exit/kill the application owning afu contexts.
> 
> After above steps a warning message is usually seen in the kernel logs
> of the form "idr_remove called for id=<context-id> which is not
> allocated."
> 
> This is caused by the function cxl_release_afu which destroys the
> contexts_idr table. So when a context is release no entry for context pe
> is found in the contexts_idr table and idr code prints this warning.
> 
> This patch fixes this issue by increasing & decreasing the ref-count on
> the afu device when a context is initialized or when its freed
> respectively. This prevents the afu from being released until all the
> afu contexts have been released. The patch introduces two new functions
> namely cxl_afu_get/put that manage the ref-count on the afu device.
> 
> Also the patch removes code inside cxl_dev_context_init that increases ref
> on the afu device as its guaranteed to be alive during this function.
> 
> Reported-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1b5df59e50874b9034c0fa38

cheers
