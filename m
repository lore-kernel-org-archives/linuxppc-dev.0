Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 714D8DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 21:45:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ioremap and outb
Date: Fri, 4 Jan 2008 11:45:20 +0100
References: <14612559.post@talk.nabble.com>
	<20080103215456.GA20691@mail.gnudd.com>
	<20080104102037.GA31627@mail.gnudd.com>
In-Reply-To: <20080104102037.GA31627@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801041145.21085.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 04 January 2008, Alessandro Rubini wrote:
> > =A0 =A0 =A0 =A0 =A0addr=3Dioremap(base_addr,size); =A0 =A0 =A0 =A0 =A0/=
/ Remap to Mem mapped
>=20
> Yes.

In newer drivers that are specific to powerpc, it's often easier
to use the of_iomap() function to map a device, so you don't
have to calculate the base address manually from the device tree.

> > =A0 =A0 =A0 =A0 =A0out_8(addr) and in_8(addr);=20
>=20
> It should be right, although __raw_readb() and __raw_writeb() may
> suffice for you.

Actually not. While they may work, the __raw_* functions do not have
a specific meaning in device drivers. Depending on the I/O model, they
may or may not work on a given platform. The {in,out}_{8,{be,le}{16,32,64}}
functions however are defined to operate on local (not PCI) ioremapped
mmio devices, and are usually more efficient than the {read,write}{b,w,l,q}
variant you'd use on PCI devices.

	Arnd <><
