Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDf5v4rCpzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 20:13:55 +1100 (AEDT)
Message-ID: <1507972420.25065.270.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Enable reset_devices parameter to
 issue a PHB reset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, "Guilherme G. Piccoli"
 <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulus@samba.org, maurosr@linux.vnet.ibm.com
Date: Sat, 14 Oct 2017 11:13:40 +0200
In-Reply-To: <87fuantpdk.fsf@concordia.ellerman.id.au>
References: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
 <87fuantpdk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-10-13 at 19:37 +1100, Michael Ellerman wrote:
> > We recently had a situation in which i40e driver couldn't start,
> > even after a full power cycle, due to a bug in its FW triggered
> > by a DCB condition in switch (thanks Mauro for narrowing this).
> > This patch enabled us to revive the adapter and use network
> > while debugging.
> 
> I really dislike this.
> 
> You're basically saying the kernel can't work out how to get a device
> working, so let's leave it up to the user.
> 
> The driver should be fixed to detect that the device is not responding
> and request a reset.

No, he's saying this is useful for the developers when debugging the
kernel driver (or for asking users to "test" something as part of
debugging a driver problem).

It's common to have various command line options affecting PCIe
behaviour. I don't see a fundamental problem with this one.

One could argue in fact that we should always PERST everything, the
main reason for not doing so is that on "normal" boot, OPAL has already
done it and it would slow the boot process down.

My only objection here is the actual name of the argument. We've had a
number of pci options so far, it makes sense to make sure we still have
"pci" in the name.

Also having the driver do a "reset" is not always simple, we don't
always have full control of PERST on a per-device basis. The patch
proposed will PERST top level PHBs which will propagate as hot reset
down switches, not 100% PERST but still useful.

Cheers,
Ben.
