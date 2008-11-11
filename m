Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 3E64FDDF29
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 01:55:01 +1100 (EST)
In-Reply-To: <49186028.8010505@emcraft.com>
References: <d02415a31b89736f070f290be89013d4@bga.com>
	<49186028.8010505@emcraft.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f6812adbe26a68b0545f5fd25b6d9d6a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [2/2] powerpc: support for 256K pages on PPC 44x
Date: Tue, 11 Nov 2008 08:59:24 -0600
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Vladimir Panfilov <pvr@emcraft.com>,
	Wolfgang Denk <wd@denx.de>, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry for the slow reply, but my shell account is broken and I had to 
post from home.

On Nov 10, 2008, at 10:24 AM, Ilya Yanok wrote:
>>> This patch adds support for 256K pages on PPC 44x along with
>>> some hacks needed for this.
>>
>> This description is insufficient, it describes neither the hacks nor
>> why they are required.
>
> Ok. Actually there is only one hack -- increasing kernel stack size. We
> do this because with 256K pages we get division by zero in 
> kernel/fork.c:
>
>         /*
>          * The default maximum number of threads is set to a safe
>          * value: the thread structures can take up at most half
>          * of memory.
>          */
>         max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
>
> so setting THREAD_SIZE to bigger value we can avoid this. I don't think
> it's very clean solution but at least we stay powerpc-specific.

And why is keeping a line of code intact, which doesn't even match its 
comment, by creating a hack workaround that increases memory 
consumption, that is triggered by enabling an option that already 
increases memory pressure, just to stay architecture specific anything 
like sanity?

No.  Submit a patch to address the division by zero instead.

Btw, I did some research for you (all are from torvalds/old-2.6-bkcvs,
and the last patch has been edited for relevance along with one of
the descriptions):


v2.6.10-rc2-g63f96a6
commit 63f96a6d9c1a54875f3bd07a6337993bc5180ecb
Author: torvalds <torvalds>
Commit: torvalds <torvalds>

    Merge bk://linux-mtd.bkbits.net/mtd-bugsonly-2.6
    into ppc970.osdl.org:/home/torvalds/v2.6/linux
       2004/11/16 17:29:15-08:00 dhowells
    [PATCH] Fork fix fix
       The attached patch fixes the fork fix to avoid the divide-by-zero 
error I'd
    previously fixed, but without using any sort of conditional.
       Signed-off-by: David Howells <dhowells@redhat.com>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
    ...
       BKrev: 419aaa45h5IsCw4CAYMVTOWK9oVaBA

diff --git a/kernel/fork.c b/kernel/fork.c
index f5fba87..f157ad6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -118,10 +118,7 @@ void __init fork_init(unsigned long mempages)
	 * value: the thread structures can take up at most half
	 * of memory.
	 */
-	if (THREAD_SIZE >= PAGE_SIZE)
-		max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
-	else
-		max_threads = mempages / 8;
+	max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
	/*
	 * we need to allow at least 20 threads to boot a system

v2.6.10-rc1-g368b064
commit 368b06415c11e286f6ab3fe7c52bdd5b9b6f3008
Author: dhowells <dhowells>
Commit: dhowells <dhowells>

    [PATCH] fix page size assumption in fork()
       The attached patch fixes fork to get rid of the assumption that 
THREAD_SIZE
    >= PAGE_SIZE (on the FR-V the smallest available page size is 16KB).
       Signed-Off-By: David Howells <dhowells@redhat.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
       BKrev: 4193db17ZJRaaVNEGezHMBUmByER4A

diff --git a/kernel/fork.c b/kernel/fork.c
index eb689d9..f5fba87 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -118,7 +118,11 @@ void __init fork_init(unsigned long mempages)
	 * value: the thread structures can take up at most half
	 * of memory.
	 */
-	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
+	if (THREAD_SIZE >= PAGE_SIZE)
+		max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
+	else
+		max_threads = mempages / 8;
+
	/*
	 * we need to allow at least 20 threads to boot a system
	 */

v2.4.0-g4214e42
commit 4214e42f96d4051cb77b1b7c2b041715db84ffd9
Author: torvalds <torvalds>
Commit: torvalds <torvalds>

    v2.4.9.11 -> v2.4.9.12
         - Alan Cox: much more merging
      - Pete Zaitcev: ymfpci race fixes
      - Andrea Arkangeli: VM race fix and OOM tweak.
      - Arjan Van de Ven: merge RH kernel fixes
      - Andi Kleen: use more readable 'likely()/unlikely()' instead of 
__builtin_expect()
      - Keith Owens: fix 64-bit ELF types
      - Gerd Knorr: mark more broken PCI bridges, update btaudio driver
      - Paul Mackerras: powermac driver update
      - me: clean up PTRACE_DETACH to use common infrastructure
       BKrev: 3c603e338Tv2BTX9tkeBFGWLdI-r4Q

diff --git a/kernel/fork.c b/kernel/fork.c
index 9179e23..91aeda9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -72,7 +72,7 @@ void __init fork_init(unsigned long mempages)
	 * value: the thread structures can take up at most half
	 * of memory.
	 */
-	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 16;
+	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;

v2.4.0-gcaeb6d6
commit caeb6d68179ecd9dfeac8fa17daa7150163fa318
Author: torvalds <torvalds>
Commit: torvalds <torvalds>

    v2.4.9.10 -> v2.4.9.11
         - Neil Brown: md cleanups/fixes
      - Andrew Morton: console locking merge
      - Andrea Arkangeli: major VM merge
       BKrev: 3c603e2fnBNvsVsBbJrGD3fFs4xTFg

diff --git a/kernel/fork.c b/kernel/fork.c
index ebfbf2b..9179e23 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -72,7 +72,7 @@ void __init fork_init(unsigned long mempages)
	 * value: the thread structures can take up at most half
	 * of memory.
	 */
-	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 2;
+	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 16;
	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;


So the comment has been wrong since 2.4.9.11, and has been changed 
several times since then.   It can be changed.  And if you fix the 
comment you might even get bonus points.   Thinking about it though, 
the minimum divide should be at least 2 (a partial page for a stack and 
a page for a flat or omagic binary).


>>>
>>>  #ifdef CONFIG_PTE_64BIT
>>>  typedef unsigned long long pte_basic_t;
>>> +#ifdef CONFIG_PPC_256K_PAGES
>>> +#define PTE_SHIFT       (PAGE_SHIFT - 7)
>>
>> This seems to be missing the comment on how many ptes are actually in
>> the page that are in the other if and else cases.
>
> Ok. I'll fix this. Actually it's another hack: we don't use full page
> for PTE table because we need to reserve something for PGD

I don't understand "we need to reserve something for PGD".   Do you 
mean that you would not require a second page for the PGD because the 
full pagetable could fit in one page?   My first reaction was to say 
then create pgtable-nopgd.h like the other two.  The page walkers 
support this with the advent of gigantic pages.  Then I realized that 
might not be optimal:  while the page table might fit in one page, it 
would mean you always allocate the pte space to cover the full address 
space.   Even if your processes spread out over the 3G of address space 
allocated to them (32 bit kernel), you will allocate space for 4G, 
wasting 1/4 of the pte space.
That does imply you want to allocate the pte page from a slab instead 
of pgalloc.  Is that covered?


milton
