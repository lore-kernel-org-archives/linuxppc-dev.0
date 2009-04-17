Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 874DBDDF81
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 23:25:28 +1000 (EST)
Message-Id: <087C29B1-39CA-4A32-81E6-533FAD21A2BC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1239964860.7443.65.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: issues w/init
Date: Fri, 17 Apr 2009 08:23:17 -0500
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
	<49E78620.7070303@freescale.com>
	<C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
	<1239953907.7443.45.camel@pasglop>
	<18920.21593.737132.732053@cargo.ozlabs.ibm.com>
	<1239964860.7443.65.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2009, at 5:41 AM, Benjamin Herrenschmidt wrote:

> On Fri, 2009-04-17 at 20:05 +1000, Paul Mackerras wrote:
>> Benjamin Herrenschmidt writes:
>>
>>> I'm pretty sure they are broken already when running off a 64-bit
>>> kernel,
>>
>> Maybe not... for 64-bit kernels we have our definition of
>> elf_read_implies_exec in arch/powerpc/include/asm/elf.h, which IIRC
>> sets the read-implies-exec personality thing on old 32-bit binaries.
>
> Ok, so looking at that more closely, if that had worked, we would
> have had PROT_EXEC, and thus VM_EXEC added to the vma by mmap... which
> apparently didn't occur.
>
> I think what may be happening is that the binary he's running has the
> PT_GNU_STACK but his libc doesn't ... the kernel will set the
> personality flag based on the binary you are trying to run, not any
> library it uses...
>
> Kumar, can you try to instrument that a bit and tell us ? What the
> personality flag gets set to and whether mmap sets PROT_EXEC ?

I can and might have already done this, need to double check.  But  
what I was seeing from elf_map is that we don't get PROT_EXEC set for  
this PHDR, but get VM_MAY_EXEC.  I'm not clear on what VM_MAY_EXEC is  
intended for.

- k
