Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KxcX0qBPzDqRV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 16:10:51 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id u86so7390544pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 23:10:51 -0700 (PDT)
Date: Tue, 10 Apr 2018 16:10:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>, "open list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC"
 <kvm-ppc@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: trace_tlbie must not be called
 in realmode
Message-ID: <20180410161039.43b9d84e@roar.ozlabs.ibm.com>
In-Reply-To: <1523338519.27phm7a0v6.naveen@linux.ibm.com>
References: <20180405175631.31381-1-npiggin@gmail.com>
 <20180405175631.31381-2-npiggin@gmail.com>
 <CAKTCnzn119+T_jkWAxPXoor_bpMezdRoQ9VqN+TYTUhxvQq4Fw@mail.gmail.com>
 <20180408234150.36d766f6@roar.ozlabs.ibm.com>
 <87in8zbvbk.fsf@concordia.ellerman.id.au>
 <1523338519.27phm7a0v6.naveen@linux.ibm.com>
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

On Tue, 10 Apr 2018 11:25:02 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Michael Ellerman wrote:
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >   
> >> On Sun, 8 Apr 2018 20:17:47 +1000
> >> Balbir Singh <bsingharora@gmail.com> wrote:
> >>  
> >>> On Fri, Apr 6, 2018 at 3:56 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >>> > This crashes with a "Bad real address for load" attempting to load
> >>> > from the vmalloc region in realmode (faulting address is in DAR).
> >>> >
> >>> >   Oops: Bad interrupt in KVM entry/exit code, sig: 6 [#1]
> >>> >   LE SMP NR_CPUS=2048 NUMA PowerNV
> >>> >   CPU: 53 PID: 6582 Comm: qemu-system-ppc Not tainted 4.16.0-01530-g43d1859f0994
> >>> >   NIP:  c0000000000155ac LR: c0000000000c2430 CTR: c000000000015580
> >>> >   REGS: c000000fff76dd80 TRAP: 0200   Not tainted  (4.16.0-01530-g43d1859f0994)
> >>> >   MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48082222  XER: 00000000
> >>> >   CFAR: 0000000102900ef0 DAR: d00017fffd941a28 DSISR: 00000040 SOFTE: 3
> >>> >   NIP [c0000000000155ac] perf_trace_tlbie+0x2c/0x1a0
> >>> >   LR [c0000000000c2430] do_tlbies+0x230/0x2f0
> >>> >
> >>> > I suspect the reason is the per-cpu data is not in the linear chunk.
> >>> > This could be restored if that was able to be fixed, but for now,
> >>> > just remove the tracepoints.    
> >>> 
> >>> Could you share the stack trace as well? I've not observed this in my testing.  
> >>
> >> I can't seem to find it, I can try reproduce tomorrow. It was coming
> >> from h_remove hcall from the guest. It's 176 logical CPUs.
> >>  
> >>> May be I don't have as many cpus. I presume your talking about the per cpu
> >>> data offsets for per cpu trace data?  
> >>
> >> It looked like it was dereferencing virtually mapped per-cpu data, yes.
> >> Probably the perf_events deref.  
> > 
> > Naveen has posted a series to (hopefully) fix this, which just missed
> > the merge window:
> > 
> >   https://patchwork.ozlabs.org/patch/894757/  
> 
> I'm afraid that won't actually help here :(
> That series is specific to the function tracer, while this is using 
> static tracepoints.
> 
> We could convert trace_tlbie() to a TRACE_EVENT_CONDITION() and guard it 
> within a check for paca->ftrace_enabled, but that would only be useful 
> if the below callsites can ever be hit outside of KVM guest mode.

Right, removing the trace points is the right thing to do here.

Doing tracing in real mode would be a whole effort itself, I'd expect.
Or disabling realmode handling of HPT hcalls if trace points are
active.

Thanks,
Nick
