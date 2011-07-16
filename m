Return-Path: <haishan.bai@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EABB1B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jul 2011 01:03:43 +1000 (EST)
Received: by iwg8 with SMTP id 8so1913810iwg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jul 2011 08:03:40 -0700 (PDT)
Message-ID: <4E21A841.9010005@gmail.com>
Date: Sat, 16 Jul 2011 11:03:29 -0400
From: Shan Hai <haishan.bai@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFC@saturn3.aculab.com>	
	<4E205D96.7010109@gmail.com> <1310775649.25044.5.camel@pasglop>
In-Reply-To: <1310775649.25044.5.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, David Laight <David.Laight@ACULAB.COM>,
	paulus@samba.org, tglx@linutronix.de, walken@google.com,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2011 08:20 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2011-07-15 at 11:32 -0400, Shan Hai wrote:
>> I agree with you, the problem could be triggered by accessing
>> any user space page which has kernel read only permission
>> in the page fault disabled context, the problem also affects
>> architectures which depend on SW dirty/young tracking as
>> stated by Benjamin in this thread.
>>
>> In the e500 case, the commit 6cfd8990e27d3a491c1c605d6cbc18a46ae51fef
>> removed the write permission fixup from TLB miss handlers and left it to
>> generic code, so it might be right time to fixup the write permission here
>> in the generic code.
> But we can't. The must not modify the PTE from an interrupt context and
> the "atomic" variants of user accesses can be called in such contexts.
>
> I think the problem is that we try to actually do things other than just
> "peek" at user memory (for backtraces etc...) but actually useful things
> in page fault disabled contexts. That's bad and various archs mm were
> designed with the assumption that this never happens.
>

Yes I understood, the *here* above means 'generic code' like futex code,
I am sorry for my ambiguous description.

> If the futex case is seldom here, we could probably find a way to work
> around in that specific case.
>

That's what my patch wants to do.

> However, I -still- don't understand why gup didn't fixup the write
> permission. gup doesn't set dirty ?
>

Yep, gup doesn't set dirty, because when the page fault
occurs on the kernel accessing a user page which is
read only to the kernel the following conditions hold,
- the page is present, because its a shared page
- the page is writable, because demand paging
     sets up the pte for the current  process to so

The follow_page() called in the __get_user_page()
returns non NULL to its caller on the above mentioned
present and writable page, so the gup(.write=1) has no
chance to set pte dirty by calling handle_mm_fault

Thanks
Shan Hai
s
> Cheers,
> Ben.
>
>
