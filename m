Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BC9D2C007E
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2012 18:28:00 +1100 (EST)
Received: from telerig.nabble.com ([192.168.236.162])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <bounces@nabble.com>) id 1TiKFy-0000dj-5U
 for linuxppc-dev@ozlabs.org; Mon, 10 Dec 2012 23:27:58 -0800
Message-ID: <34782747.post@talk.nabble.com>
Date: Mon, 10 Dec 2012 23:27:58 -0800 (PST)
From: Pegasus11 <aijazbaig1.new@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Understanding how kernel updates MMU hash table
In-Reply-To: <1355087457.28585.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <34760537.post@talk.nabble.com> <1354695642.2351.8.camel@pasglop>
 <34762800.post@talk.nabble.com> <1354766337.2351.41.camel@pasglop>
 <34765222.post@talk.nabble.com> <1354794967.28585.16.camel@pasglop>
 <34775807.post@talk.nabble.com> <1355087457.28585.61.camel@pasglop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi ben

Now that many things are becoming clear let me sum up my understanding until
this point. Do correct it if there are mistakes.

1. Linux page table structure (PGD, PUD, PMD and PTE) is directly used in
case of architecture that lend themselves to such a tree structure for
maintaining virtual memory information. Otherwise Linux needs to maintain
two seperate constructs like it does in case of PowerPC. Right?
2. PowerPC's hash table as you said is pretty large. However isn't it still
smaller than Linux's VM infrastructure such that the chances of it being
'FULL' are a lot more. It is also possible that there could be two entries
in the table that points to the same Real address. Like a page being shared
by two processes?

My main concern here is to understand if having such an inverted page table
aka the hash table helps us in any way when doing TLB flushes. You mentioned
and I also read  in a paper by Paul Mackerras that every Linux PTE (LPTE) in
case of ppc64 contains 4 extra bits that help us to get to the very slot in
the hash table that houses the corresponding hashtable PTE(HPTE). Now this
(at least to me) is smartness on the part of the kernel and I do not think
the architecture per se is doing us any favor by having that hash table
right? Or am I missing something here? 

His paper is (or rather was) on how one can optimize the Linux ppc kernel
and time and again he mentions the fact that one can first record the LPTEs
being invalidated and then remove the corresponding HPTEs in a batched
format. In his own words "Alternatively, it would be possible to make a list
of virtual addresses when LPTEs are changed and then use that list in the
TLB flush routines to avoid the search through the Linux page tables". So do
we skip looking for the corresponding LPTEs or perhaps we've already
invalidated them and we remove the corresponding HPTEs in a batch as you
mentioned earlier?? Could you shed some light on how this optimization
actually developed over time? He had results for an "immediate update"
kernel and "batched update" kernel for both ppc32 and ppc64. For ppc32 the
batched update is actually a bit worse than immediate update however for
ppc64, the batched update performs better than immediate update. What
exactly is helping ppc64 perform better with the so called "batched update"?
Is it the encoding of the HPTE address in the LPTE as mentioned above? Or
some aspect of ppc64 that I am unaware of? :thinking:

Also on a generic note, how come we have 4 spare bits in the PTE for 64bit
address space? Large pages perhaps?
-- 
View this message in context: http://old.nabble.com/Understanding-how-kernel-updates-MMU-hash-table-tp34760537p34782747.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
