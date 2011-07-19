Return-Path: <haishan.bai@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D52DB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:42:58 +1000 (EST)
Received: by qyk9 with SMTP id 9so2368443qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:42:55 -0700 (PDT)
Message-ID: <4E25442F.4080609@gmail.com>
Date: Tue, 19 Jul 2011 16:45:35 +0800
From: Shan Hai <haishan.bai@gmail.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW trackingof
	dirty & young
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFF@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ADFF@saturn3.aculab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Peter Zijlstra <peterz@infradead.org>,
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

On 07/19/2011 04:26 PM, David Laight wrote:
>
>> Got it, if the fault_in_user_writeable() is designed to catch the
>> exact same write permission fault problem we discuss here, so
>> your patch fixed that very nicely, we should fixup it by directly
>> calling handle_mm_fault like what you did because we are for sure
>> to know what just happened(permission violation), its not necessary
>> to check what's happened by calling gup-->follow_page, and
>> further the follow_page failed to report the fault :-)
> One thought I've had - and I don't know enough about the data
> area in use to know if it is a problem - is what happens if
> a different cpu faults on the same user page and has already
> marked it 'valid' between the fault happening and the fault
> handler looking at the page tables to find out why.
> If any of the memory areas are shared, it might be that the
> PTE (etc) might already show the page a writable by the
> time the fault handler is looking at them - this might confuse it!
>

There is no problem at all if you mean *valid* by page present
and writable, because when the fault_in_user_writeable()
is called, the pte to the shared page was already setup by
demand paging and pte.present and pte.write was set, and the
reason why the fault was taken is that because of violation of
permission on present and writable user page occurred on sw
dirty/young tracking architectures.

Thanks
Shan Hai

> 	David
>
>
