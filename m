Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTdR44GM1zDvr9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 11:27:44 +1100 (AEDT)
Message-ID: <1480552059.5964.1.camel@russell.cc>
Subject: Re: [PATCH] powerpc/eeh: fix deadlock when PE frozen state can't be
 cleared
From: Russell Currey <ruscur@russell.cc>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Cc: ukrishn@linux.vnet.ibm.com, pradghos@in.ibm.com
Date: Thu, 01 Dec 2016 11:27:39 +1100
In-Reply-To: <20161201002305.14591-1-andrew.donnellan@au1.ibm.com>
References: <20161201002305.14591-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-01 at 11:23 +1100, Andrew Donnellan wrote:
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
> ---

Locking in this function is such a mess, we (I) should revisit it at some point.

Acked-by: Russell Currey <ruscur@russell.cc>
