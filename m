Return-Path: <enzo.figini@italtel.it>
Received: from mercurio.italtel.it (mercurio.italtel.it [138.132.53.5])
	by ozlabs.org (Postfix) with ESMTP id 7E6ED67A7E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 23:58:19 +1100 (EST)
Received: from mercurio.italtel.it (localhost [127.0.0.1])
	by mercurio.italtel.it (8.12.11/8.12.11) with ESMTP id j0RCfKD9021492
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 13:41:20 +0100 (MET)
Received: from imads01.milano.italtel.it (imads01.milano.italtel.it
	[138.132.90.3])
	by mercurio.italtel.it (8.12.11/8.12.11) with ESMTP id j0RCfJYd021489
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 13:41:19 +0100 (MET)
From: "Figini Enzo" <enzo.figini@italtel.it>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 27 Jan 2005 13:42:57 +0100
Message-ID: <006001c5046d$bb639860$4a50848a@settimo.italtel.it>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0061_01C50476.1D280060"
Subject: PCI allocation problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0061_01C50476.1D280060
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi, All

I'm using linux 2.6.10 on a board with MPC8280 and I have a problem with the
PCI init.
After allocating resource for the bus (pcibios_allocate_bus_resource() in
pcibios_init() ), the following pcibios_allocate_resource(0) and (1) fails,
like it's possible to see from the following report.

Jan  1 00:16:52 (none) daemon.info klogd: PCI: Probing PCI hardware
Jan  1 00:16:52 (none) daemon.warn klogd: PCI: bridge rsrc
70000000..74000000 (101), parent c01ef158
Jan  1 00:16:52 (none) daemon.warn klogd: PCI: bridge rsrc
40000000..4fffffff (1200), parent c01ef174
Jan  1 00:16:52 (none) daemon.warn klogd: PCI: bridge rsrc
60000000..6fffffff (200), parent c01ef174
Jan  1 00:16:52 (none) daemon.warn klogd: PCI: pcibios_allocate_resources()
- pass=0
Jan  1 00:16:52 (none) daemon.warn klogd: 	devfn=0x0 - command=0x6
Jan  1 00:16:52 (none) daemon.warn klogd: 	idx=0 - disabled=0x0
Jan  1 00:16:52 (none) daemon.warn klogd: PCI:0000:00:00.0: Resource 0:
00000000-0001ffff (f=200)
Jan  1 00:16:52 (none) daemon.err klogd: PCI: Cannot allocate resource
region 0 of device 0000:00:00.0
Jan  1 00:16:52 (none) daemon.warn klogd: PCI:  parent is c0283070:
60000000-6fffffff (f=200)
Jan  1 00:16:52 (none) daemon.warn klogd: 	idx=1 - disabled=0x0
Jan  1 00:16:52 (none) daemon.warn klogd: PCI:0000:00:00.0: Resource 1:
00000000-03ffffff (f=1208)
Jan  1 00:16:52 (none) daemon.err klogd: PCI: Cannot allocate resource
region 1 of device 0000:00:00.0
Jan  1 00:16:52 (none) daemon.warn klogd: PCI:  parent is c0283054:
40000000-4fffffff (f=1200)
Jan  1 00:16:52 (none) daemon.warn klogd: PCI: pcibios_allocate_resources()
- pass=1
Jan  1 00:16:52 (none) daemon.warn klogd: 	devfn=0x0 - command=0x6

It's possible it will be a errata configurazione of bridge ???
The define for configuring the PCI (inbound/outbound windows) into my board
platform include file are

