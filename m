Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCYXc04z8zDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 04:44:00 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id f144so28948333pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:43:59 -0800 (PST)
Date: Tue, 31 Jan 2017 09:43:55 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powermac: fix OF node refcount leak
Message-ID: <20170131174355.GA25198@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to call of_node_put() for device nodes obtained with
of_find_node_by_name().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Found by visual inspection, not tested...

 arch/powerpc/platforms/powermac/pic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index f5f9ad7c3398..d3a9ab0dbcb1 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -604,6 +604,7 @@ static int pmacpic_find_viaint(void)
 	if (np == NULL)
 		goto not_found;
 	viaint = irq_of_parse_and_map(np, 0);
+	of_node_put(np);
 
 not_found:
 #endif /* CONFIG_ADB_PMU */
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
