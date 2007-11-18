Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E387DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Nov 2007 20:28:39 +1100 (EST)
Message-ID: <4740000A.9060900@dlasys.net>
Date: Sun, 18 Nov 2007 04:04:10 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: John Williams <jwilliams@itee.uq.edu.au>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Xilinx TEMAC driver
References: <46A5C305.5000903@dlasys.net>
	<fa686aa40707242129p1b5f5299i44818ead5ed4d2f3@mail.gmail.com>
	<47392A2A.7020200@itee.uq.edu.au>
In-Reply-To: <47392A2A.7020200@itee.uq.edu.au>
Content-Type: text/plain; charset=us-ascii
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
> Hi David, GRant
>
> Any progress on the ll_temac driver since July? In EDK9.2, ll_temac is
> really the only supported ethernet solution, apart from ethernet lite
> (yuck).
>
> If there's a PPC version in a reasonable state, i'm happy to see
> what's requierd to port it across to MicroBlaze.
Little has been done since July. The version I posted did have ll_temac
support that once upon a time worked.

I have little experience on the firmware side - yet. Though I keep
getting pushed towards it, I also end up sufficiently busy on the
software side as to have no time to even finish installing Xilinx tools.
But I am pretty sure Pico is using 9.2 and I am completely certain we
are not currently using the ll_temac.

BUT, there is serious discussion about going back to it. We strive for
the absolute smallest firmware needed for a task. We have clients that
need Linux or GreenHills on the card AND are designing large blocks of
firmware for their own purposes. No matter how much free space we give
them they need more.

I have heard that the current incarnations of the ll_temac support
interrupts. This was the deal breaker for us on the original ll_temac.
Linux could be made to work (fairly badly) without interrupts, but while
nothing is impossible, trying to write a GreenHills NIC driver that is
polled was an excercise in futility. I managed to get a polled serial
driver working - but it was very ugly.

Presuming that the currently ll_temac is smaller than the plb
implimentation and presuming that it has the option of interrupts, it is
likely to return to my todo list shortly - of course that list is fairly
long. I have spent the past several months massaging Pico's Host
utilites to run under Linxu 2.6, 2.4, OpenBSD, and Mac OS X. I have been
living exclusively in Linux since March. I accidentally obliterated my
Windows partition and the recovery partition installing OS X86 and have
not even noticed it is gone.





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
