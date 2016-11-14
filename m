Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHSp63yPCzDvXK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:23:57 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yangbo Lu <yangbo.lu@nxp.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Dirk Behme <dirk.behme@de.bosch.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 7/7] soc: renesas: Identify SoC and register with the
 SoC bus
Date: Mon, 14 Nov 2016 12:22:52 +0100
Message-ID: <3061300.3PHW8Uxca3@wuerfel>
In-Reply-To: <CAMuHMdWavRFnYFmiL2jy3KWZnHG_F8qaxK29zHx6fsLmqXEwiA@mail.gmail.com>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <25057157.YlGi2v6RrE@wuerfel>
 <CAMuHMdWavRFnYFmiL2jy3KWZnHG_F8qaxK29zHx6fsLmqXEwiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, November 14, 2016 11:51:15 AM CET Geert Uytterhoeven wrote:
> On Thu, Nov 10, 2016 at 12:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday, November 10, 2016 11:19:20 AM CET Geert Uytterhoeven wrote:
> >> On Wed, Nov 9, 2016 at 5:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Monday, October 31, 2016 12:30:55 PM CET Geert Uytterhoeven wrote:
> >> >>   - Use "renesas,prr" and "renesas,cccr" device nodes in DT if
> >> >>     available, else fall back to hardcoded addresses for compatibility
> >> >>     with existing DTBs,
> 
> >> > It does seem wrong to have a device node for a specific register though.
> >> > Shouldn't the node be for the block of registers that these are inside
> >> > of?
> >>
> >> On R-Mobile APE6, R-Car Gen2 and Gen3, PRR is a lone register.
> >> On R-Car Gen1, it's not even documented (and doesn't exist on all parts).
> >
> > It just seems odd to have it at address 0xff000044 when all the other
> > devices are at page-aligned addresses. Do you mean that accessing
> > 0xff000040 or 0xff000048 will result in a bus-level exception for a
> > missing register and just 0xff000044 is actually valid for access,
> > or is it just the only thing that is documented?
> 
> For PRR, all other registers in the page read as all zeroes on all SoCs that
> have it. So it really is a lone register.

Ok.

> >> On SH-Mobile/R-Mobile, CCCR may be part of the HPB/APB register block, which
> >> we further don't touch at all.
> >> On R-Car Gen2, it's not documented, but does exist.
> >
> > This is where the family names would come in handy ;-) I now have
> > no idea which chip(s) you are referring to.
> 
> SH/R-Mobile are r8a7740, r8a73a4, sh73a0.
> R-Car Gen2 are r8a779[0-4].
> 
> > If you know the name of the register block, just put it into DT with
> > that name. The driver can trivially add the right offset.
> 
> CCCR is different. The amount of registers that read as non-zero depends a lot
> on the actual SoC.
> 
> HPB/APB is gonna need real DT bindings, which needs some more investigation.
> Hence if you don't mind, I'd like to postpone that part, which only affects
> the older SoCs. And I'll drop the "renesas,cccr" binding.
> 
> For now, having revision detection for R-Car Gen3 (r8a779[56]) using PRR is
> most urgent, as several drivers (e.g. HDMI, Ethernet, clocks, pinctrl) are
> waiting for this support. So I'd like to have that dependency in v4.10.

Ok, sounds good.

> >> There is no SoC part number in the "renesas,prr" and "renesas,cccr" nodes.
> >> Hence I always need to look at the root nodes.
> >
> > Not sure what that would protect you from. Could you have a renesas,cccr
> 
> Looks like you forgot to finish your sentence?

Yes, and I forgot what I was going to say there now. It's probably covered
by what we discussed above.

	Arnd
