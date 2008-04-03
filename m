Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8FEEDDECA
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 17:47:36 +1100 (EST)
Message-Id: <C91EF39E-9776-4D7C-883E-F560A671E221@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18420.31327.633359.619200@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
Date: Thu, 3 Apr 2008 01:47:31 -0500
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
	<5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
	<18418.55835.338209.611273@cargo.ozlabs.ibm.com>
	<0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
	<18420.31327.633359.619200@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2008, at 1:34 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>>> For a kdump kernel, at least for 64-bit, the physical address has to
>>> be 32MB.  There is no other choice, so there is no possibility of
>>> confusion.
>>
>> But how do you know a vmlinux image is for kdump or not?
>
> By looking at the ELF headers -- either the first PT_LOAD segment or
> the .text section -- and seeing whether the start address is
> 0xc000000002000000 or not.

fair point.

>>> For 85xx, would it be possible to have the kernel figure out what
>>> physical address it has been loaded at, and use that as the base
>>> address, rather than having the base address set at compile time?
>>
>> Yes, that is what CONFIG_RELOCATABLE is all about.
>
> Is there any reason to have that as an option, rather than just always
> doing that?

Concerned about runtime performance of __va() and __pa().

>>> That would solve my objection since it would mean that there would  
>>> no
>>> longer be two things that had to be kept in sync.  You could pass  
>>> any
>>> value to wrapper/mkimage (subject to constraints such as it has to  
>>> be
>>> a multiple of 256M) and it would work.  That value could even come
>>> from a config option in the case where wrapper is invoked as part of
>>> the kernel build, but that config option shouldn't affect anything  
>>> at
>>> all in the vmlinux.
>>
>> Ok, but I still think the issues exists when we config PHYSICAL_START
>> to non-zero and CONFIG_RELOCATABLE=n.  Ideally we get set the phys
>> address the PHDR, but I'm not sure how to get the linker to do that.
>
> If we can do that then the wrapper script can dig it out and pass it
> to mkimage, which would solve the problem.

Ok, so on Segher's recommendation I looked at 'AT' and posted a patch  
that uses that so now regardless of the kernel the PT_LOAD PHDR will  
have the physical address set properly.

So now we can look at the vmlinux and determine the physical offset.   
The question is how best to do that.  Here are the options I see:
* readelf, grep and parse output
* objdump grep and parse output
* simple C program that read's the elf and reports back

[looking for suggestion on what direction you want to take]

The other questions is if we'd ever have a vmlinux with more than one  
PT_LOAD PHDR.  If so which one do we use (the one with the lowest  
physical address)?

- k
