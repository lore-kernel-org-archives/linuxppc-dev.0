Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpDcX6sX6zDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 04:47:56 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id ks6so12263654pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 11:47:56 -0700 (PDT)
Date: Mon, 11 Jul 2016 11:47:53 -0700
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, paulus@ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v2] cpufreq: powernv: Replacing pstate_id with frequency
 table index
Message-ID: <20160711184753.GD4695@ubuntu>
References: <1467267787-2622-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467267787-2622-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30-06-16, 11:53, Akshay Adiga wrote:
> Refactoring code to use frequency table index instead of pstate_id.
> This abstraction will make the code independent of the pstate values.
> 
> - No functional changes
> - The highest frequency is at frequency table index 0 and the frequency
>   decreases as the index increases.
> - Macros pstates_to_idx() and idx_to_pstate() can be used for conversion
>   between pstate_id and index.
> - powernv_pstate_info now contains frequency table index to min, max and
>   nominal frequency (instead of pstate_ids)
> - global_pstate_info new stores index values instead pstate ids.
> - variables renamed as *_idx which now store index instead of pstate
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> Changes from v1:
>   - changed macro names from get_pstate()/ get_index() to 
> idx_to_pstate()/ pstate_to_idx()
>   - Renamed variables that store index instead of pstate_id to *_idx
>   - Retained previous printk's 
> 
> v1 : http://marc.info/?l=linux-pm&m=146677701501225&w=1
> 
>  drivers/cpufreq/powernv-cpufreq.c | 177 ++++++++++++++++++++++----------------
>  1 file changed, 102 insertions(+), 75 deletions(-)

Haven't done in-depth review, but I trust that Gautham has done it :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
