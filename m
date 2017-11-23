Return-Path: <srs0=2nzt=cv=linux.vnet.ibm.com=naveen.n.rao@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjKVC2Y1lzDqwG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 00:12:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yjKVC1bBLz8t1T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 00:12:03 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yjKVB5jbBz9sPm
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2017 00:12:02 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vANDBnSi009602
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 08:12:00 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2edue9ngvg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 08:11:57 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 13:11:54 -0000
Date: Thu, 23 Nov 2017 18:41:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
To: Balbir Singh <bsingharora@gmail.com>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
 <CAKTCnzkSJo0wKx96=N2fxDVZ8KaM+uT3sUHGNgtdOD=RLajwCg@mail.gmail.com>
 <8737552nta.fsf@concordia.ellerman.id.au>
In-Reply-To: <8737552nta.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1511442295.rqmndvaowx.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>=20
>> On Thu, Nov 23, 2017 at 4:32 AM, Mahesh J Salgaonkar
>> <mahesh@linux.vnet.ibm.com> wrote:
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
>>
>> Effectively we can't enter the trace point code after we've set
>> HILE_BE.  Do we need
>> a fixes tag? Or is this a side-effect of a new generic change?
>=20
> Yes I added:
>=20
> Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
> Cc: stable@vger.kernel.org # v4.13+
>=20
>> I think the right thing in the longer run might be to do a TRACE_EVENT_C=
ONDITION
>> and have the condition do the right thing, but what you have for now is =
good.
>=20
> No I think the right thing is to not call trace points from kexec code,
> it's too fragile. TRACE_EVENT_CONDITION wouldn't have saved us from this
> RCU breakage.

I agree on the fragile part, though it appears to me that a=20
TRACE_EVENT_CONDITION() with a check for is_kexec (that needs to be=20
added) will prevent breakage since both the LOCKDEP block as well as the=20
tracepoint itself are guarded by the condition. So, none of the rcu code=20
should be executed as long as we set is_kexec at the right time. =20
However, since there are all of 1 tracepoint(s) affecting kexec, it is=20
probably not worth the effort at the moment.

- Naveen

=
