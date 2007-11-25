Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id CFEFEDDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 08:24:19 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so693397wag
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 13:24:17 -0800 (PST)
Message-ID: <9e4733910711251324y5116d90pab54a1a033d024e3@mail.gmail.com>
Date: Sun, 25 Nov 2007 16:24:17 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Access to PCI Expansion ROMs on PPC
In-Reply-To: <1196022000.7195.70.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
	<1196022000.7195.70.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/25/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Now, regarding that user problem, this it totally unrelated as it's a
> "mac" card.
>
> It's possible that it's one of these radeons that disable ROM access via
> a register in which case a quirk is needed to re-enable it.

He says in the first email that when he puts the boards into an x86
box he can read them. The quick turns the ROM back on if the firmware
is turning them off.

In the PPC box the ROMs aren't being run so they would still be in
power on state. I'd expect them to be readable in power-on state.

You can dump the PCI config block in /sys with hexdump and see if the
PCI_COMMAND_MEMORY bit is set. I was also unable to locate where in
the kernel PCI_COMMAND_MEMORY is being set. It could be that it is set
by the BIOS at boot on the x86 and not on the ppc.

-- 
Jon Smirl
jonsmirl@gmail.com
