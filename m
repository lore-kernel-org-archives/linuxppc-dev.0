Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A18B2DDDFA
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 02:02:01 +1000 (EST)
Message-ID: <465070EC.6030403@s5r6.in-berlin.de>
Date: Sun, 20 May 2007 18:01:48 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 2.6.22-rc2 built on ppc
References: <20070520112904.GM3253@aragorn.home.lxtec.de>
	<46506EE0.9000405@s5r6.in-berlin.de>
In-Reply-To: <46506EE0.9000405@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	ben.collins@ubuntu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:
> The allegedly unused variables are used in calls to dma_unmap_single(),
> but only for these calls.

and a call to dma_unmap_sg().

> On PPC32, you get
> 
> 	/* We do nothing. */
> 	#define dma_unmap_single(dev, addr, size, dir)  ((void)0)
> 
> in dma-mapping.h.  This is also the case for Linux 2.6.20.
> But in Linux 2.6.19 and older, it was
> 
> 	/* We do nothing. */
> 	#define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
...
> I don't know what's to blame for the warnings --- new gcc versions or
> the change from do { } while (0) to ((void)0)?
...

Ditto for dma_unmap_sg().
-- 
Stefan Richter
-=====-=-=== -=-= =-=--
http://arcgraph.de/sr/
