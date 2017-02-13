Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMB9p2Kq9zDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 14:39:10 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1D3YqTH079283
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:39:06 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28jsp89mgr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:39:06 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 13 Feb 2017 13:39:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8A5A03578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 14:39:02 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1D3csep7274584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 14:39:02 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1D3cUjp030514
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 14:38:30 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: akshay.adiga@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc: Blacklist GCC 5.4 6.1 and 6.2
Date: Mon, 13 Feb 2017 14:35:36 +1100
Message-Id: <20170213033536.8908-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A bug in the -02 optimisation of GCC 5.4 6.1 and 6.2 causes
setup_command_line() to not pass the correct first argument to strcpy
and therefore not actually copy the command_line.

A workaround patch was proposed: http://patchwork.ozlabs.org/patch/673130/
some discussion ensued.

A GCC bug was raised: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71709
The bug has been fixed in 7.0 and backported to GCC 5 and GCC 6.

At the time of writing GCC 5.4 is the most recent and is affected. GCC
6.3 contains the backported fix, has been tested and appears safe to
use.

Heavy-lifting-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
v2: Added check to only blacklist compilers on little-endian

 arch/powerpc/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 31286fa7873c..db5d8dabf1ca 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -381,6 +381,7 @@ TOUT	:= .tmp_gas_check
 # - gcc-3.4 and binutils-2.14 are a fatal combination
 # - Require gcc 4.0 or above on 64-bit
 # - gcc-4.2.0 has issues compiling modules on 64-bit
+# - gcc-5.4, 6.1, 6.2 don't copy the command_line around correctly
 checkbin:
 	@if test "$(cc-name)" != "clang" \
 	    && test "$(cc-version)" = "0304" ; then \
@@ -414,6 +415,16 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
+	@if test "x${CONFIG_CPU_LITTLE_ENDIAN}" = "xy" \
+		&& { test "$(cc-version)" = "0504" \
+		|| test "$(cc-version)" = "0601" \
+		|| test "$(cc-version)" = "0602" ; } ; then \
+		echo -n '*** GCC-5.4 6.1 6.2 have a bad -O2 optimisation ' ; \
+		echo 'which will cause lost command_line options (at least).' ; \
+		echo '*** Please use a different GCC version.' ; \
+		false ; \
+	fi
+
 
 
 CLEAN_FILES += $(TOUT)
-- 
2.11.1
