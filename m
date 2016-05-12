Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59p22XrCzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:32:42 +1000 (AEST)
In-Reply-To: <1460402243-24346-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, gwshan@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: Re: [2/2,
 v3] powerpc/iommu: Remove the dependency on EEH struct in DDW
 mechanism
Message-Id: <3r59p2097Vz9vKJ@ozlabs.org>
Date: Thu, 12 May 2016 21:32:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-04 at 19:17:23 UTC, "Guilherme G. Piccoli" wrote:
> Commit 39baadbf36ce ("powerpc/eeh: Remove eeh information from pci_dn")
> changed the pci_dn struct by removing its EEH-related members.
> As part of this clean-up, DDW mechanism was modified to read the device
> configuration address from eeh_dev struct.
> 
> As a consequence, now if we disable EEH mechanism on kernel command-line
> for example, the DDW mechanism will fail, generating a kernel oops by
> dereferencing a NULL pointer (which turns to be the eeh_dev pointer).
> 
> This patch just changes the configuration address calculation on DDW
> functions to a manual calculation based on pci_dn members instead of
> using eeh_dev-based address.
> 
> No functional changes were made. This was tested on pSeries, both
> in PHyp and qemu guest.
> 
> Fixes: 39baadbf36ce ("powerpc/eeh: Remove eeh information from pci_dn")
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8445a87f7092bc8336ea1305be

cheers
