Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3QT0n7dzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:52:01 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS3QS3CcBz9s8G
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:52:00 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1nFUM103966
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:51:58 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28r4dtgw38-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:51:57 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 07:21:54 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5FC59125804F
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:21:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1pqWa41549994
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:21:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1po8e026077
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:21:51 +0530
Subject: [RFC PATCH 0/7] Machine check handling for Power9 with bacward
 compatibility.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 21 Feb 2017 07:21:50 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This RFC patch series adds machine check handling for Power9. Starting from
power9 linux will depend on OPAL to handle chip specific processing for
extracting MCE error reason. This will allow linux to not worry about
chip/CPU specific bit encoding to find out MCE reason. Linux will make
OPAL call during MCE interrupt to let OPAL extract the reason and provide
a high level machine check event that should help linux to decide further
actions to take.

OPAL machine check handler will be supported on Power9 and above. Linux will
populated ppc_md.machine_check_early() function pointer if opal supports
OPAL_HANDLE_MACHINE_CHECK token. But if opal mce handler does not support
processing/extracting MCE reason for current chip, then it will return
OPAL_UNSUPPORTED. e.g. new OPAL FW installed on system with Power8 or below.
In this case (i.e on Power8 system it will fallback to in-kernel MCE handler
as it does today).

I have done all my testing in Mambo only. There are few TODOs that I am
working on and will make those changes in v2. This early version is to get
comments about this approach to support backward compatibility for Machine
check handler starting from Power9.

Comments are welcome.


---

Mahesh Salgaonkar (7):
      powerpc/book3s: Move machine check event structure to opal-api.h
      powerpc/book3s: mce: Call opal mce handler to extract MCE error reason.
      powerpc/book3s: mce: Process the MCE event and recover if possible.
      powerpc/book3s: Print additional MCE errors introduced in power9.
      powerpc/book3s: Don't turn on the MSR[ME] bit until opal processes the reason.
      powerpc/book3s: Display more info for MCE error console log.
      powerpc/book3s: Display task info for MCE error in user mode.


 arch/powerpc/include/asm/machdep.h             |    2 
 arch/powerpc/include/asm/mce.h                 |  114 +--------------
 arch/powerpc/include/asm/opal-api.h            |  179 ++++++++++++++++++++++++
 arch/powerpc/include/asm/opal.h                |    3 
 arch/powerpc/kernel/exceptions-64s.S           |   12 +-
 arch/powerpc/kernel/mce.c                      |  122 +++++++++++++++-
 arch/powerpc/kernel/mce_power.c                |   38 +++++
 arch/powerpc/kernel/traps.c                    |   15 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 arch/powerpc/platforms/powernv/opal.c          |   24 +++
 arch/powerpc/platforms/powernv/setup.c         |    4 +
 11 files changed, 387 insertions(+), 127 deletions(-)

--
Mahesh Salgaonkar
