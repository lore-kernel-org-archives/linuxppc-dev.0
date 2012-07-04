Return-Path: <zch@tx30smr01.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 244312C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 13:13:22 +1000 (EST)
Received: from mail94-va3 (localhost [127.0.0.1])	by mail94-va3-R.bigfish.com
 (Postfix) with ESMTP id 77FDE2403CC	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2012 03:11:16 +0000 (UTC)
Received: from VA3EHSMHS042.bigfish.com (unknown [10.7.14.253])	by
 mail94-va3.bigfish.com (Postfix) with ESMTP id 6B9D32014F	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 03:11:14 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q643DAg7008670	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2012 20:13:13 -0700
Date: Wed, 4 Jul 2012 11:14:26 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v7 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120704031426.GA6133@localhost.localdomain>
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXUeY-_mmBLoA25_g4eLqwHxYX4c_ECbU+KYqfM307THNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOZdJXUeY-_mmBLoA25_g4eLqwHxYX4c_ECbU+KYqfM307THNQ@mail.gmail.com>
Sender: <zch@tx30smr01.freescale.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
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

On Tue, Jul 03, 2012 at 07:46:24AM -0500, Tabi Timur-B04825 wrote:
> On Tue, Jul 3, 2012 at 5:21 AM, Zhao Chenhui <chenhui.zhao@freescale.com> wrote:
> 
> > +       np = of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
> > +       if (np) {
> > +               guts = of_iomap(np, 0);
> > +               of_node_put(np);
> > +               if (!guts) {
> > +                       pr_err("%s: Could not map guts node address\n",
> > +                                                               __func__);
> > +                       return;
> > +               }
> > +               smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
> > +               smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
> > +       }
> 
> I had this in mind:
> 
>                guts = of_iomap(np, 0);
>                of_node_put(np);
>                if (guts) {
>                        smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
>                        smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
>                 } else {
>                        pr_err("%s: Could not map guts node address\n",
>                                                                __func__);
>                }
> 
> That way, a missing GUTS node does not break everything.
> 

If the guts variable is NULL, it indicates there is error in dts or kernel.
We should fix the error, rather than ignore it.

Moreover, if smp_85xx_ops.give/take_timebase is NULL, kernel can not do the timebase sync.

-Chenhui
