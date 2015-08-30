Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDCFC1A0170
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 07:20:42 +1000 (AEST)
In-Reply-To: <1440648757-23359-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/pseries: Fix corrupted pdn list
Message-Id: <20150830212042.B5452140280@ozlabs.org>
Date: Mon, 31 Aug 2015 07:20:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-27-08 at 04:12:36 UTC, Gavin Shan wrote:
> Commit cca87d30 ("powerpc/pci: Refactor pci_dn") introduced pdn
> list for SRIOV VFs. It means the pdn is be put into the child list
> of its parent pdn when the pdn is created. When doing PCI hot
> unplugging on pSeries, the PCI device node as well as its pdn are
> released through procfs entry "powerpc/ofdt". Some one else grabs
> the memory chunk of the pdn and update it accordingly. At the same
> time, the pdn is still tracked in the child list of parent pdn. It
> leads to corrupted child list in the parent pdn.
> 
> This fixes above issue by removing the pdn from the child list of
> its parent pdn when the device node is detached from the system.
> Note the pdn is free'd when the device node is released if the
> device node is dynamic one. Otherwise, the device node as well
> as the pdn won't be released.
> 
> Fixes: cca87d30 ("powerpc/pci: Refactor pci_dn")
> Reported-by: Santwana Samantray <santwana.samantray@in.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/590c7567a2895f939525ead5

cheers
