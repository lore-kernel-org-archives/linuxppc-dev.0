Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id F03FEDE07F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 03:26:26 +1100 (EST)
Message-ID: <478798A7.2070300@pikatech.com>
Date: Fri, 11 Jan 2008 11:26:15 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/5] Warp Base Platform
References: <47852C41.8000506@pikatech.com><20080111174259.b749f1f0.sfr@canb.auug.org.au><47871675.6030602@pikatech.com>
	<20080111210237.5636d0c3.sfr@canb.auug.org.au>
In-Reply-To: <20080111210237.5636d0c3.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> I don't where that function is actually defined - I assume it is in one
> of the other recent patch sets.
>
> /me searches ...
> /me reads "ad7414 driver" email ...
> /me notes spaces missing there as well :-)
>
>   
I didn't write the ad7414 driver and wanted to change the original code 
as little as possible.
> Tricky.  You have something that can only be built in (pika_dtm_thread in
> warp.c) calling something that might be a module ... I think you need to
> think of a new way of organizing these pieces. 
>   
The DTM is a very small, but important part of the taco. Basically it 
controls the fan. I could have wrapped it in a CONFIG_AD7414, but I 
would rather have a compile time error and ship people the ad7414.c.

That said, I could just slam a CONFIG_AD7414 around the DTM code. It 
would just mean that the fan would run at high speed all the time if you 
didn't have it.

I really don't want to have to write a driver just to get one register 
from the temperature chip. And we want the DTM running ASAP on startup. 
I think forcing taco users to build in the i2c and ad7414 drivers is not 
a hardship. And we do ship a working kernel with the taco.

And as a special bonus to readers of this thread, an exclusive, never 
before seen, picture of tigger, my development taco. I have to point out 
it is a development prototype and not the final product.

ftp://ftp.seanm.ca/stuff/tigger.jpg or 
http://ftp.seanm.ca/stuff/tigger.jpg .

Cheers,
  Sean
