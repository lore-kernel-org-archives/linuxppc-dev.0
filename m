Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23FD71A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 20:17:30 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7075E1401DA
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 20:17:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 15:47:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9B4F53940057
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 15:47:23 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7RAH7Xx47186014
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 15:47:09 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7RAH5AQ008271
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 15:47:05 +0530
Message-ID: <55DEE3A0.1090100@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 15:47:04 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] cpufreq: powernv: Export frequency throttle state of
 the chip through sysfs
References: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1440667890.18333.1.camel@ellerman.id.au>
In-Reply-To: <1440667890.18333.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/27/2015 03:01 PM, Michael Ellerman wrote:
> On Thu, 2015-08-27 at 14:43 +0530, Shilpasri G Bhat wrote:
>> Create a sysfs 'throttle' attribute per-chip(per-numa-node) to reflect
>> the throttle state of the chip. The usersapce programs can poll on
>> this attribute to keep an eye on the throttle state. Currently we
>> print a log message to notify the user of throttling event. The
>> performance-sensitive applications can monitor the throttle state
>> using this attribute.
> 
> Performance sensitive applications can *poll* on a sysfs file, which does a
> loop over all chips and potentially spams the console with pr_crit() messages ?
> 
> That does not sound like a recipe for success.

Okay.

> 
> What problem are we actually trying to solve here?

How to export the throttle information to the user space, such that it is
consumable by the applications (for example to discard the benchmark run if the
frequency was throttled)?

We already print the throttle information to console. Can we extend this to
notify/broadcast as an event to the applications?

Thanks and Regards,
Shilpa
