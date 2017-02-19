Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4QS132FzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:36 +1100 (AEDT)
In-Reply-To: <1486523463-19953-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc/kernel: Remove error message in
 pcibios_setup_phb_resources()
Message-Id: <3vR4QS0CNyz9sD6@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-08 at 03:11:03 UTC, Gavin Shan wrote:
> The CAPI driver creates virtual PHB (vPHB) from the CAPI adapter.
> The vPHB's IO and memory windows aren't built from device-tree node
> as we do for normal PHBs. A error message is thrown in below path
> when trying to probe AFUs contained in the adapter. The error message
> is confusing and unnecessary.
> 
>     cxl_probe()
>     pci_init_afu()
>     cxl_pci_vphb_add()
>     pcibios_scan_phb()
>     pcibios_setup_phb_resources()
> 
> This removes the error message. We might have the case where the
> first memory window on real PHB isn't populated properly because
> of error in "ranges" property in the device-tree node. We can check
> the device-tree instead for that. This also removes one unnecessary
> blank line in the function.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/727597d12140b342a3deef10348b5e

cheers
