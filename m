Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc1-s3.bay0.hotmail.com (bay0-omc1-s3.bay0.hotmail.com
	[65.54.246.75]) by ozlabs.org (Postfix) with ESMTP id 7FFEADDE09
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 20:02:05 +1100 (EST)
Message-ID: <BAY7-F166026572702AFA9F45B66BEA90@phx.gbl>
From: "- Reyneke" <reynekejunk@hotmail.com>
To: niklaus.giger@member.fsf.org
Subject: Re: Howto use PPC4xx memory to memory DMA
Date: Fri, 19 Jan 2007 08:49:58 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Niklaus,

Here are a few things to check:

1. Your memory destination and source addresses are contiguous. You can get 
this using something like:

mem = (void*)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(size));

2. Your source and dest addresses are _bus_ addresses. You can get these by:

source = virt_to_bus((u32 *)mem);


Also, we had some trouble with the ppc4xx_ functions using 440 - it seems 
these functions are specific to the PLB4. So if you are trying to do DMA on 
say the PLB peripheral bus on a memory mapped device, you definitely have 
some trouble.

I have some code for doing both - so of you need any further help, just ask.

Regards
   Jan Reyneke

_________________________________________________________________
Get Hotmail, News, Sport and Entertainment from MSN on your mobile.  
http://www.msn.txt4content.com/
