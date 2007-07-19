Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02E1DDDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 19:47:45 +1000 (EST)
Date: Thu, 19 Jul 2007 02:47:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 2/3] ps3: BD/DVD/CD-ROM Storage Driver
Message-Id: <20070719024730.03609f1f.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.62.0707191137470.8661@pademelon.sonytel.be>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.529280000@pademelon.sonytel.be>
	<20070718164351.a92ec032.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191100270.8661@pademelon.sonytel.be>
	<20070719021752.35cb7daa.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191137470.8661@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Linux/PPC,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Development <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Jul 2007 11:39:32 +0200 (CEST) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

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
> 
> instead?

Yes.  Not that it's a terribly important issue, particularly down in the
dark and dusty corners where this code lurks.  The "function" as an lvalue
thing would be more obnoxious in some top-level interface.  We probably
already have some :(

If it were mine I'd open-code the "set" and do the "get" as a static
inline.  Or you could leave it as-is and go off and do something more
important ;)
