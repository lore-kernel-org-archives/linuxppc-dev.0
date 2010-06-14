Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id 18437B7D81
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 01:58:55 +1000 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008;
	32bit))
	with ESMTP id <0L4000IXCHQ64YC0@VL-MR-MR002.ip.videotron.ca> for
	linuxppc-dev@ozlabs.org; Mon, 14 Jun 2010 11:58:54 -0400 (EDT)
Date: Mon, 14 Jun 2010 11:58:54 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Request review of device tree documentation
In-reply-to: <AANLkTim1mYpaxe-_OGbOF3AaZ6m5_SVUXLbeyKnAyvjs@mail.gmail.com>
Message-id: <alpine.LFD.2.00.1006141143480.13427@xanadu.home>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com> <1276408773.1962.574.camel@pasglop>
	<AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
	<alpine.LFD.2.00.1006140943350.13427@xanadu.home>
	<AANLkTim1mYpaxe-_OGbOF3AaZ6m5_SVUXLbeyKnAyvjs@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Olof Johansson <olof@lixom.net>, microblaze-uclinux@itee.uq.edu.au,
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

On Mon, 14 Jun 2010, Grant Likely wrote:

> The discussion *started* with a request to review this document:
> 
> http://devicetree.org/Device_Tree_Usage
> 
> Which is in early draft form (which is why the arm list wasn't
> initially cc'd. I was soliciting feedback from the current device tree
> users.  A second request for review will go out after rework is done
> to the document).

I'm therefore assuming I can safely ignore it for now then.

> In one of the reply threads Mitch stated that he is working on an ARM
> project that will use Open Firmware as the bootloader, and that he'd
> like the ability to keep OFW available after the kernel is booted
> which is something currently done on both Sparc and OLPC x86.  Mitch
> will correct me if I'm made any misrepresentations here.

OK... but what does "keep OFW available" mean? And what for?

> Conceptually I'm not opposed to allowing OFW to stay resident
> providing that it does not impose new requirements on the boot
> interface (the kernel would still need to be handed the flattened
> representation of the device tree) and that the code to do so is well
> contained in the kernel.  The devil is of course in the details on how
> feasible it is to accomplish.

Well, you'd need to tell the kernel about what memory area not to touch 
(given that memory is not in some area the kernel will touch anyway when 
it is in its early boot stage and still not smart enough to avoid it).

Then you'll need special code to perform those steps RMK already 
mentioned.  This is a bit like the low-level code for suspend/resume 
support is doing.  This is of course if I'm still guessing right about 
the whole purpose of this.

> ARM machines with Open Firmware are
> going to be the minority, so I'm not interested in doing anything
> special or out of the ordinary specifically to support it.

This certainly doesn't have to involve the core kernel.  A special 
module may even be sufficient to keep the complexity localized.  Just 
like low-level suspend/resume code is per SOC already anyway.

But again, what for?


Nicolas
