Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id AD78867A7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 05:37:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 8 Mar 2005 12:37:33 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592E9@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok... Got a little closer....

I have PCI (outbound) mapped in the area 0x80000000-0x8fffffff
(prefetch/non-prefetch and IO)
IMMR of cource is at 0xf0000000

So I map the IO as following:
	/* Map IMMR region to a 256MB BAT */
	addr =3D (cpm2_immr !=3D NULL) ? (uint)cpm2_immr : CPM_MAP_ADDR;
	io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);

	io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);

Now I can almost boot....:
It craches when trying to read from harddisk
(only happens with more than 512MB)

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing unused kernel memory: 288k init
Machine check in kernel mode.
Caused by (from SRR1=3D49030): Transfer error ack signal
Oops: machine check, sig: 7 [#1]
PREEMPT
NIP: C000E3FC LR: C0037728 SP: EFC11C50 REGS: efc11ba0 TRAP: 0200    Not
tainted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c0be9ae0[1] 'swapper' THREAD: efc10000
Last syscall: 11
GPR00: 00000001 EFC11C50 C0BE9AE0 00000024 FE402FFC 00000000 EFE939FC
81040008
GPR08: 8124000C C02A0000 3FF80581 00000004 00000092 100C1B1C EFE9E98C
EFEA6498
GPR16: 00000007 00000001 00000000 00000000 EFC11D18 EFC11DC8 00000000
EFE9E940
GPR24: 00000000 00000000 00000080 000074A0 C0B06000 FE403000 00000080
EFC11D18
NIP [c000e3fc] __copy_tofrom_user+0xb4/0x234
LR [c0037728] file_read_actor+0x148/0x258
Call trace:
 [c00373e4] do_generic_mapping_read+0x408/0x604
 [c0037a5c] __generic_file_aio_read+0x224/0x254
 [c0037ac8] generic_file_aio_read+0x3c/0x5c
 [c005ef84] do_sync_read+0xa0/0xe4
 [c005f090] vfs_read+0xc8/0x150
 [c006ccbc] kernel_read+0x40/0x58
 [c006d994] prepare_binprm+0xd0/0xec
 [c006e098] do_execve+0x138/0x21c
 [c0006bb8] sys_execve+0x98/0xf8
 [c0003c80] ret_from_syscall+0x0/0x44
 [c00063ac] execve+0x8/0x1c
 [c0003a98] init+0xb0/0xf8
 [c0006384] kernel_thread+0x44/0x60
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..=20

> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
> Sent: Tuesday, March 08, 2005 12:07
> To: Rune Torgersen
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Lots of memory on 826x
>=20
> I would start looking at what addresses are getting assigned for=20
> VMALLOC vs any io_block_mapping() calls.  I know I've had=20
> problems with=20
> large amount of memory in systems if the virt addrs allocated in=20
> io_block_mapping calls conflict with vmalloc addrs.
>=20
> - kumar
>=20
> On Mar 8, 2005, at 11:33 AM, Rune Torgersen wrote:
>=20
> > Anybody know how to get more than 512MB (1-2GB) of RAM to work with
> >  2.6.11 on a 8265?
> >
> > Weird stuff and crashes keep happening on kernel start=20
> (vmalloc out of
> > memory, and a pci driver ups) when I tell the kernel I have=20
> more than
> >  512MB of ram.
> > The pci craches happens when I tell the kernel I have 740-760MB or=20
> > more.
> >
> > Any idea of where to start to look for this?
> >
> > Rune Torgersen
> >  System Developer
> >  Innovative Systems LLC
> >  1000 Innovative Drive
> >  Mitchell, SD 57301
> >  Ph: 605-995-6120
> >  www.innovsys.com
> > _______________________________________________
> > Linuxppc-embedded mailing list
> >  Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
>=20
