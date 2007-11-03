Return-Path: <bsingharora@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id D2F7BDDE09
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 20:03:02 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1323122wag
	for <linuxppc-dev@ozlabs.org>; Sat, 03 Nov 2007 02:02:59 -0700 (PDT)
Message-ID: <661de9470711030202x24d0186cuc96a70156ecfa23f@mail.gmail.com>
Date: Sat, 3 Nov 2007 14:32:59 +0530
From: "Balbir Singh" <balbir@linux.vnet.ibm.com>
Sender: bsingharora@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] Restore deterministic CPU accounting on powerpc
In-Reply-To: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#ifndef CONFIG_VIRT_CPU_ACCOUNTING
> +void account_process_tick(int user_tick)
> +{
> +       if (user_tick) {
> +               account_user_time(p, jiffies_to_cputime(1));
> +               account_user_time_scaled(p, jiffies_to_cputime(1));
> +       } else {
> +               account_system_time(p, HARDIRQ_OFFSET, jiffies_to_cputime(1));
> +               account_system_time_scaled(p, jiffies_to_cputime(1));
> +       }
> +}
> +#endif
> +

Hi, Paul,

So, scaled accounting will not be available if
CONFIG_VIRT_CPU_ACCOUNTING is defined? Am I reading this correctly

Balbir Singh
