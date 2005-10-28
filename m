Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7028068627
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 08:39:20 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Noah yan <noah.yan@gmail.com>
In-Reply-To: <59521b110510280856y9c39f4by54cadd01830ded07@mail.gmail.com>
References: <59521b110510270605k6e098826w2d37c50e82ddd758@mail.gmail.com>
	<1130452630.29054.77.camel@gaston>
	<59521b110510280856y9c39f4by54cadd01830ded07@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 08:39:04 +1000
Message-Id: <1130539144.29054.119.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How the linux use BAT
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-10-28 at 10:56 -0500, Noah yan wrote:

>         
> I am sorry that I did make it clear. It is a little confusing for me
> between the hardware segment and the term "segment" or "section" used
> in a process's address space (AS). One of my understanding is that a
> section in a process's AS is mapped to a hardware segment, which sound
> straightforward but maybe wrong because a process binary may have lots
> of segments that are not the same size. 

No, there is no relationship. The kernel just sets up enough segments to
map the entire process address space, this is irrelevant to the actual
program sections.

> Pure segment VM is also hard to maintain memory efficiency.  Or,
> several sections, such as different data section are in segments. I
> remember in Linux x86 (posibbly 2.4), segment is not fully used in
> term of VM. The segmentation of the kernel and userland are defined
> upon booting and never changed later on. 

The segmentation mecanism on PowerPC is slightly different. We change
segments when context switching as they contain the "vsid" which acts as
a kind of context ID, thus we can keep entry for more than one
context/process in the hash table, we don't have to flush it on context
switches.

> Thanks very much!
> Noah
> 
> 
> 
>  
> 
>         The way linux uses BATs is for the kernel linear mapping.
>         Linux uses by
>         default (though that can be configued differently) a 3G/1G
>         split, that 
>         is the low 3G of address space are used by userland (and
>         covered by the
>         user page tables) and the high 1G are used by the kernel. That
>         kernel
>         space itself is split into a bottom part up to 768Mb (by
>         default, that 
>         can also be configured differently) which is the linear
>         mapping, that is
>         a single linear mapping of all RAM from 0xc0000000. The rest
>         of the
>         kernel space is mapped with page tables and known as the
>         kernel virtual 
>         space, used for vmalloc and ioremap.
>         
>         The BATs are used for the linear mapping. They "override" the
>         page
>         tables over it if any (though we usually don't bother setting
>         up PTEs
>         over the space that is BAT mapped). They basically improve
>         performances 
>         by not requiring to go through the hash trasnslation for most
>         kernel
>         accesses to memory and not using space in the TLB/ERAT.
>         
>         Ben.
>         
>         
> 
