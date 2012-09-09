Return-Path: <haren@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 34DF12C0096
 for <linuxppc-dev@ozlabs.org>; Sun,  9 Sep 2012 21:32:13 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sun, 9 Sep 2012 07:32:11 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8AC4238C8039
 for <linuxppc-dev@ozlabs.org>; Sun,  9 Sep 2012 07:32:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q89BW8HF34472008
 for <linuxppc-dev@ozlabs.org>; Sun, 9 Sep 2012 07:32:08 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q89BW7LQ002829
 for <linuxppc-dev@ozlabs.org>; Sun, 9 Sep 2012 08:32:07 -0300
Subject: [PATCH 0/6] powerpc: SMT priority (PPR) save and restore
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Sep 2012 04:32:06 -0700
Message-ID: <1347190326.3418.7.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On P7 systems, users can define SMT priority levels 2,3 and 4 for
processes so that some can run higher priority than the other ones.
In the current kernel, the default priority is set to 4 which prohibits
processes for using higher priority. Also the kernel boosts the priority to
4 during exceptions without saving the user defined priorities when
the task enters the kernel. So we will be loosing the process PPR value
and can not be restored it back when the task exits the kernel.

This patch set implements saving and restore the user defined PPR value
for all tasks.

Haren Myneni (6):
  powerpc: Move branch instruction from ACCOUNT_CPU_USER_ENTRY to caller
  powerpc: Add enable_ppr kernel parameter to enable PPR save/restore
  powerpc: Add ppr in thread_info struct
  powerpc: Increase exceptions arrays in paca struct to save PPR
  powerpc: Macros for saving/restore PPR
  powerpc: Implement PPR save/restore

 Documentation/kernel-parameters.txt      |    4 +++
 arch/powerpc/include/asm/cputable.h      |    6 ++--
 arch/powerpc/include/asm/exception-64s.h |   51 ++++++++++++++++++++++++++----
 arch/powerpc/include/asm/paca.h          |    6 ++--
 arch/powerpc/include/asm/ppc_asm.h       |    2 --
 arch/powerpc/include/asm/reg.h           |    1 +
 arch/powerpc/include/asm/thread_info.h   |   11 +++++++
 arch/powerpc/kernel/asm-offsets.c        |    1 +
 arch/powerpc/kernel/entry_64.S           |    7 +++-
 arch/powerpc/kernel/exceptions-64s.S     |   18 ++++++-----
 arch/powerpc/kernel/setup_64.c           |   14 ++++++++
 11 files changed, 99 insertions(+), 22 deletions(-)

-- 
1.7.10.4
