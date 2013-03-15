Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 59FC22C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:26:41 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 01:26:38 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0788F1FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:21:40 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2F7QY4V380258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:26:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2F7QXMg014853
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:26:34 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] VFIO change for EEH support
Date: Fri, 15 Mar 2013 15:26:27 +0800
Message-Id: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH (Enhanced Error Handling) is one of RAS features on IBM Power
machines. In order to support EEH, the VFIO needs some modification
as the patchset addresses. Firstly, the address (domain:bus:slot:function)
of passed PCI devices looks quite different from host and guest perspectives.
So we have to mantain the address mapping in host so that the EEH could
direct the EEH errors from guest to proper PCI device. Unfortunately, it
seems that the VFIO implementation doesn't include the mechanism yet. On
the other hand, it's totally business of individual platforms. So I introduced
some weak functions in VFIO driver and individual platforms can override
that to figure out more information that platform needs. Apart from that,
the last patch [3/3] is changing the current behavior of accessing uncoverred
config space for specific PCI device.

The patchset is expected to be applied after Alexy's patchset (supporting
VFIO on PowerNV platform). Besides, there're patchset based on it queued
in my personal tree for EEH core to support PowerKVM guest. With all of
them (Alexy's patchset, this patchset, EEH core patchset), I can sucessfully
pass PCI device to guest and recover it from EEH errors.

drivers/vfio/pci/vfio_pci.c        |   42 ++++++++++++++++++++++++++++++------
drivers/vfio/pci/vfio_pci_config.c |   31 +++++++++++++++++---------
include/linux/vfio.h               |    7 +++++-
include/uapi/linux/vfio.h          |   16 +++++++++++++
4 files changed, 77 insertions(+), 19 deletions(-)

Thanks,
Gavin
