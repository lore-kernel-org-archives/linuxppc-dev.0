Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCV6CWCzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:02 +1100 (AEDT)
In-Reply-To: <20170206010717.3460-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: vaibhav@linux.vnet.ibm.com, stable@vger.kernel.org,
 ukrishn@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com, pradghos@in.ibm.com,
 imunsie@au1.ibm.com
Subject: Re: cxl: fix nested locking hang during EEH hotplug
Message-Id: <3vWyCV0F0qz9sN4@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-06 at 01:07:17 UTC, Andrew Donnellan wrote:
> Commit 14a3ae34bfd0 ("cxl: Prevent read/write to AFU config space while AFU
> not configured") introduced a rwsem to fix an invalid memory access that
> occurred when someone attempts to access the config space of an AFU on a
> vPHB whilst the AFU is deconfigured, such as during EEH recovery.
> 
> It turns out that it's possible to run into a nested locking issue when EEH
> recovery fails and a full device hotplug is required.
> cxl_pci_error_detected() deconfigures the AFU, taking a writer lock on
> configured_rwsem. When EEH recovery fails, the EEH code calls
> pci_hp_remove_devices() to remove the device, which in turn calls
> cxl_remove() -> cxl_pci_remove_afu() -> pci_deconfigure_afu(), which tries
> to grab the writer lock that's already held.
> 
> Standard rwsem semantics don't express what we really want to do here and
> don't allow for nested locking. Fix this by replacing the rwsem with an
> atomic_t which we can control more finely. Allow the AFU to be locked
> multiple times so long as there are no readers.
> 
> Fixes: 14a3ae34bfd0 ("cxl: Prevent read/write to AFU config space while AFU not configured")
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/171ed0fcd8966d82c45376f1434678

cheers
