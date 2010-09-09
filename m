Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id CB61DB7117
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 07:20:05 +1000 (EST)
Received: from mail94-tx2 (localhost.localdomain [127.0.0.1])	by
	mail94-tx2-R.bigfish.com (Postfix) with ESMTP id 25B8B58173	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 21:19:59 +0000 (UTC)
Received: from TX2EHSMHS033.bigfish.com (unknown [10.9.14.235])	by
	mail94-tx2.bigfish.com (Postfix) with ESMTP id C55EF1000050	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 21:19:58 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o89LJk2a009376	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Sep 2010 14:19:56 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o89LWCNU000627	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Sep 2010 16:32:12 -0500 (CDT)
Message-ID: <4C894F71.4050408@freescale.com>
Date: Thu, 9 Sep 2010 16:19:45 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
References: <1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
	<4C893842.6090009@freescale.com>
	<20100909200606.GE3496@ovro.caltech.edu>
	<4C893FDD.1000507@freescale.com>
	<20100909203142.GF3496@ovro.caltech.edu>
	<4C89454F.8070701@freescale.com>
	<20100909205507.GG3496@ovro.caltech.edu>
In-Reply-To: <20100909205507.GG3496@ovro.caltech.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira W. Snyder wrote:
> I have no idea how to determine this.
> 
> The code that caused the problem runs so early in boot that the MMU is
> not running yet. Looking through the tiny bit of code, it appears that
> it just uses whatever the bootloader set up for it. It hasn't gotten to
> the initial_bats function yet.

I just spoke to Kumar, and he said that the 8MB is just historical.  We ran
into the same exact problem that you ran into, except it was with a normal
kernel, so we changed 8MB to 16MB on our 85xx boards, but we never went back
and made the same change to 83xx boards.

So it should be safe to change CONFIG_SYS_BOOTMAPSZ from 8MB to 16MB on all
83xx systems.  However, U-Boot does not verify that CONFIG_SYS_BOOTMAPSZ <=
the actual amount of RAM in the system, so we need to make sure that
CONFIG_SYS_BOOTMAPSZ isn't increased on any board that actually did ship
with only 8MB of RAM.  My guess is that no such board exists, but I will get
confirmation.

However, this comment for CONFIG_SYS_BOOTMAPSZ still bothers me:

/*
 * For booting Linux, the board info and command line data
 * have to be in the first 8 MB of memory, since this is
 * the maximum mapped by the Linux kernel during initialization.
 */

This same comment says 16MB on 85xx systems, so I don't think the statement
about "maximum mapped by the Linux kernel" is really true.  Maybe someone
else can shed some light on this.

> I think the MPC8349EA would be a 603 CPU, meaning that we could increase
> CONFIG_SYS_BOOTMAPSZ up to 256MB (if the board had that much RAM).

Except that I'm still not sure what CONFIG_SYS_BOOTMAPSZ really means.  I
was under the impression that CONFIG_MAX_MEM_MAPPED is the actual value of
the size of the mapping that U-Boot creates for the kernel.  When the kernel
initializes the MMU for its own purposes, does it limit anything to 16MB?  I
seriously doubt it.

> You'll see that your patch now relocated the FDT. It didn't cause any
> problems. I'll post to the thread on the U-Boot ML.

Yes, please.  I need someone to confirm that he tested my patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
