Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3EC9100813
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 16:12:01 +1000 (EST)
Subject: Re: Request review of device tree documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTikBjwuVvij8I91XaQgLfn8r_lZDrAsIBfJrHDBF@mail.gmail.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<1276408087.1962.552.camel@pasglop>
	<AANLkTikBjwuVvij8I91XaQgLfn8r_lZDrAsIBfJrHDBF@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Jun 2010 16:09:32 +1000
Message-ID: <1276495772.2552.22.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>, Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-06-13 at 23:13 -0600, Grant Likely wrote:
> > We use that to suck the device-tree, which we flatten, and then
> re-enter
> > the kernel with the "common" entry interface.
> 
> I don't think I want to do the same on ARM.  I'd rather have the
> prom_init stuff in a boot wrapper, or have OFW itself generate the
> flat representation before booting the kernel.

But then it's no longer OF. IE. A compliant OF implementation provides a
client interface API :-)

This is going to be especially important if Mitch wants to keep OF
alive.

I suppose it could be done via a wrapper like prom_init, which flattens
the tree, and sticks somewhere in a property the address of the OF
client interface callback though it's a tad awkward. If well defined, I
suppose Mitch might even be able to make his OF natively boot kernels
that way but that's of course up to him.

> I'm trying to constrain the number of things that could go wrong by
> defining only one way for getting the device tree data into the
> kernel.

I understand, and the flattened method is the most versatile, I'm just
pointing out the situation here :-)

> Right.  We don't need to use OFW/RTAS to handle this use case.

Definitely not. It will depend on whatever hypervisor interface is
implemented in a given environment. Though I do like the idea of passing
precompiled bits of .dtb around for hotplug :-) We could make that a
standard way of KVM to do things in embedded space.

Cheers,
Ben.
