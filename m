Return-Path: <Heinz.Wrobel@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59345B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 22:20:22 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n83CKJZl009122 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 3 Sep 2009 05:20:19 -0700 (MST)
Received: from zuk35exm20.fsl.freescale.net (zuk35exm20.ea.freescale.net
	[10.210.1.54])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n83CLkZa003879
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 3 Sep 2009 07:21:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: AW: PowerPC PCI DMA issues (prefetch/coherency?)
Date: Thu, 3 Sep 2009 13:20:12 +0100
Message-ID: <AAE514D00E55E6438B7F5186462A545202750F9B@zuk35exm20.fsl.freescale.net>
In-Reply-To: <4A9F78AF.4010206@oxtel.com>
References: <1251926572.10090.17.camel@Adam> <4A9F78AF.4010206@oxtel.com>
From: "Wrobel Heinz-R39252" <Heinz.Wrobel@freescale.com>
To: "Chris Pringle" <chris.pringle@oxtel.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: Tom Burns <tburns@datacast.com>, Andrea Zypchen <azypchen@intldata.ca>,
	azilkie@datacast.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This doesn't seem right. If we are talking about a single CPU core chip,
i.e., just one data cache, then setting M is typically a) useless and
could even b) cause a performance penalty depending on a chip's
implementation.
The M bit is required if *other* cores with caches need to see changes
for coherency of their caches. You wouldn't set it for one core only
because your own core knows about its own cache.
The possible performance penalty could happen because you need some way
to tell the others that they better intercept a transaction. And that
could, depending on the chip, by a clock extra or so per transaction.
Now, in theory, a DMA engine could have caches, read from cache content
first, and could snoop the bus on global transactions like another core,
but I have never heard of such a beast.=20

Hope this helps,

Heinz

-----Original Message-----
From: linuxppc-dev-bounces+heinz.wrobel=3Dfreescale.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+heinz.wrobel=3Dfreescale.com@lists.ozlabs.or=
g
] On Behalf Of Chris Pringle
Sent: Donnerstag, 3. September 2009 10:05
To: azilkie@datacast.com
Cc: Tom Burns; Andrea Zypchen; linuxppc-dev@lists.ozlabs.org
Subject: Re: AW: PowerPC PCI DMA issues (prefetch/coherency?)

Hi Adam,

If you have a look in include/asm-ppc/pgtable.h for the following
section:
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
> I am having a problem similar to what you described in this
discussion.
> We are using the ppc arch with 2.6.24 with CONFIG_SEQUOIA with=20
> compiles arch/ppc/kernel/head_44x.c (quite different from=20
> /arch/powerpc/kernel/head_32.S). I would like to apply your=20
> backporting patch to this architecture. Any help would be appreciated.
>
> Regards,
> Adam
>
>  =20


--=20

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
Registered in England and Wales CN 02017053 Registered Office: James
House, Mere Park, Dedmere Road, Marlow, Bucks, SL7 1FJ
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
