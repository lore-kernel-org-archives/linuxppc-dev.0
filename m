Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0A1D2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 21:42:55 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 21 Aug 2012 21:41:55 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7LBY2ZZ10944726
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 21:34:02 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7LBggBs003239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 21:42:43 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v2 0/2][powerpc] Export memory_limit via device tree 
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 21 Aug 2012 17:12:16 +0530
Message-ID: <20120821113815.29282.4000.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: mahesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series exports the linux memory_limit set by
the mem= parameter via device-tree, so that kexec-tools
can limit the crash regions to the actual memory used by
the kernel.

Change since V1:

 * Added a patch to change the type of memory_limit to a
   fixed size(unsigned long long) from 'phys_addr_t' (which
   is 32bit on some ppc32 and 64 bit on ppc64 and some ppc32)

 * Rebased the patch to use recently fixed prom_update_property()
   which would add the property if it didn't exist.

---

Suzuki K. Poulose (2):
      [powerpc] Change memory_limit from phys_addr_t to unsigned long long
      [powerpc] Export memory limit via device tree


 arch/powerpc/include/asm/setup.h    |    2 +-
 arch/powerpc/kernel/fadump.c        |    3 +--
 arch/powerpc/kernel/machine_kexec.c |   14 +++++++++++++-
 arch/powerpc/kernel/prom.c          |    2 +-
 arch/powerpc/mm/mem.c               |    2 +-
 5 files changed, 17 insertions(+), 6 deletions(-)

-- 
Suzuki
