Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 598BE2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 04:01:49 +1100 (EST)
Message-ID: <1390323689.24905.484.camel@snotra.buserror.net>
Subject: Re: [PATCH RFC] powerpc/mpc85xx: add support for the kmp204x
 reference board
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Tue, 21 Jan 2014 11:01:29 -0600
In-Reply-To: <52DEA179.9090607@keymile.com>
References: <1389879525-27130-1-git-send-email-valentin.longchamp@keymile.com>
 <1389915301.24905.240.camel@snotra.buserror.net>
 <52D9273E.10008@keymile.com>
 <1389995322.24905.275.camel@snotra.buserror.net>
 <52DD50F7.1050107@keymile.com>
 <1390257432.24905.329.camel@snotra.buserror.net>
 <52DEA179.9090607@keymile.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-21 at 17:34 +0100, Valentin Longchamp wrote:
> On 01/20/2014 11:37 PM, Scott Wood wrote:
> > On Mon, 2014-01-20 at 17:38 +0100, Valentin Longchamp wrote:
> >> On 01/17/2014 10:48 PM, Scott Wood wrote:
> >>> Why isn't the compatible "keymile,kmcoge4", like the model?
> >>
> >> Because kmcoge4 is the board that is based on the kmp204x architecture/design.
> >> We expect other boards (kmcoge7 for instance) based on the same kmp204x design.
> > 
> > The top-level compatible isn't for the "architecture" or the "design".
> > It's for the board.  Surely there's something different about kmcoge7
> > versus kmcoge4 -- is it visible to software?
> 
> There should only be a few differences in the dts between the two boards.
> 
> Reading the ePAPR my understanding was that compatible is the "programming
> model" and that's what I have named above design/architecture while model is the
> exact model of the device in this case the exact board name.

In practice, model is more for human consumption (e.g. there may be many
variants that all look identical to software).  The "programming model"
for an entire board includes everything on it.
 
> >> You would prefer that I have the model and compatible stricly the same and add
> >> any future board into the compatible boards[] from corenet_generic ?
> > 
> > That's how it's usually done.  Or, at least provide the board
> > architecture name as a secondary compatible after the board name.
> > 
> >> If possible I would like to be able to see the boards that are based on a
> >> similar design, that's what I wanted to achieve with this kmp204x name.
> > 
> > Is "kmp204x" an official name of the architecture, rather than a
> > generalization of "kmp2040" and "kmp2041"?  If there were a p2042, and
> > you made a board for it, is there any chance it would be called kmp204x
> > even if it were very different from the p2040/p2041 board?
> 
> It's the name we have picked up, but it's not official. We also use km83xx,
> km82xx and it was derived from that.
> 
> If the hypothetical p2042 board was different it would then have another name.

In that case, I don't object to it being listed in compatible, though
the specific board name should come first.

> >>> The device tree describes the hardware, not what driver you want to use.
> >>>
> >>> Plus, I don't see any driver that matches "gen,spidev" nor any binding
> >>> for it, and "gen" doesn't make sense as a vendor prefix.  The only
> >>> instance of that string I can find in the Linux tree is in mgcoge.dts.
> >>
> >> Well it comes from mgcoge and that's why I have used this
> >>
> >> It's for usage with the spidev driver (driver/spi/spidev.c). I agree that the
> >> gen brings nothing. Would
> >>
> >> spidev@1 {
> >> 	compatible = "spidev";
> >>
> >> make more sense ?
> > 
> > It doesn't address any of the other comments.
> 
> Can you please explicitly tell me how I should build this node ? What other
> comments ? Must I be more generic with the name ?
> 
> Something like :
> 
> spi@1 {
> 	compatible = "zarlink,30343", "spidev";

Remove "spidev".  Any nodes under the SPI controller node will be SPI
devices, right?  So it doesn't add anything regarding hardware
description.
 
-Scott
