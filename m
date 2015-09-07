Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id C59461A234F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 17:08:05 +1000 (AEST)
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: memcpy regression
To: Michael Ellerman <mpe@ellerman.id.au>, Michal Sojka <sojkam1@fel.cvut.cz>
References: <871teeux4w.fsf@steelpick.2x.cz> <55E9A354.6070600@c-s.fr>
 <87si6utfpf.fsf@steelpick.2x.cz> <55E9DE87.4070805@c-s.fr>
 <55E9F5CE.6050904@fel.cvut.cz> <55EA3281.3000806@fel.cvut.cz>
 <55EBF6CD.5010001@c-s.fr> <87twr74bdg.fsf@steelpick.2x.cz>
 <87r3mb4603.fsf@steelpick.2x.cz> <1441588450.12945.1.camel@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Message-ID: <55ED37D1.3080503@c-s.fr>
Date: Mon, 7 Sep 2015 09:08:01 +0200
MIME-Version: 1.0
In-Reply-To: <1441588450.12945.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael

Le 07/09/2015 03:14, Michael Ellerman a écrit :
> Hi Michal,
>
> Thanks for finding the problem.
>
> On Sun, 2015-09-06 at 23:01 +0200, Michal Sojka wrote:
>> I found the problem. The compiler replaces an assignment with a call to
>> memcpy. The following patch fixes the problem for me. However, I'm not
>> sure whether this is the real solution. I guess the compiler is free to
>> generate a call to memcpy wherever it wants so other compilers or other
>> optimization levels may need fixes at other places. What do others
>> think?
> I think you're right that it's not a good solution, the compiler could generate
> other calls to memcpy depending on various factors, and people will add new
> code that causes memcpy to get called and it will break your platform.
>
> Christophe, am I right that the problem here is that your new memcpy() doesn't
> work until later in boot when caches are enabled?
>
>

That's right, memset() and memcpy() are for setting/copying data into 
cacheable RAM.
They are using dczb instruction in order to avoid wasting time loading 
the cacheline with data that will be overwritten.

memset_io() and memcpy_toio() are the functions to use when using not 
cacheable memory.

The issue identified by Michal is in function setup_cpu_spec() which is 
called by identify_cpu(). identify_cpu() is called from early_init().
In the begining of early_init(), there is (code from Paul in 2005)

	/* First zero the BSS -- use memset_io, some platforms don't have
	 * caches on yet */
	memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
			__bss_stop - __bss_start);

It shows that it is already expected that the cache is not active yet 
and standard memset() shall not be used yet. That's the same with memcpy().

I think GCC uses memcpy() in well known situations like initialising 
structures or copying structures.
Shouldn't we just avoid this kind of actions in the very few early init 
functions ?

Christophe
