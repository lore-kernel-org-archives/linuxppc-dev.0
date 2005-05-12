Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.182.167]) by ozlabs.org (Postfix) with ESMTP id 1AFEB67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 21:29:38 +1000 (EST)
Message-ID: <006101c556e5$ebbfeb10$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Pantelis Antoniou" <panto@intracom.gr>
References: <20050510154145.GB8444@logos.cnet>
	<001701c555af$c8ca0e10$0301a8c0@chuck2>
	<4282F263.8080501@intracom.gr>
Date: Thu, 12 May 2005 07:29:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

> >>There is one pending problem: the M8xx does not accept 
> >>access to non present ioports (an exception is triggered),
> >>which is quite common while inserting/removing cards.
> >>
> > Ah yes, I remember this problem from the 68360 days.
> > 
> > This is a matter of how you set up the option register ORx
> > <snip>
> > for instance, you could turn external ack on once a card
> > was inserted.  
> > 
> > As I recall, some PCMCIA cards can have VERY long
> > cycles in the configuration space, so even the maximum 
> > number of wait states in ORx may not be sufficient.
> > 
> Unfortunately this does not work on 8xx since the PCMCIA
> port is not on a chip select. It's a different peripheral
> and always expectes a DTACK to terminate the cycle.
> 
> To get over this problem we need to do something more drastic.
> 
> Take a look at the __do_in_asm macro in include/asm-ppc/io.h.
> 
> Regards
> 
> Pantelis
> 

You are right, I had forgotten that.  I'd also forgotten that PCMCIA
uses negative WAIT, which should have a pull-up on it, so there
should be no problem with non-existent cards.

Another potential problem could be the Bus Monitor Timeout
being set too short and generating a TEA before a valid WAIT is
released.

Mark Chambers
