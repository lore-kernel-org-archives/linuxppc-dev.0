Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgCms1CTLzDwBw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 01:46:21 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p66so9945636pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:46:21 -0800 (PST)
Subject: Re: [PATCH V2 0/4] OPTPROBES for powerpc
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, paulus@samba.org,
 mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <fd268944-5f8e-9815-6fef-e7d9d5191044@gmail.com>
Date: Sat, 17 Dec 2016 01:46:06 +1100
MIME-Version: 1.0
In-Reply-To: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15/12/16 03:18, Anju T Sudhakar wrote:
> This is the V2 patchset of the kprobes jump optimization
> (a.k.a OPTPROBES)for powerpc. Kprobe being an inevitable tool
> for kernel developers, enhancing the performance of kprobe has
> got much importance.
> 
> Currently kprobes inserts a trap instruction to probe a running kernel.
> Jump optimization allows kprobes to replace the trap with a branch,
> reducing the probe overhead drastically.
> 
> In this series, conditional branch instructions are not considered for
> optimization as they have to be assessed carefully in SMP systems.
> 
> The kprobe placed on the kretprobe_trampoline during boot time, is also
> optimized in this series. Patch 4/4 furnishes this.
> 
> The first two patches can go independently of the series. The helper 
> functions in these patches are invoked in patch 3/4.
> 
> Performance:
> ============
> An optimized kprobe in powerpc is 1.05 to 4.7 times faster than a kprobe.
>  
> Example:
>  
> Placed a probe at an offset 0x50 in _do_fork().
> *Time Diff here is, difference in time before hitting the probe and
> after the probed instruction. mftb() is employed in kernel/fork.c for
> this purpose.
>  
> # echo 0 > /proc/sys/debug/kprobes-optimization
> Kprobes globally unoptimized
>  [  233.607120] Time Diff = 0x1f0
>  [  233.608273] Time Diff = 0x1ee
>  [  233.609228] Time Diff = 0x203
>  [  233.610400] Time Diff = 0x1ec
>  [  233.611335] Time Diff = 0x200
>  [  233.612552] Time Diff = 0x1f0
>  [  233.613386] Time Diff = 0x1ee
>  [  233.614547] Time Diff = 0x212
>  [  233.615570] Time Diff = 0x206
>  [  233.616819] Time Diff = 0x1f3
>  [  233.617773] Time Diff = 0x1ec
>  [  233.618944] Time Diff = 0x1fb
>  [  233.619879] Time Diff = 0x1f0
>  [  233.621066] Time Diff = 0x1f9
>  [  233.621999] Time Diff = 0x283
>  [  233.623281] Time Diff = 0x24d
>  [  233.624172] Time Diff = 0x1ea
>  [  233.625381] Time Diff = 0x1f0
>  [  233.626358] Time Diff = 0x200
>  [  233.627572] Time Diff = 0x1ed
>  
> # echo 1 > /proc/sys/debug/kprobes-optimization
> Kprobes globally optimized
>  [   70.797075] Time Diff = 0x103
>  [   70.799102] Time Diff = 0x181
>  [   70.801861] Time Diff = 0x15e
>  [   70.803466] Time Diff = 0xf0
>  [   70.804348] Time Diff = 0xd0
>  [   70.805653] Time Diff = 0xad
>  [   70.806477] Time Diff = 0xe0
>  [   70.807725] Time Diff = 0xbe
>  [   70.808541] Time Diff = 0xc3
>  [   70.810191] Time Diff = 0xc7
>  [   70.811007] Time Diff = 0xc0
>  [   70.812629] Time Diff = 0xc0
>  [   70.813640] Time Diff = 0xda
>  [   70.814915] Time Diff = 0xbb
>  [   70.815726] Time Diff = 0xc4
>  [   70.816955] Time Diff = 0xc0
>  [   70.817778] Time Diff = 0xcd
>  [   70.818999] Time Diff = 0xcd
>  [   70.820099] Time Diff = 0xcb
>  [   70.821333] Time Diff = 0xf0
> 
> Implementation:
> ===================
>  
> The trap instruction is replaced by a branch to a detour buffer. To address
> the limitation of branch instruction in power architecture, detour buffer
> slot is allocated from a reserved area . This will ensure that the branch
> is within ± 32 MB range. The current kprobes insn caches allocate memory 
> area for insn slots with module_alloc(). This will always be beyond 
> ± 32MB range.
>  

The paragraph is a little confusing. We need the detour buffer to be within
+-32 MB, but then you say we always get memory from module_alloc() beyond
32MB.

> The detour buffer contains a call to optimized_callback() which in turn
> call the pre_handler(). Once the pre-handler is run, the original
> instruction is emulated from the detour buffer itself. Also the detour
> buffer is equipped with a branch back to the normal work flow after the
> probed instruction is emulated.

Does the branch itself use registers that need to be saved? I presume
we are going to rely on the +-32MB, what are the guarantees of success
of such a mechanism?

Balbir Singh.
