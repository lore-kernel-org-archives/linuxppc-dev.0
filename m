Return-Path: <zch@tx30smr01.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CFDA2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 20:24:18 +1000 (EST)
Received: from mail8-co1 (localhost [127.0.0.1])	by mail8-co1-R.bigfish.com
 (Postfix) with ESMTP id 0B6E4B40139	for <linuxppc-dev@lists.ozlabs.org>; Thu,
 5 Jul 2012 10:22:09 +0000 (UTC)
Received: from CO1EHSMHS016.bigfish.com (unknown [10.243.78.241])	by
 mail8-co1.bigfish.com (Postfix) with ESMTP id DBF4A88004A	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 10:22:06 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q65AO8Pp018947	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 03:24:09 -0700
Date: Thu, 5 Jul 2012 18:25:29 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v7 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120705102529.GA7982@localhost.localdomain>
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXUeY-_mmBLoA25_g4eLqwHxYX4c_ECbU+KYqfM307THNQ@mail.gmail.com>
 <20120704031426.GA6133@localhost.localdomain>
 <4FF3B5B6.8090400@freescale.com>
 <20120704034545.GA6196@localhost.localdomain>
 <4FF45F19.2080607@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FF45F19.2080607@freescale.com>
Sender: <zch@tx30smr01.freescale.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
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

On Wed, Jul 04, 2012 at 10:19:54AM -0500, Tabi Timur-B04825 wrote:
> Zhao Chenhui wrote:
> > On Tue, Jul 03, 2012 at 10:17:12PM -0500, Tabi Timur-B04825 wrote:
> >> Zhao Chenhui wrote:
> >>> If the guts variable is NULL, it indicates there is error in dts or kernel.
> >>> We should fix the error, rather than ignore it.
> >>
> >> And that's why there's a warning message.  Crashing the kernel is not
> >> going to fix anything.
> >>
> >
> > This error likely crashes the kenel somewhere.
> 
> Can you test this, please?
> 
> The point I'm trying to make is that it's wrong to intentionally halt the 
> kernel unless you're sure that it's the best option.  A missing device 
> tree node is supposed to only disable a given feature, not break everything.
> 

I think there is some misunderstanding here.

	np = of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
	if (np) {
		guts = of_iomap(np, 0);
		of_node_put(np);
		if (!guts) {
			pr_err("%s: Could not map guts node address\n",
								__func__);
			return;
		}
		smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
		smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
	}

If the guts node is missing, this code snippet will be skipped. If the guts node is existed,
the return value of of_iomap(), namely guts, will be tested. If it is NULL, it shows
that there is error in dts, or the ioremap() in of_iomap() failed. I think
these errors are fatal errors, so I print an error info and return.

-Chenhui
																													
