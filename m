Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A721DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 08:57:04 +1100 (EST)
Subject: Re: issue at the beginning of kernel booting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090402161209.GA19088@ld0162-tx32.am.freescale.net>
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
	<20090327161522.GA7809@ld0162-tx32.am.freescale.net>
	<22840131.post@talk.nabble.com>
	<20090402161209.GA19088@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Fri, 03 Apr 2009 08:54:55 +1100
Message-Id: <1238709295.10752.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Sauce.Cheng" <chmhou@sina.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-02 at 11:12 -0500, Scott Wood wrote:
> On Wed, Apr 01, 2009 at 08:23:42PM -0700, Sauce.Cheng wrote:
> > > I don't see where you set up a BAT that covers 0xf0000000.
> > 
> > if i have to set up a BAT that cover 0xF0000000. i had a debug with LEDs
> > like that in u-boot code. everything is //normal. 0xF00000000 is the value
> > of CFG_IMMR(CONFIG_SYS_IMMR) that memory map register, it is the phy address
> > and //base //address of all internal regishters, isnt? you mean that if i
> > set BATs, i should not get the phy address like in the //front ?
> 
> I don't quite follow the above, but what I meant is that you need to
> put a mapping in place that covers your LED I/O once you have the MMU on.
> 
> Any mappings that U-boot made will be gone at that point.

Also, f0000000 isn't a very good idea for a hard wired mapping, it will
overlap some kernel stuffs. You should dynamically allocate the virtual
address, or pick something above 0xfff00000 which should be unused iirc.

Ben.
