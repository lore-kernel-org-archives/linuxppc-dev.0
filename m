Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqp1y1nzF0XB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:14 +1100 (AEDT)
In-Reply-To: <151203273555.16587.12957613472048945542.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all
Message-Id: <3zPxqn4ZDBz9sR8@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-30 at 09:05:54 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> radix__flush_tlb_all() is called only in kexec path in real mode and any
> tracepoints at this stage will make kexec to fail if enabled.
> 
> To verify enable tlbie trace before kexec.
> 
> $ echo 1 > /sys/kernel/debug/tracing/events/powerpc/tlbie/enable
> == kexec into new kernel and kexec fails.
> 
> Fix this by not calling trace_tlbie from radix__flush_tlb_all().
> 
> Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8d81296cfcce89013a714feb8d2500

cheers
