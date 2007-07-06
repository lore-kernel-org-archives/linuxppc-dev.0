Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B313DDFF0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 23:36:47 +1000 (EST)
In-Reply-To: <1183720722.3818.126.camel@johannes.berg>
References: <468D68D4.4050704@freescale.com>
	<1183720722.3818.126.camel@johannes.berg>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E7F4501-6F8F-430B-AC14-8DCDE437A2F9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Executing from readablee, no-exec pages
Date: Fri, 6 Jul 2007 15:36:36 +0200
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> As revealed by the recent "Prevent data exception in kernel space"
>> patch, versions of glibc prior to 2.4[1] assume that, on  
>> powerpc32, they
>> can execute out of any readable mapping, regardless of whether it is
>> marked for execution.  This happens in the elf_machine_load_address()
>> function.
>
> Umm, are you sure about this? The "prevent data exception in kernel
> space" patch came from a test program I had that attempted to  
> execute a
> page with /no permissions/ at all!

I haven't looked at the code path in detail, but I believe Scott's
analysis is correct.  The kernel would merrily let a program run
code from a page without execute permission (so also from a page
without any permissions at all); not anymore, after my patch.

Programs relying on this behaviour are obviously buggy, but the
problem is that one of these broken programs is glibc, at least
some not-all-that-new but also not-all-that-old versions.

> I know that I used to have problems with mono making this  
> assumption but
> these have since been fixed; however if I understand you correctly  
> then
> you can always pre-fault the page by a read and then execute it so I
> don't see the point in not doing the change you suggest.

Too many negatives, I don't see which way you're arguing :-)

I think you're saying to treat read access as including execute
access?  I believe that would be too permissive here.

Anyway, let's first decide what is the right thing to do, and
only then look at the code ;-)


Segher
