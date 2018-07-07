Return-Path: <rdunlap@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Mzrs2MwwzDqv6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 14:58:51 +1000 (AEST)
Subject: Re: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
 <a3c9b9ee9ec116390c47dca65fcf14f138eccd3f.camel@kernel.crashing.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4f3a5969-88d5-134d-508d-7617947c588c@infradead.org>
Date: Fri, 6 Jul 2018 21:58:29 -0700
MIME-Version: 1.0
In-Reply-To: <a3c9b9ee9ec116390c47dca65fcf14f138eccd3f.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2018 06:45 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2018-07-05 at 14:30 -0700, Randy Dunlap wrote:
>> Hi,
>>
>> Is there a good way (or a shortcut) to do something like:
>>
>> $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
>>   to get a PPC32/32BIT allmodconfig
>>
>> and also be able to do:
>>
>> $make ARCH=powerpc O=PPC64 [other_options] allmodconfig
>>   to get a PPC64/64BIT allmodconfig?
> 
> Hrm... O= is for the separate build dir, so there much be something
> else.
> 
> You mean having ARCH= aliases like ppc/ppc32 and ppc64 ?

Yes.

> That would be a matter of overriding some .config defaults I suppose, I
> don't know how this is done on other archs.
> 
> I see the aliasing trick in the Makefile but that's about it.
> 
>> Note that arch/x86, arch/sh, and arch/sparc have ways to do
>> some flavor(s) of this (from Documentation/kbuild/kbuild.txt;
>> sh and sparc based on a recent "fix" patch from me):
> 
> I fail to see what you are actually talking about here ... sorry. Do
> you have concrete examples on x86 or sparc ? From what I can tell the
> "i386" or "sparc32/sparc64" aliases just change SRCARCH in Makefile and
> 32 vs 64-bit is just a Kconfig option...

Yes, your summary is mostly correct.

I'm just looking for a way to do cross-compile builds that are close to
ppc32 allmodconfig and ppc64 allmodconfig.


>> x86: i386 for 32 bit, x86_64 for 64 bit
>> sh: sh for 32 bit, sh64 for 64 bit
>> sparc: sparc32 for 32 bit, sparc64 for 64 bit

I saw the powerpc merge-config targets after I sent this original email.
I can do my own homebrew that I prefer over those, though.


thanks,
-- 
~Randy
