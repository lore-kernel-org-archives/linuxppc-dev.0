Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3040DE0B4
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 04:09:46 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0QH9VEB003814
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 10:09:38 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n0QH9UEe005016
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 11:09:30 -0600 (CST)
Date: Mon, 26 Jan 2009 11:09:29 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: Help needed with initramfs
Message-ID: <20090126170929.GA5820@ld0162-tx32.am.freescale.net>
References: <8cad0aa0901260217u5a981c77gc09caba76cce32a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8cad0aa0901260217u5a981c77gc09caba76cce32a7@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 26, 2009 at 11:17:05AM +0100, Jean-Michel Hautbois wrote:
> I have a working Kernel with a NFS mounted root filesystem.
> I am trying to use my root file system, but with the use of initramfs.
> 
> Compiling the kernel is not a problem, but when booting, I have the
> following error:
> 
> "Insufficient memory for kernel at address 0! (_start=00400000, uncompressed
> size=005a0b0c)"
> 
> I understand that my load address is 0x400000 and that the image is too big,
> but I can't find where this load adress is defined.
> It seems (from the .../arch/powerpc/boot/wrapper file) that this adress is
> calculated from the _start adress in the objfile.
> 
> Is it possible to change this adress ?
> What can I do (with the idea of not reducing the size of my rootfs) ?

You can change link_address in arch/powerpc/boot/wrapper, or provide a
vmlinux_alloc method in the wrapper ops struct.

-Scott
