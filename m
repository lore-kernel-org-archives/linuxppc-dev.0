Return-Path: <david.hagood@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id E5B82B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 22:30:50 +1100 (EST)
Received: by yws5 with SMTP id 5so879775yws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 04:30:48 -0700 (PDT)
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: David Hagood <david.hagood@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
In-Reply-To: <4CB2DE2B.7040504@windriver.com>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
	<4CB2DE2B.7040504@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Oct 2010 06:30:44 -0500
Message-ID: <1286796644.2545.29.camel@chumley>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-11 at 17:51 +0800, tiejun.chen wrote:
> 
> You should define MSI device nodes on your target dts. And you can refer to the
> file, mpc8572ds.dts.
> 
> Often U-Boot dose not generate MSI information and embed that to dtb.
> 
> > 
> > But even assuming you can define these nodes at run time, as far as I can
> > see, you are right back to the question of "and how do I know what the
> > mappings are so I can create the node?" You haven't answered the question,
> > you've just moved where you are asking it.
> 
> I think you can check fsl_msi.c to figure out what you want.
<snip>

> Often most latest classic books/articles always use x86 code as an
example to
> clarify Linux. So you have to understand something on PPC via codes.
But I think
> you will benefit more information from the codes than documents :)
> 

RTFS. That wouldn't be bad advice, if the source were actually
commented. None of these APIS have any meaningful comments in them,
around them, or anywhere near them. You'd think we were back in the old
BASIC days, when comments occupied run-time memory. Code can tell me
WHAT is being done, but not WHY, and not what assumptions are being
made.

So when you say "You should define MSI device nodes on your target dts."
we go right back to my comment of "You haven't answered the question,
you've just moved where you are asking it."

> 
> Firstly you should use irq_of_parse_and_map()/irq_create_mapping() to map the
> real hardware irq to virtual irq. Then use request_irq() with the virtual irq to
> hook your interrupt handler.
And when I do that, I get a segfault as my follow-on mail reports.

> 
> Maybe you can check the file, ppc4xx_pci.c since ppc4xx also can support EP as I
> previously said. And sounds Scott will do something to support EP for Freescale
> chip.
I will look at that file.

> 
> Looks you want to your host root complex to trigger MSI to mpc8641 EP target? If
> so I'm a bit confused since MSIs should be delivered to to the Root Complex
> resided on your host.
I want the host to be able to interrupt the PPC. Since this is PCIe, the
only way that will be working is for the root complex to do a write to
somewhere on the PPC. This is basically the same mechanism as MSI, only
with the PPC as the target of the write rather than the root complex.
Obviously, the rest of the PCI devices will be sending interrupts to the
root complex, some via MSI. That has nothing to do with this discussion.

Since the PPC is in endpoint mode, the MSI hardware on the PPC won't be
used. The hardware is writable from the root complex via the PPC BAR0,
so I see no reason not to reuse it to trigger interrupts on the PPC from
the Root complex.
