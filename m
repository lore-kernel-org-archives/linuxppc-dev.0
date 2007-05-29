Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2EA4DE0B6
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:43:40 +1000 (EST)
In-Reply-To: <200705291628.35852.arnd@arndb.de>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
	<200705291628.35852.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <624dd5293b5fde0ffdf01ea692c32e9c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 16:43:33 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Steve Munroe <sjmunroe@us.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Just call them and trap the SEGV ;-)  You can check the
>> aux vector of course, or ask glibc -- but the SEGV way
>> is the only really portable way.  Strange world :-)
>
> shouldn't that be SIGILL?

Yes sir.  Although you can do it with segmentation
faults as well, I did mean SIGILL.

>> ILP32LL64.  The C "mode" stays the same, only the generated
>> machine insns are changed.
>
> right, as mentioned before, IP32L64 would imply introducing a new
> ABI, which we don't want.

Hey, you could hijack the mswindows ABI, no need to
define your own ;-)


Segher
