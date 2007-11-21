Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4CD2EDDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 23:52:07 +1100 (EST)
Message-ID: <474429E9.401@scram.de>
Date: Wed, 21 Nov 2007 13:51:53 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: linux2.6.19.2-> mpc8xx_wdt.c: timeout extended to reach several
	seconds... but I have a problem
References: <F1F6EC0C8B75034F9E3A79FC85122E8E2649FB@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E2649FB@aquib01a>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Antonio,

> I added a kernel timer (triggering every 500 ms) to reset the watchdog
> of mpc8xx. This timer starts when the driver is opened. The timer is
> rearmed till a counter reaches a zero value. A process can use the write
> method of the driver to set the counter to a preferred value. If the
> application misses to set the counter, it will decrease to zero and then
> the board will restart.

You might want to have a look at this patch:

http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=14682

Please make sure to call pq_wdt_init() as early as possible to avoid a
reset during the initial log buffer flush to the serial console.

Thanks,
Jochen
