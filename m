Message-ID: <39A28B21.8F91CACA@aiinet.com>
Date: Tue, 22 Aug 2000 10:16:01 -0400
From: Matt Gessner <mattg@aiinet.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch to arch/ppc/kernel/m8260_setup.c
References: <m13RDKd-001SzbC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:
>
> In order to get things to compile for the MPC8260, the following
> patch was needed:
>
> dell 377} bk diffs -r1.7 -u arch/ppc/kernel/m8260_setup.c
> ===== arch/ppc/kernel/m8260_setup.c 1.7 vs 1.8 =====
> --- 1.7/arch/ppc/kernel/m8260_setup.c   Wed Aug  2 12:53:58 2000
> +++ 1.8/arch/ppc/kernel/m8260_setup.c   Mon Aug 21 21:17:00 2000
> @@ -113,9 +113,8 @@
>
>         freq = (binfo->bi_busfreq * 1000000);
>          divisor = 4;
> -        decrementer_count = freq / HZ / divisor;
> -        count_period_num = divisor;
> -        count_period_den = freq / 1000000;
> +        tb_ticks_per_jiffy = freq / (divisor * HZ);
> +        tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
>  }
>
>  /* The 8260 has an internal 1-second timer update register that
>

You don't mention the source of this code (i.e. linux rev and test#).

My 2.3 kernel compiles just fine...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
