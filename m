Message-ID: <3C7D4A56.9000308@embeddededge.com>
Date: Wed, 27 Feb 2002 16:06:30 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
References: <200202272104.g1RL4bv06375@xdr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Ashley wrote:

> I've traced the problem down to arch/ppc/mm/hashtable.S. When
> there is a page fault, the function hash_page gets called.

In the case of a 603 core, hash_page is called for DSI (Data Access)
faults.  However, if the feature indicates there is no HPTE, the
hash_page function is patched to simply return.  You can't look at
the code in hashtable.S and know how it is going to work for a particular
implementation because it is patched at initialization to change
it's behavior.

> .....This does
> some hashing and writes the hash values into a table located at
> 0xc0180000.

When your kernel boots, does it print a message to indicate it has allocated
a hash table?

> In arch/ppc/mm/ppc_mmu.c the function MMU_init_hw is called, but
> since the 8260 doesn't have the CPU_FTR_HPTE_TABLE feature, the
> hash table is never allocated and the hash_page_patch_* never get updated.


Oh, I just looked at a variety of different versions back to 2.4.11, and it
is patched just as I described above.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
