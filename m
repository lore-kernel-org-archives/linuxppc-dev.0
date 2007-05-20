Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA566DDDE4
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 04:19:36 +1000 (EST)
In-Reply-To: <200705201849.29805.arnd@arndb.de>
References: <20070520112904.GM3253@aragorn.home.lxtec.de>
	<46506EE0.9000405@s5r6.in-berlin.de>
	<200705201849.29805.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <8c9e6fe68260187606a8ad7f402a4fd8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.22-rc2 built on ppc
Date: Sun, 20 May 2007 20:19:10 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Elimar Riesebieter <riesebie@lxtec.de>, ben.collins@ubuntu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I don't know what's to blame for the warnings --- new gcc versions or
>> the change from do { } while (0) to ((void)0)? =A0Either way, the=20
>> compiler
>> should comprehend that the arguments stuffed into the =
dma_unmap_single
>> macro are _not_ unused by accident; it should stay quiet and optimize
>> the unused variables away if run with -Osomething.
>
> There is not much that the compiler can do by itself, since the macro
> expansion happens in the preprocessor.

Even if the compiler could see that the variables are
used as macro arguments, this doesn't automatically
equate to it being able to infer the variables are
unused on purpose.

> I think the best solution would be to replace the macros with
> inline functions, so that the compiler can see them.

This should shut up the warnings, yes...

> This will
> also give gcc the chance to do type checking on the arguments.

...and it is a good idea no matter what.


Segher
