Return-Path: <srs0=xksd=4c=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCX3m2kjGzDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 17:37:40 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCX3m22nNz8wVM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 17:37:40 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCX3l5sdKz9s7f
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 17:37:39 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3Q7Y1UH140194
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 03:37:31 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebuv3f5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 03:37:27 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 17:36:44 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3Q7aYPT10420280
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 17:36:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3Q7a57a022101
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 17:36:05 +1000
Subject: [PATCH v3 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 13:05:47 +0530
In-Reply-To: <149319210065.14869.5547128856388591456.stgit@hbathini.in.ibm.com>
References: <149319210065.14869.5547128856388591456.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149319214354.14869.4588799382016531714.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the introduction of 'fadump_append=' parameter to pass additional
parameters to fadump (capture) kernel, update documentation about it.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 3007bc9..8e12380 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -158,7 +158,11 @@ How to enable firmware-assisted dump (fadump):
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
 2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
-3. Optionally, user can also set 'fadump_reserve_mem=' kernel cmdline
+3. A user can pass additional kernel parameters as a comma separated list
+   through 'fadump_append=' parameter, to be enforced when fadump is active.
+   This can be used to pass parameters like nr_cpus=1, numa=off to reduce
+   memory consumption during dump capture.
+4. Optionally, user can also set 'fadump_reserve_mem=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
 
