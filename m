Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKNsN2rRjzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 16:33:44 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1A5Sd3u047870
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:33:41 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28gyp6f3wn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:33:41 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 10 Feb 2017 15:33:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F11712BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 16:33:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1A5XRqU39059526
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 16:33:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1A5X39M025739
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 16:33:03 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: akshay.adiga@linux.vnet.ibm.com
Subject: [PATCH] powerpc: Blacklist GCC 5.4 6.1 and 6.2
Date: Fri, 10 Feb 2017 16:31:15 +1100
Message-Id: <20170210053115.20565-1-cyrilbur@gmail.com>
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
 arch/powerpc/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 31286fa7873c..a4b886694391 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -414,6 +414,15 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
+	@if test "$(cc-version)" = "0504" \
+		|| test "$(cc-version)" = "0601" \
+		|| test "$(cc-version)" = "0602" ; then \
+		echo -n '*** GCC-5.4 6.1 6.2 have a bad -O2 optimisation ' ; \
+		echo 'which will cause lost commandline options (at least).' ; \
+		echo '*** Please use a different GCC version.' ; \
+		false ; \
+	fi
+
 
 
 CLEAN_FILES += $(TOUT)
-- 
2.11.1
