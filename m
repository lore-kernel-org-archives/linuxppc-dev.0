Return-Path: <srs0=nyc3=cv=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjDld0x5dzDqpV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 20:38:21 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yjDld01pmz8vsd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 20:38:21 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yjDlc2H5mz9s71
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 20:38:19 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAN9Y3eM091530
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 04:38:17 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2edrv0mb75-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 04:38:16 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 09:38:15 -0000
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
 <1511377449.2a15exj7wg.naveen@linux.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 15:08:11 +0530
MIME-Version: 1.0
In-Reply-To: <1511377449.2a15exj7wg.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <ff1f787c-afac-96fb-423e-ba55d05c835e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2017 12:37 AM, Naveen N. Rao wrote:
> Mahesh J Salgaonkar wrote:
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
>> Fix this by not calling trace_tlbie() from native_hpte_clear().
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/mm/hash_native_64.c |   15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/hash_native_64.c
>> b/arch/powerpc/mm/hash_native_64.c
>> index 3848af1..640cf56 100644
>> --- a/arch/powerpc/mm/hash_native_64.c
>> +++ b/arch/powerpc/mm/hash_native_64.c
>> @@ -47,7 +47,8 @@
>>
>>  DEFINE_RAW_SPINLOCK(native_tlbie_lock);
>>
>> -static inline void __tlbie(unsigned long vpn, int psize, int apsize,
>> int ssize)
>> +static inline unsigned long  ___tlbie(unsigned long vpn, int psize,
>> +                        int apsize, int ssize)
>>  {
>>      unsigned long va;
>>      unsigned int penc;
>> @@ -100,7 +101,15 @@ static inline void __tlbie(unsigned long vpn, int
>> psize, int apsize, int ssize)
>>                   : "memory");
>>          break;
>>      }
>> -    trace_tlbie(0, 0, va, 0, 0, 0, 0);
> 
> Does it help if you use the _rcuidle variant instead, to turn off all
> rcu checks for tracing __tlbie()?
>     trace_tlbie_rcuidle(0, 0, va, 0, 0, 0, 0);

It helps if tracepoint is not enabled. But with tracepoint enabled kexec
still fails. I think we should not have tracepoint in kexec path at all.
If someone enables it, kexec will definitely fail regardless of
CONFIG_LOCKDEP.

Thanks,
-Mahesh.
