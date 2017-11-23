Return-Path: <srs0=nyc3=cv=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjHCK0jBTzDrM5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 22:29:01 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yjHCJ6qVfz8tCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 22:29:00 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yjHCJ3Sxhz9s3w
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 22:28:59 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vANBSsZp068201
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 06:28:58 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2educ81rxg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 06:28:57 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 11:18:35 -0000
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
 <CAKTCnzkSJo0wKx96=N2fxDVZ8KaM+uT3sUHGNgtdOD=RLajwCg@mail.gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 16:48:31 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnzkSJo0wKx96=N2fxDVZ8KaM+uT3sUHGNgtdOD=RLajwCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f069c870-2bdb-89a1-16d7-9eb0e589107a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2017 04:26 AM, Balbir Singh wrote:
> On Thu, Nov 23, 2017 at 4:32 AM, Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com> wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Rebooting into a new kernel with kexec fails in trace_tlbie() which is
>> called from native_hpte_clear(). This happens if the running kernel has
>> CONFIG_LOCKDEP enabled. With lockdep enabled, the tracepoints always
>> execute few RCU checks regardless of whether tracing is on or off.
>> We are already in the last phase of kexec sequence in real mode with
>> HILE_BE set. At this point the RCU check ends up in RCU_LOCKDEP_WARN and
>> causes kexec to fail.
>>
> 
> Effectively we can't enter the trace point code after we've set
> HILE_BE.  Do we need
> a fixes tag? Or is this a side-effect of a new generic change?

Yup. I missed it. Will resend the patch with fixes tag

Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")

> 
> I think the right thing in the longer run might be to do a TRACE_EVENT_CONDITION
> and have the condition do the right thing, but what you have for now is good.
> 
> Balbir Singh.
> 
