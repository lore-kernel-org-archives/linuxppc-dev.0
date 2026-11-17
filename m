Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770F606A880
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+tbP/xp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQXc2X61z2xnZ;
	Wed, 18 Nov 2026 00:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794922096;
	cv=none; b=i/IG/oUquS0UsSKQLSWeWROuRaZQ0e6cffyou/xRseiU1L6xm685guQWHQQ1I9/1nK7XDjv6Au1FaEAE7UBfQlCQsYcCkhVgmPU9XfW1lny2/r2aEEW05NtcgrwMX8QPXyGC8cwqiEmKe3JM7VbeqlOHGPlqiCuLBTDHgWA/IlLsSId61eXHQO1rpb/NyPf+EjxJ2ximTQIz/FwHIHcRm2XsrB5RWa6BShe2c1xNqoGz0YmK4s4xKUa2v2VuxNG9DWIp4ZdCntFkWdD/5UjY7vJzUT1VG/fFUCN/dlCGA2IigQQXPMP9pkxF0SAjlhF9J16WtZpSo4jUNqzKSdoOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794922096; c=relaxed/relaxed;
	bh=HmHcMuLKVgfh8wwUH/FjH41O+keWBBkDEmkWD7YDblc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Ile0xWBlx753IoloxUKxVTMXYKaoazfuJurI1wcvOHB+NQhsubVlXTM3X9HPGyAbi6QqJouUHrpznwjYBrZPmkHkVgbJFVvIy6TLw1/rwaKHoykty+Jy0pXrS9Lj11mB+XMGbTfWVktLihSoiMkmWVplxCMFLtL3z+OcHtVzHP/jywRJVGgpqun6uSDkDrMws8U6KQzzLSnebXbppn+41ry79KAN6Jf66nRwRsNn9Ts4/BPSEeQ89PjTh+swTuFnnU+HRSeu8e1Gmw1jITUyZX0X4wqchEIybiCsisYcEZHzzs6TpaxJLAEOfrYCE698fiB+XqmMzm5XyLaVEIOXXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+tbP/xp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D+tbP/xp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQXZ6RRqz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:28:14 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-33fb4680717so11730026eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794922092; x=1795526892; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HmHcMuLKVgfh8wwUH/FjH41O+keWBBkDEmkWD7YDblc=;
        b=D+tbP/xpyznCbDpWQK5z7ifyuukjEZh/Tv6CoWeJMy8dYAPUN0LAwitPjJubOuH9bm
         eTKPrgcDBSWLR2cbL3cLR6kXem1xYjCbfqhAH7SBI7qMNpwx5JBF3roCvZu9K2q5RtD3
         GEXaBE3M+TA0qvbM4zhkqms6Fm1s5C+QShcxdwkGBpJLvtlibS1qlGgIKhVHi47FFfLp
         xtp7QFxFpD7elSKCmziwhSCvOY6UkZMKaMQ0BJCtX/gs5lNDzvLppMeBdNAaDWKmb6B1
         UPiGlsDP03nUTeBBIHB9tbp9AP30xwJDE69b3pk2LF2GnQNZcLpBc04CYDUvM+Jf3bN2
         g26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794922092; x=1795526892;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HmHcMuLKVgfh8wwUH/FjH41O+keWBBkDEmkWD7YDblc=;
        b=sLsFUKXSpdSE4tN1f5yQBIxPF35v2epco2bKa4JL7mYbLSjj8r4+NcoYCYZyMsLozJ
         aYvy6k/xACZQYhfMRRYCAYcbu35MIu/n9YZZJi8+hvH1KRbIF2B0o4ymiDEFvI/ryYBx
         g+M6OKv5OLKndpRRVZWUGO16Ntov/FI6eqb7uAG9h0CagWXUP5InQX4NtluwpPRfJeEz
         PoTKHwZP7h46v388IX2LgGPf6dSbm+zRCNwZbYMlOQxGlKAaZRNwbOD6e0pMqhiF7bQg
         mKXKZPifP++VdV/5RdMpEaG4sPPNXYOXI+3SWxYxovPWT/ZRfhVvDGUgYGj/DJB8xnSG
         i1mQ==
