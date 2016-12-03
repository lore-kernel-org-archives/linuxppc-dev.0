Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW83j4g8mzDwBK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:31:13 +1100 (AEDT)
In-Reply-To: <20161201002305.14591-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc, gwshan@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: pradghos@in.ibm.com, ukrishn@linux.vnet.ibm.com
Subject: Re: powerpc/eeh: fix deadlock when PE frozen state can't be cleared
Message-Id: <3tW83j2zrGz9t1B@ozlabs.org>
Date: Sat,  3 Dec 2016 22:31:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-01 at 00:23:05 UTC, Andrew Donnellan wrote:
> In eeh_reset_device(), we take the pci_rescan_remove_lock immediately after
> after we call eeh_reset_pe() to reset the PCI controller. We then call
> eeh_clear_pe_frozen_state(), which can return an error. In this case, we
> bail out of eeh_reset_device() without calling pci_unlock_rescan_remove().
> 
> Add a call to pci_unlock_rescan_remove() in the eeh_clear_pe_frozen_state()
> error path so that we don't cause a deadlock later on.
> 
> Reported-by: Pradipta Ghosh <pradghos@in.ibm.com>
> Fixes: 78954700631f ("powerpc/eeh: Avoid I/O access during PE reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/409bf7f8a02ef88db5a0f2cdcf9489

cheers
