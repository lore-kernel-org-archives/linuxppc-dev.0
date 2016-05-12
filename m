Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r52Cn2qKdzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:51:01 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 12 May 2016 15:51:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 87F3C2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:50:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C5nlk862783706
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:50:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C5meUh012733
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:48:41 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 0/2] powerpc/powernv/npu: Fixes for next tree
Date: Thu, 12 May 2016 15:47:08 +1000
Message-Id: <1463032030-38974-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
"next" branch sha1 e682e4c needs 3 fixes to get NVLink passthrough
working (in fact 4 but the last one is goind via VFIO tree),
two of them are in this patchset; also:

35a3a27 "powerpc/powernv: Exclude root bus in pnv_pci_reset_secondary_bus()"
needs to be reverted (otherwise it produces EEH during GPU FLR reset, i.e.
each time when the guest starts and stops).


Please comment. Thanks.


Alexey Kardashevskiy (2):
  powerpc/powernv: Fix insufficient memory allocation
  powerpc/powernv/npu: Add PE to PHB's list

 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.5.0.rc3
