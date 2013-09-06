Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3595D2C00ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 11:00:15 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 21:00:11 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E149DC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:00:09 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r86109WB41156648
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 01:00:09 GMT
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r86109Lo005059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 21:00:09 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] EEH Support for PHB3
Date: Fri,  6 Sep 2013 08:59:59 +0800
Message-Id: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Naturally, EEH has been supported for PHB3, but we had some mask bits
to disable it because the firmware isn't ready. The series of patch
instends to remove those "mask bits" and enable EEH for PHB3. Besides,
the output messages from EEH has been reordered to reflect the correct
steps during EEH recovery. Also, we have dedicated data struct for PHB3
diag-data, which is similiar to the case of P7IOC.

Note: We can't recover fenced PHB3 this moment because the f/w still have
some problems, which I'm tracing down. However, the fix shouldn't affect
the logic we have in Linux side.

In order to force frozen PE, you need issue following command or similiar
one on different PHB#:

echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0003/err_injct_outbound

---

arch/powerpc/include/asm/opal.h              |   65 +++++++++++
arch/powerpc/kernel/eeh.c                    |    6 +-
arch/powerpc/platforms/powernv/eeh-ioda.c    |  153 ++++++++++++++++++++++----
arch/powerpc/platforms/powernv/eeh-powernv.c |    5 +-
arch/powerpc/platforms/powernv/pci.h         |    2 +-
5 files changed, 200 insertions(+), 31 deletions(-)

Thanks,
Gavin
