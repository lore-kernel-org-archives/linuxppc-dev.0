Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2LH51bnQzDvWm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 13:45:04 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9O2hlJs050971
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 22:45:02 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26892167ns-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 22:45:01 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 08:14:58 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id F2B4E1258026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 08:15:33 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9O2itVj44171304
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 08:14:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9O2iqJC017209
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 08:14:54 +0530
Date: Mon, 24 Oct 2016 10:44:45 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "xen-devel-request@lists.xenproject.org"
 <xen-devel-request@lists.xenproject.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "kernellwp@gmail.com" <kernellwp@gmail.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu preempted
 check
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <580D759D.4000304@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年10月21日 19:27, David Laight wrote:
> From: Pan Xinhui
>> Sent: 20 October 2016 22:28
>> Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
>> preempted" into struct kvm_steal_time. This field tells if one vcpu is
>> running or not.
>>
>> It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
>> preempted. Other values means the vcpu has been preempted.
>>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>   Documentation/virtual/kvm/msr.txt | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kvm/msr.txt
>> index 2a71c8f..3376f13 100644
>> --- a/Documentation/virtual/kvm/msr.txt
>> +++ b/Documentation/virtual/kvm/msr.txt
>> @@ -208,7 +208,8 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
>>   		__u64 steal;
>>   		__u32 version;
>>   		__u32 flags;
>> -		__u32 pad[12];
>> +		__u8  preempted;
>> +		__u32 pad[11];
>>   	}
>
> I think I'd be explicit about the 3 pad bytes you've left.
>
yes,I  will do it in next version.

thanks

> 	David
>
