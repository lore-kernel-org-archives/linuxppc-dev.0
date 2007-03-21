Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C515FDDF11
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 03:28:50 +1100 (EST)
Date: Wed, 21 Mar 2007 09:22:07 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] PPC440EPx/440GRx EMAC support.
Message-ID: <20070321162207.GA2583@gate.ebshome.net>
References: <46003608.70308@ru.mvista.com> <20070321160438.GA3023@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321160438.GA3023@lixom.net>
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

On Wed, Mar 21, 2007 at 11:04:38AM -0500, Olof Johansson wrote:
> On Tue, Mar 20, 2007 at 10:29:12PM +0300, Valentine Barshak wrote:
> > diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac.h linux/drivers/net/ibm_emac/ibm_emac.h
> > --- linux.orig/drivers/net/ibm_emac/ibm_emac.h	2007-03-16 18:03:51.000000000 +0300
> > +++ linux/drivers/net/ibm_emac/ibm_emac.h	2007-03-18 18:53:08.000000000 +0300
> > @@ -26,7 +26,7 @@
> >  #if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
> >      !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
> >      !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE) && \
> > -    !defined(CONFIG_440GR)
> > +    !defined(CONFIG_440GR) && !defined(CONFIG_440EPX) && !defined(CONFIG_440GRX)
> 
> Same here. I know you only added a couple more, but it's reached critical
> mass (well, it did a while ago).

No, it's not same here. Please, take a time and look at the full code 
this particular snippet has nothing to do with Konfig stuff.

One can argue that it can be removed altogether, but I added this ugly 
check for a reason - people were adding support for new 4xx SoCs 
blindly in the past without checking that EMAC registers weren't 
changed slightly.

So, Valentine, keep this particular ugly ifdef as it is.

Also, Valentine, next time CC me with any EMAC changes because I'm not 
actively reading PPC maillists these days.

-- 
Eugene
