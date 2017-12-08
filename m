Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytX3r3BJ5zDrKp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 23:39:36 +1100 (AEDT)
In-Reply-To: <20171206082114.30302-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v3] powerpc/64s: ISAv3 initialize MMU registers before setting
 partition table
Message-Id: <3ytX3q6wHhz9s83@ozlabs.org>
Date: Fri,  8 Dec 2017 23:39:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-06 at 08:21:14 UTC, Nicholas Piggin wrote:
> kexec can leave MMU registers set when booting into a new kernel, PIDR
> in particular. The boot sequence does not zero PIDR, so it only gets
> set when CPUs first switch to a userspace processes (until then it's
> running a kernel thread with effective PID = 0).
> 
> This leaves a window where a process table entry and page tables are
> set up due to user processes running on other CPUs, that happen to
> match with a stale PID. The CPU with that PID may cause speculative
> accesses that address quadrant 0, which will result in cached
> translations and PWC for that process, on a CPU which is not in the
> mm_cpumask and so they will not get invalidated properly.
> 
> The most common result is the kernel hanging in infinite page fault
> loops soon after kexec (usually in schedule_tail, which is usually the
> first non-speculative quardant 0 access to a new PID) due to a stale
> PWC. However being a stale translation error, it could result in
> anything up to security and data corruption problems.
> 
> Fix this by zeroing out PIDR at boot and kexec.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/371b80447ff33ddac392c189cf884a

cheers
