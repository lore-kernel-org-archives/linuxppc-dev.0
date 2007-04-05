Return-Path: <SRS0+dbfa744e487eb5695f7d+1320+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A029DDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 22:46:32 +1000 (EST)
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17940.14667.503535.507564@cargo.ozlabs.ibm.com>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<20070404022544.59b022a6@the-village.bc.nu>
	<17939.10130.687893.167511@cargo.ozlabs.ibm.com>
	<1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<17939.17962.248566.886449@cargo.ozlabs.ibm.com>
	<1175696383.2774.24.camel@shinybook.infradead.org>
	<17940.14667.503535.507564@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 08:45:53 -0400
Message-Id: <1175777154.2719.14.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-05 at 09:48 +1000, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > OK, how about a config option to preserve the old behaviour...
> 
> Well, that's a start but it doesn't provide a migration path.
> 
> Is it possible to have the pmac_zilog ports registered both with the
> new number and with the old number (assuming it's not already taken)?
> That way people can move over gradually.

The new option was intended to provide a way to retain the old behaviour
for systems where the kernel is updated but userspace must remain
unchanged (for some reason I can't quite imagine right now).

For _migration_, I think we can handle it better in userspace.

Anyone who builds their own kernel can also manage to change one or two
scripts or configuration files which currently refer to ttyS0. The only
case where the question of migration really holds any water is for
distributions.

In Fedora, pmac_zilog has never worked -- the module always failed to
load because 8250 was built-in. So it's an easy choice there -- we just
switch over and it's fixed.

Other distributions which change over to the fixed behaviour, if they
want 8250 and z8530 ports to co-exist, can provide a udev rule which
creates a symlink from ttySn->ttyPZ0 for backwards compatibility.

Of course, the _numbers_ might change -- a given port might no longer be
ttyS0 but ttyS1. But we're happy to overlook that one even though the
effect on the user is identical, right?

That doesn't address the fact that the 'console=' kernel command line
argument needs changes. But in general, users who are that non-technical
don't use serial consoles, and those who do can cope with this.

I think perhaps we should add this new config option to the
feature-removal-schedule right now, and take it out after a year or so.
That should be plenty of time for people to upgrade.

-- 
dwmw2
