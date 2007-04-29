Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AD93CDDF5E
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 14:38:44 +1000 (EST)
Date: Sat, 28 Apr 2007 23:39:22 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070429043922.GA7478@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
	<20070427054601.GB7755@lixom.net>
	<20070429025021.GC2781@isilmar.linta.de>
	<20070429134059.feed0dc1.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070429134059.feed0dc1.sfr@canb.auug.org.au>
From: olof@lixom.net (Olof Johansson)
Cc: arnd@arndb.de, cpufreq@lists.linux.org.uk,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linuxppc-dev@ozlabs.org, paulus@samba.org, egor@pasemi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 29, 2007 at 01:40:59PM +1000, Stephen Rothwell wrote:
> On Sat, 28 Apr 2007 22:50:21 -0400 Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> >
> > Hi,
> > 
> > On Fri, Apr 27, 2007 at 12:46:01AM -0500, Olof Johansson wrote:
> > > +	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
> > 
> > (u32) or (32*) ?
> 
> Neither, get_property now returns (void *) so casting is not needed or
> wanted.
> 
> Also, later in the patch, you modify the property value in place.  Do not do this. To help you remember, if you had not done the cast, gcc would have complained because get_property return a const void *.

Yep. It came along over from the cbe_cpufreq driver, which also does
it. I'll post a patch tomorrow or Monday unless someone else beats me
to it (the driver has already been merged).

> Also, get_property is now called of_get_property.

Sure, but keeping up with the API churn during other patch merging is a mess. It's easier to
make one final pass over all new code and fix it up once more later during the merge window.


-Olof
