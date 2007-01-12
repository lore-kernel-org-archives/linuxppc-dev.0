Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68095DDE31
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 20:52:20 +1100 (EST)
Date: Fri, 12 Jan 2007 10:52:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: ebony.zhu@freescale.com
Subject: Re: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Message-ID: <20070112095213.GA24536@lst.de>
References: <ZCH01EXM20D0kWSxlXp000006f8@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ZCH01EXM20D0kWSxlXp000006f8@zch01exm20.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 12, 2007 at 01:31:02PM +0800, ebony.zhu@freescale.com wrote:
> +ifeq ($(CONFIG_SPE),y)
> +ifneq ($(CONFIG_MATH_EMULATION),y)
> +core-y				+= arch/powerpc/math-emu/
> +endif
> +endif
>  core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/

This statement doesn't make any sense.  I guess you always want to
build arch/powerpc/math-emu if CONFIG_SPE is set, right?  The proper
way to do that is to force CONFIG_MATH_EMULATION in the Kconfig.

Then again we need a really good explanation why CONFIG_SPE should
force the math emulation to be built.