/* BR0 - allow the CPU to access PCI address space */
#define MPC826x_PCI_BASE	0x40000000
#define MPC826x_PCI_MASK	0xc0000000
/* OUTBOUND 0 - Master window that allows the CPU to access PCI Memory
(prefetch). */
#define MPC826x_PCI_LOWER_MEM	0x40000000
#define MPC826x_PCI_UPPER_MEM	0x4fffffff
#define MPC826x_PCI_MEM_OFFSET	0x00000000
/* OUTBOUND 1 - allows the CPU to access PCI Memory (non-prefetch) */
#define MPC826x_PCI_LOWER_MMIO  0x60000000
#define MPC826x_PCI_UPPER_MMIO  0x6fffffff
#define MPC826x_PCI_MMIO_OFFSET 0x00000000
/* OUTBOUND 2 -0 allows the CPU to access PCI IO space */
#define MPC826x_PCI_LOWER_IO	0x70000000
#define MPC826x_PCI_UPPER_IO	0x74000000
#define MPC826x_PCI_IO_BASE	MPC826x_PCI_LOWER_IO
#define MPC826x_PCI_IO_SIZE	(MPC826x_PCI_UPPER_IO-MPC826x_PCI_LOWER_IO)
/* INBOUND 0 - PCI Memory map */
#define MPC826x_PCI_SLAVE_MEM_LOCAL	(((struct bd_info
*)__res)->bi_memstart)
#define MPC826x_PCI_SLAVE_MEM_BUS	(((struct bd_info
*)__res)->bi_memstart)
#define MPC826x_PCI_SLAVE_MEM_SIZE	(((struct bd_info
*)__res)->bi_memsize)

and are the same value used in u-boot, where all is ok and the pci run
properly.
Shuld be defined something other ???

Best regards.
  Enzo Figini

PS - with this define about OUTBOUND 2  is not possible insert module, with
problem of vmalloc reported.

------=_NextPart_000_0061_01C50476.1D280060
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IjsMAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEGgAMADgAAANUHAQAbAA0AKgAAAAQAMwEB
A5AGAOwCAAAcAAAACwACAAEAAAALACMAAAAAAAMAJgAAAAAACwApAAAAAAADADYAAAAAAB4AcAAB
AAAAFwAAAFBDSSBhbGxvY2F0aW9uIHByb2JsZW0AAAIBcQABAAAAFgAAAAHFBG26Tsn+vNNDAkdH
q22gwgH6/qoAAAIBHQwBAAAAHAAAAFNNVFA6RU5aTy5GSUdJTklASVRBTFRFTC5JVAALAAEOAAAA
AEAABg4AXB6YbQTFAQIBCg4BAAAAGAAAAAAAAAC6Kz/3bD7XEbm6AFCLCNPYwoAAAAMAFA4BAAAA
AwAJWQEAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAADhQAAAAAAAAMAAoAIIAYAAAAAAMAAAAAA
AABGAAAAABCFAAAAAAAAAwAHgAggBgAAAAAAwAAAAAAAAEYAAAAAUoUAAD9xAQAeAAmACCAGAAAA
AADAAAAAAAAARgAAAABUhQAAAQAAAAQAAAA5LjAACwARgAggBgAAAAAAwAAAAAAAAEYAAAAABoUA
AAAAAAADABKACCAGAAAAAADAAAAAAAAARgAAAAABhQAAAAAAAAsAG4AIIAYAAAAAAMAAAAAAAABG
AAAAAA6FAAAAAAAAAwAcgAggBgAAAAAAwAAAAAAAAEYAAAAAEYUAAAAAAAADAB6ACCAGAAAAAADA
AAAAAAAARgAAAAAYhQAAAAAAAAIB+A8BAAAAEAAAALorP/dsPtcRuboAUIsI09gCAfoPAQAAABAA
AAC6Kz/3bD7XEbm6AFCLCNPYAgH7DwEAAABMAAAAAAAAADihuxAF5RAaobsIACsqVsIAAG1zcHN0
LmRsbAAAAAAATklUQfm/uAEAqgA32W4AAABZOlxPdXRsb29rXG91dGxvb2sucHN0AAMA/g8FAAAA
AwANNP03AAACAX8AAQAAADEAAAAwMDAwMDAwMEJBMkIzRkY3NkMzRUQ3MTFCOUJBMDA1MDhCMDhE
M0Q4QzQ0NDY1MDAAAAAAwXk=

------=_NextPart_000_0061_01C50476.1D280060--
