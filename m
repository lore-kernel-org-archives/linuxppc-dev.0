Date: Mon, 21 Aug 2000 17:06:41 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: diekema_jon <diekema@bucks.si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: decrementer_count, count_period_num, and count_period_den has
In-Reply-To: <m13Qrpt-001SzbC@bucks>
Message-ID: <Pine.HPX.4.10.10008211653500.15550-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 21 Aug 2000, diekema_jon wrote:

> Does this patch make sense?

Yes, with the few remarks below...

>
>
> dell 200} bk diffs -r1.7 -u arch/ppc/kernel/m8260_setup.c
> ===== arch/ppc/kernel/m8260_setup.c 1.7 vs 1.10 =====
> --- 1.7/arch/ppc/kernel/m8260_setup.c   Wed Aug  2 12:53:58 2000
> +++ 1.10/arch/ppc/kernel/m8260_setup.c  Mon Aug 21 09:34:30 2000
> @@ -113,9 +113,8 @@
>
>         freq = (binfo->bi_busfreq * 1000000);
>          divisor = 4;
> -        decrementer_count = freq / HZ / divisor;
> -        count_period_num = divisor;
> -        count_period_den = freq / 1000000;
> +       tb_ticks_per_jiffy = freq / divisor / HZ;

I'd rather write it freq/(divisor*HZ), but it should not change anything.

> +       tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);

I had the impression that the tb/decrementer frequency was not guaranteed
(from the comments) to be > 1MHz, while it's always the case for 6xx
processors. If it's in the right frequency range (1MHz to something like
4 billion*HZ or ~400GHz ;-)), then this code should work just fine.

The final test is obviously that it works... Check that gettimeofday does
not always return an exact multiple of 1/HZ. (or that 2 succesive calls to
gettimeofday do not return exactly the same value from user mode so that
there is enough delay)

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
