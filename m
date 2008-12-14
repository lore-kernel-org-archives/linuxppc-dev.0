Return-Path: <gknispel@proformatique.com>
Received: from proformatique.com (web.proformatique.com [91.194.179.68])
	by ozlabs.org (Postfix) with ESMTP id 97769DDE9F
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 05:50:53 +1100 (EST)
Date: Sun, 14 Dec 2008 19:50:50 +0100
From: Guillaume Knispel <gknispel@proformatique.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
Message-ID: <20081214195050.677ba7d1@xilun.lan.proformatique.com>
In-Reply-To: <493E8BE2.809@freescale.com>
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
	<493E88B7.5020702@freescale.com>
	<20081209161422.5e289e6c@xilun.lan.proformatique.com>
	<493E8BE2.809@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tjernlund <joakim.tjernlund@transmode.se>, Joakim,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 09 Dec 2008 09:16:50 -0600
Timur Tabi <timur@freescale.com> wrote:

> Guillaume Knispel wrote:
> 
> > blk = NULL; at the end of the loop is what is done in the more used
> > rh_alloc_align(), so for consistency either we change both or we use
> > the same construction here.
> > I also think that testing for &info->free_list is harder to understand
> > because you must have the linked list implementation in your head
> > (which a kernel developer should anyway so this is not so important)
> 
> Fair enough.
> 
> Acked-by: Timur Tabi <timur@freescale.com>
> 

Kumar, can this go into your tree ?
(copying the patch under so you have it at hand)

There is an error in rh_alloc_fixed() of the Remote Heap code:
If there is at least one free block blk won't be NULL at the end of the
search loop, so -ENOMEM won't be returned and the else branch of
"if (bs == s || be == e)" will be taken, corrupting the management
structures.

Signed-off-by: Guillaume Knispel <gknispel@proformatique.com>
---
Fix an error in rh_alloc_fixed() that made allocations succeed when
they should fail, and corrupted management structures.

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 29b2941..45907c1 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -556,6 +556,7 @@ unsigned long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, co
 		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
+		blk = NULL;
 	}
 
 	if (blk == NULL)

-- 
Guillaume KNISPEL
