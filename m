Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [80.160.20.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A0779DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 19:41:25 +1000 (EST)
Date: Thu, 19 Jul 2007 11:41:01 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 2/3] ps3: BD/DVD/CD-ROM Storage Driver
Message-ID: <20070719094100.GF11657@kernel.dk>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.529280000@pademelon.sonytel.be>
	<20070718164351.a92ec032.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191100270.8661@pademelon.sonytel.be>
	<20070719021752.35cb7daa.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191137470.8661@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0707191137470.8661@pademelon.sonytel.be>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 19 2007, Geert Uytterhoeven wrote:
> On Thu, 19 Jul 2007, Andrew Morton wrote:
> > On Thu, 19 Jul 2007 11:02:07 +0200 (CEST) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > 
> > > On Wed, 18 Jul 2007, Andrew Morton wrote:
> > > > > +struct ps3rom_private {
> > > > > +	struct ps3_storage_device *dev;
> > > > > +	struct scsi_cmnd *curr_cmd;
> > > > > +};
> > > > > +#define ps3rom_priv(dev)	((dev)->sbd.core.driver_data)
> > > > > +
> > > > 
> > > > Someone should invent a keyboard which delivers an electric shock when the
> > > > operator types "#define".   In the meanwhile, I get to do the honours.
> > > > 
> > > > Please don't implement in a macro anything which can be implemented in C.
> > > 
> > > All I needed was a shorthand to access driver_data, for both read and write
> > > access (you cannot do the latter with C, unless you decouple read and write).
> > 
> > Oh dear.
> > 
> > 	ps3rom_priv(dev) = host;
> > 
> > that's 'orrid.  We have an identifier pretending to be a function, only we
> > go and treat it as an lvalue.
> > 
> > I mean, C code should look like C code, and the above just doesn't.
> > 
> > Sigh.
> 
> Do you prefer
> 
> static inline struct ps3rom_private *ps3rom_priv_get(struct ps3_storage_device
> *dev)
> {
> 	return dev->sbd.core.driver_data;
> }
> 
> static inline void ps3rom_priv_set(struct ps3_storage_device *dev,
> 				   struct ps3rom_private *priv)
> {
> 	dev->sbd.core.driver_data = priv;
> }

how about just killing them? it makes the code harder to read, what is
the point of abstracting something like that out?

-- 
Jens Axboe
