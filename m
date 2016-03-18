Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRg9f60MbzDq6V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 09:38:30 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qRg9f3WHkz9s9j
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2016 09:38:30 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 19 Mar 2016 08:38:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1C3A03578053
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2016 09:38:14 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2IMc6Lm30015550
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2016 09:38:14 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2IMbf6u031423
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2016 09:37:41 +1100
Message-ID: <1458340635.3107.89.camel@au1.ibm.com>
Subject: Re: [PATCH v8 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Neuling <mikey@neuling.org>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 shreyas@linux.vnet.ibm.com, rjw@rjwysocki.net, pc@us.ibm.com,
 viresh.kumar@linaro.org, anton@samba.org
Date: Sat, 19 Mar 2016 09:37:15 +1100
In-Reply-To: <1458273857.6622.75.camel@neuling.org>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1458273857.6622.75.camel@neuling.org>
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

On Fri, 2016-03-18 at 15:04 +1100, Michael Neuling wrote:
> 
>  static int nr_chips;
> +static DEFINE_PER_CPU(unsigned int, chip_id);
>  
>  /*
>   * Note: The set of pstates consists of contiguous integers, the
> @@ -317,9 +318,7 @@ static void powernv_cpufreq_throttle_check(void
> *data)
>  
>         pmsr = get_pmspr(SPRN_PMSR);
>  
> -       for (i = 0; i < nr_chips; i++)
> -               if (chips[i].id == cpu_to_chip_id(cpu))
> -                       break;
> +       i = this_cpu_read(chip_id);

Except it's not a chip_id, so your patch confused me for a good 2mn ...
Call it chip_idx maybe ? ie, index.

Cheers,
Ben.

>         /* Check for Pmax Capping */
>         pmsr_pmax = (s8)PMSR_MAX(pmsr);
> @@ -560,6 +559,7 @@ static int init_chip_info(void)
>         for_each_possible_cpu(cpu) {
>                 unsigned int id = cpu_to_chip_id(cpu);
>  
> +               per_cpu(chip_id, cpu) = nr_chips;
>                 if (prev_chip_id != id) {
>                         prev_chip_id = id;
>                         chip[nr_chips++] = id;
> _______________________________________________
