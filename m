Return-Path: <srs0=oqq6=4j=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJ64G3jpKzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 04:23:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wJ64F5jy3z8svY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 04:23:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wJ64D515Gz9rvt
 for <linuxppc-dev@ozlabs.org>; Thu,  4 May 2017 04:23:56 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v43IIhfd002753
 for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2017 14:23:48 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7j1672h8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 03 May 2017 14:23:48 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 4 May 2017 04:23:45 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v43INZTJ64815348
 for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2017 04:23:43 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v43IN4TX031252
 for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2017 04:23:05 +1000
Subject: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 03 May 2017 23:52:52 +0530
In-Reply-To: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
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

Changes from v4:
* Based on top of patchset that includes
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=05f383cdfba8793240e73f9a9fbff4e25d66003f


 Documentation/powerpc/firmware-assisted-dump.txt |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 8394bc8..6327193 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -162,7 +162,15 @@ How to enable firmware-assisted dump (fadump):
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
 2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
-3. Optionally, user can also set 'crashkernel=' kernel cmdline
+3. A user can pass additional command line parameters as a comma
+   separated list through 'fadump_append=' parameter, to be enforced
+   when fadump is active. For example, if parameters like nr_cpus=1,
+   numa=off & udev.children-max=2 are to be enforced when fadump is
+   active, 'fadump_append=nr_cpus=1,numa=off,udev.children-max=2'
+   can be passed in command line, which will be replaced with
+   "nr_cpus=1 numa=off udev.children-max=2" when fadump is active.
+   This helps in reducing memory consumption during dump capture.
+4. Optionally, user can also set 'crashkernel=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
 
