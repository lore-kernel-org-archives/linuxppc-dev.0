Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77A932C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 09:22:05 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Tue, 14 Aug 2012 19:22:02 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8305338C803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 19:21:55 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7ENLtPo111410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 19:21:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7ENLrCx022727
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 20:21:54 -0300
Message-ID: <1344986638.4430.22.camel@footlong>
Subject: [PATCH V3 0/3] tpm: Add new vTPM device driver for PPC64
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Aug 2012 18:23:58 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, adlai@linux.vnet.ibm.com,
 linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 adlai@us.ibm.com, key@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change log V3:
- Replaced TPM_NO_EVENT_LOG macro with stubs
- Removed tpm_noeventlog.c file 
- Called of_node_put() before return in tpm_of.c

Change log V2:
- Removed unnecessary tpm_bios_log_setup and tpm_bios_log_teardown
  functions in tpm_eventlog.h (patch 3/3).
- Added more descriptions on vTPM (patch 1/3).

These patches add support for IBM vTPM for PPC64. This new device driver
works on firmware that supports vTPM (firmware release 740 or higher).

Tested on Power7+ system with firmware level ZM770_001.

Applied to Kent Yoder tree at:
https://github.com/shpedoikal/linux/tree/v3.6-rc1-tpmdd-staging

Ashley Lai (3):
  drivers/char/tpm: Add new device driver to support IBM vTPM
  PPC64: Add support for instantiating SML from Open Firmware
  drivers/char/tpm: Add securityfs support for event log

 arch/powerpc/kernel/prom_init.c |   62 ++++
 drivers/char/tpm/Kconfig        |    8 +
 drivers/char/tpm/Makefile       |    6 +
 drivers/char/tpm/tpm.h          |   13 +-
 drivers/char/tpm/tpm_eventlog.h |   15 +
 drivers/char/tpm/tpm_ibmvtpm.c  |  749 +++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_ibmvtpm.h  |   83 +++++
 drivers/char/tpm/tpm_of.c       |   73 ++++
 8 files changed, 997 insertions(+), 12 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_ibmvtpm.c
 create mode 100644 drivers/char/tpm/tpm_ibmvtpm.h
 create mode 100644 drivers/char/tpm/tpm_of.c
