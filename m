Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT7bs09g0zDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 00:03:20 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u86E2xuA092288
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 10:03:18 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259v09knsv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 10:03:17 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 00:03:15 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0CB0A3578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 00:03:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u86E3DKU6095188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 00:03:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u86E3C0i027513
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 00:03:12 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/9] ima: carry the measurement list across kexec 
Date: Tue,  6 Sep 2016 10:02:55 -0400
Message-Id: <1473170584-15094-1-git-send-email-zohar@linux.vnet.ibm.com>
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
boot, possibly of a different architecture.

The existing securityfs binary_runtime_measurements file conveniently
provides a serialized format of the IMA measurement list. This patch
set serializes the measurement list in this format and restores it.

Up to now, the binary_runtime_measurements was defined as architecture
native format.  The assumption being that userspace could and would
handle any architecture conversions.  With the ability of carrying the
measurement list across kexec, possibly from one architecture to a
different one, the per boot architecture information is lost and with it
the ability of recalculating the template digest hash.  To resolve this
problem, without breaking the existing ABI, this patch set introduces
the boot command line option "ima_canonical_fmt", which is arbitrarily
defined as little endian.

The need for this boot command line option will be limited to the
existing version 1 format of the binary_runtime_measurements.
Subsequent formats will be defined as canonical format (eg. TPM 2.0
support for larger digests).

This patch set pre-req's Thiago Bauermann's "kexec_file: Add buffer
hand-over for the next kernel" patch set. 

These patches can also be found in the next-kexec-restore branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Changelog v3:
- Cleaned up the code for calculating the requested kexec segment size
needed for the IMA measurement list, limiting the segment size to half
of the totalram_pages.
- Fixed kernel test robot reports as enumerated in the respective
patch changelog.

Changelog v2:
- Canonical measurement list support added
- Redefined the ima_kexec_hdr struct to use well defined sizes

Mimi

Andreas Steffen (1):
  ima: platform-independent hash value

Mimi Zohar (7):
  ima: on soft reboot, restore the measurement list
  ima: permit duplicate measurement list entries
  ima: maintain memory size needed for serializing the measurement list
  ima: serialize the binary_runtime_measurements
  ima: store the builtin/custom template definitions in a list
  ima: support restoring multiple template formats
  ima: define a canonical binary_runtime_measurements list format

Thiago Jung Bauermann (1):
  ima: on soft reboot, save the measurement list

 Documentation/kernel-parameters.txt       |   4 +
 include/linux/ima.h                       |  12 ++
 kernel/kexec_file.c                       |   4 +
 security/integrity/ima/Kconfig            |  12 ++
 security/integrity/ima/Makefile           |   1 +
 security/integrity/ima/ima.h              |  28 +++
 security/integrity/ima/ima_crypto.c       |   6 +-
 security/integrity/ima/ima_fs.c           |  30 ++-
 security/integrity/ima/ima_init.c         |   2 +
 security/integrity/ima/ima_kexec.c        | 209 +++++++++++++++++++++
 security/integrity/ima/ima_main.c         |   1 +
 security/integrity/ima/ima_queue.c        |  76 +++++++-
 security/integrity/ima/ima_template.c     | 293 ++++++++++++++++++++++++++++--
 security/integrity/ima/ima_template_lib.c |   7 +-
 14 files changed, 653 insertions(+), 32 deletions(-)
 create mode 100644 security/integrity/ima/ima_kexec.c

-- 
2.1.0
