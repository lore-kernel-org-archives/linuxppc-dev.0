Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id DEBD1679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 16:23:07 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4C6RlIg022082
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 09:27:48 +0300 (EEST)
Message-ID: <4282F263.8080501@intracom.gr>
Date: Thu, 12 May 2005 09:06:27 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
References: <20050510154145.GB8444@logos.cnet>
	<001701c555af$c8ca0e10$0301a8c0@chuck2>
In-Reply-To: <001701c555af$c8ca0e10$0301a8c0@chuck2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: m8xx_pcmcia driver ported to v2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark Chambers wrote:
>>There is one pending problem: the M8xx does not accept 
>>access to non present ioports (an exception is triggered),
>>which is quite common while inserting/removing cards.
>>
>>We've hacked around this in our tree, Panto once mentioned 
>>that another PPC's do handle those exceptions fine (?).
>>
> 
> 
> Ah yes, I remember this problem from the 68360 days.
> 
> This is a matter of how you set up the option register ORx
> for a particular chip select.  You can choose external or 
> internal acknowledge.  You can have both at the same time:
> if you set up the ORx for the maximum number of wait states
> and also select external acknowledge, the cycle will end
> with the external acknowledge, or end with the maximum
> wait states if no external ack is generated.  Also note that
> the internal/external ack bit can be changed on the fly - so,
> for instance, you could turn external ack on once a card
> was inserted.  
> 
> As I recall, some PCMCIA cards can have VERY long
> cycles in the configuration space, so even the maximum 
> number of wait states in ORx may not be sufficient.
> 
> Mark Chambers
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

Unfortunately this does not work on 8xx since the PCMCIA
port is not on a chip select. It's a different peripheral
and always expectes a DTACK to terminate the cycle.

To get over this problem we need to do something more drastic.

Take a look at the __do_in_asm macro in include/asm-ppc/io.h.

Regards

Pantelis
