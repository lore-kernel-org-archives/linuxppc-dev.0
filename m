Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91163683F1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 06:35:18 +1000 (EST)
Message-ID: <4339AD01.30708@iki.fi>
Date: Tue, 27 Sep 2005 22:35:13 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
In-Reply-To: <384d09b865d454875c447cc02c89d001@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:

>
> On Sep 27, 2005, at 10:11 AM, Kalle Pokki wrote:
>
>> Any ideas what can set the bootmem memory as cached?
>
> All of memory is always cached on 82xx.  Which is fine
> since the cache controller keeps the processor core
> and peripherals coherent in hardware.

OK. Then the question really is why isn't the cache controller enforcing 
coherency between the G2_LE core and the CPM. While trying to debug the 
console driver I wrote a really simple SCC driver separated from the 
rest of the kernel in order to have a usable debug printf. And I 
couldn't get any buffers printed through the SCC until I started to use 
buffers in DPRAM. The CPM just didn't see anything I wrote to the 
buffers. The same thing seems to bother at least the console driver and 
the FCC ethernet driver (though they don't work at all for me at the 
moment..)

I think it is obvious I have misconfigured something, but at this point 
I am not even sure if it is something I should have initialised in the 
boot loader.
