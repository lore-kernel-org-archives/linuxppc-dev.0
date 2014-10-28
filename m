Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB6621A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 14:25:39 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 84C3914007F
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 14:25:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 28 Oct 2014 13:25:38 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH v2] CXL: Fix PSL error due to duplicate segment table entries
Date: Tue, 28 Oct 2014 14:25:26 +1100
Message-Id: <1414466730-15591-1-git-send-email-imunsie@au.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 greg <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 imunsie <imunsie@au1.ibm.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In certain circumstances the PSL (Power Service Layer, which provides
translation services for CXL hardware) can send an interrupt for a segment miss
that the kernel has already handled. This can happen if multiple translations
for the same segment are queued in the PSL before the kernel has restarted the
first translation.

The CXL driver does not expect this situation and does not check if a segment
had already been handled. This could cause a duplicate segment table entry
which in turn caused a PSL error taking down the card.

This patch series fixes the issue by checking for existing entries in the
segment table that match the segment it is trying to insert to avoid inserting
duplicate entries.

Some of the code has been refactored to simplify it - the segment table
hash has been moved from cxl_load_segment to find_free_sste where it is
used and we have disabled the secondary hash in the segment table to
reduce the number of entries that need to be tested from 16 to 8. Due to
the large segment sizes we use it is extremely unlikely that the
secondary hash would ever have been used in practice, so this should not
have any negative impacts and may even improve performance.

copro_calculate_slb didn't use the correct ESID mask for 1T vs 256M segments,
which was not a problem as the extra bits were ignored. This series fixes it to
use the correct mask to make debugging easier and so that we can directly
compare the ESID values for duplicates without needing to worry about masking
in the comparison.

- Patch 1 disables the secondary hash in the segment table to simplify the code.

- Patch 2 cleans up and refactors cxl_load_segment and find_free_sste to move
  the hash calculation to where it is actually used.

- Patch 3 fixes the ESID returned by copro_calculate_slb to be properly masked
  based on the segment size.

- Patch 4 prevents duplicate segment table entries from being inserted to fix
  PSL errors resulting from this situation.

Changes since v1:
- Split patch out into separate patches for cleanups and bug fix
