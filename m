Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EB0A1A0764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 11:40:45 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1CD7E1400DD
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Mar 2015 10:40:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 86EEE357804C
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:41 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2O0eXH246661716
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:41 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2O0e7Df007405
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:40:07 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 0/3] powerpc/powernv: Unified PCI slot reset
Date: Tue, 24 Mar 2015 11:39:39 +1100
Message-Id: <1427157582-11196-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patches intend to utilize the PCI slot reset capability exposed from
the skiboot firmware, which requires corresponding changes as follows:

Changelog
=========
v2 -> v3
   * Rebased to Richard's SRIOV patchset.
   * Removed hotplug part, which needs rework.
v1 -> v2
   * Keep opal_pci_reinit(). In case the slot is resetted by kernel,
     instead of skiboot, this API should be called to restore states
     for those affected devices.
   * Reworked slot ID scheme so that old/new kernel can work with
     skiboot with or without unified PCI slot management support.
   * Code cleanup here and there.
   * Separate powernv-php driver to support PCI hotplug for
     PowerNV platform.
   * Check if the OPAL API supported by firmware before calling
     into it, which is necessary for back-compability.
   * Separate patch for factoring pnv_pci_poll().


Gavin Shan (3):
  powerpc/powernv: Use PCI slot reset infrastructure
  powerpc/powernv: Fundamental reset for PCI bus reset
  powerpc/pci: Don't scan empty slot

 arch/powerpc/include/asm/eeh.h               |   1 +
 arch/powerpc/include/asm/opal.h              |   4 +-
 arch/powerpc/kernel/pci-hotplug.c            |   3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 235 ++++++++++++++-------------
 4 files changed, 127 insertions(+), 116 deletions(-)

-- 
1.8.3.2
