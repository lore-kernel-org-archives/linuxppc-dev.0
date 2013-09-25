Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C8F12C0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 04:01:24 +1000 (EST)
Received: from mail211-ch1 (localhost [127.0.0.1])	by
 mail211-ch1-R.bigfish.com (Postfix) with ESMTP id 22FF63601A9	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 18:01:20 +0000 (UTC)
Received: from CH1EHSMHS024.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.234])	by mail211-ch1.bigfish.com (Postfix) with ESMTP id
 A6C6526004E	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 18:01:18
 +0000 (UTC)
Message-ID: <1380132075.24959.188.camel@snotra.buserror.net>
Subject: Re: [PATCH V4 1/3] powerpc/85xx: Add QE common init functions
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>
Date: Wed, 25 Sep 2013 13:01:15 -0500
In-Reply-To: <69EC9ED88E3CC04094A78F8074A7986D5FF934@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380064397.24959.135.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5FF934@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-25 at 04:51 -0500, Xie Xiaobo-R63061 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 25, 2013 7:13 AM
> > To: Xie Xiaobo-R63061
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH V4 1/3] powerpc/85xx: Add QE common init functions
> > 
> > On Tue, 2013-09-24 at 18:48 +0800, Xie Xiaobo wrote:
> > > Define two QE init functions in common file, and avoid the same codes
> > > being duplicated in board files.
> > >
> > > Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> > > ---
> > > V4 -> V3: Nochange
> > >
> > >  arch/powerpc/platforms/85xx/common.c  | 51
> > > +++++++++++++++++++++++++++++++++++
> > >  arch/powerpc/platforms/85xx/mpc85xx.h |  8 ++++++
> > >  2 files changed, 59 insertions(+)
> > >
> > > diff --git a/arch/powerpc/platforms/85xx/common.c
> > > b/arch/powerpc/platforms/85xx/common.c
> > > index d0861a0..08fff48 100644
> > > --- a/arch/powerpc/platforms/85xx/common.c
> > > +++ b/arch/powerpc/platforms/85xx/common.c
> > > @@ -7,6 +7,9 @@
> > >   */
> > >  #include <linux/of_platform.h>
> > >
> > > +#include <asm/machdep.h>
> > > +#include <asm/qe.h>
> > > +#include <asm/qe_ic.h>
> > >  #include <sysdev/cpm2_pic.h>
> > >
> > >  #include "mpc85xx.h"
> > > @@ -80,3 +83,51 @@ void __init mpc85xx_cpm2_pic_init(void)
> > >  	irq_set_chained_handler(irq, cpm2_cascade);  }  #endif
> > > +
> > > +#ifdef CONFIG_QUICC_ENGINE
> > > +void __init mpc85xx_qe_pic_init(void) {
> > > +	struct device_node *np;
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > > +	if (np) {
> > > +		if (machine_is(mpc8568_mds) || machine_is(mpc8569_mds))
> > > +			qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
> > > +		else
> > > +			qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > > +					qe_ic_cascade_high_mpic);
> > > +		of_node_put(np);
> > > +	} else
> > > +		pr_err("%s: Could not find qe-ic node\n", __func__); }
> > 
> > Have the caller pass in a flag indicating the type of cascade.  Or,
> > perhaps this function isn't worth factoring out.  Where is the check for
> > p1021_mds?  Where did 8568/9 MDS come from?  I don't see those checks
> > removed in patch 2.
> 
> [Xie] The qe_pic_init just call one function qe_ic_init(), So I just need factor out the qe_init function, Is it feasible?

"Or, perhaps this function isn't worth factoring out." :-)

-Scott
