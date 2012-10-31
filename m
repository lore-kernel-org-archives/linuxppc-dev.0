Return-Path: <haren@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 55C0F2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 17:49:40 +1100 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 02:49:36 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7D058C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 02:49:34 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9V6nYrC65798162
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 02:49:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9V6nX37030185
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 04:49:34 -0200
Subject: [PATCH 0/6] powerpc: SMT priority (PPR) save and restore
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Oct 2012 23:49:31 -0700
Message-ID: <1351666171.32304.10.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 0/6] powerpc: SMT priority (PPR) save and restore

On P7 systems, users can define SMT priority levels 2,3 and 4 for
processes so that some can run higher priority than the other ones.
In the current kernel, the default priority is set to 4 which prohibits
processes for using higher priority. Also the kernel boosts the priority to
4 during exceptions without saving the user defined priorities when
the task enters the kernel. So we will be loosing the process PPR value
and can not be restored it back when the task exits the kernel.

This patchset implements saving and restore the user defined PPR value
for all tasks.

With null_syscall testcase (http://ozlabs.org/~anton/junkcode/null_syscall.c),
this feature takes around extra 10 CPU cycles on average for 25 samples. 

Haren Myneni (6):
  powerpc: Move branch instruction from ACCOUNT_CPU_USER_ENTRY to caller
  powerpc: Define CPU_FTR_HAS_PPR
  powerpc: Increase exceptions arrays in paca struct to save PPR
  powerpc: Define ppr in thread_struct
  powerpc: Macros for saving/restore PPR
  powerpc: Implement PPR save/restore

 arch/powerpc/include/asm/cputable.h      |    6 ++-
 arch/powerpc/include/asm/exception-64s.h |   45 ++++++++++++++++++++++++++----
 arch/powerpc/include/asm/paca.h          |    6 ++--
 arch/powerpc/include/asm/ppc_asm.h       |   27 ++++++++++++++++-
 arch/powerpc/include/asm/processor.h     |    6 ++++
 arch/powerpc/include/asm/reg.h           |    1 +
 arch/powerpc/kernel/asm-offsets.c        |    1 +
 arch/powerpc/kernel/entry_64.S           |    6 +++-
 arch/powerpc/kernel/exceptions-64e.S     |    3 +-
 arch/powerpc/kernel/exceptions-64s.S     |   15 +++++----
 arch/powerpc/kernel/process.c            |    2 +
 11 files changed, 96 insertions(+), 22 deletions(-)
