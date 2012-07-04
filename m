Return-Path: <zch@az84smr01.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 276AF2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 13:44:40 +1000 (EST)
Received: from mail8-va3 (localhost [127.0.0.1])	by mail8-va3-R.bigfish.com
 (Postfix) with ESMTP id 2FC3E3200BD	for <linuxppc-dev@lists.ozlabs.org>; Wed,
 4 Jul 2012 03:42:35 +0000 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.241])	by
 mail8-va3.bigfish.com (Postfix) with ESMTP id BFF21E0057	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 03:42:32 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q643iQLD032371	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2012 20:44:27 -0700
Date: Wed, 4 Jul 2012 11:45:45 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v7 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120704034545.GA6196@localhost.localdomain>
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXUeY-_mmBLoA25_g4eLqwHxYX4c_ECbU+KYqfM307THNQ@mail.gmail.com>
 <20120704031426.GA6133@localhost.localdomain>
 <4FF3B5B6.8090400@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FF3B5B6.8090400@freescale.com>
Sender: <zch@az84smr01.freescale.net>
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

On Tue, Jul 03, 2012 at 10:17:12PM -0500, Tabi Timur-B04825 wrote:
> Zhao Chenhui wrote:
> > If the guts variable is NULL, it indicates there is error in dts or kernel.
> > We should fix the error, rather than ignore it.
> 
> And that's why there's a warning message.  Crashing the kernel is not 
> going to fix anything.
> 

This error likely crashes the kenel somewhere.

> > Moreover, if smp_85xx_ops.give/take_timebase is NULL, kernel can not do the timebase sync.
> 
> Is that necessary for the kernel to boot?
> 

No. But in the cpu hotplug context, we need do the timebase sync.

-Chenhui
