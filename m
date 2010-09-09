Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 99D85B70DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 06:36:56 +1000 (EST)
Received: from mail13-tx2 (localhost.localdomain [127.0.0.1])	by
	mail13-tx2-R.bigfish.com (Postfix) with ESMTP id 7087918E0525	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 20:36:39 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.238])	by
	mail13-tx2.bigfish.com (Postfix) with ESMTP id 87FAC170804C	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 20:36:37 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o89KaV00005256	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Sep 2010 13:36:31 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o89KmwLS014370	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Sep 2010 15:48:58 -0500 (CDT)
Message-ID: <4C89454F.8070701@freescale.com>
Date: Thu, 9 Sep 2010 15:36:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
References: <1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
	<4C893842.6090009@freescale.com>
	<20100909200606.GE3496@ovro.caltech.edu>
	<4C893FDD.1000507@freescale.com>
	<20100909203142.GF3496@ovro.caltech.edu>
In-Reply-To: <20100909203142.GF3496@ovro.caltech.edu>
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
> That did it!

Yea!

> I'm using include/configs/MPC8349EMDS.h. On that board,
> CONFIG_SYS_BOOTMAPSZ is 8MB. Boosting it to 16MB fixed the problem and
> the kernel now boots.

Ah, yes.  I believe the reason that is the case is because some of those
boards were shipped with only 8MB of RAM.

> I'll make a post to the U-Boot list asking if this should be boosted for
> MPC8349EMDS (and others?). It is easy to build a kernel that overruns
> this limit. Other than debugging options, my kernel is fairly minimal,
> only a few drivers are built in.

I think we should first determine if the kernel boot map limit really is
16MB.  If it's more than that, then we should consider making it match.
Assuming, of course, that the U-Boot code can handle a situation where
CONFIG_SYS_BOOTMAPSZ is larger than the actual amount of RAM.

> I'm using your always-relocate-fdt patch. Your patch made no difference
> to the FDT location. U-Boot with and without your patch bo

My patch only does something if the FDT is already located inside the boot
map.  Since you were expanding the size of the boot map, there's a chance
that the FDT was located between 8MB and 16MB, and if so, my patch would
have made a difference.


-- 
Timur Tabi
Linux kernel developer at Freescale
