Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqRTc3gdbzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 04:01:08 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DHxu2Y108082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:01:05 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0a-001b2d01.pphosted.com with ESMTP id 245hgaw8yy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:01:02 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 13 Jul 2016 19:01:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4F3172190046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:00:27 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DI0wbQ15270378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 18:00:59 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DI0whl002993
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 12:00:58 -0600
Subject: Re: [PATCH V2 4/5] kvm/stats: Add provisioning for 64-bit vcpu
 statistics
To: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-4-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=e=hScxto3c=4rJ88Phg989UZhk+O44rV56obFP3v1SFg@mail.gmail.com>
 <9253603f-fbfb-09f1-9576-9291d1587397@redhat.com>
 <CALzav=cueDab=SQ0WmL6JcAY-18SLvcaVF9Zc1Ezs_f-eP7HOA@mail.gmail.com>
 <353f05d6-74a2-69c0-978d-7c3df6b33755@redhat.com>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 kvm list <kvm@vger.kernel.org>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 13 Jul 2016 20:00:54 +0200
MIME-Version: 1.0
In-Reply-To: <353f05d6-74a2-69c0-978d-7c3df6b33755@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <578681D6.8070801@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2016 09:31 PM, Paolo Bonzini wrote:
> 
> 
> On 11/07/2016 19:30, David Matlack wrote:
>> On Mon, Jul 11, 2016 at 10:05 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>>
>>> On 11/07/2016 18:51, David Matlack wrote:
>>>>>> vcpus have statistics associated with them which can be viewed within the
>>>>>> debugfs. Currently it is assumed within the vcpu_stat_get() and
>>>>>> vcpu_stat_get_per_vm() functions that all of these statistics are
>>>>>> represented as 32-bit numbers. The next patch adds some 64-bit statistics,
>>>>>> so add provisioning for the display of 64-bit vcpu statistics.
>>>> Thanks, we need 64-bit stats in other places as well. Can we use this
>>>> opportunity to wholesale upgrade all KVM stats from u32 to u64? Most
>>>> of this patch is duplicated code with "u32" swapped with "u64".
>>>>
>>>
>>> I'm not sure of what 32-bit architectures would do, but perhaps we could
>>> upgrade them to unsigned long at least.
>>
>> I thought u64 still existed on 32-bit architectures. unsigned long
>> would be fine but with the caveat that certain stats would overflow on
>> 32-bit architectures.
> 
> Yes, but not all 32-bit architectures can do atomic read-modify-write
> (e.g. add) operations on 64-bit values.

So what about only doing it for the VCPU events? Those should be only
modified by one CPU. We would have some odd values on 32bit overflow, but
this will be certainly better than just start with 0
