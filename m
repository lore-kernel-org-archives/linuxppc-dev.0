Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrRRw3CBTzDsFZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 14:04:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] powerpc/64s: ISAv3 initialize MMU registers before
 setting partition table
In-Reply-To: <20171204024055.11108-1-npiggin@gmail.com>
References: <20171204024055.11108-1-npiggin@gmail.com>
Date: Tue, 05 Dec 2017 14:04:42 +1100
Message-ID: <87d13tswmt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

Sorry I didn't reply sooner.

Nicholas Piggin <npiggin@gmail.com> writes:

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
> PWC. However being a stale translation erorr, it could result in
> anything up to security and data corruption errors.
>
> Fix this by zeroing out PIDR before setting PTCR.
>
> LPIDR is also not initialized, and may cause a similar issue with
> speculative access to quadrant 1/2. This has not been observed, but
> LPIDR is cleared to prevent that possibility.

Isn't LPID initialised in __setup_cpu_power9() and __restore_cpu_power9() ?

eg:

_GLOBAL(__setup_cpu_power9)
	mflr	r11
	bl	__init_FSCR
	bl	__init_PMU
	bl	__init_hvmode_206
	mtlr	r11
	beqlr
	li	r0,0
	mtspr	SPRN_PSSCR,r0
	mtspr	SPRN_LPID,r0


Similarly, shouldn't we be doing the PID initialisation there as well?

cheers
