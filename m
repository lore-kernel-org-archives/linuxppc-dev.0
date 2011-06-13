Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 927ECB6FFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 12:03:18 +1000 (EST)
Received: from hpaq13.eem.corp.google.com (hpaq13.eem.corp.google.com
	[172.25.149.13]) by smtp-out.google.com with ESMTP id p5D23CcJ026643
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2011 19:03:12 -0700
Received: from pva4 (pva4.prod.google.com [10.241.209.4])
	by hpaq13.eem.corp.google.com with ESMTP id p5D22wUO030576
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2011 19:03:11 -0700
Received: by pva4 with SMTP id 4so2098762pva.30
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Jun 2011 19:03:11 -0700 (PDT)
Date: Sun, 12 Jun 2011 19:03:02 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Christoph Lameter <cl@linux-foundation.org>
Subject: [PATCH] slub: fix kernel BUG at mm/slub.c:1950!
Message-ID: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

3.0-rc won't boot with SLUB on my PowerPC G5: kernel BUG at mm/slub.c:1950!
Bisected to 1759415e630e "slub: Remove CONFIG_CMPXCHG_LOCAL ifdeffery".

After giving myself a medal for finding the BUG on line 1950 of mm/slub.c
(it's actually the
	VM_BUG_ON((unsigned long)(&pcp1) % (2 * sizeof(pcp1)));
on line 268 of the morass that is include/linux/percpu.h)
I tried the following alignment patch and found it to work.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/slub_def.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 3.0-rc2/include/linux/slub_def.h	2011-05-29 18:42:37.077880848 -0700
+++ linux/include/linux/slub_def.h	2011-06-12 17:17:51.000000000 -0700
@@ -43,7 +43,7 @@ struct kmem_cache_cpu {
 #ifdef CONFIG_SLUB_STATS
 	unsigned stat[NR_SLUB_STAT_ITEMS];
 #endif
-};
+} __attribute__((aligned(2 * sizeof(long))));
 
 struct kmem_cache_node {
 	spinlock_t list_lock;	/* Protect partial list and nr_partial */
