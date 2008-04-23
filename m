Return-Path: <cbouatmailru@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 6F812DDF9E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 10:37:43 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so2072289fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 17:37:42 -0700 (PDT)
Date: Wed, 23 Apr 2008 04:37:37 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO
	LEDs, MCU, and NAND on UPM
Message-ID: <20080423003737.GA11781@zarina>
References: <20080422194135.GA27822@polina.dev.rtsoft.ru>
	<fa686aa40804221308w5960ces1f03a6a8c049edd4@mail.gmail.com>
	<1208897422.6654.61.camel@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1208897422.6654.61.camel@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 03:50:22PM -0500, Josh Boyer wrote:
> On Tue, 2008-04-22 at 14:08 -0600, Grant Likely wrote:
> > On Tue, Apr 22, 2008 at 1:41 PM, Anton Vorontsov
> > <avorontsov@ru.mvista.com> wrote:
> > > Hi all,
> > > +    w) NAND on UPM-driven Freescale Localbus
> > > +
> > > +      Required properties:
> > > +      - compatible : "fsl,upm-nand".
> > > +      - reg : should specify localbus chip select and size used for the chip.
> > > +      - width : should specify port size in bytes.
> > > +      - fsl,upm-addr-offset : UPM pattern offset for the address latch.
> > > +      - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
> > > +      - fsl,wait-pattern : should be present if NAND chip requires waiting
> > > +        for Ready-Not-Busy pin after each executed pattern.
> > > +      - fsl,wait-write : should be present if NAND chip needs waiting on
> > > +        Ready-Not-Busy pin after each write cycle.
> > > +      - linux,chip-delay : optional, may contain delay value in milliseconds
> > > +        (in case when Ready-Not-Busy pin was unspecified).
> > > +      - gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
> > 
> > I'm not competent to comment on this binding; I haven't spent any time
> > looking at NAND binding conventions.
> 
> That's because there are none, and every time someone proposes one it's
> like this.  Full of weird $board specific stuff that have nothing to do
> with the actual NAND chip.
> 
> For example, why is fsl,wait-write defined as an fsl specific property?
> It seems generic to the NAND chip itself.  Also, why in the example is
> the specific NAND chip part number listed, followed by fsl,upm-nand?
> It's almost as if people want to mix the NAND chip and NAND controller
> definitions together.  Maybe there is a good reason for it, but it's
> really confusing.

Much thanks for the idea, I should indeed separate UPM NAND controller
and NAND chip itself.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
