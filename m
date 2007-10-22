Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F504DDE3F
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 16:01:55 +1000 (EST)
Subject: Re: ppc manual paging question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
In-Reply-To: <200710221350.31688.wangbj@lzu.edu.cn>
References: <200710221203.24157.wangbj@lzu.edu.cn>
	<393029235.18964@lzu.edu.cn>  <200710221350.31688.wangbj@lzu.edu.cn>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 16:01:33 +1000
Message-Id: <1193032893.6745.60.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rtlinuxgpl@upv.es,
	Miguel Masmano <mimastel@doctor.upv.es>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm porting an adeos nano kernel named xtratum (http://www.xtratum.org) from 
> x86 to ppc, I think I'm near the ending except the above problem. xtratum is 
> doing things like xen but it's much simpler (it's aimed for realtime), it 
> need provides memory space sperations for it's domains, so I need manually 
> paging. Each domain is loaded by a userspace program (instead of the root 
> domain as a kernel module), the loader will load the domain's (ELF staticly 
> excutable) PT_LOAD section into memory, and then raise a properly system call 
> (passing the structurized loaded data as arguments) to load the domain via 
> load_domain_sys(), and at the last step of loading the domain, xtratum will 
> jump to the entry code of the new domain(asm wrappered start() routine) and 
> then everything should be fine. The problem now is as follow:
> 
> under my ppc (440GR/440EP) platform, start() is always at 0x100000a0, but I 
> guess there is something wrong with my mm code so after the domain is loaded, 
> the virt addres 0x100000a0 just point to garbage instead of the right start() 
> routine. So how can I setup paging properly so that the virtual memory could 
> be translated to proper data?

Are you aware that the 440 MMU doesn't actually know what a page table
is and doesn't load PTEs from memory ?

It's a software loaded TLB, you'll have to put translations in the TLB
yourself. You'll need to design your own data structures for that, tho
you can use a page table for tracking, like we do in linux, and then
have your own TLB miss handler to fill the TLB from that.

Your initial code probably need to bolt a TLB entry for the kernel
itself.

Ben.
