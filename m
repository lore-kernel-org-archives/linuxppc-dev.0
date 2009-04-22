Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id D5E92DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 00:57:57 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2352yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 07:57:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49EF2E82.9080905@embeddedarm.com>
References: <49EF2E82.9080905@embeddedarm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 22 Apr 2009 08:57:37 -0600
Message-ID: <fa686aa40904220757u1bcf1693oc2329c67209249ac@mail.gmail.com>
Subject: Re: FPGA IRQ design question
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 8:49 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
> Hello,
>
> I'm working on a board based on the Yosemite AMCC 440EP. We have an FPGA
> connected via the PCI bus, and has an IRQ line connected directly to the
> 440EP. The FPGA implements two registers to indicate which core generated
> the interrupt. So now the question is from a design standpoint is it
> preferable to setup the IRQ as a single external IRQ then have each driver
> request this same IRQ. In each ISR the driver is responsible for checking
> the FPGA registers to see if the interrupt is intended for itself. Or would
> it be preferable to modify the lower level irq routines such that multiple
> software/virtual(not sure what the right term is here) irqs are created
> corresponding to the single external IRQ. Then abstract the details of the
> FPGA interrupt registers from each driver. Such that each driver request the
> proper software/virtual IRQ and requires no knowledge of the fpga irq
> registers. Any comments would be appreciated.

Both approaches are valid and you can use your judgment here, but here
are some suggestions:

If the IRQs need to be explicity acked in the FPGA iq controller, then
I'd probably write a cascaded irq driver.  Or, if you will be using
existing device drivers, then I would also probably do a cascaded
driver.

However, if you're writing one-off custom drivers and there is no
common coded needed for acking irqs, then I would probably just use
the external IRQ.

g.
