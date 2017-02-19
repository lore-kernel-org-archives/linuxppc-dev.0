Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4QZ0FvCzDqCg
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:42 +1100 (AEDT)
In-Reply-To: <1487200954-14681-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, "# v4 . 8+" <stable@vger.kernel.org>
Subject: Re: [1/3] pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
Message-Id: <3vR4QY5lK1z9s9j@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-15 at 23:22:32 UTC, Gavin Shan wrote:
> The WARN_ON() causes unnecessary backtrace when putting the parent
> slot, which is likely to be NULL.
> 
>  WARNING: CPU: 2 PID: 1071 at drivers/pci/hotplug/pnv_php.c:85 \
>                               pnv_php_release+0xcc/0x150 [pnv_php]
>     :
>  Call Trace:
>  [c0000003bc007c10] [d00000000ad613c4] pnv_php_release+0x144/0x150 [pnv_php]
>  [c0000003bc007c40] [c0000000006641d8] pci_hp_deregister+0x238/0x330
>  [c0000003bc007cd0] [d00000000ad61440] pnv_php_unregister_one+0x70/0xa0 [pnv_php]
>  [c0000003bc007d10] [d00000000ad614c0] pnv_php_unregister+0x50/0x80 [pnv_php]
>  [c0000003bc007d40] [d00000000ad61e84] pnv_php_exit+0x50/0xcb4 [pnv_php]
>  [c0000003bc007d70] [c00000000019499c] SyS_delete_module+0x1fc/0x2a0
>  [c0000003bc007e30] [c00000000000b184] system_call+0x38/0xe0
> 
> Cc: <stable@vger.kernel.org> # v4.8+
> Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/36c7c9da40c408a71e5e6bfe12e57d

cheers
