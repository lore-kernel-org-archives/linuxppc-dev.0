Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4pzW3yvlzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:24:55 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74COGk6100759
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 08:24:50 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkakh56s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 08:24:50 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 22:24:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 74C6E357805B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:24:44 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74COigG29688040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 22:24:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74COhGQ019017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 22:24:43 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 0/7] ima: carry the measurement list across kexec 
Date: Thu,  4 Aug 2016 08:24:28 -0400
Message-Id: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TPM PCRs are only reset on a hard reboot.  In order to validate a
TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
of the running kernel must be saved and then restored on the subsequent
boot.

The existing securityfs binary_runtime_measurements file conveniently
provides a serialized format of the IMA measurement list. This patch
set serializes the measurement list in this format and restores it.

This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
hand-over for the next kernel" patch set* for actually carrying the
serialized measurement list across the kexec.

Mimi

*https://lists.infradead.org/pipermail/kexec/2016-June/016157.html

Mimi Zohar (6):
  ima: on soft reboot, restore the measurement list
  ima: permit duplicate measurement list entries
  ima: maintain memory size needed for serializing the measurement list
  ima: serialize the binary_runtime_measurements
  ima: store the builtin/custom template definitions in a list
  ima: support restoring multiple template formats

Thiago Jung Bauermann (1):
  ima: on soft reboot, save the measurement list

 include/linux/ima.h                   |  15 ++
 kernel/kexec_file.c                   |   3 +
 security/integrity/ima/Kconfig        |  12 ++
 security/integrity/ima/Makefile       |   1 +
 security/integrity/ima/ima.h          |  14 ++
 security/integrity/ima/ima_fs.c       |   2 +-
 security/integrity/ima/ima_init.c     |   2 +
 security/integrity/ima/ima_kexec.c    | 189 ++++++++++++++++++++++++
 security/integrity/ima/ima_main.c     |   1 +
 security/integrity/ima/ima_queue.c    |  72 +++++++++-
 security/integrity/ima/ima_template.c | 262 ++++++++++++++++++++++++++++++++--
 11 files changed, 556 insertions(+), 17 deletions(-)
 create mode 100644 security/integrity/ima/ima_kexec.c

-- 
2.1.0
