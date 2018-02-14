Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhXj80kDSzDqxS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:34:00 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1ELU0jc067303
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:33:58 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g4ukt37tm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:33:58 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 14:33:57 -0700
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH 0/3] Setup RFI flush after PowerVM LPM migration
Date: Wed, 14 Feb 2018 19:33:38 -0200
Message-Id: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset allows for setup_rfi_flush() to be called again
after PowerVM LPM (live partition mobility) aka LPAR migration.

It's originally written by Michael Ellerman; I just rebased it
on top of powerpc/merge as of 2018-02-14 BRST (commit 3f6f556).

I tested it with a debug patch (sending shortly) to shortcut
the LPM functions migration_store() and post_mobility_fixup()
to just reach pseries_setup_rfi_flush(), and abuse the boot
option 'no_rfi_flush' not to allocate the fallback flush area
at boot (to simulate the migration from patched to unpatched
system).

Testing:
-------

Fallback flush area allocated at boot time:

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using fallback displacement flush
    [    0.000000] rfi-flush: patched 8 locations

    # echo > /sys/kernel/mobility/migration 

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: Using fallback displacement flush
    [    0.000000] rfi-flush: patched 8 locations
    [   51.793238] rfi-flush: Using fallback displacement flush
    [   51.793258] rfi-flush: patched 8 locations

Fallback flush area NOT allocated at boot time:

    # grep -o no_rfi_flush /proc/cmdline
    no_rfi_flush
    
    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: disabled on command line.
    [    0.000000] rfi-flush: re-enabled

    # echo > /sys/kernel/mobility/migration 

    # dmesg | grep rfi-flush
    [    0.000000] rfi-flush: disabled on command line.
    [    0.000000] rfi-flush: re-enabled
    [   31.817921] rfi-flush: Error unable to use fallback displacement flush!
    [   31.817927] rfi-flush: patched 8 locations

Michael Ellerman (3):
  rfi-flush: Move the logic to avoid a redo into the debugfs code
  rfi-flush: Make it possible to call setup_rfi_flush() again
  rfi-flush: Call setup_rfi_flush() after LPM migration

 arch/powerpc/include/asm/setup.h          |  2 +-
 arch/powerpc/kernel/setup_64.c            | 38 +++++++++++++++++++++++--------
 arch/powerpc/platforms/pseries/mobility.c |  3 +++
 arch/powerpc/platforms/pseries/pseries.h  |  2 ++
 arch/powerpc/platforms/pseries/setup.c    |  2 +-
 5 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.7.4
