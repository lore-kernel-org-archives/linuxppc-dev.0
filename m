Return-Path: <SRS0+2a2af2387a6de104fe6b+841+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F29168881
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2005 20:38:41 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20051211193118.GR23349@stusta.de>
References: <20051211185212.GQ23349@stusta.de>
	<20051211192109.GA22537@flint.arm.linux.org.uk>
	<20051211193118.GR23349@stusta.de>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 10:38:15 +0100
Message-Id: <1134380295.10234.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, grundler@parisc-linux.org,
	matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.xn--org-boa, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, parisc-linux@parisc-linux.org
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-12-11 at 20:31 +0100, Adrian Bunk wrote:
> Either the depency of MTD_OBSOLETE_CHIPS on BROKEN is correct (in
> which case CONFIG_MTD_OBSOLETE_CHIPS=y wouldn't bring you anything),
> or the dependency on BROKEN is not correct and should be corrected.
> 
> David, can you comment on this issue?

I don't see any justification for MTD_OBSOLETE_CHIPS depending on
BROKEN. That option covers a few of the obsolete chip drivers which
people shouldn't be using any more -- and I'm perfectly willing to
believe that one or two of those don't work any more, but if that's the
case then those individual drivers ought to be marked BROKEN (or just
removed). We shouldn't mark MTD_OBSOLETE_CHIPS broken.

I'd like to see the collie_defconfig updated to use the appropriate CFI
driver back end.

-- 
dwmw2
