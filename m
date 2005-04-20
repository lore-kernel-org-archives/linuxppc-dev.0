Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 28F0167A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 17:40:29 +1000 (EST)
To: "Atit_Shah" <Atit_Shah@satyam.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Apr 2005 10:22:40 +0530."
	<D8595042F3765A4285B848A78A2C2ED102774F@bsdmsg002.corp.satyam.ad>
Date: Wed, 20 Apr 2005 09:40:03 +0200
Sender: wd@denx.de
Message-Id: <20050420074008.B7CA2C1784@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RAM test - How to 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <D8595042F3765A4285B848A78A2C2ED102774F@bsdmsg002.corp.satyam.ad> you wrote:
> 
> 	I am using a SDRAM having a port size 64 and size 32MB, and the
> burst length is 4. I want to know how i can test my RAM for burst mode
> operation. I have read in a couple of places that there is no sure RAM
> test but there must be some reasonable test which can be performed to
> atleast be sure that the RAM functions fine under burst mode.

You can probably implement a memory test like this one:

1)  Map a region of physical RAM into two virtual regions:
    one cached and the the other one uncached.
2)  Fill the cached region with a pattern, and flush the cache
2a) Check the uncached region to match the pattern
2b) Check the cached region to match the pattern
3)  Fill the uncached region with a pattern
3a) Check the cached region to match the pattern
3b) Check the uncached region to match the pattern
4)  Change the patterns and go to step 2.

You probably want to do this in your boot loader, though.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A Freudian slip is when you say one thing but mean your mother.
