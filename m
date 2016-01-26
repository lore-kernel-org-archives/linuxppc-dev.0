Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F24711A0FF8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 05:08:55 +1100 (AEDT)
Message-ID: <1453831729.27129.35.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Thomas Gleixner <tglx@linutronix.de>, Zhao Qiang <qiang.zhao@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, xiaobo.xie@nxp.com
Date: Tue, 26 Jan 2016 12:08:49 -0600
In-Reply-To: <alpine.DEB.2.11.1601261830120.3886@nanos>
References: <1453338364-45129-1-git-send-email-qiang.zhao@nxp.com>
 <alpine.DEB.2.11.1601261830120.3886@nanos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] qe_ic: fix a buffer overflow error and add check elsewhere
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-26 at 18:31 +0100, Thomas Gleixner wrote:
> On Thu, 21 Jan 2016, Zhao Qiang wrote:
> 
> > 127 is the theoretical up boundary of QEIC number,
> > in fact there only be 44 qe_ic_info now.
> > add check to overflow for qe_ic_info
> 
> How do you trigger that overflow? The above does not explain WHY we need
> these
> checks.

The check in qe_ic_host_map can be triggered by bad data in a device tree.

The set_priority functions do not appear to be used at all.

> 
> > diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> > index 5419527..90c00b7 100644
> > --- a/drivers/soc/fsl/qe/qe_ic.c
> > +++ b/drivers/soc/fsl/qe/qe_ic.c
> 
> Sigh. Another dump ground for SOC stuff?

Another?  Where are the others, besides arch?

>  irq chip drivers belong into drivers/irqchip.

Yes.  This stuff was recently moved out of arch/powerpc to work toward being
able to use it on ARM.  I'm expecting followup patches to move things like
this that belong elsewhere.

-Scott
