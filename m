Return-Path: <srs0=2nzt=cv=linux.vnet.ibm.com=naveen.n.rao@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjFH74ZdqzDrJB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 21:02:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yjFH73rSHz8tD0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 21:02:11 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yjFH62MCXz9t2M
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 21:02:10 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAN9xHJZ081727
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 05:02:08 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2edtj4fgbu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 05:02:07 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 10:02:06 -0000
Date: Thu, 23 Nov 2017 15:32:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
 <1511377449.2a15exj7wg.naveen@linux.ibm.com>
 <ff1f787c-afac-96fb-423e-ba55d05c835e@linux.vnet.ibm.com>
In-Reply-To: <ff1f787c-afac-96fb-423e-ba55d05c835e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1511430895.ji4w98bqzo.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh Jagannath Salgaonkar wrote:
> On 11/23/2017 12:37 AM, Naveen N. Rao wrote:
>> Mahesh J Salgaonkar wrote:
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> Rebooting into a new kernel with kexec fails in trace_tlbie() which is
>>> called from native_hpte_clear(). This happens if the running kernel has
>>> CONFIG_LOCKDEP enabled. With lockdep enabled, the tracepoints always
>>> execute few RCU checks regardless of whether tracing is on or off.
>>> We are already in the last phase of kexec sequence in real mode with
>>> HILE_BE set. At this point the RCU check ends up in RCU_LOCKDEP_WARN an=
d
>>> causes kexec to fail.
>>>
>>> Fix this by not calling trace_tlbie() from native_hpte_clear().
>>>
>>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>> =C2=A0arch/powerpc/mm/hash_native_64.c |=C2=A0=C2=A0 15 ++++++++++++---
>>> =C2=A01 file changed, 12 insertions(+), 3 deletions(-)
>>>

[snip]

>>> @@ -100,7 +101,15 @@ static inline void __tlbie(unsigned long vpn,=20
>>> int
>>> psize, int apsize, int ssize)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "memory");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 trace_tlbie(0, 0, va, 0, 0, 0, 0);
>>=20
>> Does it help if you use the _rcuidle variant instead, to turn off all
>> rcu checks for tracing __tlbie()?
>> =C2=A0=C2=A0=C2=A0=C2=A0trace_tlbie_rcuidle(0, 0, va, 0, 0, 0, 0);
>=20
> It helps if tracepoint is not enabled. But with tracepoint enabled kexec
> still fails. I think we should not have tracepoint in kexec path at all.
> If someone enables it, kexec will definitely fail regardless of
> CONFIG_LOCKDEP.

Ok, thanks for confirming that other tracepoints don't interfere with=20
kexec. As Balbir points out, moving to TRACE_EVENT_CONDITION() with a=20
global in_kexec variable may be the other option, but is probably=20
overkill for a single tracepoint.

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Thanks,
Naveen

=
