Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17992.64515.797925.855510@cargo.ozlabs.ibm.com>
Date: Tue, 15 May 2007 10:17:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
In-Reply-To: <246be0d2277753c0c0b61d0f4131c092@kernel.crashing.org>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<246be0d2277753c0c0b61d0f4131c092@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> This is wrong -- there are systems with ISA that
> also have PCI devices that require 16-bit legacy
> I/O windows (e.g., systems with the AMD8111 chip,
> like Maple).

If they are PCI devices and their drivers use a pci_dev's resources
to get to the device's I/O resources, then they are fine.

The only reason for reserving the low 64k is to cater for drivers that
use a hard-coded port number, e.g. video drivers using the VGA port
numbers.  We have been gradually getting rid of the hard coded port
numbers in drivers but I don't think they're all gone yet.

Paul.
