Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 3BD39DDEE5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 15:00:02 +1000 (EST)
Date: Thu, 28 May 2009 01:00:00 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
Message-ID: <20090528010000.31423083@lappy.seanm.ca>
In-Reply-To: <fa686aa40905272042yd7b4698gbd1133b4c61c9b87@mail.gmail.com>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop>
	<1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de>
	<1243226023.24376.23.camel@pasglop>
	<20090527233451.2d02343d@lappy.seanm.ca>
	<fa686aa40905272042yd7b4698gbd1133b4c61c9b87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 May 2009 21:42:18 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> Make your driver use a platform device or an of_platform device.  It's
> not at all hard.

Here is my first shot.... any other fields that I need to fill in so I
don't have any gotchas?

/* This must exist */
static void warp_device_release(struct device *dev) {}

static struct platform_device warp_device = {
	.name = "warp-device",
	.id = 0,
	.num_resources = 0,
	.dev = {
		.coherent_dma_mask = ~0ULL,
		.release = warp_device_release,
	},
};


	platform_device_register(&warp_device);

Cheers,
   Sean
