Return-Path: <benh@kernel.crashing.org>
Subject: Re: MSI support on Linux PCI implementation for Ocotea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
In-Reply-To: <c3d0340b0606151414q6d218554j255fa74a68a5c9af@mail.gmail.com>
References: <c3d0340b0606151414q6d218554j255fa74a68a5c9af@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 09:22:51 +1000
Message-Id: <1150413771.7725.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, ppcembed <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-15 at 14:14 -0700, Shawn Jin wrote:
> Hi,
> 
> I'm looking at the linux PCI implementation, especially MSI support
> for Ocotea. And I have some observations and questions about it. Maybe
> somebody here can shed some light on them. Thanks.

Hi ! What is Ocotea ! :)

> 1. Obviously MSI is supported in Linux 2.6.x, maybe even in 2.4.x. But
> MSI implementation seems to support only IOxAPIC on x86 or IA64
> architectures, though the implemenation is in generic drivers/pci
> tree.

Exact. And it's also a pile of crap.

> 2. Why is the message data defined in a such way shown as follows? Or
> does it just follow IOxAPIC's design? Further question is who defines
> the format of the message data. The PCI/PCIe specs don't say anything
> about the content of the message data register.

 .../...

It's all intel specific junk.

> 3. How is the pci subsystem initialized on a PPC platform? Is there
> any existing document discussing PCI subsystem? Of course I've been
> doing a lot internet search and couldn't find too much useful infor.

pci host bridges are initialized early, generally in setup_arch() and
the PCI bus is probed later. You can see the code in
arch/powerpc/kernel/pci_{32,64}.c

Now, regarding MSI, as you have noticed, the situation isn't great. I'm
currently in the middle of reworking our interrupt management (and
interrupt numbers allocation layer) and Michael Ellermann is looking at
the MSI issue in parallel.

We don't have a solution yet but are working on it.

Ben.
