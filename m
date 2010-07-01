Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55909B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:00:48 +1000 (EST)
Message-ID: <4C2C6745.8040001@suse.de>
Date: Thu, 01 Jul 2010 12:00:37 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
	<7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
	<4C2C547E.7010404@redhat.com>
In-Reply-To: <4C2C547E.7010404@redhat.com>
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
> On 07/01/2010 11:18 AM, Alexander Graf wrote:
>>
>> How does dirty bitmap flushing work on x86 atm? I loop through all
>> mapped pages and flush the ones that match the range of the region I
>> need to flush. But wouldn't it be a lot more efficient to have an
>> hlist in the memslot and loop through that when I need to flush that
>> memslot?
>>    
>
> x86 loops through the reverse-map link list rooted at the memory
> slot.  The linked list links all sptes for a single hva.
>
> So, it's like you describe, except it's an array of lists instead of a
> single list.  We need per-page rmap lists to be able to remove a
> page's sptes in response to an mmu notifier callback, and to be able
> to write protect a guest page if it's used as a page table.
>

But doesn't that mean that you still need to loop through all the hvas
that you want to invalidate? Wouldn't it speed up dirty bitmap flushing
a lot if we'd just have a simple linked list of all sPTEs belonging to
that memslot?

Alex
