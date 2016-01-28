Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0292C1A07DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 19:28:45 +1100 (AEDT)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 486C2140BA3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 19:28:44 +1100 (AEDT)
Received: by mail-pa0-x231.google.com with SMTP id cy9so19662241pac.0
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 00:28:44 -0800 (PST)
Date: Thu, 28 Jan 2016 13:58:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v7 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Message-ID: <20160128082840.GI3935@vireshk>
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

On 28-01-16, 12:55, Shilpasri G Bhat wrote:
> cpu_to_chip_id() does a DT walk through to find out the chip id by
> taking a contended device tree lock. This adds an unnecessary overhead
> in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> the chip ids for all cores in the array 'core_to_chip_map' and use it
> in the hotpath.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v6:
> - Minor changes to move the code 'cpumask_copy()' after 'core_to_chip_map'
>   is allocated.
> - Move 'kfree(chips)' to a separate patch.

See, you weren't that bad :)

Just that you missed saying that individual patches contain
version-log in cover-letter :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
