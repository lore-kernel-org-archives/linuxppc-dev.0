Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3rs2PCwzF3PJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:38:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Track LMB nid instead of using device
 tree
In-Reply-To: <153677072365.15599.14388703259401466198.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <153677072365.15599.14388703259401466198.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Thu, 20 Sep 2018 14:38:36 +1000
Message-ID: <87h8ikkckz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> When removing memory we need to remove the memory from the node
> it was added to instead of looking up the node it should be in
> in the device tree.
>
> During testing we have seen scenarios where the affinity for a
> LMB changes due to a partition migration or PRRN event. In these
> cases the node the LMB exists in may not match the node the device
> tree indicates it belongs in. This can lead to a system crash
> when trying to DLAPR remove the LMB after a migration or PRRN
> event. The current code looks up the node in the device tree to
> remove the LMB from, the crash occurs when we try to offline this
> node and it does not have any data, i.e. node_data[nid] == NULL.

This isn't building for 32-bit etc:

arch/powerpc/mm/drmem.c: In function 'init_drmem_v1_lmbs':
arch/powerpc/mm/drmem.c:371:14: error: implicit declaration of function 'memory_add_physaddr_to_nid' [-Werror=implicit-function-declaration]
   lmb->nid = memory_add_physaddr_to_nid(lmb->base_addr);
              ^
cc1: all warnings being treated as errors
scripts/Makefile.build:317: recipe for target 'arch/powerpc/mm/drmem.o' failed

See the failed checks here:
  https://patchwork.ozlabs.org/patch/969150/


Probably drmem.c should only be compiled for 64-bit NUMA etc.

cheers
