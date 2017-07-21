Return-Path: <bsingharora@gmail.com>
Received: from mail-it0-x229.google.com (mail-it0-x229.google.com
 [IPv6:2607:f8b0:4001:c0b::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDPTQ63P4zDqtT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:44:42 +1000 (AEST)
Received: by mail-it0-x229.google.com with SMTP id a62so4462066itd.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 01:44:42 -0700 (PDT)
Message-ID: <1500626634.8256.21.camel@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/xmon: support dumping software pagetables
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 21 Jul 2017 18:43:54 +1000
In-Reply-To: <87k232e0mg.fsf@concordia.ellerman.id.au>
References: <20170721052406.28960-1-bsingharora@gmail.com>
 <87k232e0mg.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-21 at 16:59 +1000, Michael Ellerman wrote:
> Nice !
> 
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > It would be nice to be able to dump page tables in a
> > particular context
> > 
> > Example use cases
> > 
> > Dumping PTE contents to see the keys (useful for debugging)
> > 
> > c0000000ba48c880 c0000000bab438b0   2677   2675 T  2 protection_keys
> 
> What is that ^ ?


Thats extra, the output of P (print all tasks, I've used that task selection)

> 
> > 0:mon> ds c0000000ba48c880 0x7ffff7f70000
> > translating tsk c0000000ba48c880, addr 7ffff7f70000
> > G: 0xb95b6400   U: 0xb6334000   M: 0xb6543000   PA: 0x012c0000, PTE: 0xd4800000012c0504
> 
> Without reading the code I don't grok what G/U/M mean.

PGD, PUD and PMD, I'll expand on them.

> 
> Feel free to use more than one line of output :)
> 
> > Dumping vmalloc space
> > 
> > 0:mon> ds 0 d000000000000000
> 
> I suspect we will want to do that a lot. So I'd rather the arguments
> were reversed, and the second (task) can be omitted.

I considered that as well, can do

> 
> So:
> 0:mon> ds x	== translate x via init_mm
> 0:mon> ds x y	== translate x via &y->mm
> 
> I guess it's easier for folks to find a task rather than an mm directly?
> Otherwise it could take an mm not a task.
> 

we already have commands for task, via (P), which is why I thought
task makes sense.

> > translating tsk           (null), addr d000000000000000
> 
> We should special case that to say "using kernel page tables" or similar.
> 
> > G: 0x3d450400   U: 0xbc184000   M: 0x3d460000   PA: 0x7e010000, PTE: 0xc08000007e01018e
> > I did not replicate the complex code of dump_pagetable and have no support
> > for bolted linear mapping, thats why I've called it software pagetable
> > dumping support.
> 
> Not sure about that naming. On hash it makes sense, but not on radix or
> on other platforms.
> 
> Maybe 'dv' for dump Virtual address ?
> 
> It doesn't dump a PTE, it tries to translate an address into a PTE.
>

Done, will do a v2

Thanks for the review!
Balbir Singh. 
