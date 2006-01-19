Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C756F68A14
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 09:13:01 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20060119164811.GB4418@dmt.cnet>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
	<1137664156.8471.16.camel@localhost.localdomain>
	<20060119164811.GB4418@dmt.cnet>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 22:12:19 +0000
Message-Id: <1137708739.8471.69.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Kumar Gala <galak@gate.crashing.org>,
	wim@iguana.be, linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Iau, 2006-01-19 at 14:48 -0200, Marcelo Tosatti wrote:
> On Thu, Jan 19, 2006 at 09:49:16AM +0000, Alan Cox wrote:
> > 
> > 	f = open("/dev/watchdog", O_RDWR);
> > 	fork();
> > 	while(1) {
> > 		write(f, "Boing", 5);
> > 	}
> 
> Oops.
> 
> At least 50% of the watchdog drivers rely solely on the "wdt_is_open"
> atomic variable and are broken with respect to synchronization.

What an excellent janitors project
