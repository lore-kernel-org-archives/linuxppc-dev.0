Date: Wed, 27 Feb 2002 13:36:03 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202272136.g1RLa3m06440@xdr.com>
To: dan@embeddededge.com
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Let's agree on one thing: This isn't my theory of what is
happening. This *is* what is happening. I can single step the cpu with
the BDI2000 and see the writes taking place.

So when you say hash_page simply returns, well it isn't that way in
actuality. Where is it supposed to be patched? What isn't working correctly
to have hash_page just return? How can I fix this?

There is no message about allocating the hashtable.

-Dave


>David Ashley wrote:
>
>> I've traced the problem down to arch/ppc/mm/hashtable.S. When
>> there is a page fault, the function hash_page gets called.
>
>In the case of a 603 core, hash_page is called for DSI (Data Access)
>faults.  However, if the feature indicates there is no HPTE, the
>hash_page function is patched to simply return.  You can't look at
>the code in hashtable.S and know how it is going to work for a particular
>implementation because it is patched at initialization to change
>it's behavior.
>
>> .....This does
>> some hashing and writes the hash values into a table located at
>> 0xc0180000.
>
>When your kernel boots, does it print a message to indicate it has allocated
>a hash table?
>
>> In arch/ppc/mm/ppc_mmu.c the function MMU_init_hw is called, but
>> since the 8260 doesn't have the CPU_FTR_HPTE_TABLE feature, the
>> hash table is never allocated and the hash_page_patch_* never get updated.
>
>
>Oh, I just looked at a variety of different versions back to 2.4.11, and it
>is patched just as I described above.
>
>
>        -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