X-Gm-Message-State: APuU4Z9wNA6768zDLUrUKgv4jbvKZkhiysJm3Rdk6c5Kb0Qs0kSYYW47
	uJjtxNwyg/+dk7fQk6TXUFaCzUsvpwpeiznKEpC+iSaFP6HLVzr7aqU0
X-Gm-Gg: AZFdTZfxUBHIZAKUUj/0SLn/nEJ2XuQnupL+cYFqoI/m1jPBwyeo0i4xPkdYBrMIZW1
	uM4xlnPqODiwZSjgTI348I0aRsNGzz9yTQhi7FL45wIaZtPL21l9aeTRHAFMt9IKRdFpbRlkRvQ
	tAlH+WQO6fy3go/BRdzCnmc12ltBwOG1E3lPnMnf+B9wLXTMSYFSz1E/L27gliZScNnY+BsfphT
	YqjJrdDhOhQUtsf/ouz5IXCtUhvLscDtlquqWFDDs6ysFihKv06C3s5EJZJ4C7lBlzX2Znd/lux
	qLJSrSbydUR34KreeK8F1Wh5y2Lm77AxK0zIbsyAX5l0B3jI4+AFqtx5rbiI18Slg9EueYGk6DV
	nyORF3eARUNodfvhKdC9Xyn9buMKPaXbI6je08rO3Evqa8/LeSpjToUTfhW2N2v6CXKqQ1M8mvq
	T+VvCNSRRqMo2SL7WNo7UXRHJeLdbHY2ldQBY/tn1RkXq6j/h8hWt3/TTGYZLr1WsPMLZ3v+G6n
	KHCDrrLe2FqNup5DgtwOhOvLtHi81uEXi6kX9LLdoNBsiwu8XfVEWPDIhhKAs0nE/NY0InKnQwm
	qAl2I+ef41ng/wx3pl6viwgiGBA=
X-Received: by 2002:a05:7301:d185:b0:370:1652:5ff4 with SMTP id 5a478bee46e88-37966387cb3mr12902348eec.6.1794922091687;
        Tue, 17 Nov 2026 05:28:11 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm46077098eec.28.2026.11.17.05.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:28:10 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCHv2 2/3] powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32
In-Reply-To: <avsn7Kn4a8wbB2QH@kernel.org>
Date: Tue, 17 Nov 2026 18:03:37 +0530
Message-ID: <zev77i3i.ritesh.list@gmail.com>
References: <cover.1794572365.git.ritesh.list@gmail.com> <82c4973addebd82923c460cb44221f5b76146afe.1794572365.git.ritesh.list@gmail.com> <avltdwzlh07VZSFC@kernel.org> <f7834f3e-6c43-4b58-806d-fe4c07a93457@kernel.org> <avsn7Kn4a8wbB2QH@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mike Rapoport <rppt@kernel.org> writes:

