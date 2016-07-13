Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqCZP6KmWzDqFX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:04:29 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D93kU8141654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:04:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452at63tk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:04:27 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 13 Jul 2016 10:04:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6D5EB1B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:05:33 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6D94CGD61210878
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:04:12 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6D94Av0012952
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:04:12 -0400
Subject: Re: [PATCH V3 4/5] kvm/stats: Add provisioning for 64-bit vm and vcpu
 statistics
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, christoffer.dall@linaro.org,
 marc.zyngier@arm.com, james.hogan@imgtec.com, agraf@suse.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 cornelia.huck@de.ibm.com, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
 linux-s390@vger.kernel.org
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 13 Jul 2016 11:04:08 +0200
MIME-Version: 1.0
In-Reply-To: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57860408.1000203@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2016 10:53 AM, Suraj Jitindar Singh wrote:
> vms and vcpus have statistics associated with them which can be viewed
> within the debugfs. Currently it is assumed within the vcpu_stat_get() and
> vm_stat_get() functions that all of these statistics are represented as
> u32s, however the next patch adds some u64 statistics.
> 
> Thus modify these two functions, vcpu_stat_get() and vm_stat_get(), such
> that they expect u64 statistics and update vm and vcpu statistics to u64s
> accordingly.
> 
> ---
> Change Log:
> 
> V1 -> V2:
> 	- Nothing
> V2 -> V3:
> 	- Instead of implementing separate u32 and u64 functions keep the
> 	  generic functions and modify them to expect u64s. Thus update all
> 	  vm and vcpu statistics to u64s accordingly.

Have not looked into everything, but I agree with changing everything to 64bit.


> @@ -3583,8 +3583,8 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
>  };
> 
>  static const struct file_operations *stat_fops_per_vm[] = {
> -	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
> -	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
> +	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
> +	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
>  };
unrelated white space changes?

> 
>  static int vm_stat_get(void *_offset, u64 *val)
> @@ -3628,8 +3628,8 @@ static int vcpu_stat_get(void *_offset, u64 *val)
>  DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
> 
>  static const struct file_operations *stat_fops[] = {
> -	[KVM_STAT_VCPU] = &vcpu_stat_fops,
> -	[KVM_STAT_VM]   = &vm_stat_fops,
> +	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
> +	[KVM_STAT_VM]		= &vm_stat_fops,
>  };
> 
>  static int kvm_init_debug(void)
> 
