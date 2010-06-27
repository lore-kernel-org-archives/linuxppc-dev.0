Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F08DB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:43:49 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-13-git-send-email-agraf@suse.de>
	<4C270AA1.5030801@redhat.com>
Message-Id: <E1AEC6DF-6F46-463C-A8F8-81AE17A89FD0@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C270AA1.5030801@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 12/26] KVM: PPC: First magic page steps
Date: Sun, 27 Jun 2010 11:44:09 +0200
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 27.06.2010 um 10:24 schrieb Avi Kivity <avi@redhat.com>:

> On 06/26/2010 02:25 AM, Alexander Graf wrote:
>> We will be introducing a method to project the shared page in guest  
>> context.
>> As soon as we're talking about this coupling, the shared page is  
>> colled magic
>> page.
>>
>> This patch introduces simple defines, so the follow-up patches are  
>> easier to
>> read.
>>
>>
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/ 
>> include/asm/kvm_host.h
>> index e35c1ac..5f8c214 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -285,6 +285,8 @@ struct kvm_vcpu_arch {
>>      u64 dec_jiffies;
>>      unsigned long pending_exceptions;
>>      struct kvm_vcpu_arch_shared *shared;
>> +    unsigned long magic_page_pa; /* phys addr to map the magic  
>> page to */
>> +    unsigned long magic_page_ea; /* effect. addr to map the magic  
>> page to */
>>
>
> Is ea like a va?  If so, can't the guest specify it by manipulating  
> the hash table (or tlb)?

ea in ppc speech is va in x86 speech. Yes, the guest could map it  
itself, but I couldn't find out how. This way I at least know what's  
happening :).


Alex
