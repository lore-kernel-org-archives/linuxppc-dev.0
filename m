Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C411D68789
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 00:35:25 +1100 (EST)
Received: from [194.100.64.94] (host94.eke.fi [194.100.64.94])
	by smtp2.song.fi (Postfix) with ESMTP id D6DA2B6118
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 15:35:20 +0200 (EET)
Message-ID: <43C26698.1070308@iki.fi>
Date: Mon, 09 Jan 2006 15:35:20 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <43C25787.4010204@iki.fi>
	<20060109125339.GA12997@oops.ghostprotocols.net>
In-Reply-To: <20060109125339.GA12997@oops.ghostprotocols.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Badness in dma_alloc_init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Aristeu Sergio Rozanski Filho wrote:

>Hi!
>  
>
>>I'm having some trouble with the DMA allocation using Linux 2.6.14-rc2 + 
>>some platform modifications. Namely, the dma_alloc_coherent() function 
>>returns bogus virtual addresses causing machine check exceptions. At 
>>boot, the kernel complains there is something wrong, but I cannot figure 
>>out how to fix it. CONFIG_CONSISTENT_START is at its default value, 
>>0xff100000. Any hints where to look further?
>>
>>Oh, this is a custom 8xx board. Has the support for DMA in 8xx been 
>>unstable at the time of pre-2.6.14?
>>    
>>
>probably your IMAP_ADDR is at 0xff000000, isn't it? if it is, please adjust
>CONFIG_CONSISTENT_START to an address like 0xe0000000.
>
>  
>
True, my IMAP_ADDR is at 0xff000000. But IMAP_SIZE is just 64 KB, so 
there should be no overlap, right? Or is the IMAP memory area mapped 
with an 8-MB TLB entry or something like that?

No badness in dma-mapping.c anymore with CONFIG_CONSISTENT_START being 
0xe0000000, however. Thanks.
