Return-Path: <linuxram@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A49814009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 10:06:16 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 28 Apr 2014 20:06:14 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2E10F6E801C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 20:06:03 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T0611o6881784
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 00:06:10 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T05bxc014737
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 20:05:37 -0400
From: Ram Pai <linuxram@us.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/1] powerpc: crtsaveres.o needed only when -Os flag is enabled
Date: Mon, 28 Apr 2014 17:05:08 -0700
Message-Id: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 hartb@us.ibm.com, anton@samba.org, tony@ozlabs.au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    powerpc: crtsaveres.o needed only when -Os flag is enabled
    
    Currently on powerpc arch, out-of-tree module fails to build without
    crtsaveres.o, even when the module has no dependency on the symbols
    provided by the file; when built without the -Os flag.
    
    BTW: '-Os' flag is enabled when CONFIG_CC_OPTIMIZE_FOR_SIZE is
    configured.
    
    This patch fixes that problem.
    
Signed-off-by: Ram Pai <linuxram@us.ibm.com>

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 4c0cedf..cf12f38 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -157,7 +157,10 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
 
+ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+endif
+
 
 # No AltiVec or VSX instructions when building kernel
 KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
