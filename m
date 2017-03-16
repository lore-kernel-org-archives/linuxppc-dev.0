Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkLLf49DvzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:53:14 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7hYb4095981
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:53:04 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297nd03g0x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:53:03 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 16 Mar 2017 17:53:00 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7qndl42205244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:52:57 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7qPcE001382
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:52:25 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v2G7qPel000832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:52:25 +1100
Received: from camb691.ibm.com (unknown [9.83.1.95])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 73BC0A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:52:00 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] arch/powerpc: Fix zImage wrapper with 64bit only toolchains
Date: Thu, 16 Mar 2017 18:49:48 +1100
Message-Id: <20170316074948.5955-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Historically the zImage wrapper has needed to be compiled 32bit to run
on 32bit only platforms. Today some platforms can have 64bit wrappers as
they've always been 64bit compatible, notably little endian systems.

Problems arise when a kernel and zImage are cross compiled with a 64bit
only toolchain. The Makefile will determine that the toolchain is not
32bit compatible and whilst attempting to fall back to CROSS32CC or
CROSS32_COMPILE which are unlikely to be set, it falls back to using
`gcc`, the host compiler.

On platforms that can have the wrapper compiled 64bit (and where the
compiler is not 32bit capable), the Makefile should first fall back to
the compiler it used for the rest of the kernel.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8b433334d5af..e7a90952ed36 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -25,6 +25,16 @@ ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
 KBUILD_ARFLAGS	+= --target=elf32-powerpc
 endif
+else
+ifeq ($(CONFIG_PPC64_BOOT_WRAPPER),y)
+ifeq ($(CROSS32_COMPILE),)
+#The 64bit only toolchain is perfectly capable of building a 64bit
+#boot wrapper.
+#So use it
+CROSS32CC	:= $(CC)
+CROSS32AR	:= $(AR)
+endif
+endif
 endif
 
 export CROSS32CC CROSS32AR
-- 
2.12.0
