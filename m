Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C639DE074
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 03:43:26 +1100 (EST)
Date: Tue, 5 Feb 2008 10:43:18 -0600
From: Matt Porter <mporter@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 6/6] Change the kernel configurated RapidIO system size to
	auto-probing.
Message-ID: <20080205164318.GC20177@gate.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<12016890832943-git-send-email-wei.zhang@freescale.com>
	<12016890873190-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12016890873190-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 06:30:53PM +0800, Zhang Wei wrote:
> The RapidIO system size will auto probe in RIO setup. The route
> table and rionet_active in rionet.c are changed to be allocated
> dynamically according the system size.

<snip>

> +	port->sys_size = (in_be32((priv->regs_win + RIO_PEF_CAR))
> +					& RIO_PEF_CTLS) >> 4;
> +	dev_info(&dev->dev, "RapidIO Common Transport System size: %d\n",
> +			port->sys_size ? 65536 : 256);
> +

This is much nicer than the original hardcoded transport size
implementation.

-Matt
