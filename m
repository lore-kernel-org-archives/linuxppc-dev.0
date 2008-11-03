Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 4043FDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 08:31:58 +1100 (EST)
Subject: RE: Accessing PCI-E resources on 460EX
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 3 Nov 2008 15:31:56 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F852@tanisys-ex2.Tanisys.Local>
In-Reply-To: <490F6882.6050101@embedded-sol.com>
References: <490F6882.6050101@embedded-sol.com>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: "Felix Radensky" <felix@embedded-sol.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-bounces+aymane=3Dtanisys.com@ozlabs.org <> said on :

> I'm currently struggling with some application that tries to
> access PCI-E memory by mmaping address found in
> /sys/bus/pci/devices/<device>/resource
>=20
> mmap() fails with "invalid argument" error, apparently
> because on 460EX PCI addresses are 36-bit.
>=20
> What is the correct way of accessing PCI-E from userspace on this
> platform.=20

What works for me is using the mmap64 as in the following example to
map the physical address, fd is the file descriptor for /dev/mem

off64_t offset =3D static_cast<off64_t>(your physical address);
void * const p =3D
mmap64(0,256,PROT_WRITE|PROT_READ,MAP_SHARED,fd,offset);

The only thing to note is that the address you pass should be aligned=20
to the page boundry even though some devices are not.
