Return-Path: <a.woellert@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id B919267D00
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 09:35:25 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so1609352wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 16:35:24 -0700 (PDT)
Message-ID: <42DEDF9D.3080400@gmail.com>
Date: Thu, 21 Jul 2005 01:34:53 +0200
From: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050720062859.GA8477@dmt.cnet>
In-Reply-To: <20050720062859.GA8477@dmt.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: avoid icbi misbehaviour in
	__flush_dcache_icache_phys
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Can you please test the following which is equivalent to your 
> suggest changes, the only difference being the location, contained 
> inside flush_dcache_icache_page(). After confirmation that it works
> we can send up to the kernel maintainers.

of course, i can do that :).

> We should still try to understand why this is happening, possibly 
> matching it to a published CPU errata bug, or inform Freescale
> otherwise.

i think so too. as far as i understand it, the thing with the previous 
__flush_dcache_icache&tlbie patch was that __flush_dcache_icache should 
try to call dcbst on every address on a cache-line-boundary that could 
reference the page to give the cpu a hint, so that the next write-access 
to this page will be more effective, right? but while trying to do the 
dcbst, the TLB is looked up for the addresses for a faster translation. 
but here the old TLB-Entry exists, that says invalid Page or something 
like that, right? So it should be invalidated before, right?
	Question, normally the dcbst should cause a TLB-Error-Exception, that 
than should do reload the TLB-Entry automatically, doesn't this work 
because of the dcb*-errata (btw. where can i found that?). And the 
__flush_dcache_icache should do a dcbst 4096/16=256 times, but there are 
just 64 cache-lines à 16Byte (1Kb DCache), so shouldn't be 3/4 of that 
routine redundant? and also, as it seems to me, the whole dcache will be 
*flushed* or better dcbst'd trough this routine. is that right?
please correct me!

so, now the __flush_dcache_icache_phys(). this is just called, when the 
memory-mapping of the vma is not same as the one of that from the 
current process. this should be the case with ptrace. couldn't now be 
done the same as above? maybe no because the address is the virtual 
address as seen from the ptraced process? and so that will *flush* the 
pages from the ptraced process (that doesn't exists yet?, because they 
were just created for the tracing process?).
so the pte, that was created for the tracing process is used. from that, 
the physical address is calculated (how is this done, whats the magic 
about the pfn-stuff etc, i didn't really understand that :( ). now 
__flush_dcache_icache_phys is used, because the [d|i]cache uses physical 
address tags and so the data-mmu could be turned off to flush these entries.
so to understand the things further, i have to understand which 
addresses are used with dcbst and icbi. there is 
page=pfn_to_page(pte_pfn(pte)) and (page_to_pfn(page) << PAGE_SHIFT). 
but what are these values or where do they point. any hints to the 
pfn&pte stuff? unfortunately i didn't have much time the last days to 
understand this more deeply...

> 
> On 8xx, in the case where a pagefault happens for a process who's not
> the owner of the vma in question (ptrace for instance), the flush 
> operation is performed via the physical address.
> 
> Unfortunately, that results in a strange, unexplainable "icbi" 
> instruction fault, most likely due to a CPU bug (see oops below).

where do you know, that "icbi" is the bad?

Anton
