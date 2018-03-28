Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BHzL3KchzF2Pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 06:30:38 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id l201so6897452wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 12:30:38 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/19] powerpc/powermac: Mark variable x as unused
Date: Wed, 28 Mar 2018 21:30:28 +0200
Message-Id: <20180328193028.823-1-malat@debian.org>
In-Reply-To: <20180322202007.23088-3-malat@debian.org>
References: <20180322202007.23088-3-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the value of x is never intended to be read, remove it. Fix warning
treated as error with W=1:

  arch/powerpc/platforms/powermac/udbg_scc.c:76:9: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: remove x completely

 arch/powerpc/platforms/powermac/udbg_scc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index d83135a9830e..8901973ed683 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -73,7 +73,7 @@ void udbg_scc_init(int force_scc)
 	struct device_node *stdout = NULL, *escc = NULL, *macio = NULL;
 	struct device_node *ch, *ch_def = NULL, *ch_a = NULL;
 	const char *path;
-	int i, x;
+	int i;
 
 	escc = of_find_node_by_name(NULL, "escc");
 	if (escc == NULL)
@@ -120,7 +120,7 @@ void udbg_scc_init(int force_scc)
 	mb();
 
 	for (i = 20000; i != 0; --i)
-		x = in_8(sccc);
+		in_8(sccc);
 	out_8(sccc, 0x09);		/* reset A or B side */
 	out_8(sccc, 0xc0);
 
-- 
2.11.0
