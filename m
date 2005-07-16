Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6B4267C25
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jul 2005 04:02:24 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20050715160115.GA22990@janus> <1121535588.14393.18.camel@gaston>
Date: Sat, 16 Jul 2005 20:02:18 +0200
In-Reply-To: <1121535588.14393.18.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sun, 17 Jul 2005 03:39:47 +1000")
Message-ID: <jeackmbped.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: bug in arch/ppc/kernel/misc.S: __ashrdi3?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2005-07-15 at 18:01 +0200, Frank van Maarseveen wrote:
>> I don't really grok the code but an operand seems to be missing and the
>> assembler makes something out of it I don't trust:
>> 
>> _GLOBAL(__ashrdi3)
>> 	...
>> 	rlwinm  r8,r7,0,32      # t3 = (count < 32) ? 32 : 0
>
> This is equivalent to r8 = r7 & 32. It will definitely not do what the
> comment says though. If (count < 64), however, it will do something
> like r8 = (r7 < 32) ? 0 : 32. Paul, maybe we should dbl check what's
> going in there ?

r7 is count + 32, and ((count + 32) & 32) is equivalent to the expression
above if count < 64.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
