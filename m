Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.182.164]) by ozlabs.org (Postfix) with ESMTP id 58A7567A2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 08:29:37 +1000 (EST)
Message-ID: <001701c555af$c8ca0e10$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
	"linux-ppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <20050510154145.GB8444@logos.cnet>
Date: Tue, 10 May 2005 18:29:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

> 
> There is one pending problem: the M8xx does not accept 
> access to non present ioports (an exception is triggered),
> which is quite common while inserting/removing cards.
> 
> We've hacked around this in our tree, Panto once mentioned 
> that another PPC's do handle those exceptions fine (?).
> 

Ah yes, I remember this problem from the 68360 days.

This is a matter of how you set up the option register ORx
for a particular chip select.  You can choose external or 
internal acknowledge.  You can have both at the same time:
if you set up the ORx for the maximum number of wait states
and also select external acknowledge, the cycle will end
with the external acknowledge, or end with the maximum
wait states if no external ack is generated.  Also note that
the internal/external ack bit can be changed on the fly - so,
for instance, you could turn external ack on once a card
was inserted.  

As I recall, some PCMCIA cards can have VERY long
cycles in the configuration space, so even the maximum 
number of wait states in ORx may not be sufficient.

Mark Chambers
