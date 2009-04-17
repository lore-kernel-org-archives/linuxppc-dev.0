Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 763FFDE08A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:42:56 +1000 (EST)
Message-Id: <1599F61A-ADDE-4846-B3A9-263918995618@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1239987791.7210.15.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: issues w/init
Date: Fri, 17 Apr 2009 12:40:47 -0500
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
	<49E78620.7070303@freescale.com>
	<C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
	<1239953907.7443.45.camel@pasglop>
	<18920.21593.737132.732053@cargo.ozlabs.ibm.com>
	<1239964860.7443.65.camel@pasglop>
	<087C29B1-39CA-4A32-81E6-533FAD21A2BC@kernel.crashing.org>
	<1239987791.7210.15.camel@pasglop>
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


On Apr 17, 2009, at 12:03 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2009-04-17 at 08:23 -0500, Kumar Gala wrote:
>> I can and might have already done this, need to double check.  But
>> what I was seeing from elf_map is that we don't get PROT_EXEC set for
>> this PHDR, but get VM_MAY_EXEC.  I'm not clear on what VM_MAY_EXEC is
>> intended for.
>
> Looking at a 2.6.29 tree here, I don't see any reference to  
> VM_MAY_EXEC
> but I see a VM_MAYEXEC :-) Though it shouldn't be relevant here.
>
> What I see, and what should be checked is:
>
> 1- In binfmt_elf.c, what happens with this statement ?
>
>        if (elf_read_implies_exec(loc->elf_ex, executable_stack))
>                current->personality |= READ_IMPLIES_EXEC;

on ppc32 noting as its elf_read_implies_exec is not implemented.

> (ie. is the personality flag set ?)
>
> 2- When the phdr's are mmap'ed, do you hit this:
>
>        if ((prot & PROT_READ) && (current->personality &  
> READ_IMPLIES_EXEC))
>                if (!(file && (file->f_path.mnt->mnt_flags &  
> MNT_NOEXEC)))
>                        prot |= PROT_EXEC;
>
> (Which should later be turned into VM_EXEC by calc_vm_prot_bits().
>
> If any of these isn't happening, then we need to figure out why.

As I said before current->personality = 0 in ppc32 in the setup I've  
got. (because we don't have elf_read_implies_exec defined).  I can  
define it and doing so makes this all work properly.  I'm just  
questioning if defining elf_read_implies_exec for ppc32 is actually  
the right answer or not.

- k
