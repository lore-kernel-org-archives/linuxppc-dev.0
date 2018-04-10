Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KxGV6qFCzDqwG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 15:55:14 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3A5pHGA085017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 01:55:12 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h8h08d937-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 01:55:11 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 10 Apr 2018 06:55:09 +0100
Date: Tue, 10 Apr 2018 11:25:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: trace_tlbie must not be called
 in realmode
To: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC"
 <kvm-ppc@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
References: <20180405175631.31381-1-npiggin@gmail.com>
 <20180405175631.31381-2-npiggin@gmail.com>
 <CAKTCnzn119+T_jkWAxPXoor_bpMezdRoQ9VqN+TYTUhxvQq4Fw@mail.gmail.com>
 <20180408234150.36d766f6@roar.ozlabs.ibm.com>
 <87in8zbvbk.fsf@concordia.ellerman.id.au>
In-Reply-To: <87in8zbvbk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1523338519.27phm7a0v6.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
>> On Sun, 8 Apr 2018 20:17:47 +1000
>> Balbir Singh <bsingharora@gmail.com> wrote:
>>
>>> On Fri, Apr 6, 2018 at 3:56 AM, Nicholas Piggin <npiggin@gmail.com> wro=
te:
>>> > This crashes with a "Bad real address for load" attempting to load
>>> > from the vmalloc region in realmode (faulting address is in DAR).
>>> >
>>> >   Oops: Bad interrupt in KVM entry/exit code, sig: 6 [#1]
>>> >   LE SMP NR_CPUS=3D2048 NUMA PowerNV
>>> >   CPU: 53 PID: 6582 Comm: qemu-system-ppc Not tainted 4.16.0-01530-g4=
3d1859f0994
>>> >   NIP:  c0000000000155ac LR: c0000000000c2430 CTR: c000000000015580
>>> >   REGS: c000000fff76dd80 TRAP: 0200   Not tainted  (4.16.0-01530-g43d=
1859f0994)
>>> >   MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48082222  XER: 0000000=
0
>>> >   CFAR: 0000000102900ef0 DAR: d00017fffd941a28 DSISR: 00000040 SOFTE:=
 3
>>> >   NIP [c0000000000155ac] perf_trace_tlbie+0x2c/0x1a0
>>> >   LR [c0000000000c2430] do_tlbies+0x230/0x2f0
>>> >
>>> > I suspect the reason is the per-cpu data is not in the linear chunk.
>>> > This could be restored if that was able to be fixed, but for now,
>>> > just remove the tracepoints. =20
>>>=20
>>> Could you share the stack trace as well? I've not observed this in my t=
esting.
>>
>> I can't seem to find it, I can try reproduce tomorrow. It was coming
>> from h_remove hcall from the guest. It's 176 logical CPUs.
>>
>>> May be I don't have as many cpus. I presume your talking about the per =
cpu
>>> data offsets for per cpu trace data?
>>
>> It looked like it was dereferencing virtually mapped per-cpu data, yes.
>> Probably the perf_events deref.
>=20
> Naveen has posted a series to (hopefully) fix this, which just missed
> the merge window:
>=20
>   https://patchwork.ozlabs.org/patch/894757/

I'm afraid that won't actually help here :(
That series is specific to the function tracer, while this is using=20
static tracepoints.

We could convert trace_tlbie() to a TRACE_EVENT_CONDITION() and guard it=20
within a check for paca->ftrace_enabled, but that would only be useful=20
if the below callsites can ever be hit outside of KVM guest mode.

- Naveen

=
