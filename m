Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6BDE1A0B6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 23:29:02 +1100 (AEDT)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0087A140B0E
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Jan 2016 23:29:01 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Sat, 23 Jan 2016 05:29:00 -0700
Message-ID: <56A37200.3030402@linux.vnet.ibm.com>
Date: Sat, 23 Jan 2016 17:58:48 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@ozlabs.org>
CC: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 kvm@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 1/2] KVM: PPC: New capability to control MCE behaviour
References: <20160113070759.20248.86252.stgit@aravindap>
 <20160123102013.GA11916@fergus.ozlabs.ibm.com>
In-Reply-To: <20160123102013.GA11916@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Saturday 23 January 2016 03:50 PM, Paul Mackerras wrote:
> On Wed, Jan 13, 2016 at 12:37:59PM +0530, Aravinda Prasad wrote:
>> This patch introduces a new KVM capability to control
>> how KVM behaves on machine check exception (MCE).
>> Without this capability, KVM redirects machine check
>> exceptions to guest's 0x200 vector if the address in
>> error belongs to the guest. With this capability KVM
>> causes a guest exit with NMI exit reason.
>>
>> This is required to avoid problems if a new kernel/KVM
>> is used with an old QEMU for guests that don't issue
>> "ibm,nmi-register". As old QEMU does not understand the
>> NMI exit type, it treats it as a fatal error. However,
>> the guest could have handled the machine check error
>> if the exception was delivered to guest's 0x200 interrupt
>> vector instead of NMI exit in case of old QEMU.
> 
> [snip]
> 
>> @@ -1132,6 +1135,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>>  		break;
>>  	}
>>  #endif /* CONFIG_KVM_XICS */
>> +	case KVM_CAP_PPC_FWNMI:
>> +		r = 0;
>> +		vcpu->kvm->arch.fwnmi_enabled = true;
>> +		break;
> 
> Might we ever want to set this flag back to false after setting it to
> true?  If so perhaps we should do vcpu->kvm->arch.fwnmi_enabled =
> !!cap->args[0].  However, I admit I can't actually think of a
> situation where we would need to reset it. :)

Even I am not able to think of any situation where resetting is required.

Regards,
Aravinda

> 
> Paul.
> 

-- 
Regards,
Aravinda
