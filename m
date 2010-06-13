Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75086100823
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 15:48:30 +1000 (EST)
Subject: Re: Request review of device tree documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 13 Jun 2010 15:48:07 +1000
Message-ID: <1276408087.1962.552.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Olof Johansson <olof@lixom.net>, Mitch Bradley <wmb@firmworks.com>,
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

On Sat, 2010-06-12 at 23:07 -0600, Grant Likely wrote:
> 
> What is needed to keep OFW alive?  I've got no problem with doing so
> if it isn't invasive, and as long as the same boot entry interface can
> be used.

Well, no. OF has a well defined "client interface" which is what gets us
in prom_init.c on powerpc when r5 is non NULL. You can use it to do
things like access devices or the device-tree.

We use that to suck the device-tree, which we flatten, and then re-enter
the kernel with the "common" entry interface.

If you want to keep OF alive, you -can- probably do that too, but it's
more tricky. You need to keep the memory where OF resides reserved, OF
might need special MMU translations, you maybe need to install hooks in
OF itself for it to be able to manipulate some of those, etc...

> What is the use-case for having a dynamic device tree?  I can see
> keeping OFW alive being useful for some debug facilities, but once the
> kernel has started, I'm really not interested in relying on firmware
> to manage the hardware.  (but then again it's no secret that I'm
> suspicious of anything that depends on runtime interaction with
> firmware).

As we all are :-)

I see one genuine use of dynamic device-tree though, which is in a
virtualized environment (where the host can be Linux itself). Hotplug
can then be a matter of getting new nodes & properties fed down to the
OS by the hypervisor/firmware.

pSeries somewhat works like that, but using weirdo rtas calls. We could
do something saner for kvm or whatever other hypervisors we have some
amount of control onto, where bits of compiled dtb can be handed down
representing a sub-hierarchy of the tree.

Cheers,
Ben.
