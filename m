Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x234.google.com (mail-vk0-x234.google.com
 [IPv6:2607:f8b0:400c:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40JqBQ67GqzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Apr 2018 20:17:50 +1000 (AEST)
Received: by mail-vk0-x234.google.com with SMTP id r184so3121197vke.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 03:17:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180405175631.31381-2-npiggin@gmail.com>
References: <20180405175631.31381-1-npiggin@gmail.com>
 <20180405175631.31381-2-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sun, 8 Apr 2018 20:17:47 +1000
Message-ID: <CAKTCnzn119+T_jkWAxPXoor_bpMezdRoQ9VqN+TYTUhxvQq4Fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: trace_tlbie must not be called
 in realmode
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC"
 <kvm-ppc@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 6, 2018 at 3:56 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> This crashes with a "Bad real address for load" attempting to load
> from the vmalloc region in realmode (faulting address is in DAR).
>
>   Oops: Bad interrupt in KVM entry/exit code, sig: 6 [#1]
>   LE SMP NR_CPUS=2048 NUMA PowerNV
>   CPU: 53 PID: 6582 Comm: qemu-system-ppc Not tainted 4.16.0-01530-g43d1859f0994
>   NIP:  c0000000000155ac LR: c0000000000c2430 CTR: c000000000015580
>   REGS: c000000fff76dd80 TRAP: 0200   Not tainted  (4.16.0-01530-g43d1859f0994)
>   MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48082222  XER: 00000000
>   CFAR: 0000000102900ef0 DAR: d00017fffd941a28 DSISR: 00000040 SOFTE: 3
>   NIP [c0000000000155ac] perf_trace_tlbie+0x2c/0x1a0
>   LR [c0000000000c2430] do_tlbies+0x230/0x2f0
>
> I suspect the reason is the per-cpu data is not in the linear chunk.
> This could be restored if that was able to be fixed, but for now,
> just remove the tracepoints.

Could you share the stack trace as well? I've not observed this in my testing.
May be I don't have as many cpus. I presume your talking about the per cpu
data offsets for per cpu trace data?

Balbir Singh.
