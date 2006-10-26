Return-Path: <benh@kernel.crashing.org>
Subject: 83xx usage of pci_fixup_irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 14:34:25 +1000
Message-Id: <1161837265.5299.11.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'd like to remove on ppc32 those 2 members of ppc_md:

unsigned char (*pci_swizzle)(struct pci_dev *, unsigned char *);
int (*pci_map_irq)(struct pci_dev *, unsigned char, unsigned char);

They are used by only those 2 platforms:

arch/powerpc/platforms/83xx/mpc832x_mds.c:

and

arch/powerpc/platforms/83xx/mpc8360e_pb.c:

They shouldn't be necessary however with the prom_parse.c code and using
standard of_irq_map_pci() (or pci_read_irq_line() which uses it).

So is there any special reason I can't just remove these ?

(I'm also adding a common 32/64 bits pci_irq_fixup for platforms that
really need a fixup and making pci_read_irq_line() the default).

If we ever need some non-standard swizzle, then I might re-introduce a
swizzle callback in here (but common 32/64 bits this time) that is used
by of_irq_map_pci().

Ben.
