Return-Path: <imrek@atomki.hu>
Received: from imrek.org (strawberry.diszk.unideb.hu [193.6.143.139])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97EB9DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 13:41:00 +1000 (EST)
Received: from localhost ([127.0.0.1]) by imrek.org with esmtp (Exim 4.63)
	(envelope-from <imrek@atomki.hu>) id 1IIbuG-00032n-8I
	for linuxppc-embedded@ozlabs.org; Wed, 08 Aug 2007 05:08:20 +0200
Date: Wed, 8 Aug 2007 05:08:20 +0200 (CEST)
From: jozsef imrek <imrek@atomki.hu>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux with data2mem
In-Reply-To: <OF56B29E3B.75AC018C-ON85257330.0055CDE0-85257330.0056CDD1@ct.wec.com>
Message-ID: <Pine.LNX.4.61.0708080455410.11634@imrek.org>
References: <OF56B29E3B.75AC018C-ON85257330.0055CDE0-85257330.0056CDD1@ct.wec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 7 Aug 2007 Glenn.G.Hart@us.westinghouse.com wrote:

> ERROR:Data2MEM:33 - Matching ADDRESS_SPACE for code segment #0 not found in
> 'sys
> tem_bd.bmm'.
>    Code segment #0 occupies [0x00400000:0x0062AFFF]
>

...

> ///////////////////////////////////////////////////////////////////////////////
>
>    ADDRESS_SPACE plb_bram_if_cntlr_1_bram_combined RAMB16
> [0xFFFFC000:0xFFFFFFFF]


make sure that the memory range your software wants to use is backed
by real memory. it seems that your elf expects itself to be loaded at
0x00400000:0x0062AFFF, but you block memory is at 0xFFFFC000:0xFFFFFFFF
(use readelf -l to find out what address ranges does your software want
to use).


probably what you want is a boot loader in the bram, not the kernel image
(the zImage). the boot loader would load the linux kernel into the main
memory (starting at memory address 0x00000000).



-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       imrek@atomki.hu
----------------------------------------------------------------
