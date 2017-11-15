Return-Path: <srs0=fjvl=cn=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycSdw54lZzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:16:52 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ycSdw4MvKz8t1V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:16:52 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ycSdv6h3xz9s7C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2017 02:16:51 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFFG8W3022553
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:16:50 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e8qy70j4a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:16:49 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 15:16:46 -0000
Subject: [PATCH v9 0/8] reduce memory consumption for powerpc
 firmware-assisted capture kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 lkml <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 20:46:40 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I posted the initial version [1] of patchset [2] adding support to enforce
additional parameters when firmware-assisted dump capture kernel is active.
Michal reposted it with few improvements to parameter processing to make
it more robust. He further posted patchset [3] with few more improvements.

This patch series clubs the work from these two patch-sets while segregating
the generic and arch-specific code to ease the review process.

[1] http://patchwork.ozlabs.org/patch/758176/
[2] http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=2733
[3] http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3338

---

Hari Bathini (2):
      powerpc/fadump: reduce memory consumption for capture kernel
      powerpc/fadump: update documentation about 'fadump_extra_args=' parameter

Michal Suchanek (6):
      lib/cmdline.c: remove quotes symmetrically
      boot/param: add pointer to current and next argument to unknown parameter callback
      lib/cmdline.c: add backslash support to kernel commandline parsing
      Documentation/admin-guide: backslash support in commandline
      lib/cmdline.c: implement single quotes in commandline argument parsing
      Documentation/admin-guide: single quotes in kernel arguments


 Documentation/admin-guide/kernel-parameters.rst  |    5 +
 Documentation/powerpc/firmware-assisted-dump.txt |   20 ++++-
 arch/powerpc/include/asm/fadump.h                |    2 
 arch/powerpc/kernel/fadump.c                     |   97 +++++++++++++++++++++-
 arch/powerpc/kernel/prom.c                       |    7 ++
 include/linux/moduleparam.h                      |    1 
 init/main.c                                      |    8 +-
 kernel/module.c                                  |    5 +
 kernel/params.c                                  |   18 +++-
 lib/cmdline.c                                    |   54 +++++++-----
 lib/dynamic_debug.c                              |    1 
 11 files changed, 179 insertions(+), 39 deletions(-)
