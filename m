Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 724291A086D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:36:42 +1000 (AEST)
Received: by pdbki1 with SMTP id ki1so24140257pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2015 23:36:40 -0700 (PDT)
Date: Thu, 4 Jun 2015 12:06:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian.Tang@freescale.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpufreq: qoriq: optimize the CPU frequency switching time
Message-ID: <20150604063636.GH11325@linux>
References: <1433399142-18324-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433399142-18324-1-git-send-email-Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04-06-15, 14:25, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> Each time the CPU switches its frequency, the clock nodes in
> DTS are walked through to find proper clock source. This is
> very time-consuming, for example, it is up to 500+ us on T4240.
> Besides, switching time varies from clock to clock.
> To optimize this, each input clock of CPU is buffered, so that
> it can be picked up instantly when needed.
> 
> Since for each CPU each input clock is stored in a pointer
> which takes 4 or 8 bytes memory and normally there are several
> input clocks per CPU, that will not take much memory as well.

Not sure how it got included in this form in the first place. :)

> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
