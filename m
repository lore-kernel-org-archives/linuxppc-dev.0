Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A66B1A0FF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 04:32:58 +1100 (AEDT)
Date: Tue, 26 Jan 2016 18:31:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Zhao Qiang <qiang.zhao@nxp.com>
cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, oss@buserror.net, xiaobo.xie@nxp.com
Subject: Re: [PATCH] qe_ic: fix a buffer overflow error and add check elsewhere
In-Reply-To: <1453338364-45129-1-git-send-email-qiang.zhao@nxp.com>
Message-ID: <alpine.DEB.2.11.1601261830120.3886@nanos>
References: <1453338364-45129-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Jan 2016, Zhao Qiang wrote:

> 127 is the theoretical up boundary of QEIC number,
> in fact there only be 44 qe_ic_info now.
> add check to overflow for qe_ic_info

How do you trigger that overflow? The above does not explain WHY we need these
checks.

> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index 5419527..90c00b7 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ic.c

Sigh. Another dump ground for SOC stuff? irq chip drivers belong into
drivers/irqchip.

Thanks,

	tglx
