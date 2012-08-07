Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D574E2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 05:32:22 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Tue, 7 Aug 2012 15:32:18 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B10E2C901F1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 15:27:10 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q77JR9fp145856
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2012 15:27:10 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q780w2hL011143
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2012 20:58:02 -0400
Message-ID: <1344367748.24990.1.camel@footlong>
Subject: [PATCH 0/3] tpm: Add new vTPM device driver for PPC64
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 07 Aug 2012 14:29:08 -0500
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

These patches add support for IBM vTPM for PPC64.  This new device driver
works on firmware that supports vTPM (firmware release 740 or higher).

Tested on Power7+ system with firmware level ZM770_001.

Applied to Kent Yoder patch to modularize event log located at:
https://github.com/shpedoikal/linux/tree/tpmdd-next

Ashley Lai (3):
  drivers/char/tpm: Add new device driver to support IBM vTPM
  PPC64: Add support for instantiating SML from Open Firmware
  drivers/char/tpm: Add securityfs support for event log

 arch/powerpc/kernel/prom_init.c   |   64 ++++
 drivers/char/tpm/Kconfig          |    8 +
 drivers/char/tpm/Makefile         |    9 +-
 drivers/char/tpm/tpm.h            |   13 +-
 drivers/char/tpm/tpm_eventlog.c   |    7 +
 drivers/char/tpm/tpm_eventlog.h   |   24 ++
 drivers/char/tpm/tpm_ibmvtpm.c    |  750 +++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_ibmvtpm.h    |   83 ++++
 drivers/char/tpm/tpm_noeventlog.c |   21 +
 drivers/char/tpm/tpm_of.c         |   68 ++++
 10 files changed, 1034 insertions(+), 13 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_ibmvtpm.c
 create mode 100644 drivers/char/tpm/tpm_ibmvtpm.h
 create mode 100644 drivers/char/tpm/tpm_noeventlog.c
 create mode 100644 drivers/char/tpm/tpm_of.c
