Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id B4608B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 22:10:33 +1000 (EST)
Message-ID: <4C20A836.2010908@suse.de>
Date: Tue, 22 Jun 2010 14:10:30 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 1/2] KVM: PPC: Add generic hpte management functions
References: <1277127841-32704-1-git-send-email-agraf@suse.de>
	<4C20A64D.2070805@redhat.com> <4C20A6C8.4070002@suse.de>
	<4C20A795.6040607@redhat.com>
In-Reply-To: <4C20A795.6040607@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity wrote:
> On 06/22/2010 03:04 PM, Alexander Graf wrote:
>> Avi Kivity wrote:
>>   
>>> On 06/21/2010 04:44 PM, Alexander Graf wrote:
>>>     
>>>> Currently the shadow paging code keeps an array of entries it knows
>>>> about.
>>>> Whenever the guest invalidates an entry, we loop through that entry,
>>>> trying to invalidate matching parts.
>>>>
>>>> While this is a really simple implementation, it is probably the most
>>>> ineffective one possible. So instead, let's keep an array of lists
>>>> around
>>>> that are indexed by a hash. This way each PTE can be added by 4
>>>> list_add,
>>>> removed by 4 list_del invocations and the search only needs to loop
>>>> through
>>>> entries that share the same hash.
>>>>
>>>> This patch implements said lookup and exports generic functions that
>>>> both
>>>> the 32-bit and 64-bit backend can use.
>>>>
>>>>        
>>> Mind explaining the all list in there?
>>>      
>> The all list is used to flush all entries when we need to get rid of all
>> entries, for example when we write a BAT.
>>
>>    
>
> Yes, I more or less gathered that when I saw patch 2.  Does it make
> sense to avoid it by looping over all vpte lists in the vpte hash? 
> More effort for a full flush, esp. when the mmu is sparse, but less
> for individual pte operations.

Hrm. We could probably make the vpte_long list shorter. Currently all
lists are 1 << 13 entries wide. So we have 8192 lists to loop through.
For vpte_long 1 << 8 = 256 is probably enough. With that it would
probably make sense, yes.

If you have more performance hints, I'll gladly take them :).


Alex
