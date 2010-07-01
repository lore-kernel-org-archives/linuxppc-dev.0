Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 436CEB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 18:40:34 +1000 (EST)
Message-ID: <4C2C547E.7010404@redhat.com>
Date: Thu, 01 Jul 2010 11:40:30 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
	<7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
In-Reply-To: <7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
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

On 07/01/2010 11:18 AM, Alexander Graf wrote:
>
> How does dirty bitmap flushing work on x86 atm? I loop through all mapped pages and flush the ones that match the range of the region I need to flush. But wouldn't it be a lot more efficient to have an hlist in the memslot and loop through that when I need to flush that memslot?
>    

x86 loops through the reverse-map link list rooted at the memory slot.  
The linked list links all sptes for a single hva.

So, it's like you describe, except it's an array of lists instead of a 
single list.  We need per-page rmap lists to be able to remove a page's 
sptes in response to an mmu notifier callback, and to be able to write 
protect a guest page if it's used as a page table.

-- 
error compiling committee.c: too many arguments to function
