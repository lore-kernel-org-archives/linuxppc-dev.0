Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxrcG4L6qzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 17:15:26 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u18so1193286pgo.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 00:15:26 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
 npiggin@gmail.com, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 0/5] Revisit MCE handling for UE Errors
Date: Wed, 20 Sep 2017 17:15:07 +1000
Message-Id: <20170920071512.19522-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series is designed to hook up memory_failure on
UE errors, this is specially helpful for user_mode UE errors.

The first two patches cleanup bits, remove dead code.
I could not find any users of get_mce_fault_addr().
The second one improves printing of physical address

The third patch walks kernel/user mode page tables in
real mode to extract the effective address of the instruction
that caused the UE error and the effective address it was
trying to access (for load/store). The fourth patch hooks
up the pfn for instruction UE errors (ierror).

The fifth patch hooks up memory_failure to the MCE patch.

TODO:
Log the address in NVRAM, so that we can recover from
bad pages at boot and keep the blacklist persistent.

Changelog v3:
	- Check for recursive MCE invocations (suggested
	by Nick)
Changelog v2:
	- Remove pr_warn from real mode to a more delayed
	context, where its OK to warn.
	- Add a trivial patch to align prints of physical
	and effective address
Changelog v1:
	- Address review comments from Nick and Mahesh
	(initialization of pfn and more comments on failure
	when addr_to_pfn() or anaylse_instr() fail)
	- Hookup ierrors to the framework as well
	(comments from Mahesh)

Balbir Singh (5):
  powerpc/mce.c: Remove unused function get_mce_fault_addr()
  powerpc/mce: align the print of physical address better
  powerpc/mce: Hookup derror (load/store) UE errors
  powerpc/mce: Hookup ierror (instruction) UE errors
  powerpc/mce: hookup memory_failure for UE errors

 arch/powerpc/include/asm/mce.h  |   4 +-
 arch/powerpc/kernel/mce.c       | 114 ++++++++++++++++++++++++----------------
 arch/powerpc/kernel/mce_power.c | 109 +++++++++++++++++++++++++++++++++++---
 3 files changed, 172 insertions(+), 55 deletions(-)

-- 
2.9.5
