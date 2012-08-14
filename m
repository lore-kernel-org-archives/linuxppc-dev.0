Return-Path: <zch@az84smr01.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8755C2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 19:59:07 +1000 (EST)
Received: from mail166-ch1 (localhost [127.0.0.1])	by
 mail166-ch1-R.bigfish.com (Postfix) with ESMTP id 6C0AC6051C	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 09:59:02 +0000 (UTC)
Received: from CH1EHSMHS021.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.250])	by mail166-ch1.bigfish.com (Postfix) with ESMTP id
 83590240087	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 09:59:00
 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q7E9wuZW020328	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 02:58:57 -0700
Date: Tue, 14 Aug 2012 17:58:59 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] fsl_pmc: Add API to enable device as wakeup event
 source
Message-ID: <20120814095859.GA21028@localhost.localdomain>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-2-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXXdgS5x2ZkuXb4wHckdqLzSM2xy-eYU3+28d_=JH3euxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOZdJXXdgS5x2ZkuXb4wHckdqLzSM2xy-eYU3+28d_=JH3euxg@mail.gmail.com>
Sender: <zch@az84smr01.freescale.net>
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>, B04825@freescale.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 11, 2012 at 08:19:43AM -0500, Tabi Timur-B04825 wrote:
> On Tue, Aug 7, 2012 at 3:43 AM, Zhao Chenhui <chenhui.zhao@freescale.com> wrote:
> 
> > +               return -EINVAL;
> > +
> > +       prop = of_get_property(clk_np, "fsl,pmcdr-mask", NULL);
> > +       if (!prop) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +       pmcdr_mask = be32_to_cpup(prop);
> > +
> > +       if (enable)
> > +               /* clear to enable clock in low power mode */
> > +               clrbits32(&pmc_regs->pmcdr, pmcdr_mask);
> > +       else
> > +               setbits32(&pmc_regs->pmcdr, pmcdr_mask);
> > +
> > +out:
> > +       of_node_put(clk_np);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(mpc85xx_pmc_set_wake);
> 
> Use EXPORT_SYMBOL, not EXPORT_SYMBOL_GPL.
> 

Hi kumar,

Is that ok with upstream?

-Chenhui
