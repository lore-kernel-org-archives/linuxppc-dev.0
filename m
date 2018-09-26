Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KxfY3y98zF3Jl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 22:13:09 +1000 (AEST)
In-Reply-To: <6a7769a5-c8bc-f857-61cc-a76cdd98b28c@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, minkim@us.ibm.com,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [v02] REPOST powerpc/migration: Handle unitialized timer reset
Message-Id: <42KxfY2bFQz9s4Z@ozlabs.org>
Date: Wed, 26 Sep 2018 22:13:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-09-20 at 16:45:13 UTC, Michael Bringmann wrote:
> After migration of a powerpc LPAR, the kernel executes code to
> update the system state to reflect new platform characteristics.
> Such changes include modifications to device tree properties
> provided to the system by PHYP.  Property notifications received
> by the powerpc 'migration_store' code are passed along to the
> kernel in general through a call to 'of_update_property' which
> in turn passes such events back to all modules through entries like
> the '.notifier_call' function within the NUMA module.  When the
> NUMA module updates its state, it resets its event timer.  If this
> occurs after a previous call to 'stop_topology_update' or on a
> system without VPHN enabled, the code runs into an unitialized
> timer structure and crashes.  This patch adds a safety check
> along this path toward the problem code.
> 
> Note: This crash was observed on every LPM in the 4.17-rc7 kernel
> (and in the 4.18 kernel) of a system with dedicated CPUs enabled.
> An example crash log without the patch is as follows.
> 
...
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8604895a34d92f5e186ceb931b0d1b

cheers
