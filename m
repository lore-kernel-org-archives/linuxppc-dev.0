Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 46B9BDDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 09:41:31 +1000 (EST)
Date: Fri, 19 Oct 2007 16:41:43 -0700 (PDT)
Message-Id: <20071019.164143.75786621.davem@davemloft.net>
To: Emilian.Medve@freescale.com
Subject: Re: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
From: David Miller <davem@davemloft.net>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270168520B@az33exm24.fsl.freescale.net>
References: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com>
	<20071018.173032.48505868.davem@davemloft.net>
	<598D5675D34BE349929AF5EDE9B03E270168520B@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Date: Fri, 19 Oct 2007 06:39:12 -0700

> For the current situation, 32-bit QE, 32-bit PowerPC, do you find
> the patch acceptable?

No piece of code in the kernel should live in a vacuum.

In order to improve overall code quality, every piece of
driver code should avoid assuming things about pointer
sizes and things of this nature.

Then the driver can get enabled into the build on every
platform, and therefore nobody will break the build of
this driver again since it will get hit by "allmodconfig"
et al. builds even on platforms other than the one it is
meant for.

This hack fix is not acceptable, really.
