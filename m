Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH30GJDzF08D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:55 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id t6so2264575wmt.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:54 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 07/19] ppc64: change %ld into %d
Date: Fri, 16 Mar 2018 12:02:12 +0100
Message-Id: <20180316110224.12260-8-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
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

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘excprint’:
../arch/powerpc/xmon/xmon.c:1629:25: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘pid_t {aka int}’ [-Werror=format=]
   printf("    pid   = %ld, comm = %s\n",
                         ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 738888e6a927..6117164cb5ba 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1626,7 +1626,7 @@ static void excprint(struct pt_regs *fp)
 	       local_paca, local_paca->irq_soft_mask, local_paca->irq_happened);
 #endif
 	if (current) {
-		printf("    pid   = %ld, comm = %s\n",
+		printf("    pid   = %d, comm = %s\n",
 		       current->pid, current->comm);
 	}
 
-- 
2.11.0
