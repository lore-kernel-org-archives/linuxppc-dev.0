Date: Fri, 4 Feb 2000 23:26:03 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Chas Williams <chas@cmf.nrl.navy.mil>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
In-Reply-To: <200002050215.VAA02658@fermi.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.3.96.1000204232520.15802L-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 4 Feb 2000, Chas Williams wrote:

>
> i needed to apply the following to fix nvram access:
>
> --- drivers/char/misc.c.000     Fri Feb  4 18:00:52 2000
> +++ drivers/char/misc.c Fri Feb  4 18:03:43 2000
> @@ -72,6 +72,7 @@
>  extern int rtc_DP8570A_init(void);
>  extern int rtc_MK48T08_init(void);
>  extern int dsp56k_init(void);
> +extern int nvram_init(void);
>  extern int radio_init(void);
>  extern int pc110pad_init(void);
>  extern int pmu_device_init(void);
> @@ -207,6 +208,9 @@
>  #endif
>  #ifdef CONFIG_ATARI_DSP56K
>         dsp56k_init();
> +#endif
> +#ifdef CONFIG_NVRAM
> +       nvram_init();
>  #endif
>  #ifdef CONFIG_MISC_RADIO
>         radio_init();

This patch is wrong.  I fixed nvram to use initcalls.

If nvram doesn't load you have other problems.

	Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
