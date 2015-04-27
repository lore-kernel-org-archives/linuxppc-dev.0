Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B85511A0245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 18:03:34 +1000 (AEST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 89893140328
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 18:03:33 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7D0822BB004D
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:28 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R83KEm47775932
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:03:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R82s9i005409
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:02:54 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, thuth@redhat.com
Subject: [PATCH v2 0/4] PCI: Generic fixes and moving enumeration back to QEMU
Date: Mon, 27 Apr 2015 13:32:29 +0530
Message-Id: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

patch 1:   Fixes a bug in pci-to-pci bridge while programming the limit 
           registers during probe
patch 2,3: Support 64-bit address translation and usb devices can have
      	   64-bit pci memory BARs
patch 4:   Use QEMU create device tree nodes and program the BARs


Nikunj A Dadhania (4):
  pci: program correct bridge limit registers during probe
  pci: Support 64-bit address translation
  usb: support 64-bit pci bars
  pci: Use QEMU created PCI device nodes

 board-qemu/slof/pci-phb.fs      | 44 ++++++++++++++++++++++++++++++++++++++++-
 slof/fs/devices/pci-class_0c.fs | 10 ++++++++--
 slof/fs/pci-properties.fs       |  6 +++++-
 slof/fs/pci-scan.fs             |  6 +++---
 slof/fs/translate.fs            |  6 ++----
 5 files changed, 61 insertions(+), 11 deletions(-)

-- 
1.8.3.1
