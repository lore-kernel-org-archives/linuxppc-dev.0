Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id E5EFD6816B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 19:56:14 +1000 (EST)
Message-ID: <1084.24.92.61.26.1126086971.squirrel@webmail.albany.edu>
In-Reply-To: <BDEHJGPIKNLKJJBCCFPLCEOOCPAA.listuser@epygi.de>
References: <BDEHJGPIKNLKJJBCCFPLCEOOCPAA.listuser@epygi.de>
Date: Wed, 7 Sep 2005 05:56:11 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: "Markus" <listuser@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ads8272 SEC problem on 2.4.18
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I had the similar error with SEC1 for 8248. My RNG DPD could not generate
desired result. After DPD address written my ISR was invoked but all i had
is TEA error, or bus error etc when i checked the Status Registers.

regards
-vikas

> HiHo!
>
> I am trying to get the SEC engine running on a ads8272
> but i am completely stuck now. (It feels like the problem
> we saw on this list last month, but there is still no solution
> to that issue yet.
>
> Quick Problem description:
>   initialize seems, ok, yet when i feed a single
>   dpd (for DES EU) into channel 0, the engine
>   seems to stuck during fetch. Nothing happens.
>
> Questions:
> - Can someone help me out? (Not sure if this is the right list for this?)
> - Do (open) sources for the SEC1 (motorola/freescale) engine exist for
> vanilla linux?
>   (I know of Arabella, but they are neither open nor for vanilla linux)
>
> ciao
>   Markus
>
> P.S. some more details below
> --------------------------------------------
> more info:
>  - i hopefully initialized it correctly
>  - prepared a dpd
>  - wrote it into fetch register
>  - see that something happens: CurrentDescriptorPR changes
>  - boing, that's it... no more
>
> some dumps:
>  Before writing the fetch register:
>   CryptoChannelConfigRegister (f0042008), 0x00000000 0x0000071c
>   CryptoChannelPointerStatusRegister (f0042010), 0x00000000 0x00000007
>   CryptoChannelCurrentDescriptorPointerRegister (f0042040), 0x00000000
> 0x00000000
>   CryptoChannelFetchDescriptorRegister (f0042048), 0x00000000 0x00000000
>   CryptoChannelDescriptorBufferRegister 0 (f0042080), 0x00000000
>
>  after writing to fetch register
>   CryptoChannelConfigRegister (f0042008), 0x00000000 0x0000071c
>   CryptoChannelPointerStatusRegister (f0042010), 0x00000002 0x00000007
>   CryptoChannelCurrentDescriptorPointerRegister (f0042040), 0x00000000
> 0x002e9a98
>   CryptoChannelFetchDescriptorRegister (f0042048), 0x00000000 0x00000000
>   CryptoChannelDescriptorBufferRegister 0 (f0042080), 0x00000000
>
> CCPSR changes to 2 (error), but i don't know why?
> Nothing else (at least nothing i can see) happens.
> ------------------------------------------------------
> markus schaefer  ---  software engineer
> epygi labs de gmbh
> herrenstrasse 23
> d-76133 karlsruhe, germany
> tel: +49 (721) 205 96 30  -- fax: +49 (721) 205 96 59
> sip: 20444@sip.epygi.com
> *email removed, but it is easy to guess*
> http://www.epygi.de
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
