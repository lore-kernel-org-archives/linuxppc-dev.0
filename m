Return-Path: <root@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id 7EFDBDDE41
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 14:40:11 +1000 (EST)
Date: Mon, 22 Oct 2007 06:40:08 +0200 (CEST)
From: Nicholas Mc Guire <der.herr@hofr.at>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: ppc manual paging question
In-Reply-To: <393088111.08518@eyou.net>
Message-ID: <Pine.LNX.4.60.0710220627390.1447@rtl14.hofr.at>
References: <393088111.08518@eyou.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, rtlinuxgpl@upv.es,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Miguel Masmano <mimastel@doctor.upv.es>, linux-embedded@opentech.lzu.edu.cn
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>
>  I've got some qeustion about ppc(ppc44x) paging:
>
> how can I manually map a virtual address to a physical address through a
> specific pgd? How does ppc translate virt address to physical one? I think
> besides from tlb, the CPU will search the page table entries via the pgd, can
> I alter the pgd value to change the memory translation? under i386, it's very
> simple, we can just rewrite %%cr3, it even could invalidate all tlb entries
> automatically, how can I do this under ppc? I've tried rewrite
> current->mm->pgd and current->thread.pgdir, but sounds like it still not
> insufficiant, am I missing something vital?
>

sur ! same thing flush the tlb 
or you will be totally inconsistant - actually the box should not
have survived this treatment in a stable manner. You might want to
look at kernel/ppc-stub.c as a good reference - its a similar problem
gdb also writes into memory without the kernel knowing about it - that
is comparable to what XM is doing - the solution flush the cache/tlb
all over the place - now flushing the cache is evil - but I would do
it for now and we can check alternatives and optimizations later - for
now brute force is the way to go.

for 4xx dont forget to isync after fidling with pgd/pte (see set_context
in entry_4xx.S . As far as I understand 4xx all you would really need to
do is clear the TLB entry and then you get an exception and that is
handled via 0x1100/0x1200 D/I respectively (head_4xx.S) - admitedly Im
not up to this task - need to give the manuals a lock my self to 
understand whats going on there ;)

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFHHCmpnU7rXZKfY2oRAjLmAJ90QwCBHLaglOfJ5QAnJyCCIZDmGwCgh/fD
E76Ki1FdfofUSuVBXL1tG0M=
=/1C5
-----END PGP SIGNATURE-----
