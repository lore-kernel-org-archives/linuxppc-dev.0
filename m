Return-Path: <azilkie@datacast.com>
Received: from datacast.com (mail.datacast.com [209.87.232.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 53844B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 02:07:55 +1000 (EST)
Received: from [192.168.2.131] by datacast.com (MDaemon PRO v9.6.1)
	with ESMTP id md50001429222.msg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2009 12:03:01 -0400
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
From: Adam Zilkie <azilkie@datacast.com>
To: chris.pringle@oxtel.com
In-Reply-To: <4A9F78AF.4010206@oxtel.com>
References: <1251926572.10090.17.camel@Adam>  <4A9F78AF.4010206@oxtel.com>
Content-Type: text/plain
Date: Thu, 03 Sep 2009 11:54:44 -0400
Message-Id: <1251993284.2548.4.camel@Adam>
Mime-Version: 1.0
Cc: Tom Burns <tburns@datacast.com>, Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chris,

I noticed the following comment in pgtable.h: 

* - CACHE COHERENT bit (M) has no effect on PPC440 core, because it
 *     doesn't support SMP. So we can use this as software bit, like
 *     DIRTY.

And _PAGE_COHERENT is not defined for the 44x (giving a compile error
when I add it the _PAGE_BASE line as you suggested). This would confirm
that the M bit is meaningless for the PPC440

Regards,
Adam


On Thu, 2009-09-03 at 09:05 +0100, Chris Pringle wrote:
> Hi Adam,
> 
> If you have a look in include/asm-ppc/pgtable.h for the following section:
> #ifdef CONFIG_44x
> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
> #else
> #define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
> #endif
> 
> Try adding _PAGE_COHERENT to the appropriate line above and see if that 
> fixes your issue - this causes the 'M' bit to be set on the page which 
> sure enforce cache coherency. If it doesn't, you'll need to check the 
> 'M' bit isn't being masked out in head_44x.S (it was originally masked 
> out on arch/powerpc, but was fixed in later kernels when the cache 
> coherency issues with non-SMP systems were resolved).
> 
> The patch I had fixed two problems on 2.6.26 for 'powerpc':
> 1) It stopped the 'M' bit being masked out (head_32.S)
> 2) It set the cache coherency ('M' bit) flag on each page table entry 
> (pgtable-ppc32.h)
> 
> Hope this helps!
> 
> Cheers,
> Chris
> 
> Adam Zilkie wrote:
> > Hi Chris,
> >
> > I am having a problem similar to what you described in this discussion.
> > We are using the ppc arch with 2.6.24 with CONFIG_SEQUOIA with compiles
> > arch/ppc/kernel/head_44x.c (quite different
> > from /arch/powerpc/kernel/head_32.S). I would like to apply your
> > backporting patch to this architecture. Any help would be appreciated.
> >
> > Regards,
> > Adam 
> >
> >   
> 
> 
-- 
Adam Zilkie
Software Designer,
International Datacasting Corp.

This message and the documents attached hereto are intended only for the addressee and may contain privileged or confidential information. Any unauthorized disclosure is strictly prohibited. If you have received this message in error, please notify us immediately so that we may correct our internal records. Please then delete the original message. Thank you.
