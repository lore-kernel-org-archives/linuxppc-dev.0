Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH10m14zF07D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:52 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id o1so11246215wro.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:52 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 04/19] ppc32: change %lx into %p
Date: Fri, 16 Mar 2018 12:02:09 +0100
Message-Id: <20180316110224.12260-5-malat@debian.org>
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

also remove extra fp->link since no formatter associated.

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘excprint’:
../arch/powerpc/xmon/xmon.c:1607:31: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘struct pt_regs *’ [-Werror=format=]
  printf("Vector: %lx %s at [%lx]\n", fp->trap, getvecname(trap), fp);
                               ^
../arch/powerpc/xmon/xmon.c:1611:9: error: too many arguments for format [-Werror=format-extra-args]
  printf("    lr: ", fp->link);
         ^~~~~~~~~~
../arch/powerpc/xmon/xmon.c:1623:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘struct task_struct *’ [-Werror=format=]
  printf("  current = 0x%lx\n", current);
                          ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index f155f030550f..15011be7a051 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1604,11 +1604,11 @@ static void excprint(struct pt_regs *fp)
 #endif /* CONFIG_SMP */
 
 	trap = TRAP(fp);
-	printf("Vector: %lx %s at [%lx]\n", fp->trap, getvecname(trap), fp);
+	printf("Vector: %lx %s at [%p]\n", fp->trap, getvecname(trap), fp);
 	printf("    pc: ");
 	xmon_print_symbol(fp->nip, ": ", "\n");
 
-	printf("    lr: ", fp->link);
+	printf("    lr: ");
 	xmon_print_symbol(fp->link, ": ", "\n");
 
 	printf("    sp: %lx\n", fp->gpr[1]);
@@ -1620,7 +1620,7 @@ static void excprint(struct pt_regs *fp)
 			printf(" dsisr: %lx\n", fp->dsisr);
 	}
 
-	printf("  current = 0x%lx\n", current);
+	printf("  current = 0x%p\n", current);
 #ifdef CONFIG_PPC64
 	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
 	       local_paca, local_paca->irq_soft_mask, local_paca->irq_happened);
-- 
2.11.0
