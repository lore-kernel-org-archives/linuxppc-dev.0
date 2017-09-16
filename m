Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvDxm34L7zDrbr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 11:21:31 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id f24so2499623qte.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 18:21:31 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org
Cc: arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 0/6] mm, x86, powerpc: Memory Protection Keys enhancement
Date: Fri, 15 Sep 2017 18:21:04 -0700
Message-Id: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch-series enhances memory protection keys feature.

The patch(1)  introduces  an  additional  vma bit to support 32
pkeys.  PowerPC supports 32 pkeys.

The patch(2,3)  introduces a new interface arch_pkeys_enabled(),
this  interface  can   be used by arch-neutral code to display
protection key value in smap.

The patch(4) introduces a syfs interface, to display the static
attributes  of the protection key. Eg: max number of keys.

The last two patches, (5,6) update documentation.

A separate patch series that enhances selftest will follow. The
entire  patch  series  that  enables  pkeys  on  powerpc  is at 
https://github.com/rampai/memorykeys.git memkey.v9-rc1

Testing:
-------
This  patches are tested on powerpc platform using a
enhaced set of selftests.
Could not test on x86 since I do not have access to
one with pkey support.

History:
-------
version v3:
	(1) sysfs interface - thanks Thiago.
	(2) Documentation update.

version v2:
	(1) Documentation   is   updated   to  better 
		capture the semantics.
	(2) introduced   arch_pkeys_enabled() to find
       		if an arch enables pkeys.  Correspond-
		ing change in logic that displays key
		value in smaps.
	(3) code  rearranged  in many places based on
       		comments from   Dave Hansen,   Balbir,
	       	Anshuman.	
version v1: Initial version

Ram Pai (5):
  mm: introduce an additional vma bit for powerpc pkey
  mm, x86 : introduce arch_pkeys_enabled()
  mm: display pkey in smaps if arch_pkeys_enabled() is true
  Documentation/x86: Move protecton key documentation to arch neutral
    directory
  Documentation/vm: PowerPC specific updates to memory protection keys

Thiago Jung Bauermann (1):
  mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys: Add sysfs interface

 Documentation/vm/protection-keys.txt  |  160 +++++++++++++++++++++++++++++++++
 Documentation/x86/protection-keys.txt |   85 -----------------
 arch/powerpc/include/asm/pkeys.h      |    2 +
 arch/powerpc/mm/pkeys.c               |   20 ++++
 arch/x86/include/asm/mmu_context.h    |    4 +-
 arch/x86/include/asm/pkeys.h          |    2 +
 arch/x86/kernel/fpu/xstate.c          |    5 +
 arch/x86/kernel/setup.c               |    8 --
 arch/x86/mm/pkeys.c                   |    8 ++
 fs/proc/task_mmu.c                    |   17 ++--
 include/linux/mm.h                    |   16 ++--
 include/linux/pkeys.h                 |    9 ++
 mm/mprotect.c                         |   88 ++++++++++++++++++
 13 files changed, 317 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/vm/protection-keys.txt
 delete mode 100644 Documentation/x86/protection-keys.txt
