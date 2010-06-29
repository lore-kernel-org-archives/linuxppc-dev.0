Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A51DDB6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 23:06:25 +1000 (EST)
Message-ID: <4C29EFCC.3030303@suse.de>
Date: Tue, 29 Jun 2010 15:06:20 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
	<4C285D1C.5060508@redhat.com>
	<20417D40-9345-485B-9201-8B3722B7457F@suse.de>
	<4C286770.6010204@redhat.com> <4C29ED94.6060904@suse.de>
	<4C29EF8A.4070508@redhat.com>
In-Reply-To: <4C29EF8A.4070508@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity wrote:
> On 06/29/2010 03:56 PM, Alexander Graf wrote:
>> Avi Kivity wrote:
>>   
>>> On 06/28/2010 11:55 AM, Alexander Graf wrote:
>>>     
>>>>       
>>>>>> +
>>>>>> +static inline u64 kvmppc_mmu_hash_pte(u64 eaddr) {
>>>>>> +    return hash_64(eaddr>>    PTE_SIZE, HPTEG_HASH_BITS_PTE);
>>>>>> +}
>>>>>> +
>>>>>> +static inline u64 kvmppc_mmu_hash_vpte(u64 vpage) {
>>>>>> +    return hash_64(vpage&    0xfffffffffULL, HPTEG_HASH_BITS_VPTE);
>>>>>> +}
>>>>>> +
>>>>>> +static inline u64 kvmppc_mmu_hash_vpte_long(u64 vpage) {
>>>>>> +    return hash_64((vpage&    0xffffff000ULL)>>    12,
>>>>>> +               HPTEG_HASH_BITS_VPTE_LONG);
>>>>>> +}
>>>>>>
>>>>>>
>>>>>>            
>>>>> Still with the wierd coding style?
>>>>>
>>>>>          
>>>> Not sure what's going on there. My editor displays it normally. Weird.
>>>>
>>>>        
>>> Try hitting 'save'.
>>>      
>> hexdump -C on the respective section in the exact patch file I submitted
>> above shows:
>>
>> 00000a80  75 72 6e 20 68 61 73 68  5f 36 34 28 65 61 64 64  |urn
>> hash_64(eadd|
>> 00000a90  72 20 3e 3e 20 50 54 45  5f 53 49 5a 45 2c 20 48  |r>>
>> PTE_SIZE, H|
>>
>>
>> Maybe your mail client breaks it?
>>    
>
> The list archives too:
>
>   http://www.mail-archive.com/kvm@vger.kernel.org/msg37093.html
>
> Looks like a cache coherency bug.  What processor are you using?

Are we looking at the same link? Looks good to me there.

Alex
