Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D587E140146
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:24:02 +1000 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 24 Apr 2014 08:23:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9BD1F1B08040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 08:23:59 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7Nrhw2359746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 07:23:53 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O7NrMG020111
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 01:23:53 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 11/15] powerpc/boot: add little endian support to elf utils
Date: Thu, 24 Apr 2014 09:23:35 +0200
Message-Id: <1398324219-8919-12-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
References: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
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
