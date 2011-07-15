Return-Path: <haishan.bai@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44C49B6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jul 2011 01:32:53 +1000 (EST)
Received: by iwg8 with SMTP id 8so1236537iwg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 08:32:50 -0700 (PDT)
Message-ID: <4E205D96.7010109@gmail.com>
Date: Fri, 15 Jul 2011 11:32:38 -0400
From: Shan Hai <haishan.bai@gmail.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2011 06:32 AM, David Laight wrote:
>
>> The fault causing futex_atomic_cmpxchg_inatomic() is
>> protected by pagefault_disable(), so the page fault handler has
>> no chance to toggle the SW dirty/young tracking.
> Perhaps that is the bug!
> Whatever pagefault_disable() does, it shouldn't disable the
> SW dirty/young tracking - which should only needs bits moving
> in the page table itself (and TLB update??) rather than any
> operations on the rest of the data areas.
>
> It looks to me as though this could happen any time a page
> is marked inaccessible by the dirty/young tracking.
> Not just as a result of COW.
>

I agree with you, the problem could be triggered by accessing
any user space page which has kernel read only permission
in the page fault disabled context, the problem also affects
architectures which depend on SW dirty/young tracking as
stated by Benjamin in this thread.

In the e500 case, the commit 6cfd8990e27d3a491c1c605d6cbc18a46ae51fef
removed the write permission fixup from TLB miss handlers and left it to
generic code, so it might be right time to fixup the write permission here
in the generic code.


Thanks
Shan Hai

> 	David
>
>
