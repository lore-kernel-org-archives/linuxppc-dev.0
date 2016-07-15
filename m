Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrPql4yy0zDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 17:50:11 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id q2so5740364pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 00:50:11 -0700 (PDT)
Subject: Re: [PATCH V3 4/5] kvm/stats: Add provisioning for 64-bit vm and vcpu
 statistics
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
 <57860408.1000203@de.ibm.com>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, christoffer.dall@linaro.org,
 marc.zyngier@arm.com, james.hogan@imgtec.com, agraf@suse.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 cornelia.huck@de.ibm.com, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
 linux-s390@vger.kernel.org
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <578895A7.5060001@gmail.com>
Date: Fri, 15 Jul 2016 17:49:59 +1000
MIME-Version: 1.0
In-Reply-To: <57860408.1000203@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/07/16 19:04, Christian Borntraeger wrote:
> On 07/13/2016 10:53 AM, Suraj Jitindar Singh wrote:
>> vms and vcpus have statistics associated with them which can be viewed
>> within the debugfs. Currently it is assumed within the vcpu_stat_get() and
>> vm_stat_get() functions that all of these statistics are represented as
>> u32s, however the next patch adds some u64 statistics.
>>
>> Thus modify these two functions, vcpu_stat_get() and vm_stat_get(), such
>> that they expect u64 statistics and update vm and vcpu statistics to u64s
>> accordingly.
>>
>> ---
>> Change Log:
>>
>> V1 -> V2:
>> 	- Nothing
>> V2 -> V3:
>> 	- Instead of implementing separate u32 and u64 functions keep the
>> 	  generic functions and modify them to expect u64s. Thus update all
>> 	  vm and vcpu statistics to u64s accordingly.
> Have not looked into everything, but I agree with changing everything to 64bit.
>
>
>> @@ -3583,8 +3583,8 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
>>  };
>>
>>  static const struct file_operations *stat_fops_per_vm[] = {
>> -	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
>> -	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
>> +	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
>> +	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
>>  };
> unrelated white space changes?

Woops, I'll fix that. Thanks

>
>>  static int vm_stat_get(void *_offset, u64 *val)
>> @@ -3628,8 +3628,8 @@ static int vcpu_stat_get(void *_offset, u64 *val)
>>  DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
>>
>>  static const struct file_operations *stat_fops[] = {
>> -	[KVM_STAT_VCPU] = &vcpu_stat_fops,
>> -	[KVM_STAT_VM]   = &vm_stat_fops,
>> +	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
>> +	[KVM_STAT_VM]		= &vm_stat_fops,
>>  };
>>
>>  static int kvm_init_debug(void)
>>
