Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrWBs1t4JzF07C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 16:53:41 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id e3so10439673pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 21:53:40 -0800 (PST)
Date: Tue, 5 Dec 2017 15:53:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@ozlabs.org>, Michael
 Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] powerpc/64s: ISAv3 initialize MMU registers before
 setting partition table
Message-ID: <20171205155317.6df2a891@roar.ozlabs.ibm.com>
In-Reply-To: <87d13tswmt.fsf@concordia.ellerman.id.au>
References: <20171204024055.11108-1-npiggin@gmail.com>
 <87d13tswmt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 05 Dec 2017 14:04:42 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hi Nick,
> 
> Sorry I didn't reply sooner.
> 
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > kexec can leave MMU registers set when booting into a new kernel, PIDR
> > in particular. The boot sequence does not zero PIDR, so it only gets
> > set when CPUs first switch to a userspace processes (until then it's
> > running a kernel thread with effective PID = 0).
> >
> > This leaves a window where a process table entry and page tables are
> > set up due to user processes running on other CPUs, that happen to
> > match with a stale PID. The CPU with that PID may cause speculative
> > accesses that address quadrant 0, which will result in cached
> > translations and PWC for that process, on a CPU which is not in the
> > mm_cpumask and so they will not get invalidated properly.
> >
> > The most common result is the kernel hanging in infinite page fault
> > loops soon after kexec (usually in schedule_tail, which is usually the
> > first non-speculative quardant 0 access to a new PID) due to a stale
> > PWC. However being a stale translation erorr, it could result in
> > anything up to security and data corruption errors.
> >
> > Fix this by zeroing out PIDR before setting PTCR.
> >
> > LPIDR is also not initialized, and may cause a similar issue with
> > speculative access to quadrant 1/2. This has not been observed, but
> > LPIDR is cleared to prevent that possibility.  
> 
> Isn't LPID initialised in __setup_cpu_power9() and __restore_cpu_power9() ?
> 
> eg:
> 
> _GLOBAL(__setup_cpu_power9)
> 	mflr	r11
> 	bl	__init_FSCR
> 	bl	__init_PMU
> 	bl	__init_hvmode_206
> 	mtlr	r11
> 	beqlr
> 	li	r0,0
> 	mtspr	SPRN_PSSCR,r0
> 	mtspr	SPRN_LPID,r0
> 
> 
> Similarly, shouldn't we be doing the PID initialisation there as well?

Hmm, yes I must have missed that! Yes that would be the best place to
put it.

Thanks,
Nick
