Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28CE9B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 23:32:58 +1000 (EST)
Message-ID: <4C28A485.1050403@suse.de>
Date: Mon, 28 Jun 2010 15:32:53 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
	<4C285D1C.5060508@redhat.com>
	<20417D40-9345-485B-9201-8B3722B7457F@suse.de>
	<4C286770.6010204@redhat.com>
	<1A0E0E54-D055-4333-B5EC-DE2F71382AB7@suse.de>
	<4C286C98.8060903@redhat.com> <4C2871A8.1060706@suse.de>
	<4C2872F5.20501@redhat.com> <4C28A2C1.50700@suse.de>
	<4C28A409.9090207@redhat.com>
In-Reply-To: <4C28A409.9090207@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Avi Kivity wrote:
> On 06/28/2010 04:25 PM, Alexander Graf wrote:
>>>
>>>>> Less and simpler code, better reporting through slabtop, less wastage
>>>>> of partially allocated slab pages.
>>>>>
>>>>>          
>>>> But it also means that one VM can spill the global slab cache and kill
>>>> another VM's mm performance, no?
>>>>
>>>>        
>>> What do you mean by spill?
>>>      
>
>
> Well?

I was thinking of a global capping, but I guess I could still do it
per-vcpu. So yes, doing a global slab doesn't hurt.

>
>>> btw, in the midst of the nit-picking frenzy I forgot to ask how the
>>> individual hash chain lengths as well as the per-vm allocation were
>>> limited.
>>>
>>> On x86 we have a per-vm limit and we allow the mm shrinker to reduce
>>> shadow mmu data structures dynamically.
>>>
>>>      
>> Very simple. I keep an int with the number of allocated entries around
>> and if that hits a define'd threshold, I flush all shadow pages.
>>    
>
> A truly nefarious guest will make all ptes hash to the same chain,
> making some operations very long (O(n^2) in the x86 mmu, don't know
> about ppc) under a spinlock.  So we had to limit hash chains, not just
> the number of entries.
>
> But your mmu is per-cpu, no?  In that case, no spinlock, and any
> damage the guest does is limited to itself.

Yes, it is. No locking. The vcpu can kill its own performance, but I
don't care about that.


Alex
