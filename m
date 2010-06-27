Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id DDDE6B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 17:53:07 +1000 (EST)
Message-ID: <4C27035D.1010604@redhat.com>
Date: Sun, 27 Jun 2010 10:53:01 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] KVM: PPC: Add generic hpte management functions
References: <1277127841-32704-1-git-send-email-agraf@suse.de>	
	<4C20A64D.2070805@redhat.com> <4C20A6C8.4070002@suse.de>	
	<4C20A795.6040607@redhat.com> <4C20A836.2010908@suse.de>	
	<4C20A890.9040806@redhat.com> <4C20A91A.1080607@suse.de>	
	<4C20AA9B.8000807@redhat.com> <1277593118.4200.122.camel@pasglop>
In-Reply-To: <1277593118.4200.122.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2010 01:58 AM, Benjamin Herrenschmidt wrote:
>
>> Then mmu intensive loads can expect to be slow.
>>      
> Well, depends. ppc64 indeed requires the hash to be managed by the
> hypervisor, so inserting or invalidating translations will mean a
> roundtrip to the hypervisor, though there are ways at least the
> insertion could be alleviated (for example, the HV could service the
> hash misses directly walking the guest page tables).
>    

But the guest page tables are software defined, no?  That means the 
interface will break if the page table format changes.

> But that's due in part to a design choice (whether it's a good one or
> not I'm not going to argue here) which favors huge reasonably static
> workloads where the hash is expected to contain all translations for
> everything.
>    

What about when you have memory pressure?  The hash will have to reflect 
those pte_clear_flush_young(), no?

It seems horribly expensive.

> However, note that BookE (the embedded variant of the architecture) uses
> a different model for virtualization, including options in its latest
> variant for a HW logical->real translation (via a small dedicated TLB)
> and direct access to some TLB ops from the guest.
>    

I'm somewhat familiar with it, yes.

-- 
error compiling committee.c: too many arguments to function
