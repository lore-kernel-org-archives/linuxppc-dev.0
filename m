Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 4E3181007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 21:14:56 +1000 (EST)
Message-ID: <4C2C78AC.3070605@redhat.com>
Date: Thu, 01 Jul 2010 14:14:52 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
	<7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
	<4C2C547E.7010404@redhat.com> <4C2C6745.8040001@suse.de>
In-Reply-To: <4C2C6745.8040001@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 07/01/2010 01:00 PM, Alexander Graf wrote:
>
> But doesn't that mean that you still need to loop through all the hvas
> that you want to invalidate?

It does.

>   Wouldn't it speed up dirty bitmap flushing
> a lot if we'd just have a simple linked list of all sPTEs belonging to
> that memslot?
>    

The complexity is O(pages_in_slot) + O(sptes_for_slot).

Usually, every page is mapped at least once, so sptes_for_slot 
dominates.  Even when it isn't so, iterating the rmap base pointers is 
very fast since they are linear in memory, while sptes are scattered 
around, causing cache misses.

Another consideration is that on x86, an spte occupies just 64 bits (for 
the hardware pte); if there are multiple sptes per page (rare on modern 
hardware), there is also extra memory for rmap chains; sometimes we also 
allocate 64 bits for the gfn.  Having an extra linked list would require 
more memory to be allocated and maintained.

-- 
error compiling committee.c: too many arguments to function
