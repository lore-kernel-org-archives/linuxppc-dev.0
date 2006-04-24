Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9183A679EF
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 05:20:20 +1000 (EST)
Date: Mon, 24 Apr 2006 12:21:41 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060424192141.GC11896@mag.az.mvista.com>
References: <20060420215514.GE25755@gate.ebshome.net>
	<1468.1145570898@www002.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1468.1145570898@www002.gmx.net>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 21, 2006 at 12:08:18AM +0200, Gerhard Pircher wrote:
> > --- Ursprüngliche Nachricht ---
> > Von: Eugene Surovegin <ebs@ebshome.net>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> > Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> > Datum: Thu, 20 Apr 2006 14:55:14 -0700
> > 
> > Well, you aren't the first person who tries to run G4 with 
> > CONFIG_NOT_COHERENT_CACHE. This was done before and I don't remember 
> > that those people had to implement anything as complex as you are 
> > trying to do.
> 
> Maybe these systems have cache coherent northbridges, which is not the case
> for the AmigaOne and its "famous" ArticiaS northbridge.

Nope.  I believe Eugene is referring to the Marvell 64x60 line of *North*
bridges.

> > You can try asking on #mklinux. It always better to ask people who 
> > actually _did_ this :).
> > 
> > In fact, I just grepped 2.6 and found 
> > #ifdef(CONFIG_NOT_COHERENT_CACHE) in syslib/mv64x60.c. Guess what 
> > systems usually have this type of bridge? Not 4xx/8xx, that's for sure.
> 
> Hmm, strange. AFAIK the NOT_COHERENT_CACHE config option is available only
> for the 4xx and 8xx platforms. Wouldn't the config option depend on
> CONFIG_6XX too, if there are not cache coherent systems with G4 cpus? 
> 
> At least I could not compile in the dma-mapping.c file without modifying the
> Kconfig file.

If you're looking in arch/ppc/Kconfig in either the kernel.org or paulus'
git trees, look further down.  There is a separate option where
NOT_COHERENT_CACHE can be set for 64x60 bridges.

Mark
