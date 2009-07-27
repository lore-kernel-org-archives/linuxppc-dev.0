Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2474AB7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 07:59:24 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A48DFDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 07:59:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6RLx35R009432
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 14:59:13 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n6RLx2VI025717
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 16:59:02 -0500 (CDT)
Date: Mon, 27 Jul 2009 16:59:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: PPCboot and latest kernel
Message-ID: <20090727215901.GA19572@b07421-ec1.am.freescale.net>
References: <e571380d0907191132u3985423aiacc7ec8c75c0534b@mail.gmail.com>
	<e571380d0907191136j37d341d7k514f46396a38abc3@mail.gmail.com>
	<20090720174041.1873A832E416@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090720174041.1873A832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, vijay sharma <vjai22@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 20, 2009 at 07:40:41PM +0200, Wolfgang Denk wrote:
> > zImage starting: loaded at 0x01900000 (sp: 0x0fdc3a08)
> > Allocating 0x165ca04 bytes for kernel ...
> > gunzipping (0x00000000 <- 0x0190c000:0x02f58efc)...done 0x1637b54 bytes
> 
> You loaded the image at 01900000, but the uncompr4essed image extends
> until 02f58efc, i. e. there is a good chance that you will overwrite
> parts of the still uncompressed image.

I think the above output says that the compressed image extends to
0x02f58efc, and that the uncompressed image goes from zero to 0x165ca04. 
So no conflict (you should get an error message in case of conflict) with
0x01900000.

> > Linux/PowerPC load:
> > Finalizing device tree... flat tree at 0x2f65300 <== Beyond this point no
> > output is available.
> 
> Your device tree might be wrong, too.

Either that or something is wrong with the kernel itself.  This is the
point at which it transfers control to the main kernel.

-Scott
