Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCX2SyTzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:04 +1100 (AEDT)
In-Reply-To: <20170215184528.11755.568.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jallen@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 mdroth@linux.vnet.ibm.com, sahilmehta17@gmail.com
Subject: Re: [v7,2/4] powerpc/pseries: Revert 'Auto-online hotplugged memory'
Message-Id: <3vWyCX0NzRz9sN8@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-15 at 18:45:30 UTC, Nathan Fontenot wrote:
> Revert the patch patch to auto-online hotplugged memory, commit
> id ec999072442a. Using the auto-online acpability does online added
> memory but does not update the associated device struct to
> indicate that the memory is online. The result of this is that
> memoryXX/online file in sysfs still reports the memory as being offline.
> 
> Additionally, not updating the device struct to indicate the memory
> is online will cause the pseries memory DLPAR code to fail when trying
> to remove a LMB that was previously removed and added back. This happens
> when validating that the LMB is removable.
> 
> Looking further into the auto-online memory, it seems that this
> capability is meant more for something like a balloon driver rather than
> general memory hotplug.
> 
> This patch reverts to the previous behavior of calling device_online()
> to online the LMB when it is DLPAR added and moves the lmb_to_memblock()
> routine out of CONFIG_MEMORY_HOTREMOVE now that we call it for add.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/943db62c316c578f8e2cc6fb81a5f6

cheers
