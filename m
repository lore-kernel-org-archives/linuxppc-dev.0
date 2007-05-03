Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC1C3DDF7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 20:24:01 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1HjYQV-0001vD-VA
	for <linuxppc-embedded@ozlabs.org>; Thu, 03 May 2007 06:20:43 -0400
Message-ID: <4639B7CE.8020402@dlasys.net>
Date: Thu, 03 May 2007 06:22:06 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
References: <4636C836.4050502@itee.uq.edu.au>
	<87647b5ofn.fsf@sleipner.barco.com>
	<46393609.1010205@itee.uq.edu.au>
In-Reply-To: <46393609.1010205@itee.uq.edu.au>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John Williams wrote:
>
> I think that's Grant's approach of using in/out_be32, and the real base 
> address (ie not +3) is the only logically correct solution.
>   
    Trying to track how every permutation maps in every possible
scenario is more than my brain can handle.
    What I do know is that throwing an arbitrary +3 offset in is
incredibly confusing.
   
    While I pointed out that the Xilinx docs sugguest  implimentations
with regshifts of 0,1 &2 - and I beleive
    I have seen xilinx example code that sugest they may have somehow
implimented UartLite on occasion
    with less than 32bit registers. The stock GreenHills Integrity
default UartLite driver presumes a regshift of 0.
     But I have never seen an 8 or 16 bit Uartlite.
    However before either my driver or Peters showed up there was one
posted to this list that used dcr.
   
    My suggestion would be to handle "port IO" inside
serial_in()serial_out() functions like the 8250 driver (and about 1/3 of
the
    other serial drivers) do.
    While in a perfect world we should be able to compile the UartLite
driver without change for an x86
    if somehow that can be created, atleast with all the io moved to two
functions, adjusting for different regshifts,
    endians, .... requires a very limited number of localized changes.
  
    I would be happy to submit a patch to do that
    but I can not test it because I can not get Peter's driver to work
with my hardware.
   
   

   
   




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
