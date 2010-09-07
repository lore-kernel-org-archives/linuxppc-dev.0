Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 4F478B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Sep 2010 06:01:11 +1000 (EST)
Received: from mail26-tx2 (localhost.localdomain [127.0.0.1])	by
	mail26-tx2-R.bigfish.com (Postfix) with ESMTP id 8110DE0439	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2010 20:01:04 +0000 (UTC)
Received: from TX2EHSMHS009.bigfish.com (unknown [10.9.14.247])	by
	mail26-tx2.bigfish.com (Postfix) with ESMTP id 246DD1590052	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2010 20:01:04 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o87K0e8f009102	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 7 Sep 2010 13:00:50 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o87KD2vx011794	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 7 Sep 2010 15:13:02 -0500 (CDT)
Date: Tue, 7 Sep 2010 15:00:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: Small issue at init with spi_mpc8xxx.c with CPM1
Message-ID: <20100907150038.57a7b065@schlenkerla.am.freescale.net>
In-Reply-To: <4C86031D.5080804@c-s.fr>
References: <4C86031D.5080804@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Kumar Gala <kumar.gala@freescale.com>,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 7 Sep 2010 11:17:17 +0200
LEROY Christophe <christophe.leroy@c-s.fr> wrote:

> 
>   Dear Kumar,
> 
> I have a small issue in the init of spi_mpc8xxx.c with MPC866 (CPM1)
> 
> Unlike cpm_uart that maps the parameter ram directly using 
> of_iomap(np,1), spi_mpc8xxx.c uses cpm_muram_alloc_fixed().
> 
> This has two impacts in the .dts file:
> * The driver must be declared with pram at 1d80 instead of 3d80 whereas 
> it is not a child of muram@2000 but a child of cpm@9c0
> * muram@2000/data@0 must be declared with reg = <0x0 0x2000>   whereas 
> is should be reg=<0x0 0x1c00> to avoid cpm_muram_alloc() to allocate 
> space from parameters ram.
> 
> Maybe I misunderstood something ?

Don't make the device tree lie, fix the driver instead.

The allocator should not be given any chunks of muram that are
dedicated to a fixed purpose -- it might hand it out to something else
before you reserve it.  I don't think that cpm_muram_alloc_fixed() has
any legitimate use at all.

-Scott
