Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49D761A0150
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 15:46:37 +1100 (AEDT)
Message-ID: <1417668384.15957.240.camel@freescale.com>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 3 Dec 2014 22:46:24 -0600
In-Reply-To: <20141204043816.GB14597@pek-khao-d1.corp.ad.wrs.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
 <1417665891.15957.238.camel@freescale.com>
 <20141204043816.GB14597@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-12-04 at 12:38 +0800, Kevin Hao wrote:
> On Wed, Dec 03, 2014 at 10:04:51PM -0600, Scott Wood wrote:
> > On Wed, 2014-12-03 at 16:53 +0800, Kevin Hao wrote:
> > > This reverts commit da788acb28386aa896224e784954bb73c99ff26c.
> > > 
> > > That commit tried to fix the section mismatch warning by moving the
> > > ppc_corenet_clk_driver struct to init section. This is definitely wrong
> > > because the kernel would free the memories occupied by this struct
> > > after boot while this driver is still registered in the driver core.
> > > The kernel would panic when accessing this driver struct.
> > > 
> > > Cc: stable@vger.kernel.org # 3.17
> > 
> > I don't see stable@vger.kernel.org in the actual CC list.
> 
> With the above cc tag, Won't this get automatically included in the stable
> tree once it is merged into mainline? As I know, we only need to explicitly
> send the patch to stable@vger.kernel.org only when that patch was already
> merged into mainline without the corresponding cc stable tag and we also want
> the stable tree include it. Did I miss something?

I reread stable_kernel_rules.txt and it looks like you're right, though
usually it ends up on the real CC list anyway due to how git send-email
works.

Since only this first patch is a critical bugfix, and there's no
arch/powerpc content in that patch, I think it should go via Mike's tree
if it's to go in for 3.18 (if it's not already too late).  Or, to keep
things simple given the dependency of the following patches, we could
batch them all together for -next and add a # 3.18 stable request.

-Scott
