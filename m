Return-Path: <haren@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C70092C00B4
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 18:44:31 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 7 Dec 2012 00:44:29 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AD8621FF0039
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 00:44:19 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB77iPX6266238
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 00:44:25 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB77kNu5019048
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 00:46:23 -0700
Subject: [PATCH 0/6] powerpc: SMT priority (PPR) save and restore
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 Dec 2012 23:44:23 -0800
Message-ID: <1354866263.1281.10.camel@hbabu-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, 

This patch-set is created against your tree (next branch) and fixed the build failure that you pointed. 

Changes from the previous version:
- Changes for PPR save/restore in denorm_exception_hv, data_access_slb_relon_pSeries and instruction_access_slb_relon_pSeries 
  exception vectors (P8) code.
- Fix build failure with ppc64e_defconfig
- Macro name changes (HMT_MEDIUM_PPR_DISCARD and HMT_MEDIUM_PPR_SAVE) and other fixes as Michael Neuling suggested

[PATCH 0/6] powerpc: SMT priority (PPR) save and restore

On P7/P8 systems, users can define SMT priority levels 2,3 and 4 for
processes so that some can run higher priority than the other ones.
In the current kernel, the default priority is set to 4 which prohibits
processes for using higher priority. Also the kernel boosts the priority to
4 during exceptions without saving the user defined priorities when
the task enters the kernel. So we will be loosing the process PPR value
and can not be restored it back when the task exits the kernel.

This patch-set implements saving and restore the user defined PPR value
for all tasks.

With null_syscall testcase (http://ozlabs.org/~anton/junkcode/null_syscall.c),
this feature takes around extra 10 CPU cycles on average for 25 samples.
 
Haren Myneni (6):
  powerpc: Move branch instruction from ACCOUNT_CPU_USER_ENTRY to caller
  powerpc: Enable PPR save/restore
  powerpc: Increase exceptions arrays in paca struct to save PPR
  powerpc: Define ppr in thread_struct
  powerpc: Macros for saving/restore PPR
  powerpc: Implement PPR save/restore

 arch/powerpc/include/asm/cputable.h      |    7 +++-
 arch/powerpc/include/asm/exception-64s.h |   59 +++++++++++++++++++++++++-----
 arch/powerpc/include/asm/paca.h          |    6 ++--
 arch/powerpc/include/asm/ppc_asm.h       |   27 +++++++++++++-
 arch/powerpc/include/asm/processor.h     |   12 ++++++
 arch/powerpc/include/asm/reg.h           |    1 +
 arch/powerpc/kernel/asm-offsets.c        |    1 +
 arch/powerpc/kernel/entry_64.S           |    6 +++-
 arch/powerpc/kernel/exceptions-64e.S     |    3 +-
 arch/powerpc/kernel/exceptions-64s.S     |   23 +++++++-----
 arch/powerpc/kernel/process.c            |    2 +
 11 files changed, 119 insertions(+), 28 deletions(-)
