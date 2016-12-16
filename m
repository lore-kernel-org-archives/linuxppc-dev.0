Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgH9l2dyxzDw6F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 04:19:38 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBGHJ2mo090109
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 12:19:34 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27cjd1fnen-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 12:19:34 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 16 Dec 2016 22:49:26 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 71D0FE005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:50:02 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBGHIiNS24903786
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:48:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBGHJLDS002701
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:49:23 +0530
Date: Fri, 16 Dec 2016 22:49:16 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, srikar@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, paulus@samba.org, mhiramat@kernel.org,
 ananth@in.ibm.com
Subject: Re: [PATCH V2 0/4] OPTPROBES for powerpc
References: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
 <fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com>
Message-Id: <20161216171916.GH4109@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/12/17 01:46AM, Balbir Singh wrote:
> 
> 
> On 15/12/16 03:18, Anju T Sudhakar wrote:
> > This is the V2 patchset of the kprobes jump optimization
> > (a.k.a OPTPROBES)for powerpc. Kprobe being an inevitable tool
> > for kernel developers, enhancing the performance of kprobe has
> > got much importance.
> > 
> > Currently kprobes inserts a trap instruction to probe a running kernel.
> > Jump optimization allows kprobes to replace the trap with a branch,
> > reducing the probe overhead drastically.
> > 
> > In this series, conditional branch instructions are not considered for
> > optimization as they have to be assessed carefully in SMP systems.
> > 
> > The kprobe placed on the kretprobe_trampoline during boot time, is also
> > optimized in this series. Patch 4/4 furnishes this.
> > 
> > The first two patches can go independently of the series. The helper 
> > functions in these patches are invoked in patch 3/4.
> > 
> > Performance:
> > ============
> > An optimized kprobe in powerpc is 1.05 to 4.7 times faster than a kprobe.
> >  
> > Example:
> >  
> > Placed a probe at an offset 0x50 in _do_fork().
> > *Time Diff here is, difference in time before hitting the probe and
> > after the probed instruction. mftb() is employed in kernel/fork.c for
> > this purpose.
> >  
> > # echo 0 > /proc/sys/debug/kprobes-optimization
> > Kprobes globally unoptimized
> >  [  233.607120] Time Diff = 0x1f0
> >  [  233.608273] Time Diff = 0x1ee
> >  [  233.609228] Time Diff = 0x203
> >  [  233.610400] Time Diff = 0x1ec
> >  [  233.611335] Time Diff = 0x200
> >  [  233.612552] Time Diff = 0x1f0
> >  [  233.613386] Time Diff = 0x1ee
> >  [  233.614547] Time Diff = 0x212
> >  [  233.615570] Time Diff = 0x206
> >  [  233.616819] Time Diff = 0x1f3
> >  [  233.617773] Time Diff = 0x1ec
> >  [  233.618944] Time Diff = 0x1fb
> >  [  233.619879] Time Diff = 0x1f0
> >  [  233.621066] Time Diff = 0x1f9
> >  [  233.621999] Time Diff = 0x283
> >  [  233.623281] Time Diff = 0x24d
> >  [  233.624172] Time Diff = 0x1ea
> >  [  233.625381] Time Diff = 0x1f0
> >  [  233.626358] Time Diff = 0x200
> >  [  233.627572] Time Diff = 0x1ed
> >  
> > # echo 1 > /proc/sys/debug/kprobes-optimization
> > Kprobes globally optimized
> >  [   70.797075] Time Diff = 0x103
> >  [   70.799102] Time Diff = 0x181
> >  [   70.801861] Time Diff = 0x15e
> >  [   70.803466] Time Diff = 0xf0
> >  [   70.804348] Time Diff = 0xd0
> >  [   70.805653] Time Diff = 0xad
> >  [   70.806477] Time Diff = 0xe0
> >  [   70.807725] Time Diff = 0xbe
> >  [   70.808541] Time Diff = 0xc3
> >  [   70.810191] Time Diff = 0xc7
> >  [   70.811007] Time Diff = 0xc0
> >  [   70.812629] Time Diff = 0xc0
> >  [   70.813640] Time Diff = 0xda
> >  [   70.814915] Time Diff = 0xbb
> >  [   70.815726] Time Diff = 0xc4
> >  [   70.816955] Time Diff = 0xc0
> >  [   70.817778] Time Diff = 0xcd
> >  [   70.818999] Time Diff = 0xcd
> >  [   70.820099] Time Diff = 0xcb
> >  [   70.821333] Time Diff = 0xf0
> > 
> > Implementation:
> > ===================
> >  
> > The trap instruction is replaced by a branch to a detour buffer. To address
> > the limitation of branch instruction in power architecture, detour buffer
> > slot is allocated from a reserved area . This will ensure that the branch
> > is within ± 32 MB range. The current kprobes insn caches allocate memory 
> > area for insn slots with module_alloc(). This will always be beyond 
> > ± 32MB range.
> >  
> 
> The paragraph is a little confusing. We need the detour buffer to be within
> +-32 MB, but then you say we always get memory from module_alloc() beyond
> 32MB.

Yes, I think it can be described better. What Anju is mentioning is that 
the existing generic approach for kprobes insn cache uses module_alloc() 
which is not suitable for us due to the 32MB range limit with relative 
branches on powerpc.

Instead, we reserve a 64k block within .text and allocate the detour 
buffer from that area. This puts the detour buffer in range for most of 
the symbols and should be a good start.

> 
> > The detour buffer contains a call to optimized_callback() which in turn
> > call the pre_handler(). Once the pre-handler is run, the original
> > instruction is emulated from the detour buffer itself. Also the detour
> > buffer is equipped with a branch back to the normal work flow after the
> > probed instruction is emulated.
> 
> Does the branch itself use registers that need to be saved? I presume

No, we use immediate values to encode the relative address.

> we are going to rely on the +-32MB, what are the guarantees of success
> of such a mechanism?

We explicitly ensure that the return branch is within range as well 
during registration. In fact, this is one of the reasons why we can't 
optimize conditional branches - we can't know in advance where we need 
to jump back.

> 
> Balbir Singh.
> 

Thanks,
- Naveen
