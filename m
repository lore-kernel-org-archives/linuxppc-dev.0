Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqcZy1NN3zDqVw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 19:51:06 +1000 (AEST)
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qqcZx3Ymqz9t3Z
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 19:51:03 +1000 (AEST)
Received: by mail-pa0-x235.google.com with SMTP id fs9so16458028pac.2
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 02:51:02 -0700 (PDT)
Date: Wed, 20 Apr 2016 15:20:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernv: Fixes initialization of chip and chip
 mask
Message-ID: <20160420095056.GE12019@vireshk-i7>
References: <1461144758-17810-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461144758-17810-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20-04-16, 15:02, Shilpasri G Bhat wrote:
> commit 735366fc4077 ("cpufreq: powernv: Call throttle_check() on
> receiving OCC_THROTTLE") used cpumask_of_node() as the chip mask. But
> this mask contains only online cpus. This breaks a setup where cpufreq
> is initialized with few offline cores and made online later. So this
> patch fixes this bug by scanning all the possible cpus and sets the
> cpu in the chip mask. It also fixes the chip discovery with
> non-contiguous cpu mask. This patch creates a list of chips
> 'powernv_chip_list' to replace the chip array for cleaner
> initialization.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 80 +++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 32 deletions(-)

You have made your patch less readable by mixing two things here. Yes
you prefer/need the list way of doing things for the new stuff, but
that should have been done separately. Right now, I have to read it
very carefully to see which line did the real change you are talking
about.

So, please split this up into multiple patches. First one just moving
to the list instead of array.

-- 
viresh