> On Mon, Nov 16, 2026 at 04:11:07PM +0100, Christophe Leroy (CS GROUP) wrote:
>> Hi Mike,
>> 
>> Le 15/11/2026 à 09:29, Mike Rapoport a écrit :
>> > On Fri, Nov 13, 2026 at 06:01:37PM +0530, Ritesh Harjani (IBM) wrote:
>> > > On book3s/32, a kprobe on an instruction that can't be emulated and has
>> > > to be single stepped out of line, crashes the kernel. For e.g. with the
>> > > following cmds...
>> > >      ~> echo 9 > /proc/sys/kernel/printk
>> > >      ~> mount -t debugfs debugfs /sys/kernel/debug
>> > >      ~> echo 'p:wx filldir64+0xb8' > /sys/kernel/debug/tracing/kprobe_events
>> > >      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/wx/enable
>> > >      ~> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
>> > > 
>> > > ...we can see the following crash:
>> > >      kernel tried to execute exec-protected page (f101a008) - exploit attempt? (uid: 0)
>> > >      BUG: Unable to handle kernel instruction fetch
>> > >      Faulting instruction address: 0xc02b919c
>> > >      Vector: 400 (Instruction Access) at [f19a9d60]
>> > >          pc: c02b919c: filldir64+0xb8/0x2dc
>> > >          lr: c02b9148: filldir64+0x64/0x2dc
>> > >          sp: f19a9e20
>> > >         msr: 10029032
>> > >        current = 0xc112e900
>> > >          pid   = 102, comm = ls
>> > >      enter ? for help
>> > >      [f19a9e20] c1a8d420 (unreliable)
>> > >      [f19a9e50] c02e4074 dcache_readdir+0x208/0x2a8
>> > >      [f19a9e90] c02b8c5c iterate_dir+0x88/0x1fc
>> > >      [f19a9ec0] c02b96e0 sys_getdents64+0x88/0x198
>> > >      [f19a9f10] c0014400 system_call_exception+0xf8/0x20c
>> > >      [f19a9f30] c00191ac ret_from_syscall+0x0/0x2c
>> > >      ---- Exception: c00 (System Call) at a7596164
>> > >      SP (af802310) is in userspace
>> > > 
>> > > This happens because on book3s/32 the exec permission is per segment
>> > > (256MB), not per page. The page tables have no hardware exec bit, only
>> > > the segment registers have a no-execute (N) bit. mmu_mark_initmem_nx()
>> > > sets N on all the kernel segments except the ones of the modules area.
>> > > So nothing in the vmalloc area can be executed, even when the page is
>> > > mapped with PAGE_KERNEL_ROX or PAGE_KERNEL_EXEC, because _PAGE_EXEC is
>> > > a software only bit there and the segment's N bit is what the MMU
>> > > enforces.
>> > > 
>> > > Before commit 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes
>> > > allocations"), the kprobes insn pages came from module_alloc(). That
>> > > commit moved them to the whole of the vmalloc space, on the grounds
>> > > that kprobes use a breakpoint and don't need to be near the kernel
>> > > text. That is fine on platforms where the exec permission is per page,
>> > > as PAGE_KERNEL_ROX is then enough to make a vmalloc page executable.
>> > > It is not on book3s/32, where the modules area is not only close to
>> > > the kernel text but is also the only page-mapped area whose segment is
>> > > left executable. So the insn pages must keep coming from there.
>> > > 
>> > > Hence, use the modules area for EXECMEM_KPROBES on book3s/32.
>> > Right, I missed that on book3s/32 does vmalloc is not executable and its
>> > protection can't be changed.
>> > 
>> > Could it be that 8xx also need a special treatment for kprobes?
>> 
>> Yes indeed, not for the same reasons but because 8xx ITLB-miss handler
>> doesn't expect any instruction TLB miss on kernel addresses other than the
>> ones from the module area:
>> 
>> Commit 4afb0be7ccda ("powerpc/8xx: Avoid testing for kernel space in ITLB
>> Miss.")
>> Commit 16a71c045186 ("powerpc/8xx: Preallocate execmem page tables")
>> Commit 33c527522f39 ("powerpc/8xx: Inconditionally use task PGDIR in ITLB
>> misses")
>> 

Right. I looked at the above series which added all of this support [1].
So looks like 603 might also have this related problem (other than the
per segment N bit issue), since it's iTLB miss handler only walks the
task's PGDIR, unlike it's dTLB handler which falls back to reloading the
missing kernel PGD entry from swapper_pg_dir. So what I meant to say is
that, similar to 8xx, a new PGD entry created in the kernel's vmalloc
area for an insn page does not get copied over after the task is
created (/PGDIR allocated), on 603 as well.
But since MODLUES_VADDR is defined for both BOOK3S/32 and 8xx, so I guess it
gets covered by the same change anyways.

[1]: https://lore.kernel.org/linuxppc-dev/cover.1724173828.git.christophe.leroy@csgroup.eu/

>> So at the end as MODULES_VADDR/MODULES_END only exist on book3s/32 and 8xx I
>> think when they exist they should be used as follows:
>> 
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index b617b69452cd..856f4609c488 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -428,8 +428,13 @@ struct execmem_info __init *execmem_arch_setup(void)
>>  				.fallback_end	= fallback_end,
>>  			},
>>  			[EXECMEM_KPROBES] = {
>> +#ifdef MODULES_VADDR
>> +				.start	= MODULES_VADDR,
>> +				.end	= MODULES_END,
>> +#else
>>  				.start	= VMALLOC_START,
>>  				.end	= VMALLOC_END,
>> +#endif
>
> We already have #ifdef MODULES_VADDR a few lines above, I think the
> assignment of kprobes_start and kprobes_end could go there instead of if
> (IS_ENABLED(CONFIG_PPC_BOOK3S_32)).
>

Right. So let me use the following diff then? 

Please let me know if this diff looks good to you? If yes, then I can
send a v3.

Also - it will be good to know if patch-1 and patch-3 looks ok too,
before I spin a next revision?

Thanks Christophe & Mike, for reviewing and pointing this out!


diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 77b63b52d8f2..547120a30bee 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
        pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
        pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
        unsigned long fallback_start = 0, fallback_end = 0;
+       unsigned long kprobes_start = VMALLOC_START, kprobes_end = VMALLOC_END;
        unsigned long start, end;

        /*
@@ -410,6 +411,9 @@ struct execmem_info __init *execmem_arch_setup(void)
        }

        end = MODULES_END;
+
+       kprobes_start = MODULES_VADDR;
+       kprobes_end = MODULES_END;
 #else
        start = VMALLOC_START;
        end = VMALLOC_END;
@@ -428,8 +432,8 @@ struct execmem_info __init *execmem_arch_setup(void)
                                .fallback_end   = fallback_end,
                        },
                        [EXECMEM_KPROBES] = {
-                               .start  = VMALLOC_START,
-                               .end    = VMALLOC_END,
+                               .start  = kprobes_start,
+                               .end    = kprobes_end,
                                .pgprot = kprobes_prot,
                                .alignment = 1,
                        },



-ritesh


>>  				.pgprot	= kprobes_prot,
>>  				.alignment = 1,
>>  			},
>> 
>> 
>> > 
>> > > Fixes: 1b750c2fbf82 ("powerpc: extend execmem_params for kprobes allocations")
>> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> > 
>> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> > 
>> > > ---
>> > >   arch/powerpc/mm/mem.c | 10 ++++++++--
>> > >   1 file changed, 8 insertions(+), 2 deletions(-)
>> > > 
>> > > diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> > > index 77b63b52d8f2..ae1bc7359353 100644
>> > > --- a/arch/powerpc/mm/mem.c
>> > > +++ b/arch/powerpc/mm/mem.c
>> > > @@ -391,6 +391,7 @@ struct execmem_info __init *execmem_arch_setup(void)
>> > >   	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>> > >   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>> > >   	unsigned long fallback_start = 0, fallback_end = 0;
>> > > +	unsigned long kprobes_start = VMALLOC_START, kprobes_end = VMALLOC_END;
>> > >   	unsigned long start, end;
>> > > 
>> > >   	/*
>> > > @@ -410,6 +411,11 @@ struct execmem_info __init *execmem_arch_setup(void)
>> > >   	}
>> > > 
>> > >   	end = MODULES_END;
>> > > +
>> > > +	if (IS_ENABLED(CONFIG_PPC_BOOK3S_32)) {
>> > > +		kprobes_start = MODULES_VADDR;
>> > > +		kprobes_end = MODULES_END;
>> > > +	}
>> > >   #else
>> > >   	start = VMALLOC_START;
>> > >   	end = VMALLOC_END;
>> > > @@ -428,8 +434,8 @@ struct execmem_info __init *execmem_arch_setup(void)
>> > >   				.fallback_end	= fallback_end,
>> > >   			},
>> > >   			[EXECMEM_KPROBES] = {
>> > > -				.start	= VMALLOC_START,
>> > > -				.end	= VMALLOC_END,
>> > > +				.start	= kprobes_start,
>> > > +				.end	= kprobes_end,
>> > >   				.pgprot	= kprobes_prot,
>> > >   				.alignment = 1,
>> > >   			},
>> > > --
>> > > 2.39.5
>> > > 
>> > > 
>> > 
>> 
>
> -- 
> Sincerely yours,
> Mike.

