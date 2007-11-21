Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 002DADDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 08:40:43 +1100 (EST)
Message-ID: <4744A5EC.1090201@freescale.com>
Date: Wed, 21 Nov 2007 15:41:00 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>	<20071120175416.GA4389@loki.buserror.net>	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
	<18244.42181.426804.662877@cargo.ozlabs.ibm.com>
In-Reply-To: <18244.42181.426804.662877@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Geert Uytterhoeven writes:
> 
>> +#define WARN_EMULATE(type)						\
>> +	do {								\
>> +	    static unsigned int count;					\
>> +	    if (count++ < 10)						\
>> +		    pr_warning("%s used emulated %s instruction\n",	\
>> +			       current->comm, type);			\
> 
> Thinking about this a bit more, if an instruction gets emulated 10
> times then I don't care, since it's probably only cost me 10
> microseconds or so.  If it gets emulated a million times then I might
> want to look at it.  So in fact this approach doesn't give me the
> information I need to know whether there is a real problem or not.

Maybe print the first time, then when it's happened 10 times, then 100, 
then 1000, etc.

-Scott
