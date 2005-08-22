Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.2.116])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47BD268003
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 23:39:54 +1000 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j7MDdnBU023109
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 Aug 2005 15:39:49 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4309D5F0.7080003@246tNt.com>
Date: Mon, 22 Aug 2005 15:41:04 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <43006FD4.6060801@varma-el.com> <43009A8D.1040704@246tNt.com>
	<4300AF41.9000807@varma-el.com>
In-Reply-To: <4300AF41.9000807@varma-el.com>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [00/02] MPC5200 Bestcomm platform driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrey Volkov wrote:

>> - I never really liked to have multiple "type" of buffer descriptors
>>depending of the number of pointers in them. "standard" task have
>>either 1 or 2 pointers true but I have custom tasks with 3 so I need a
>>subtmitbuffer3 ... Not very extensible imho. I think there is no problem
>>as defining the descriptor structure with an array of pointer and then
>>just allocate the good size at init. Whoever use them must anyway know
>>the number of pointer to fill.
> 
> Accepted. But I think it will be better to start from another end:
> allow everyone to create him/here self task (variable buffers number
> will consequence of that).

Sure, see my comments about your bestcomm microcode doc in my preceing mail.


>> - When I started to clean up bescomm a while ago, the only thing I
>>really got done was a rewrite of the SRAM allocator that supports the
>>freeing of block at little overcost. I'll try to find it and send it to you.
> 
> I agree with you, sram_free is required function, especially if
> sdma-depended drivers will loaded/unloaded as modules. But I also agree
> with Dale's comments: What to do with fragmentations? I could lightly
> imagine situation, when after some load/unload iterations we receive
> ENOMEM :(.

Sure, fragmentation is a problem but there is no 'easy' way to prevent
that ... It's not perfet but better than nothing IMHO.


>> - I like the separation of phys/virt ;)
> 
> I'd like it too :), but I had a pa/va headache when setting up
> task/var/inc tables, so everyone, who will write sdma related code must
> be very careful.

Anyway, they must be careful ;)
Bestcomm is like a very fragile balance between numerous task competing
for some dma transfers. Without caution, one will starve the others ...




	Sylvain
