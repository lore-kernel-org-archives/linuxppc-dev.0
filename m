Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pr3B7pzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:56 +1000 (AEST)
In-Reply-To: <149638860805.20682.16651712989980265609.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RESEND,
 v2] powerpc/fadump: set an upper limit for boot memory size
Message-Id: <3wh9pq5DCjz9s1h@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-02 at 07:30:27 UTC, Hari Bathini wrote:
> By default, 5% of system RAM is reserved for preserving boot memory.
> Alternatively, a user can specify the amount of memory to reserve.
> See Documentation/powerpc/firmware-assisted-dump.txt for details. In
> addition to the memory reserved for preserving boot memory, some more
> memory is reserved, to save HPTE region, CPU state data and ELF core
> headers.
> 
> Memory Reservation during first kernel looks like below:
> 
>   Low memory                                        Top of memory
>   0      boot memory size                                       |
>   |           |                       |<--Reserved dump area -->|
>   V           V                       |   Permanent Reservation V
>   +-----------+----------/ /----------+---+----+-----------+----+
>   |           |                       |CPU|HPTE|  DUMP     |ELF |
>   +-----------+----------/ /----------+---+----+-----------+----+
>         |                                           ^
>         |                                           |
>         \                                           /
>          -------------------------------------------
>           Boot memory content gets transferred to
>           reserved area by firmware at the time of
>           crash
> 
> This implicitly means that the sum of the sizes of boot memory, CPU
> state data, HPTE region, DUMP preserving area and ELF core headers
> can't be greater than the total memory size. But currently, a user is
> allowed to specify any value as boot memory size. So, the above rule
> is violated when a boot memory size around 50% of the total available
> memory is specified. As the kernel is not handling this currently, it
> may lead to undefined behavior. Fix it by setting an upper limit for
> boot memory size to 25% of the total available memory. Also, instead
> of using memblock_end_of_DRAM(), which doesn't take the holes, if any,
> in the memory layout into account, use memblock_phys_mem_size() to
> calculate the percentage of total available memory.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/48a316e350974739235c234430ec0e

cheers
