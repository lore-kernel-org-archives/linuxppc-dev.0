Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C8391A0541
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:31:32 +1000 (AEST)
Message-ID: <1440667890.18333.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Export frequency throttle state of
 the chip through sysfs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Date: Thu, 27 Aug 2015 19:31:30 +1000
In-Reply-To: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-27 at 14:43 +0530, Shilpasri G Bhat wrote:
> Create a sysfs 'throttle' attribute per-chip(per-numa-node) to reflect
> the throttle state of the chip. The usersapce programs can poll on
> this attribute to keep an eye on the throttle state. Currently we
> print a log message to notify the user of throttling event. The
> performance-sensitive applications can monitor the throttle state
> using this attribute.

Performance sensitive applications can *poll* on a sysfs file, which does a
loop over all chips and potentially spams the console with pr_crit() messages ?

That does not sound like a recipe for success.

What problem are we actually trying to solve here?

cheers
