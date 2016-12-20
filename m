Return-Path: <geliangtang@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjfd84kJWzDrBt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 01:03:08 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id w68so6038826pgw.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 06:03:08 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/perf/24x7: use rb_entry
Date: Tue, 20 Dec 2016 22:02:17 +0800
Message-Id: <38870b7604726c87e468f365ebe9236994c33f29.1482203132.git.geliangtang@gmail.com>
In-Reply-To: <ddabc96c798df194791134d8e070d728e2a7b59f.1482203698.git.geliangtang@gmail.com>
References: <ddabc96c798df194791134d8e070d728e2a7b59f.1482203698.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To make the code clearer, use rb_entry() instead of container_of() to
deal with rbtree.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 7b2ca16..51bd3b4 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -547,7 +547,7 @@ static int event_uniq_add(struct rb_root *root, const char *name, int nl,
 		struct event_uniq *it;
 		int result;
 
-		it = container_of(*new, struct event_uniq, node);
+		it = rb_entry(*new, struct event_uniq, node);
 		result = ev_uniq_ord(name, nl, domain, it->name, it->nl,
 					it->domain);
 
-- 
2.9.3
