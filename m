Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED765DDF25
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 01:55:01 +1000 (EST)
Message-ID: <4643404E.30608@freescale.com>
Date: Thu, 10 May 2007 10:54:54 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] Mark prop unused in early_init_dt_scan_chosen().
References: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.64.0705092238390.29512@localhost.localdomain>
	<Pine.LNX.4.62.0705100938110.32241@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0705100938110.32241@pademelon.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Wed, 9 May 2007, Kumar Gala wrote:
>>On Tue, 8 May 2007, Scott Wood wrote:
>>>-	u32 *prop;
>>>+	u32 __attribute__((unused)) *prop;
>>
>>is this the desired way to remove warnings related to CONFIG_ options?  I
>>know in the past we'd wrap it with a #ifdef CONFIG_FOO

Granted...  in this case, it looked as if there could be potential for 
using it for other things in the future as well.  That, and the extra 
ifdefs are ugly. :-)

> Exactly my thought.
> 
> Another advantage of #ifdef CONFIG_FOO is that if the actual code that uses it
> goes away, we'll get a warning again. Else in the end we'll be stuck with
> zillions of unused variables that don't cause warnings...

Again, granted -- though I'd say the primary problem in that case is 
functions that are too long to determine that by visual inspection alone.

I agree with Michael Ellerman that it'd be best to just factor the 
initrd stuff out into its own function.

-Scott
