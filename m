Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CD50681B8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 05:48:56 +1100 (EST)
Date: Thu, 19 Jan 2006 14:48:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Message-ID: <20060119164811.GB4418@dmt.cnet>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
	<1137664156.8471.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137664156.8471.16.camel@localhost.localdomain>
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

On Thu, Jan 19, 2006 at 09:49:16AM +0000, Alan Cox wrote:
> On Iau, 2006-01-19 at 00:58 -0600, Kumar Gala wrote:
> > Since we can only open the watchdog once having a spinlock to protect
> > multiple access is pointless.
> > 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> NAK
> 
> This is a common mistake.
> 
> open is called on the open() call and is indeed in this case 'single
> open', but file handles can be inherited and many users may have access
> to a single file handle.
> 
> eg
> 
> 	f = open("/dev/watchdog", O_RDWR);
> 	fork();
> 	while(1) {
> 		write(f, "Boing", 5);
> 	}

Oops.

At least 50% of the watchdog drivers rely solely on the "wdt_is_open"
atomic variable and are broken with respect to synchronization.
