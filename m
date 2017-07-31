Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x232.google.com (mail-qt0-x232.google.com
 [IPv6:2607:f8b0:400d:c0d::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKdz4dsnzDr9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:12:39 +1000 (AEST)
Received: by mail-qt0-x232.google.com with SMTP id t37so104573330qtg.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:12:39 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 00/25] powerpc: Memory Protection Keys
Date: Sun, 30 Jul 2017 17:12:01 -0700
Message-Id: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory protection keys enable applications to protect its
address  space from inadvertent access from or corruption
by itself.

The overall idea:
-----------------
 A process allocates a   key  and associates it with
 an  address  range  within    its   address   space.
 The process  then  can  dynamically  set read/write 
 permissions on  the   key   without  involving  the 
 kernel. Any  code that  violates   the  permissions
 of  the address space; as defined by its associated
 key, will receive a segmentation fault.

This  patch series enables the feature on PPC64 HPTE
platform.

ISA3.0   section  5.7.13   describes  the  detailed
specifications.


Highlevel view of the design:
---------------------------
When  an  application associates a key with a address
address  range,  program  the key in    the Linux PTE.
When the MMU   detects  a page fault, allocate a hash
page  and   program  the  key into HPTE.  And finally
when the  MMU    detects  a  key  violation;  due  to
invalid    application  access, invoke the registered
signal   handler and provide the violated  key number
as   well  as the state of the key register (AMR), at
the time it faulted.


Testing:
-------
This  patch  series has passed all the protection key
tests   available    in   the selftests directory.The
tests are updated  to    work on both x86 and powerpc.
NOTE: All the selftest related patches will be   part
of  a separate patch series.


Outstanding issues:
-------------------
How will the application know if pkey is  enabled, if
so   how   many     pkeys     are       available? Is
PKEY_DISABLE_EXECUTE supported?  - Ben.


History:
-------
version v7:
	(1) refers to device tree property to enable
		protection keys.
	(2) adds 4K PTE support.
	(3) fixes a couple of bugs noticed by Thiago
	(4) decouples this patch series from   arch-
	    independent code. This patch series can
	    now stand by itself, with one kludge
	    patch(2).

version v6:
	(1) selftest changes  are broken down into 20
		incremental patches.
	(2) A  separate   key  allocation  mask  that
       		includes    PKEY_DISABLE_EXECUTE   is 
		added for powerpc
	(3) pkey feature  is enabled for 64K HPT case
		only.  RPT and 4k HPT is disabled.
	(4) Documentation   is   updated   to  better 
		capture the semantics.
	(5) introduced   arch_pkeys_enabled() to find
       		if an arch enables pkeys.  Correspond-
		ing change the  logic   that displays
		key value in smaps.
	(6) code  rearranged  in many places based on
       		comments from   Dave Hansen,   Balbir,
	       	Anshuman.	
	(7) fixed  one bug where a bogus key could be
		associated     successfully        in
		pkey_mprotect().

version v5:
	(1) reverted back to the old  design -- store
	    the key in the pte,  instead of bypassing
	    it.  The v4  design  slowed down the hash
	    page path.
	(2) detects key violation when kernel is told
       		to access user pages.
	(3) further  refined the patches into smaller
       		consumable units
	(4) page faults   handlers captures the fault-
		ing key 
	    from the pte   instead of   the vma. This
	    closes  a  race  between  where  the  key 
	    update in the  vma and a key fault caused
	    by the key programmed in the pte.
	(5) a key created   with access-denied should
	    also set it up to deny write. Fixed it.
	(6) protection-key   number   is displayed in
       		smaps the x86 way.

version v4:
	(1) patches no more depend on the pte bits
       		to program the hpte
			-- comment by Balbir
	(2) documentation updates
	(3) fixed a bug in the selftest.
	(4) unlike x86, powerpc   lets signal handler
		change   key   permission   bits; the
	       	change   will   persist across signal
	       	handler   boundaries.   Earlier    we
	       	allowed   the   signal   handler   to
	       	modify   a   field   in   the siginfo
		structure   which would  than be used
       		by  the  kernel  to  program  the key
		protection register (AMR)
       		  -- resolves a issue raised by Ben.
    		"Calls  to  sys_swapcontext  with   a
		made-up  context  will  end up with a
		crap  AMR  if done by code who didn't
	       	know about that register".
	(5) these  changes  enable protection keys on
       		4k-page kernel aswell.

version v3:
	(1) split the patches into smaller consumable
		patches.
	(2) added  the  ability  to  disable  execute
       		permission  on  a  key  at   creation.
	(3) rename    calc_pte_to_hpte_pkey_bits() to
	    pte_to_hpte_pkey_bits()
		-- suggested by Anshuman
	(4) some   code   optimization and clarity in
		do_page_fault()  
	(5) A bug fix while  invalidating a hpte slot
		in __hash_page_4K()
       		-- noticed by Aneesh
	

version v2:
	(1) documentation and selftest added.
 	(2) fixed a  bug  in 4k  hpte  backed 64k pte
       		where  page    invalidation   was not
		done  correctly,  and  initialization
	       	of    second-part-of-the-pte  was not
		done    correctly  if the pte was not
	       	yet Hashed with a hpte.
	       	   --	Reported by Aneesh.
	(3) Fixed  ABI  breakage  caused in siginfo
       		structure.
		-- Reported by Anshuman.
	

version v1: Initial version


Ram Pai (25):
  powerpc: define an additional vma bit for protection keys.
  powerpc: track allocation status of all pkeys
  powerpc: helper function to read,write AMR,IAMR,UAMOR registers
  powerpc: helper functions to initialize AMR, IAMR and UAMOR registers
  powerpc: cleaup AMR,iAMR when a key is allocated or freed
  powerpc: implementation for arch_set_user_pkey_access()
  powerpc: sys_pkey_alloc() and sys_pkey_free() system calls
  powerpc: ability to create execute-disabled pkeys
  powerpc: store and restore the pkey state across context switches
  powerpc: introduce execute-only pkey
  powerpc: ability to associate pkey to a vma
  powerpc: implementation for arch_override_mprotect_pkey()
  powerpc: map vma key-protection bits to pte key bits.
  powerpc: sys_pkey_mprotect() system call
  powerpc: Program HPTE key protection bits
  powerpc: helper to validate key-access permissions of a pte
  powerpc: check key protection for user page access
  powerpc: Macro the mask used for checking DSI exception
  powerpc: implementation for arch_vma_access_permitted()
  powerpc: Handle exceptions caused by pkey violation
  powerpc: capture AMR register content on pkey violation
  powerpc: introduce get_pte_pkey() helper
  powerpc: capture the violated protection key on fault
  powerpc: Deliver SEGV signal on pkey violation
  powerpc: Enable pkey subsystem

 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   10 +
 arch/powerpc/include/asm/book3s/64/mmu.h      |   10 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   69 +++++++-
 arch/powerpc/include/asm/cputable.h           |    8 +-
 arch/powerpc/include/asm/mman.h               |   16 ++-
 arch/powerpc/include/asm/mmu_context.h        |   18 ++-
 arch/powerpc/include/asm/paca.h               |    4 +
 arch/powerpc/include/asm/pkeys.h              |  255 ++++++++++++++++++++++++-
 arch/powerpc/include/asm/processor.h          |    5 +
 arch/powerpc/include/asm/reg.h                |    8 +-
 arch/powerpc/include/asm/systbl.h             |    3 +
 arch/powerpc/include/asm/unistd.h             |    6 +-
 arch/powerpc/include/uapi/asm/ptrace.h        |    1 +
 arch/powerpc/include/uapi/asm/unistd.h        |    3 +
 arch/powerpc/kernel/asm-offsets.c             |    6 +
 arch/powerpc/kernel/exceptions-64s.S          |    2 +-
 arch/powerpc/kernel/process.c                 |   25 +++
 arch/powerpc/kernel/prom.c                    |   19 ++
 arch/powerpc/kernel/signal_32.c               |    5 +
 arch/powerpc/kernel/signal_64.c               |    4 +
 arch/powerpc/kernel/traps.c                   |   15 ++
 arch/powerpc/mm/fault.c                       |   31 +++
 arch/powerpc/mm/hash_utils_64.c               |   26 +++
 arch/powerpc/mm/mmu_context_book3s64.c        |    2 +
 arch/powerpc/mm/pkeys.c                       |  256 +++++++++++++++++++++++++
 25 files changed, 787 insertions(+), 20 deletions(-)
