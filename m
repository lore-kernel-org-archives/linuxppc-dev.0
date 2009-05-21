Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48867DE1DE
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 03:42:15 +1000 (EST)
In-Reply-To: <fa686aa40905200936o63f47937rda28126ce0f46aad@mail.gmail.com>
References: <1242806865-2334-1-git-send-email-w.sang@pengutronix.de>
	<9e4733910905200817w20a812bcy14481255fefd011f@mail.gmail.com>
	<20090520155346.GG29102@pengutronix.de>
	<9e4733910905200910r5342c087pa4ebc579b37c8671@mail.gmail.com>
	<20090520161511.GH29102@pengutronix.de>
	<fa686aa40905200925o763179c7r27c12f7659560807@mail.gmail.com>
	<fa686aa40905200936o63f47937rda28126ce0f46aad@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38563D01-3F19-480A-AC65-743A0A2318BE@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pcm030.dts: add i2c eeprom and delete cruft
Date: Thu, 21 May 2009 19:43:14 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> As the other thread states, "eeprom" is far too vague, and it is
> certainly not documented, and does not say anything meaningful about
> the protocol used to talk to the eeprom.  Sure, most i2c eeproms use
> the same protocol,

Not at all!  Pretty much every size of 24c has its own protocol;
and some manufacturers have special extensions for locking parts
of the array, etc.  A driver can ignore that last part, but not
the first.  So the SEEPROM size should be part of its "compatible"
name; simplest way for that is to use the model number.

> but an assumption cannot be made that that will
> always be the case.  Plus, the namespace will collide with non-i2c
> eeproms.  "i2c-eeprom" is better, but not great.  Before a value like
> "i2c-eeprom" can be acceptable, it must be documented and reviewed as
> to exactly what it means, and even then I'm uncomfortable with it.
>
> However, on the other point, Jon is correct.  The first value in the
> list should be "atmel,24c32", not "at24,24c32".

Yeah.  So perhaps "atmel,24c32","24c32" ?  I'm not terribly happy
with that last name, but these devices are _very_ common.


Segher
