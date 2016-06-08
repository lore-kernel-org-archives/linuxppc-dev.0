Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPfYb4P4PzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 17:04:02 +1000 (AEST)
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Becky Bruce <beckyb@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <oss@buserror.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC] Implementing HUGEPAGE on MPC 8xx
Message-ID: <b2980a9d-4795-ae1b-16dd-ba244d559a31@c-s.fr>
Date: Wed, 8 Jun 2016 09:03:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

MPC 8xx has several page sizes: 4k, 16k, 512k and 8M.
Today, 4k and 16k sizes are implemented as normal page sizes and 8M is 
used for mapping linear memory space in kernel.

I'd like to implement HUGE PAGE to reduce TLB misses from user apps.

In 4k mode, PAGE offset is 12 bits, PTE offset is 10 bits and PGD offset 
is 10 bits
In 16k mode, PAGE offset is 14 bits, PTE offset is 12 bits and PGD 
offset is 6 bits

In 4k mode, we could use 512k HUGE PAGE and have a HPAGE offset of 19 
bits so HPTE offset of 3 bits and PGD offset of 10 bits
In 16k mode, we could use both 512k HUGE PAGE and 8M HUGE PAGE and have:
* For 512k: a HPAGE offset of 19 bits so HPTE offset of 7 bits and PGD 
offset of 6 bits
* For 8M: a HPAGE offset of 23 bits so HPTE offset of 3 bits and PGD 
offset of 6 bits

In see in the current ppc kernel that for PPC32, SYS_SUPPORTS_HUGETLBFS 
is selected only if we have PHYS_64BIT.
What is the reason for only implementing HUGETLBFS with 64 bits phys 
addresses ?

 From your point of view, what would be the best approach to extend 
support of HUGE PAGES to PPC_8xx ?
Would the good starting point be to implement a hugepagetlb-8xx.c from 
hugepagetlb-book3e.c ?

Christophe
