Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 1D097DDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 05:17:55 +1000 (EST)
Date: Mon, 18 Jun 2007 12:15:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Message-ID: <20070618191529.GC8740@mag.az.mvista.com>
References: <20070618185715.321010@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070618185715.321010@gmx.net>
Cc: linuxppc-dev@ozlabs.org, "list <linuxppc-dev"@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 08:57:15PM +0200, Gerhard Pircher wrote:

> 1. The AmigaOne makes use of different G3 (750Cx, 750GL, 750GX) and G4 (7400, 7450, 7455, 7457) CPUs. The current dts file defines a cpu node with the name "PowerPC,7xxx@0" and the bootwrapper just fills in the cpu-, bus- and timebase frequencies. Is this the recommended way, or should the bootwrapper create a fresh cpu node with the correct name of the CPU (e.g. "PowerPC,7455@ 0" - I guess this would require a table with all PVR values and their corresponding CPU name. Or is there a function in the kernel that do this?).

I'm far from an authoritative figure on this but making a reasonable
default (in your dts file) then updating in the bootwrapper makes sense
to me.  That's what I did for several properties in the prpmc2800's dts.

> 2. I tried to define all ISA devices, which are integrated in the southbridge (VT82C686B). Currently these are child nodes of the device tree root. Should they be child nodes of the southbridge's PCI-to-ISA device node?

I would think so.

> If so, where should I specify the register address ranges (reg property)? In the PCI device node or in the ISA device nodes, as it is now?

Each device's node should have a reg property for its registers.  You'll
need a ranges property for the pci-isa bridge as well.

Mark

P.S. You should change email clients of fix the one you're using to
     break lines up so they don't wrap in a std 80 char line window.
