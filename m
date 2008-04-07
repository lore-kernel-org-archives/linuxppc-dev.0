Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66A30DDF64
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Apr 2008 02:04:03 +1000 (EST)
Message-ID: <47FA4601.1080707@freescale.com>
Date: Mon, 07 Apr 2008 11:04:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Deepak Gaur <dgaur@cdotd.ernet.in>
Subject: Re: MVL Linux on MPC8560 Booting goes into infinite loop in early_init
	memset_io ( )
References: <20080407064547.M56295@cdotd.ernet.in>
In-Reply-To: <20080407064547.M56295@cdotd.ernet.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Deepak Gaur wrote:
> Hi all,
> 
> While booting MVL linux

Have you talked to MV support?  For community support, it's best to use 
the latest upstream sources (and arch/powerpc, not arch/ppc).

BTW, it's generally bad form to post the same question repeatedly.  If 
you have new information regarding your problem, just post a followup in 
the same thread containing the new information.

> arch/ppc/kernel/setup.c
> ----------------------------------------
> unsigned long
> early_init(int r3, int r4, int r5)
> {
>         unsigned long phys;
>         unsigned long offset = reloc_offset();
> 
>         /* Default */
>         phys = offset + KERNELBASE;
> 
>         /* First zero the BSS -- use memset, some arches don't have
>          * caches on yet */
>        
>         memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);
> 
>         __bss_start is 0xc039b00 and __bss_stop = _end =c03c7d90  _end
> 
> 
>         Please anyone give me some pointers to understand this i.e use of PTRRELOC

The kernel hasn't been remapped yet, so the pointer is adjusted manually.

> and REASON BEHIND clearing area from __bss_start to _end - __bss_start even though lot of
> symbols and functions are defined here(as per System.map)

That's what the BSS is for -- symbols that are cleared at runtime so as 
to eliminate the need to store them in the image.  There should be no 
functions in there.

-Scott
