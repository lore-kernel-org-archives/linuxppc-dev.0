Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 66E5FB7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 03:05:39 +1000 (EST)
Message-ID: <4AB7A411.3030406@ovro.caltech.edu>
Date: Mon, 21 Sep 2009 09:04:33 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: MPC8536 PCI rescan to discover FPGA
References: <4AB79D41.60902@embedded-sol.com>
In-Reply-To: <4AB79D41.60902@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Felix,

> On a custom MPC8536 board running linux-2.6.31,
> I'd like to load FPGA code from linux and then rescan
> PCI-E bus to discover FPGA device. Is that possible ?
> When linux boots FPGA is not loaded, so initial PCI
> scan does not detect it.
> 
> I've tried playing with /sys/bus/pci/rescan and 
> /sys/bus/pci/devices/.../rescan
> but didn't have much success.

This can be made to work using the kernel hot-swap
interface. PCI devices have an ENUM# interrupt that
they assert when inserted or extracted, and the host
hot-swap driver can be hooked up to it. PCI-E may
have a similar mechanism, if it does, then when your
FPGA configures as a PCI-E device, it can assert that
interrupt line (or send the appropriate PCI-E
message to simulate that interrupt).

However, even if PCI-E does not have the concept of
an ENUM# interrupt there is a way to generate a fake
hot-swap event and generate a re-scan of the PCI bus.

I haven't tested the kernel hot-swap interface, but I
know that Ira did, so I'll cc him on this mail, and he
can let you know what he tested.

Cheers,
Dave
