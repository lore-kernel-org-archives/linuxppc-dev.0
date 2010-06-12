Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E79A9B7E16
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 08:52:35 +1000 (EST)
Subject: Re: Request review of device tree documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitch Bradley <wmb@firmworks.com>
In-Reply-To: <4C13B618.1030006@firmworks.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com>  <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>  <4C13B618.1030006@firmworks.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 13 Jun 2010 08:52:12 +1000
Message-ID: <1276383132.1962.195.camel@pasglop>
Mime-Version: 1.0
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Olof Johansson <olof@lixom.net>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-06-12 at 06:30 -1000, Mitch Bradley wrote:

> I'm certainly going to try keeping OFW alive.  On the x86 OLPC machines, 
> the ability to
> dive into OFW via a SysRq key combo was very helpful for debugging some 
> difficult
> problems.  The team has asked me to support the feature on ARM.

Oh well, if you can and can convince the ARM kernel folks to do the
necessary changes ... :-)

One thing tho, you will only benefit from the whole infrastructure we
have created accross platforms in linux if the device-tree is "sucked"
into linux at boot. IE. Linux will not do constant accesses to OF for
the DT. Even sparc converted to that now.

That means that if your device-tree has a dynamic nature, we'll need to
come up with a way to inform the kernel of changes in it so it can
update it's copy accordingly.

We also don't have much mechanisms within Linux to notify users that
things have changed either. It only really happens on IBM pseries for
hotplug, which uses a private notifier.

Ben.
