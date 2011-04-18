Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 0D72A1007E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Apr 2011 07:43:50 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 9/14] PM / Blackfin: Use struct syscore_ops instead of
	sysdevs for PM
Date: Mon, 18 Apr 2011 23:43:41 +0200
References: <201103280125.11750.rjw@sisk.pl> <201104172311.59289.rjw@sisk.pl>
	<BANLkTi=BRXtsG0wK6SbK-6L-xzwMccR3eQ@mail.gmail.com>
In-Reply-To: <BANLkTi=BRXtsG0wK6SbK-6L-xzwMccR3eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201104182343.41702.rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Russell King <linux@arm.linux.org.uk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>,
	Kay Sievers <kay.sievers@suse.de>,
	Linux PM mailing list <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, April 18, 2011, Mike Frysinger wrote:
> On Sun, Apr 17, 2011 at 17:11, Rafael J. Wysocki wrote:
> > Convert some Blackfin architecture's code to using struct syscore_ops
> > objects for power management instead of sysdev classes and sysdevs.
> >
> > This simplifies the code and reduces the kernel's memory footprint.
> > It also is necessary for removing sysdevs from the kernel entirely in
> > the future.
> 
> looks straight forward enough ...
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> 
> > +static struct syscore_ops nmi_syscore_ops = {
> >        .resume         = nmi_wdt_resume,
> >        .suspend        = nmi_wdt_suspend,
> >  };
> 
> a bit sad this couldnt be made const

Well, that would trigger a compiler warning from register_syscore_ops().

However, I'm going to make that change change everywhere at once when all of
the conversions have been made, since it looks like we're only going to have
static syscore_ops.

Thanks,
Rafael
