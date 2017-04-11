Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2ZC061P7zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:42:52 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id g2so672995pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:42:52 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, bsingharora@gmail.com, linux-nvdimm@lists.01.org
Subject: ZONE_DEVICE and pmem API support for powerpc
Date: Wed, 12 Apr 2017 03:42:24 +1000
Message-Id: <20170411174233.21902-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This series adds support for ZONE_DEVICE and the pmem api on powerpc. Namely,
support for altmaps and the various bits and pieces required for DAX PMD faults.
The first two patches touch generic mm/ code, but otherwise this is fairly well
contained in arch/powerpc.

If the nvdimm folks could sanity check this series I'd appreciate it.

Series is based on next-20170411, but it should apply elsewhere with minor
fixups to arch_{add|remove}_memory due to conflicts with HMM.  For those
interested in testing this, there is a driver and matching firmware that carves
out some system memory for use as an emulated Con Tutto memory card.

Driver: https://github.com/oohal/linux/tree/contutto-next
Firmware: https://github.com/oohal/skiboot/tree/fake-contutto

Edit core/init.c:686 to control the amount of memory borrowed for the emulated
device.  I'm keeping the driver out of tree for a until 4.13 since I plan on
reworking the firmware interface anyway and There's at least one showstopper
bug.


Thanks,
Oliver
