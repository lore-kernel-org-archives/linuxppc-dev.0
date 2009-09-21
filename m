Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C07EB7B69
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 06:49:50 +1000 (EST)
Subject: Re: [PATCH] [V1] USB: Add support for Xilinx USB host controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julie Zhu <julie.zhu@xilinx.com>
In-Reply-To: <20090921193821.CB9DF1620046@mail78-sin.bigfish.com>
References: <20090921193821.CB9DF1620046@mail78-sin.bigfish.com>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 06:49:40 +1000
Message-Id: <1253566180.7103.147.camel@pasglop>
Mime-Version: 1.0
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-21 at 13:38 -0600, Julie Zhu wrote:

> +	iounmap(hcd->regs);
> +err_ioremap:
> +	irq_dispose_mapping(irq);

You missed that one too :-)

I'm actually considering making irq_dispose_mapping() a private
API and rename it to something like __irq_dispose_mapping() :-)

I think the only reasonable use case for it is when re-allocating
MSIs to avoid using the whole virq space.

Cheers,
Ben.
