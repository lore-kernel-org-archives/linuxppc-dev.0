Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 182B11A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:50:18 +1000 (AEST)
Message-ID: <1428454204.22867.497.camel@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
From: Scott Wood <scottwood@freescale.com>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Date: Tue, 7 Apr 2015 19:50:04 -0500
In-Reply-To: <20150408003638.GA5170@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
 <1428446044.22867.475.camel@freescale.com>
 <20150407235812.GA3443@ime.usp.br>
 <1428451332.22867.490.camel@freescale.com>
 <20150408003638.GA5170@ime.usp.br>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 21:37 -0300, Rogério Brito wrote:
> Dear Scott,
> 
> Once again, thank you very much for your answer.
> 
> On Apr 07 2015, Scott Wood wrote:
> > On Tue, 2015-04-07 at 20:58 -0300, Rogério Brito wrote:
> > > This is good to know. Is there any reasonable dts that I can copy/adapt?
> > 
> > I'm not familiar with how flash is connected on this chip, so I don't
> > have a specific recommendation other than to read the binding and look
> > at several examples.
> 
> How can I discover how the flash is connected? I'm really showing here that
> I am only a luser, but I am willing to find any specs so that this can be
> fixed.
>
> > > Another question: would putting the description of the flash device into the
> > > dts file be helpful to remove any code from the kernel?
> > 
> > If you currently have a custom flash map driver, you could get rid of
> > that, but I suspect that's already gone away due to the fact that it's
> > no longer working.
> 
> I see. If I do some "archaeology" (read: bisect when it stopped working),
> would that help to discover how the flash is connected?

It will probably give you the address and size of the flash, which is
good enough to get something working.  Does your config (for the old
kernel) have anything with PHYSMAP in it?  I suspect it probably broke
with commit dcb3e137ce9be1dfc86e306182b23e3ae5e239c4 ("[MTD] physmap:
make physmap compat explicit").

-Scott
