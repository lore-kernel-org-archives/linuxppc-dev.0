Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 45EDFDDF56
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 13:40:33 +1000 (EST)
Date: Sun, 29 Apr 2007 13:40:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] [2.6.22] pasemi: cpufreq driver
Message-Id: <20070429134059.feed0dc1.sfr@canb.auug.org.au>
In-Reply-To: <20070429025021.GC2781@isilmar.linta.de>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
	<20070427054601.GB7755@lixom.net>
	<20070429025021.GC2781@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: arnd@arndb.de, cpufreq@lists.linux.org.uk, linuxppc-dev@ozlabs.org,
	egor@pasemi.com, Olof Johansson <olof@lixom.net>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 28 Apr 2007 22:50:21 -0400 Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>
> Hi,
> 
> On Fri, Apr 27, 2007 at 12:46:01AM -0500, Olof Johansson wrote:
> > +	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
> 
> (u32) or (32*) ?

Neither, get_property now returns (void *) so casting is not needed or
wanted.

Also, later in the patch, you modify the property value in place.  Do not do this. To help you remember, if you had not done the cast, gcc would have complained because get_property return a const void *.

Also, get_property is now called of_get_property.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
