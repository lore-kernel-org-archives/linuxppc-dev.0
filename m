Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 25E5FB70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 06:13:58 +1000 (EST)
Received: from mail104-tx2 (localhost.localdomain [127.0.0.1])	by
	mail104-tx2-R.bigfish.com (Postfix) with ESMTP id 8D167A98409	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 20:13:52 +0000 (UTC)
Received: from TX2EHSMHS024.bigfish.com (unknown [10.9.14.238])	by
	mail104-tx2.bigfish.com (Postfix) with ESMTP id 55B159E8083	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 20:13:27 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o89KDIUK003105	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 9 Sep 2010 13:13:18 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o89KRJf9016787	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Sep 2010 15:27:19 -0500 (CDT)
Message-ID: <4C893FDD.1000507@freescale.com>
Date: Thu, 9 Sep 2010 15:13:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
	<4C893842.6090009@freescale.com>
	<20100909200606.GE3496@ovro.caltech.edu>
In-Reply-To: <20100909200606.GE3496@ovro.caltech.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira W. Snyder wrote:
> That easily overruns the location where U-Boot puts the FDT. Is this a
> U-Boot bug, meaning I should post this information on the U-Boot
> mailing list?

Possibly.

I am under the impression that the memory in the boot block that contains
the FDT is marked as "reserved" in the device tree, so that the kernel
doesn't overwrite it.  However, that obviously isn't helpful if we haven't
parsed the device tree yet.

What concerns me is this in U-Boot:

/*
 * For booting Linux, the board info and command line data
 * have to be in the first 16 MB of memory, since this is
 * the maximum mapped by the Linux kernel during initialization.
 */
#define CONFIG_SYS_BOOTMAPSZ	(16 << 20)	/* Initial Memory map for Linux*/

If the 16MB mapping limit is true, then does this mean that the Linux's BSS
is larger than the memory that is mapped?  If so, that means that Linux
can't even access all of its BSS at this point.  Somehow, I doubt that.

Can you try increasing the size of CONFIG_SYS_BOOTMAPSZ?  Combined with my
always-relocate-fdt, I think this will force the FDT to be placed higher in
memory.

-- 
Timur Tabi
Linux kernel developer at Freescale
