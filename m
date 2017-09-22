Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xywGF4KzHzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 11:03:33 +1000 (AEST)
In-Reply-To: <1505941372-9147-1-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sachinp@linux.vnet.ibm.com, v4.13+@b01ledav001.gho.pok.ibm.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 abdhalee@linux.vnet.ibm.com, robh+dt@kernel.org, paulus@samba.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, #@b01ledav001.gho.pok.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/pseries: fix "OF: ERROR: Bad of_node_put() on
 /cpus" during DLPAR
Message-Id: <3xywGF3LZvz9t32@ozlabs.org>
Date: Fri, 22 Sep 2017 11:03:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-20 at 21:02:51 UTC, Tyrel Datwyler wrote:
> Commit 215ee763f8cb ("powerpc: pseries: remove dlpar_attach_node dependency on
> full path") reworked dlpar_attach_node() to no longer look up the parent
> node "/cpus", but instead to have the parent node passed by the caller in the
> function parameter list. As a result dlpar_attach_node() is no longer
> responsible for freeing the reference to the parent node. However,
> commit 215ee763f8cb failed to remove the of_node_put(parent) call in
> dlpar_attach_node(), or to take into account that the reference to the
> parent in the caller dlpar_cpu_add() needs to be held until after
> dlpar_attach_node() returns. As a result doing repeated cpu add/remove dlpar
> operations will eventually result in the following error:
> 
> OF: ERROR: Bad of_node_put() on /cpus
> CPU: 0 PID: 10896 Comm: drmgr Not tainted 4.13.0-autotest #1
> Call Trace:
> [c00000026ecdf810] [c00000000278a2a4] dump_stack+0x15c/0x1f8
> (unreliable)
> [c00000026ecdf850] [c0000000025371a4] of_node_release+0x1a4/0x1c0
> [c00000026ecdf8e0] [c0000000027948c8] kobject_put+0x1a8/0x310
> [c00000026ecdf960] [c000000002794bdc] kobject_del+0xbc/0xf0
> [c00000026ecdf990] [c000000002535ff4] __of_detach_node_sysfs+0x144/0x210
> [c00000026ecdf9d0] [c000000002536f70] of_detach_node+0xf0/0x180
> [c00000026ecdfa40] [c0000000016ed494] dlpar_detach_node+0xc4/0x120
> [c00000026ecdfa80] [c0000000016f47d0] dlpar_cpu_remove+0x280/0x560
> [c00000026ecdfb60] [c0000000016f4d9c] dlpar_cpu_release+0xbc/0x1b0
> [c00000026ecdfbb0] [c00000000161279c] arch_cpu_release+0x6c/0xb0
> [c00000026ecdfbe0] [c00000000218ebf0] cpu_release_store+0xa0/0x100
> [c00000026ecdfc20] [c000000002178388] dev_attr_store+0x68/0xa0
> [c00000026ecdfc50] [c000000001bfaae8] sysfs_kf_write+0xa8/0xf0
> [c00000026ecdfc80] [c000000001bf8a3c] kernfs_fop_write+0x2cc/0x400
> [c00000026ecdfce0] [c000000001ad33fc] __vfs_write+0x5c/0x340
> [c00000026ecdfd80] [c000000001ad89e8] vfs_write+0x1a8/0x3d0
> [c00000026ecdfdd0] [c000000001ad9178] SyS_write+0xa8/0x1a0
> [c00000026ecdfe30] [c0000000015eb8e0] system_call+0x58/0x6c
> 
> Fix the issue by removing the of_node_put(parent) call from
> dlpar_attach_node(), and ensuring that the reference to the parent node
> is properly held and released by the caller dlpar_cpu_add().
> 
> Cc: stable@vger.kernel.org # v4.13+
> Fixes: 215ee763f8cb ("powerpc: pseries: remove dlpar_attach_node dependency on full path")
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/087ff6a5ae3052bb2835e191094b79

cheers
