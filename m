Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 23CF22C029F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 20:48:49 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 07476-08 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 12 Mar 2013 09:48:37 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Tue, 12 Mar 2013 09:47:13 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7183@saturn3.aculab.com>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C15369@039-SN1MPN1-003.039d.mgd.msft.net>
References: <412C8208B4A0464FA894C5F0C278CD5D01BFC620@039-SN1MPN1-002.039d.mgd.msft.net>(from
 B38951@freescale.com on Fri Mar 8 02:01:46 2013) <1362790153.29198.11@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C15369@039-SN1MPN1-003.039d.mgd.msft.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jia Hongtao-B38951" <B38951@freescale.com>,
 "Wood Scott-B07421" <B07421@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Is that OK if I use the following code?
...
> 	if (is_in_pci_mem_space(addr)) {
> 		if (!user_mode(regs)) {
> 			ret =3D probe_kernel_address(regs->nip, inst);
>=20
> 			if (!ret) {
> 				rd =3D get_rt(inst);
> 				regs->gpr[rd] =3D 0xffffffff;
> 			}
> 		}

Don't you need to check that the instruction is actually
a memory read?

I also know that there are people mapping PCIe addresses
directly into userspace for 'simple' access to things like
fpga devices.

I suspect that such devices are the ones likely to generate
the faulting cycles. So you probably do want to handle
faults from normal userspace addresses.

	David
