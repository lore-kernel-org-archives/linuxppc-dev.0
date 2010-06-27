Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9506CB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:47:35 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-19-git-send-email-agraf@suse.de>
	<4C270BB8.60404@redhat.com>
Message-Id: <0E529B3E-541C-4E3B-81E7-AACCD96CBF2C@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C270BB8.60404@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
Date: Sun, 27 Jun 2010 11:47:45 +0200
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


Am 27.06.2010 um 10:28 schrieb Avi Kivity <avi@redhat.com>:

> On 06/26/2010 02:25 AM, Alexander Graf wrote:
>> We will soon start and replace instructions from the text section  
>> with
>> other, paravirtualized versions. To ease the readability of those  
>> patches
>> I split out the generic looping and magic page mapping code out.
>>
>> This patch still only contains stubs. But at least it loops through  
>> the
>> text section :).
>>
>>
>> +
>> +static void kvm_check_ins(u32 *inst)
>> +{
>> +    u32 _inst = *inst;
>> +    u32 inst_no_rt = _inst&  ~KVM_MASK_RT;
>> +    u32 inst_rt = _inst&  KVM_MASK_RT;
>> +
>> +    switch (inst_no_rt) {
>> +    }
>> +
>> +    switch (_inst) {
>> +    }
>> +
>> +    flush_icache_range((ulong)inst, (ulong)inst + 4);
>> +}
>>
>
> Shouldn't we flush only if we patched something?

We introduce the patching in the next patches. This is only a  
preparation stub.

>
>> +
>> +static void kvm_use_magic_page(void)
>> +{
>> +    u32 *p;
>> +    u32 *start, *end;
>> +
>> +    /* Tell the host to map the magic page to -4096 on all CPUs */
>> +
>> +    on_each_cpu(kvm_map_magic_page, NULL, 1);
>> +
>> +    /* Now loop through all code and find instructions */
>> +
>> +    start = (void*)_stext;
>> +    end = (void*)_etext;
>> +
>> +    for (p = start; p<  end; p++)
>> +        kvm_check_ins(p);
>> +}
>> +
>>
>
> Or, flush the entire thing here.

I did that at first. It breaks. During the patching we may take  
interrupts (pahe faults for example) that contain just patched  
instructions. And really, hell breaks loose if we don't flush it  
immediately :). I was hoping at first a 32 bit replace would be atomic  
in cache, but the cpu tried to execute invalid instructions, so it  
must have gotten some intermediate state.

Alex
