Return-Path: <srs0=roly=67=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xK1Rx5D5gzDrRQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 06:59:25 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xK1Rx4V6Dz8syC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 06:59:25 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xK1Rx0t2yz9s7m
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2017 06:59:24 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6SKx6aF141885
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 16:59:23 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c0bnu2qqn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 16:59:21 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 29 Jul 2017 06:59:09 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6SKvqv812255304
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2017 06:57:52 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6SKvpdX016630
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2017 06:57:51 +1000
Subject: [PATCH v6 2/2] powerpc/fadump: update documentation about
 'fadump_extra_args=' parameter
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Sat, 29 Jul 2017 02:27:44 +0530
In-Reply-To: <150127542322.3236.985689008735814219.stgit@hbathini.in.ibm.com>
References: <150127542322.3236.985689008735814219.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150127545575.3236.11820169568543892061.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the introduction of 'fadump_extra_args=' parameter to pass additional
parameters to fadump (capture) kernel, update documentation about it.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes from v5:
* Changed subject line to have 'fadump_extra_args='


 Documentation/powerpc/firmware-assisted-dump.txt |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index bdd344a..f2dd058 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -162,7 +162,18 @@ How to enable firmware-assisted dump (fadump):
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
 2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
-3. Optionally, user can also set 'crashkernel=' kernel cmdline
+3. A user can pass additional command line parameters as a space
+   separated quoted list through 'fadump_extra_args=' parameter,
+   to be enforced when fadump is active. For example, parameter
+   'fadump_extra_args="nr_cpus=1 numa=off udev.children-max=2"'
+   will be changed to 'fadump_extra_args nr_cpus=1  numa=off
+   udev.children-max=2' in-place when fadump is active. This
+   parameter has no affect when fadump is not active. Multiple
+   instances of 'fadump_extra_args=' can be passed. This provision
+   can be used to reduce memory consumption during dump capture by
+   disabling unwarranted resources/subsystems like CPUs, NUMA
+   and such.
+4. Optionally, user can also set 'crashkernel=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
 
@@ -172,6 +183,9 @@ NOTE: 1. 'fadump_reserve_mem=' parameter has been deprecated. Instead
       2. If firmware-assisted dump fails to reserve memory then it
          will fallback to existing kdump mechanism if 'crashkernel='
          option is set at kernel cmdline.
+      3. Special parameters like '--' are also just replaced in-place.
+         So, the user is advised to consider this while specifying
+         such parameters.
 
 Sysfs/debugfs files:
 ------------
