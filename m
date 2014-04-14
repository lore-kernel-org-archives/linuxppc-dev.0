Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0876A14011C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:48:17 +1000 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 14 Apr 2014 08:48:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 566C117D805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 08:49:06 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3E7mBFT63635678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 07:48:11 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3E7mAum029418
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 01:48:11 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 11/15] powerpc/boot: add little endian support to elf utils
Date: Mon, 14 Apr 2014 09:47:10 +0200
Message-Id: <1397461634-20949-12-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
References: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/elf_util.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/elf_util.c b/arch/powerpc/boot/elf_util.c
index 1567a0c0f05c..316552dea4d8 100644
--- a/arch/powerpc/boot/elf_util.c
+++ b/arch/powerpc/boot/elf_util.c
@@ -26,7 +26,11 @@ int parse_elf64(void *hdr, struct elf_info *info)
 	      elf64->e_ident[EI_MAG2]  == ELFMAG2	&&
 	      elf64->e_ident[EI_MAG3]  == ELFMAG3	&&
 	      elf64->e_ident[EI_CLASS] == ELFCLASS64	&&
+#ifdef __LITTLE_ENDIAN__
+	      elf64->e_ident[EI_DATA]  == ELFDATA2LSB	&&
+#else
 	      elf64->e_ident[EI_DATA]  == ELFDATA2MSB	&&
+#endif
 	      (elf64->e_type            == ET_EXEC ||
 	       elf64->e_type            == ET_DYN)	&&
 	      elf64->e_machine         == EM_PPC64))
-- 
1.7.10.4
