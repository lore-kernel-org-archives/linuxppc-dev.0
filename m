Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7BCF1A1AA1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:38:18 +1100 (AEDT)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D0EC14031F
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 16:38:18 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sun, 24 Jan 2016 22:38:15 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7D1E61FF0042
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jan 2016 22:26:21 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0P5cAe927197528
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 05:38:10 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0P5cAFl015296
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 00:38:10 -0500
Date: Mon, 25 Jan 2016 11:08:05 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH v6 2/5] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Message-ID: <20160125053804.GA5599@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453447145-17722-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160123195920.552990ed@cotter.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160123195920.552990ed@cotter.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Balbir,

On Sat, Jan 23, 2016 at 07:59:20PM +1100, Balbir Singh wrote:
> On Fri, 22 Jan 2016 12:49:02 +0530
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:
> 
> > cpu_to_chip_id() does a DT walk through to find out the chip id by
> > taking a contended device tree lock. This adds an unnecessary overhead
> > in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> > the chip ids for all cores in the array 'core_to_chip_map' and use it
> > in the hotpath.
> > 
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> snip
> 
> Does the core_to_chip_map need to be updated/refreshed on/after/ a
> cpu (core) hotplug? I presume id's don't change

No, the id's don't change on cpu/core hotplug. The core_to_chip_map is
initialized in init_chip_info() where we use for_each_possible_cpu().

Thanks for the review!
> 
> Balbir
> 
--
Thanks and Regards
gautham.
