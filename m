Date: Wed, 27 Feb 2002 13:04:37 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202272104.g1RL4bv06375@xdr.com>
To: dan@embeddededge.com
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've traced the problem down to arch/ppc/mm/hashtable.S. When
there is a page fault, the function hash_page gets called. This does
some hashing and writes the hash values into a table located at
0xc0180000. That is the default value, before patching. These writes are
what is corrupting the linux kernel, because they are on top of linux
itself.

In arch/ppc/mm/ppc_mmu.c the function MMU_init_hw is called, but
since the 8260 doesn't have the CPU_FTR_HPTE_TABLE feature, the
hash table is never allocated and the hash_page_patch_* never get updated.

Turning on the CPU_FTR_HPTE_TABLE for the 8260 doesn't fix the problem.

I'm out of my depth here. This is a bug in linux, I know that much. But I
don't know what is supposed to happen during a page fault. So I need help
in resolving this.

Thanks--
Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
