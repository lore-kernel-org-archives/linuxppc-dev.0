Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0679067A3E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 04:43:04 +1000 (EST)
Date: Fri, 6 May 2005 11:43:02 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050506184302.GA28614@gate.ebshome.net>
References: <427B22A0.8010704@ru.mvista.com>
	<20050506081805.GA19401@gate.ebshome.net>
	<427B3465.1070502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <427B3465.1070502@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH 2.6.12-rc2] Updated platform additions for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 06, 2005 at 01:09:57PM +0400, Vitaly Bordug wrote:
> 
> PHY_INTERRUPT is defined in the board-specific platforms/pq2ads.h 
> (likewise approach was used in 2.4). Others from this define crowd 
> should reside as they are IMHO, until we have some common board-specific 
> header for 82xx (or all these will be scattered along different 82xx 
> platform defines such as tqm8260.h etc. which is even worse).  What do 
> you think?

The best way I think is to NOT use defines like PHY_INTERRUPT at all. 
This is what I mean in my previous e-mail when I said I didn't quite 
like approach your chosen but thought it was OK for now.

I think that platform files should initialize only stuff which is 
common for all boards using this platform.

Board specific stuff should be _filled_ in board .c file. Basically we 
have two different ways to do board specific stuff (I think feature 
call stuff which Dan is proposing is orthogonal to these):

1) Add some defines with generic name like PHY_INTERRUPT_FCC1, allow 
board specific _header_ file to define them and use some default if 
it wasn't overridden by the board port. This is I believe approach you 
have chosen.

2) _Fill_ corresponding platform_device fields in the board C file. 
This is what I think is better.

Approach 1) is less intrusive because it's similar to what we were 
doing so far.

Approach 2) is more flexible (e.g. I wasn't to use the same kernel 
image for all boards from some family, and they may use different IRQ 
routing). Also, 2) avoids "header file hell", when board info scattered 
around different headers and sometime it's not that obvious where 
particular define comes from.

-- 
Eugene
