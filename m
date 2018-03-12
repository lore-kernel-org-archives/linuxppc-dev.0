Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400YRx47b2zF07p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 10:03:09 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2CN2Tsi124730
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:07 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gp0mxveua-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 19:03:06 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 12 Mar 2018 17:03:06 -0600
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [PATCH v2 0/4] Setup RFI flush after PowerVM LPM migration
Date: Mon, 12 Mar 2018 20:02:54 -0300
Message-Id: <1520895778-17586-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset allows for setup_rfi_flush() to be called again
after PowerVM LPM (live partition mobility) aka LPAR migration,
in order to possibly switch to a different flush method.

The patches are mostly from Michael Ellerman, I have rebased to
powerpc/linux.git merge branch as of commit 249d7ba (March 12th),
and added one extra commit to force init of fallback flush area
on pseries.

Testing:
-------

I've disabled most code in the LPM functions migration_store()
and post_mobility_fixup() to just reach pseries_setup_rfi_flush(),
and modified pseries_setup_rfi_flush() a few times to fake the
first and non-first calls to either enable instructions or the
fallback flush method, to cover all 4 possible scenarios.

Case 1) fallback -> fallback

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using fallback displacement flush
    [    0.000000] rfi-flush: patched 8 locations

    # echo > /sys/kernel/mobility/migration 

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using fallback displacement flush
    [    0.000000] rfi-flush: patched 8 locations
    [   20.583029] rfi-flush: Using fallback displacement flush
    [   20.583038] rfi-flush: patched 8 locations

Case 2) instructions -> fallback

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using ori type flush
    [    0.000000] rfi-flush: Using mttrig type flush
    [    0.000000] rfi-flush: patched 8 locations

    # echo > /sys/kernel/mobility/migration 

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using ori type flush
    [    0.000000] rfi-flush: Using mttrig type flush
    [    0.000000] rfi-flush: patched 8 locations
    [   36.023759] rfi-flush: Using fallback displacement flush
    [   36.023764] rfi-flush: patched 8 locations

Case 3) fallback -> instructions

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using fallback displacement flush
    [    0.000000] rfi-flush: patched 8 locations

    # echo > /sys/kernel/mobility/migration 

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using fallback displacement flush
    [    0.000000] rfi-flush: patched 8 locations
    [   23.373037] rfi-flush: Using ori type flush
    [   23.373039] rfi-flush: Using mttrig type flush
    [   23.373044] rfi-flush: patched 8 locations

Case 4) instructions -> instructions

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using ori type flush
    [    0.000000] rfi-flush: Using mttrig type flush
    [    0.000000] rfi-flush: patched 8 locations

    # echo > /sys/kernel/mobility/migration 

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using ori type flush
    [    0.000000] rfi-flush: Using mttrig type flush
    [    0.000000] rfi-flush: patched 8 locations
    [   23.243564] rfi-flush: Using ori type flush
    [   23.243566] rfi-flush: Using mttrig type flush
    [   23.243570] rfi-flush: patched 8 locations


Mauricio Faria de Oliveira (1):
  rfi-flush: Allow pseries to force init of fallback flush area

Michael Ellerman (3):
  rfi-flush: Move the logic to avoid a redo into the debugfs code
  rfi-flush: Make it possible to call setup_rfi_flush() again
  rfi-flush: Call setup_rfi_flush() after LPM migration

 arch/powerpc/include/asm/setup.h          |  2 +-
 arch/powerpc/kernel/setup_64.c            | 22 +++++++++++++++-------
 arch/powerpc/platforms/powernv/setup.c    |  3 ++-
 arch/powerpc/platforms/pseries/mobility.c |  3 +++
 arch/powerpc/platforms/pseries/pseries.h  |  2 ++
 arch/powerpc/platforms/pseries/setup.c    |  6 +++---
 6 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.7.4
