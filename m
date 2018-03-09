Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyKvb2LQXzF1v7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 19:15:55 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w298Dx1T139080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2018 03:15:53 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gkn2n39p2-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 03:15:52 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 9 Mar 2018 08:15:50 -0000
Date: Fri, 09 Mar 2018 13:45:45 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <87efkve0a2.fsf@concordia.ellerman.id.au>
In-Reply-To: <87efkve0a2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1520581934.wrzeu3w6z6.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>=20
>> We can't take a trap in most parts of real mode code. Instead of adding
>> the 'notrace' annotation to all C functions that can be invoked from
>> real mode, detect that we are in real mode on ftrace entry and return
>> back.
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>> This RFC only handles -mprofile-kernel to demonstrate the approach being=
=20
>> considered. We will need to handle other ftrace entry if we decide to=20
>> continue down this path.
>=20
> Paul and I were talking about having a paca flag for this, ie.
> paca->safe_to_ftrace (or whatever). I'm not sure if you've talked to
> him and decided this is a better approach.
>=20
> I guess I'm 50/50 on which is better, they both have pluses and minuses.

Thanks, I hadn't spoken to Paul, but I now think that this is probably=20
the better approach to take.

My earlier assumption was that we have other scenarios when we are in=20
realmode (specifically with MSR_RI unset) where we won't be able to=20
recover from a trap, during function tracing (*). I did a set of=20
experiments yesterday to verify that, but I was not able to uncover any=20
such scenarios with my brief testing. So, we seem to be functioning just=20
fine while tracing realmode C code, except for KVM.

As such, rather than blacklisting all realmode code, I think it is=20
better to be selective and just disable the tracer for KVM since we know=20
we can't take a trap there. We will be able to use the same approach if=20
we uncover additional scenarios where we can't use function tracing. I=20
will look at implementing a paca field for this purpose.

I also noticed that even with an unexpected timebase, we still seem to=20
recover just fine with a simple change:

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2629,8 +2629,8 @@ static noinline void
 rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
                    struct rb_event_info *info)
 {
-       WARN_ONCE(info->delta > (1ULL << 59),
-                 KERN_WARNING "Delta way too big! %llu ts=3D%llu write sta=
mp =3D %llu\n%s",
+       if (info->delta > (1ULL << 59))
+               pr_warn_once("Delta way too big! %llu ts=3D%llu write stamp=
 =3D %llu\n%s",
                  (unsigned long long)info->delta,
                  (unsigned long long)info->ts,
                  (unsigned long long)cpu_buffer->write_stamp,


This allowed the virtual machine to boot and we were able to trace the=20
rest of KVM C code. I only just did a boot test, so I'm not sure if=20
there are other scenarios where things can go wrong.

Steve,
Would you be willing to accept a patch like the above? Since we seem to=20
handle the larger delta just fine, I think the above change should be=20
fine?

I will still work on excluding KVM C code from being traced, but the=20
advantage with the above patch is that we will be able to trace KVM C=20
code with a small change if necessary.


- Naveen

---
(*) putting on my kprobe hat

=
