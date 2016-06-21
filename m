Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYZXm6HJLzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:30:48 +1000 (AEST)
In-Reply-To: <1466476865-13425-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Exclude MSI region in extended bridge window
Message-Id: <3rYZXm3HTnz9sxS@ozlabs.org>
Date: Tue, 21 Jun 2016 14:30:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-21-06 at 02:41:05 UTC, Gavin Shan wrote:
> The windows of root port and bridge behind that are extended to
> the PHB's windows to accomodate the PCI hotplug happening in
> future. The PHB's 64KB 32-bits MSI region is included in bridge's
> M32 windows (in hardware) though it's excluded in the corresponding
> resource, as the bridge's M32 windows have 1MB as their minimal
> alignment. We observed EEH error during system boot when the MSI
> region is included in bridge's M32 window.
> 
> This excludes top 1MB (including 64KB 32-bits MSI region) region
> from bridge's M32 windows when extending them.

AFAICS you added that code in "powerpc/powernv: Extend PCI bridge resources", so
I'll squash it into that. That way there is no window of breakage.

cheers
