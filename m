Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DEACDDFAA
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 08:24:53 +1100 (EST)
Subject: Re: dcr stuff.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
References: <20080321190524.4F3491CE0087@mail160-dub.bigfish.com>
Content-Type: text/plain
Date: Sat, 22 Mar 2008 08:24:16 +1100
Message-Id: <1206134656.24542.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-21 at 12:05 -0700, Stephen Neuendorffer wrote:
> Is anybody working on the dcr infrastructure?
> 
> In particular, there seems to be inconsistency between what the kernel
> does and what ePAPR thinks it should.  The code in the kernel selects
> mmio or native access based on a Kconfig parameter and uses some device
> tree parameters to correctly configure the mmio access, whereas ePAPR
> doesn't seem to document all the device tree attributes (in particular,
> dcr-mmio-stride and dcr-mmio-range) and provides a dynamic binding for
> dcr-access-method...
> 
> Is there a plan here?  (In particular, in FPGA designs, its possible to
> have crazy things like multiple independent dcr busses, some using
> native access, some using mmio.  Or even if there is one bus, many of
> the existing non-linux drivers we have assume native or mmio access.
> I'd like to clean this up, obviously.. :)

So far, the crazy things never happened, at least as far as I can tell,
which is why the kernel does what it does. That allows to inline the DCR
instructions on 4xx processors, and thus avoids code bloat. It also
avoids trying to use DCR instructions on processors that don't support
them like Cell with the Axon bridge.

If it becomes necessary, we can make it dynamic tho.

Ben.
