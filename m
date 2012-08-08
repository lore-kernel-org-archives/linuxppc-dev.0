Return-Path: <zch@tx30smr01.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 407E92C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 17:09:54 +1000 (EST)
Received: from mail75-co1 (localhost [127.0.0.1])	by mail75-co1-R.bigfish.com
 (Postfix) with ESMTP id 353D780363	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2012 07:09:50 +0000 (UTC)
Received: from CO1EHSMHS026.bigfish.com (unknown [10.243.78.238])	by
 mail75-co1.bigfish.com (Postfix) with ESMTP id AAC9A640044	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 07:09:47 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q7879gfX027888	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2012 00:09:45 -0700
Date: Wed, 8 Aug 2012 15:11:26 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] cpu: export cpu hotplug disable/enable functions as
 global functions
Message-ID: <20120808071125.GA31389@localhost.localdomain>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-3-git-send-email-chenhui.zhao@freescale.com>
 <B4FC7F5E-EA8F-4FCA-B206-353FE4481DCE@kernel.crashing.org>
 <50220382.4010405@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <50220382.4010405@linux.vnet.ibm.com>
Sender: <zch@tx30smr01.freescale.net>
Cc: rjw@sisk.pl,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2012 at 11:43:22AM +0530, Srivatsa S. Bhat wrote:
> On 08/07/2012 11:21 PM, Kumar Gala wrote:
> > 
> > On Aug 7, 2012, at 3:43 AM, Zhao Chenhui wrote:
> > 
> >> The cpufreq driver of mpc85xx will disable/enable cpu hotplug temporarily.
> >> Therefore, the related functions should be exported.
> >>
> >> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> >> ---
> >> include/linux/cpu.h |    4 ++++
> >> 1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > Rafael, Srivatsa,
> > 
> > Wanted to get your ack on export these functions for direct calling by arch code.
> >
> 
> Why not just use get_online_cpus()/put_online_cpus()?
> 
> In the case of suspend/resume/hibernation, we had introduced these CPU hotplug disable
> functions because we would end up doing CPU hotplug ourselves, further down the path.
> So if we did a get_online_cpus(), we would end up deadlocking ourselves. Whereas, the
> patch 4/4 looks like a straightforward case of wanting to simply disable CPU hotplug..
> I don't see where you are doing CPU hotplug yourself in the path. So IMO, just
> get/put_online_cpus() should do.
> 
> Regards,
> Srivatsa S. Bhat
> 

Thanks for your comment. I will try to use get/put_online_cpus() in my patch.

-Chenhui
