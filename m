Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 58CDDB7B8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 04:50:15 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>, "Bo.Liu@windriver.com"
	<Bo.Liu@windriver.com>
Date: Wed, 4 Nov 2009 10:50:04 -0700
Subject: RE: DMA to User-Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F033103030E@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
	<4AF0E4A0.30802@windriver.com>
	<BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 1. I open /dev/mem and get a file descriptor
> 2. I use mmap to reserve some physical addresses for my buffers in
> user space.
> 3. I give that address to the FPGA for DMA use.
> 4. When I get the FPGA interrupt, I invalidate the data cache and
> write the data to disk
>=20
> Does that sound like it would work?  Would the address I receive
> from mmap() and pass to the FPGA be the actual physical address, or
> would I need to send the physical address to the FPGA and use the
> mmap() address to access and write to disk?

One more question about this approach: does the mmap() call prevent the ker=
nel from using this memory for other purposes?  Will the kernel be able to =
"move" this memory elsewhere?  I guess what I am asking is if this memory i=
s locked for all other purposes?
