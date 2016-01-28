Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 510A21A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 19:11:14 +1100 (AEDT)
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52EF6140B96
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 19:11:13 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 03:11:11 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EC0B738C8039
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 03:11:08 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S8B8lo28704912
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 08:11:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S8B7pn018793
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 03:11:08 -0500
Date: Thu, 28 Jan 2016 13:41:03 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v7 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Message-ID: <20160128081103.GB13654@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453965941-7363-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2016 at 12:55:38PM +0530, Shilpasri G Bhat wrote:
> cpu_to_chip_id() does a DT walk through to find out the chip id by
> taking a contended device tree lock. This adds an unnecessary overhead
> in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> the chip ids for all cores in the array 'core_to_chip_map' and use it
> in the hotpath.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.
