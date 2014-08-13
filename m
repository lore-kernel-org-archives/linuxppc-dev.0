Return-Path: <himangi774@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E3571A004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 19:18:55 +1000 (EST)
Received: by mail-pa0-f49.google.com with SMTP id hz1so14564400pad.36
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 02:18:52 -0700 (PDT)
Date: Wed, 13 Aug 2014 14:48:47 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: enjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: Drop unnecessary continue
Message-ID: <20140813091847.GA3078@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Continue is not needed at the bottom of a loop.

The Coccinelle semantic patch implementing this change is:

@@
@@

for (...;...;...) {
  ...
  if (...) {
    ...
-   continue;
  }
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Not compile tested.
 arch/powerpc/platforms/pseries/cmm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 2d8bf15..fc44ad0 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -555,7 +555,6 @@ static int cmm_mem_going_offline(void *arg)
 				pa_last = pa_last->next;
 				free_page((unsigned long)cmm_page_list);
 				cmm_page_list = pa_last;
-				continue;
 			}
 		}
 		pa_curr = pa_curr->next;
-- 
1.9.1
