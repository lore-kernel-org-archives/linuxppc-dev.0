Return-Path: <chris.pringle@oxtel.com>
Received: from oxtel.com (mail.oxtel.com [193.200.114.15])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 043FCB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 18:15:15 +1000 (EST)
Message-ID: <4A9F78AF.4010206@oxtel.com>
Date: Thu, 03 Sep 2009 09:05:03 +0100
From: Chris Pringle <chris.pringle@oxtel.com>
MIME-Version: 1.0
To: azilkie@datacast.com
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)
References: <1251926572.10090.17.camel@Adam>
In-Reply-To: <1251926572.10090.17.camel@Adam>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tom Burns <tburns@datacast.com>, Andrea Zypchen <azypchen@intldata.ca>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Adam,

If you have a look in include/asm-ppc/pgtable.h for the following section:
#ifdef CONFIG_44x
#define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_GUARDED)
#else
#define _PAGE_BASE    (_PAGE_PRESENT | _PAGE_ACCESSED)
#endif

Try adding _PAGE_COHERENT to the appropriate line above and see if that 
fixes your issue - this causes the 'M' bit to be set on the page which 
sure enforce cache coherency. If it doesn't, you'll need to check the 
'M' bit isn't being masked out in head_44x.S (it was originally masked 
out on arch/powerpc, but was fixed in later kernels when the cache 
coherency issues with non-SMP systems were resolved).

The patch I had fixed two problems on 2.6.26 for 'powerpc':
1) It stopped the 'M' bit being masked out (head_32.S)
2) It set the cache coherency ('M' bit) flag on each page table entry 
(pgtable-ppc32.h)

Hope this helps!

Cheers,
Chris

Adam Zilkie wrote:
> Hi Chris,
>
> I am having a problem similar to what you described in this discussion.
> We are using the ppc arch with 2.6.24 with CONFIG_SEQUOIA with compiles
> arch/ppc/kernel/head_44x.c (quite different
> from /arch/powerpc/kernel/head_32.S). I would like to apply your
> backporting patch to this architecture. Any help would be appreciated.
>
> Regards,
> Adam 
>
>   


-- 

______________________________
Chris Pringle
Software Design Engineer

Miranda Technologies Ltd.
Hithercroft Road
Wallingford
Oxfordshire OX10 9DG
UK

Tel. +44 1491 820206
Fax. +44 1491 820001
www.miranda.com

____________________________

Miranda Technologies Limited
Registered in England and Wales CN 02017053
Registered Office: James House, Mere Park, Dedmere Road, Marlow, Bucks, SL7 1FJ
