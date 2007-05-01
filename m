Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31115DDF74
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 14:46:34 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1HikDE-0000cB-Gd
	for <linuxppc-embedded@ozlabs.org>; Tue, 01 May 2007 00:43:40 -0400
Message-ID: <4636C5C5.8050408@dlasys.net>
Date: Tue, 01 May 2007 00:44:53 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: I always encouter this simple error message compiling 2.6 for
	ML403 UART 16550
References: <BAY115-W11DBD14D233C8E1FE8CAD3B24C0@phx.gbl>
	<528646bc0704300032r394d6510mfb0ba38fa0be791b@mail.gmail.com>
	<528646bc0704300122r29747b36q648fcde3da755a36@mail.gmail.com>
In-Reply-To: <528646bc0704300122r29747b36q648fcde3da755a36@mail.gmail.com>
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

Grant Likely wrote:
>
> Oops; that patch won't work.  Try this one instead.

    What really needs to be done is to create some kind of mini-driver
architecture for the boot and debug serial drivers.
    There are only something like 4 or 5 simple functions, and in many
cases only putchar() needs implimented.
   
    The whole boot/debug early serial stuff is highly and unescesarily
8250 specific. While there are several alternatives,
    these typically involve numerous #ifdef's and then end up being
board specific.
   
    Being able to output data, before linux has loaded, or before the
standard serial drivers have initialized is probably not important for
    working systems, but is incredibly useful when trying to bring up a
new board - particularly if you are trying to do so with
    silly scopes, logic analyzers, and other electronic gizmo's

    "give me an output bit and an LED to hang on it, and I can flash the
world"

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
