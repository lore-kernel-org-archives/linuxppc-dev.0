Return-Path: <stefanb@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4B291A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 11:55:12 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stefanb@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 21:55:09 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6F95C6E801D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 21:46:53 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t781t7N566977976
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Aug 2015 01:55:07 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t781t71S012118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Aug 2015 21:55:07 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nikunj@linux.vnet.ibm.com, aik@au1.ibm.com,
 pmac@au1.ibm.com
Cc: gcwilson@us.ibm.com, dimitris@us.ibm.com, latten@us.ibm.com,
 lo1@us.ibm.com, stefanb@us.ibm.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 00/16] Add vTPM support to SLOF
Date: Fri,  7 Aug 2015 21:54:49 -0400
Message-Id: <1438998905-4085665-1-git-send-email-stefanb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series of patches adds TPM support to SLOF.
In particular it adds the following:

- TPM drivers for hardware interface and CRQ interface
- TPM initialization
- TPM logging area and firmware API to transfer it to the OS
  (measurements are visible in sysfs)
- Some measurement code (Static Core Root Of Trust)
- TPM menu (accessible via 't' key during boot if TPM is available)
- Firmware API extensions following Power Firmware Doc
  (to make trusted grub work)

Necessarily, some of its parts are written in Forth, many are written
in 'C'. The extensions are known to work with QEMU for ppc64 running Linux.

Patches 4-6 will eventually need to be merged to avoid compiler warnings
related to unused functions.

Regards,
    Stefan

Stefan Berger (16):
  Add a TPM driver implementation
  Add TPM initialization support
  Add sha1 implementation
  Add initial support for logging
  Extend internal firmware API
  Return value of actual log in sml-get-handover-size
  Perform some initial measurements
  Add support for controlling the states of the TPM
  Add support for a TPM menu to control the state of the TPM
  Implement measurements of the master boot record
  Measure the static core root of trust for measurements
  Add TPM firmware API calls hash-all, log-event, hash-log-extend-event
  Add TPM firmware API call get-maximum-cmd-size
  Add TPM firmware API call pass-through-to-tpm
  Add TPM firmware API call get-state
  Add TPM firmware API call get-failure-reason

 board-js2x/slof/OF.fs               |    2 +
 board-qemu/Makefile                 |    2 +-
 board-qemu/slof/Makefile            |   10 +-
 board-qemu/slof/OF.fs               |    7 +
 board-qemu/slof/tree.fs             |    3 +
 board-qemu/slof/vio-vtpm-cdriver.fs |  144 ++++
 board-qemu/slof/vtpm-sml.fs         |  108 +++
 include/helpers.h                   |    1 +
 lib/Makefile                        |    2 +-
 lib/libtpm/Makefile                 |   51 ++
 lib/libtpm/sha1.c                   |  197 +++++
 lib/libtpm/sha1.h                   |   20 +
 lib/libtpm/tcgbios.c                | 1563 +++++++++++++++++++++++++++++++++++
 lib/libtpm/tcgbios.h                |   53 ++
 lib/libtpm/tcgbios_int.h            |  206 +++++
 lib/libtpm/tpm.code                 |  207 +++++
 lib/libtpm/tpm.in                   |   33 +
 lib/libtpm/tpm_drivers.c            |  456 ++++++++++
 lib/libtpm/tpm_drivers.h            |   93 +++
 slof/fs/packages/disk-label.fs      |    6 +-
 slof/fs/start-up.fs                 |    9 +
 slof/fs/tpm/tpm-static.fs           |  351 ++++++++
 slof/helpers.c                      |    6 +
 23 files changed, 3524 insertions(+), 6 deletions(-)
 create mode 100644 board-qemu/slof/vio-vtpm-cdriver.fs
 create mode 100644 board-qemu/slof/vtpm-sml.fs
 create mode 100644 lib/libtpm/Makefile
 create mode 100644 lib/libtpm/sha1.c
 create mode 100644 lib/libtpm/sha1.h
 create mode 100644 lib/libtpm/tcgbios.c
 create mode 100644 lib/libtpm/tcgbios.h
 create mode 100644 lib/libtpm/tcgbios_int.h
 create mode 100644 lib/libtpm/tpm.code
 create mode 100644 lib/libtpm/tpm.in
 create mode 100644 lib/libtpm/tpm_drivers.c
 create mode 100644 lib/libtpm/tpm_drivers.h
 create mode 100644 slof/fs/tpm/tpm-static.fs

-- 
1.9.3
