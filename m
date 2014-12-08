Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD2361A05EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 09:48:31 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48A651400A0
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2014 09:48:29 +1100 (AEDT)
Message-ID: <1418075026.13358.4.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 09 Dec 2014 08:43:46 +1100
In-Reply-To: <20141208205520.GA12715@katana>
References: <20141208063039.14356.34770.stgit@localhost.localdomain>
 <1418069595.4827.43.camel@kernel.crashing.org>
 <20141208205520.GA12715@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-08 at 21:55 +0100, Wolfram Sang wrote:
> On Tue, Dec 09, 2014 at 07:13:15AM +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2014-12-08 at 12:06 +0530, Neelesh Gupta wrote:
> > > The patch exposes the available i2c busses on the PowerNV platform
> > > to the kernel and implements the bus driver to support i2c and
> > > smbus commands.
> > > The driver uses the platform device infrastructure to probe the busses
> > > on the platform and registers them with the i2c driver framework.
> > 
> > Wolfram, what are you remaining objections here ? We need that in
> > distros ASAP ...
> 
> Oh, I thought we agreed that you take it via powerpc. I still think this
> is the best solution.

I threatened to do that :-) I don't remember you replying, did I miss
it ? If you are ok with the driver and are happy for me to take it,
please send an Ack.

> > I still maintain that it's not reasonable to hold driver for the
> > additions of multi-byte smbus offsets. This is a new feature that will
> > require changes to a number of existing bus and device drivers, so a
> > very pervasive change, and which will be visible to user space, which
> > means that drivers will need to continue supporting the "old" way at
> > least for a while anyway...
> 
> Yeah, I agree on that. I am still unsure about the port-name binding,
> but well, if it is needed to fit your PowerNV scheme...

>From a binding perspective, it's just a piece of additional info that
the firmware provides for convenience. That we use it as the i2c port
name in Linux makes sense, it means that when listing the i2c ports,
it's immediately clear to the user which is which, it's not used
functionally by any driver or piece of code, but it's handy for people
doing things like manufacturing of machines, to know what bus to poke to
program a VPD EEPROM or test if a chip responds for example.

Cheers,
Ben.
