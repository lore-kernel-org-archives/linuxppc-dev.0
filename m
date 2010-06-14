Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195]) by ozlabs.org (Postfix) with ESMTP id 3BCB7B7D5C
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 15:14:11 +1000 (EST)
Received: by ywh33 with SMTP id 33so2583802ywh.11
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 22:14:10 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276408087.1962.552.camel@pasglop>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<1276408087.1962.552.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 13 Jun 2010 23:13:50 -0600
Message-ID: <AANLkTikBjwuVvij8I91XaQgLfn8r_lZDrAsIBfJrHDBF@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Sat, Jun 12, 2010 at 11:48 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2010-06-12 at 23:07 -0600, Grant Likely wrote:
>>
>> What is needed to keep OFW alive? =A0I've got no problem with doing so
>> if it isn't invasive, and as long as the same boot entry interface can
>> be used.
>
> Well, no. OF has a well defined "client interface" which is what gets us
> in prom_init.c on powerpc when r5 is non NULL. You can use it to do
> things like access devices or the device-tree.
>
> We use that to suck the device-tree, which we flatten, and then re-enter
> the kernel with the "common" entry interface.

I don't think I want to do the same on ARM.  I'd rather have the
prom_init stuff in a boot wrapper, or have OFW itself generate the
flat representation before booting the kernel.  I'm trying to
constrain the number of things that could go wrong by defining only
one way for getting the device tree data into the kernel.

> If you want to keep OF alive, you -can- probably do that too, but it's
> more tricky. You need to keep the memory where OF resides reserved, OF
> might need special MMU translations, you maybe need to install hooks in
> OF itself for it to be able to manipulate some of those, etc...
>
>> What is the use-case for having a dynamic device tree? =A0I can see
>> keeping OFW alive being useful for some debug facilities, but once the
>> kernel has started, I'm really not interested in relying on firmware
>> to manage the hardware. =A0(but then again it's no secret that I'm
>> suspicious of anything that depends on runtime interaction with
>> firmware).
>
> As we all are :-)

:-)

> I see one genuine use of dynamic device-tree though, which is in a
> virtualized environment (where the host can be Linux itself). Hotplug
> can then be a matter of getting new nodes & properties fed down to the
> OS by the hypervisor/firmware.
>
> pSeries somewhat works like that, but using weirdo rtas calls. We could
> do something saner for kvm or whatever other hypervisors we have some
> amount of control onto, where bits of compiled dtb can be handed down
> representing a sub-hierarchy of the tree.

Right.  We don't need to use OFW/RTAS to handle this use case.

g.
