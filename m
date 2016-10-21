Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0VQl2rXWzDvZs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:45:19 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2hp6W045126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:45:17 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2675yjs25s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:45:16 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:45:14 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 80D70352005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:44:45 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2jBNW16318800
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:45:11 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2jB2h004106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:45:11 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v6 00/10] ima: carry the measurement list across kexec
Date: Fri, 21 Oct 2016 00:44:48 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This is just a rebase on top of kexec_file_load patches v9 which I just
posted. The previous version of this series has some conflicts with it.

Original cover letter:

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

A simplified method of Thiago Bauermann's "kexec buffer handover" patch
series for carrying the IMA measurement list across kexec is included
in this patch set.  The simplified method requires all file measurements
be taken prior to executing the kexec load, as subsequent measurements
will not be carried across the kexec and restored.

Changelog v6:
- Rebased on top of "kexec_file_load implementation for PowerPC"
  patches v9.

Changelog v5:
- Included patches from Thiago Bauermann's "kexec buffer handover"
patch series for carrying the IMA measurement list across kexec.
- Added CONFIG_HAVE_IMA_KEXEC
- Renamed functions to variations of ima_kexec_buffer instead of
variations of kexec_handover_buffer

Changelog v4:
- Fixed "spinlock bad magic" BUG - reported by Dmitry Vyukov
- Rebased on Thiago Bauermann's v5 patch set
- Removed the skip_checksum initialization  

Changelog v3:
- Cleaned up the code for calculating the requested kexec segment size
needed for the IMA measurement list, limiting the segment size to half
of the totalram_pages.
- Fixed kernel test robot reports as enumerated in the respective
patch changelog.

Changelog v2:
- Canonical measurement list support added
- Redefined the ima_kexec_hdr struct to use well defined sizes

Andreas Steffen (1):
  ima: platform-independent hash value

Mimi Zohar (7):
  ima: on soft reboot, restore the measurement list
  ima: permit duplicate measurement list entries
  ima: maintain memory size needed for serializing the measurement list
  ima: on soft reboot, save the measurement list
  ima: store the builtin/custom template definitions in a list
  ima: support restoring multiple template formats
  ima: define a canonical binary_runtime_measurements list format

Thiago Jung Bauermann (2):
  powerpc: ima: Get the kexec buffer passed by the previous kernel
  powerpc: ima: Send the kexec buffer to the next kernel

 Documentation/kernel-parameters.txt         |   4 +
 arch/Kconfig                                |   3 +
 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/asm/ima.h              |  29 +++
 arch/powerpc/include/asm/kexec.h            |  15 +-
 arch/powerpc/kernel/Makefile                |   4 +
 arch/powerpc/kernel/ima_kexec.c             | 223 +++++++++++++++++++++
 arch/powerpc/kernel/kexec_elf_64.c          |   2 +-
 arch/powerpc/kernel/machine_kexec_file_64.c |  15 +-
 include/linux/ima.h                         |  12 ++
 kernel/kexec_file.c                         |   4 +
 security/integrity/ima/Kconfig              |  12 ++
 security/integrity/ima/Makefile             |   1 +
 security/integrity/ima/ima.h                |  31 +++
 security/integrity/ima/ima_crypto.c         |   6 +-
 security/integrity/ima/ima_fs.c             |  30 ++-
 security/integrity/ima/ima_init.c           |   2 +
 security/integrity/ima/ima_kexec.c          | 168 ++++++++++++++++
 security/integrity/ima/ima_main.c           |   1 +
 security/integrity/ima/ima_queue.c          |  76 +++++++-
 security/integrity/ima/ima_template.c       | 293 ++++++++++++++++++++++++++--
 security/integrity/ima/ima_template_lib.c   |   7 +-
 22 files changed, 901 insertions(+), 38 deletions(-)
 create mode 100644 arch/powerpc/include/asm/ima.h
 create mode 100644 arch/powerpc/kernel/ima_kexec.c
 create mode 100644 security/integrity/ima/ima_kexec.c

-- 
2.7.4
