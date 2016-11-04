Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9C0y4K78zDvYb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 17:41:37 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id d2so46260493pfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 23:41:37 -0700 (PDT)
Date: Fri, 4 Nov 2016 12:11:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] cpufreq: powernv: Use PMSR to verify global and
 local pstate
Message-ID: <20161104064132.GB3414@vireshk-i7>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04-11-16, 10:57, Akshay Adiga wrote:
> As fast_switch may get called in interrupt disable mode, it does not

s/in interrupt disable mode/with interrupts disabled
s/it does/it may

> update the global_pstate_info data structure. Hence the global_pstate_info
> has stale data whenever pstate is updated through fast_swtich().

s/has/may have
s/swtich/switch

> 
> So the gpstate_timer can fire after a fast_switch() call has update

s/So the/The
s/a fast_swtich() call has update/the fast_switch() call has updated

> the pstates to a different value. Hence the timer handler cannot rely
> on the cached values of local and global pstate and needs to read it
> from the PMSR. 
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> 
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)

I am not the best guy to judge the code changes here. Can you please include
Shilpa and Gautham to the mail chain and get there feedback.

-- 
viresh
