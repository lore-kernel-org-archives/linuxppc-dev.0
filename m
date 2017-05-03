Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHS1X6jzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:19:00 +1000 (AEST)
In-Reply-To: <20170427052325.11818-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, stable@vger.kernel.org,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH-RESEND,v4] cxl: Force context lock during EEH flow
Message-Id: <3wJCHS0FXxz9s0m@ozlabs.org>
Date: Thu,  4 May 2017 08:18:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-27 at 05:23:25 UTC, Vaibhav Jain wrote:
> During an eeh event when the cxl card is fenced and card sysfs attr
> perst_reloads_same_image is set following warning message is seen in the
> kernel logs:
> 
>  [   60.622727] Adapter context unlocked with 0 active contexts
>  [   60.622762] ------------[ cut here ]------------
>  [   60.622771] WARNING: CPU: 12 PID: 627 at
>  ../drivers/misc/cxl/main.c:325 cxl_adapter_context_unlock+0x60/0x80 [cxl]
> 
> Even though this warning is harmless, it clutters the kernel log
> during an eeh event. This warning is triggered as the EEH callback
> cxl_pci_error_detected doesn't obtain a context-lock before forcibly
> detaching all active context and when context-lock is released during
> call to cxl_configure_adapter from cxl_pci_slot_reset, a warning in
> cxl_adapter_context_unlock is triggered.
> 
> To fix this warning, we acquire the adapter context-lock via
> cxl_adapter_context_lock() in the eeh callback
> cxl_pci_error_detected() once all the virtual AFU PHBs are notified
> and their contexts detached. The context-lock is released in
> cxl_pci_slot_reset() after the adapter is successfully reconfigured
> and before the we call the slot_reset callback on slice attached
> device-drivers.
> 
> Cc: stable@vger.kernel.org
> Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exists")
> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Tested-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ea9a26d117cf0637c71d3e0076f4a1

cheers
