Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCSGH0SSgzDrCn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 05:46:46 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6JJhonH002155
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 15:46:44 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2btdkw8k1a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 15:46:44 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 16:46:42 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6JJkeFt18415664
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:46:40 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6JJkgmp025837
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:46:42 -0300
Date: Wed, 19 Jul 2017 16:46:34 -0300
From: joserz@linux.vnet.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oohall@gmail.com
Subject: KVM guests freeze under upstream kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <20170719194634.GA1222@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

We're not able to boot any KVM guest using upstream kernel (cb8c65ccff7f77d0285f1b126c72d37b2572c865 - 4.13.0-rc1+).
After reaching the SLOF initial counting, the guest simply freezes:

SLOF
**********************************************************************
QEMU Starting
 Build Date = Mar  3 2017 13:29:19
  FW Version = git-66d250ef0fd06bb8
   Press "s" to enter Open Firmware.

   C0360

After bisecting I found the commit:

https://github.com/torvalds/linux/commit/ebd3119

    powerpc/mm: Add devmap support for ppc64

    Add support for the devmap bit on PTEs and PMDs for PPC64 Book3S.  This
    is used to differentiate device backed memory from transparent huge
    pages since they are handled in more or less the same manner by the core
    mm code.

Reverting the commit and rebuilding 4.13.0-rc1+ was enough to make a workaround.
But I'll need some help from you guys in order to solve it.

Thanks!

Jose Ziviani
