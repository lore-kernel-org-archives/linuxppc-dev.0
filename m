Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 68A68DE135
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 06:50:29 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2707771pyg.27
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 13:50:28 -0700 (PDT)
Subject: Re: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO
	LEDs, MCU, and NAND on UPM
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40804221308w5960ces1f03a6a8c049edd4@mail.gmail.com>
References: <20080422194135.GA27822@polina.dev.rtsoft.ru>
	<fa686aa40804221308w5960ces1f03a6a8c049edd4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 15:50:22 -0500
Message-Id: <1208897422.6654.61.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-04-22 at 14:08 -0600, Grant Likely wrote:
> On Tue, Apr 22, 2008 at 1:41 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > Hi all,
> > +    w) NAND on UPM-driven Freescale Localbus
> > +
> > +      Required properties:
> > +      - compatible : "fsl,upm-nand".
> > +      - reg : should specify localbus chip select and size used for the chip.
> > +      - width : should specify port size in bytes.
> > +      - fsl,upm-addr-offset : UPM pattern offset for the address latch.
> > +      - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
> > +      - fsl,wait-pattern : should be present if NAND chip requires waiting
> > +        for Ready-Not-Busy pin after each executed pattern.
> > +      - fsl,wait-write : should be present if NAND chip needs waiting on
> > +        Ready-Not-Busy pin after each write cycle.
> > +      - linux,chip-delay : optional, may contain delay value in milliseconds
> > +        (in case when Ready-Not-Busy pin was unspecified).
> > +      - gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
> 
> I'm not competent to comment on this binding; I haven't spent any time
> looking at NAND binding conventions.

That's because there are none, and every time someone proposes one it's
like this.  Full of weird $board specific stuff that have nothing to do
with the actual NAND chip.

For example, why is fsl,wait-write defined as an fsl specific property?
It seems generic to the NAND chip itself.  Also, why in the example is
the specific NAND chip part number listed, followed by fsl,upm-nand?
It's almost as if people want to mix the NAND chip and NAND controller
definitions together.  Maybe there is a good reason for it, but it's
really confusing.

josh
