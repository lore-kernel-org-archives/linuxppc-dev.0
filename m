Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DD0FDDF44
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 00:14:32 +1100 (EST)
Message-Id: <0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18418.55835.338209.611273@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
Date: Wed, 2 Apr 2008 08:14:26 -0500
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
	<5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
	<18418.55835.338209.611273@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 1, 2008, at 7:58 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> Hmm, need to think about that.  But my initial reaction is two fold.
>> One I don't think this information would be around and two don't we
>> already have this problem with a kdump kernel?
>
> I'm just concerned that we have two things that have to match up - the
> compiled-in physical address that the kernel assumes it is running at,
> and the physical address where it is actually loaded.  While those two
> things were both always 0 for embedded processors, there wasn't a
> problem, but now we can have a situation where a kernel binary has to
> be loaded at some nonzero address to work correctly, but there is no
> way to work out what that address is for an existing vmlinux binary.
> Or have I missed something?

Nope, that sums up the situation pretty well.

> For a kdump kernel, at least for 64-bit, the physical address has to
> be 32MB.  There is no other choice, so there is no possibility of
> confusion.

But how do you know a vmlinux image is for kdump or not?

> For 85xx, would it be possible to have the kernel figure out what
> physical address it has been loaded at, and use that as the base
> address, rather than having the base address set at compile time?

Yes, that is what CONFIG_RELOCATABLE is all about.

> That would solve my objection since it would mean that there would no
> longer be two things that had to be kept in sync.  You could pass any
> value to wrapper/mkimage (subject to constraints such as it has to be
> a multiple of 256M) and it would work.  That value could even come
> from a config option in the case where wrapper is invoked as part of
> the kernel build, but that config option shouldn't affect anything at
> all in the vmlinux.

Ok, but I still think the issues exists when we config PHYSICAL_START  
to non-zero and CONFIG_RELOCATABLE=n.  Ideally we get set the phys  
address the PHDR, but I'm not sure how to get the linker to do that.

- k
