In-Reply-To: <OFBC5021DB.73FD330B-ON85256EA1.0069EDD8-85256EA1.006A2638@nanometrics.ca>
Subject: Re: patch for cpu/mpc8xx/cpu.c:get_tbclk - correction
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF56B34E9F.F54633BE-ON85256EA1.006B44CD-85256EA1.006B91DC@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Thu, 27 May 2004 15:34:56 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Now that I think of it, the _multiplier_ (as I declared it here) cannot be
an integer, so this is all wrong.

I don't know how I got this working... I have a 50 Mhz oscillator with 66
Mhz system clock.

Why not use the oscillator define (CFG_8XX_XIN) for MPC866_et_al?

David


owner-linuxppc-embedded@lists.linuxppc.org wrote on 05/27/2004 03:19:26 PM:

>
> > The last if condition is wrong in this function.   The change is made
> > against 0.4.8.  AFAIK, 1.0.2 still has the same problem.
> >
> > And I wonder why it has to reverse engineer the oscclk when I pass the
> > value as a define to come up with the gd->cpu_clk for the MPC866
> family...
> > It is a bit useless I think.
> >
>
> Sorry, the last patch breaks on the old 8xx.
>
> This is a bit better.
>
>
> /*
>  * Get timebase clock frequency (like cpu_clk in Hz)
>  *
>  * See table 15-5 pp. 15-16, and SCCR[RTSEL] pp. 15-27.
>  */
> unsigned long get_tbclk (void)
> {
>         DECLARE_GLOBAL_DATA_PTR;
>
>         volatile immap_t *immr = (volatile immap_t *) CFG_IMMR;
>         ulong oscclk, factor, multiplier;
>
>         if (immr->im_clkrst.car_sccr & SCCR_TBS) {
>                 return (gd->cpu_clk / 16);
>         }
> #define PLPRCR_val(a) (((CFG_PLPRCR) & PLPRCR_ ## a ## _MSK) >> PLPRCR_
##
> a ## _SHIFT)
> #ifdef CONFIG_MPC866_et_al
>         /*                   MFN
>                      MFI + -------
>                            MFD + 1
>           factor =  -----------------
>                      (PDF + 1) * 2^S
>          */
>
>         factor = (PLPRCR_val(MFI) + PLPRCR_val(MFN)/(PLPRCR_val(MFD)+1));
>
>         multiplier = (PLPRCR_val(MFI) +
> PLPRCR_val(MFN)/(PLPRCR_val(MFD)+1))/
>                      (PLPRCR_val(PDF)+1) / (1<<PLPRCR_val(S));
> #else
>         multiplier = factor = PLPRCR_val(MF)+1;
> #endif
>
>         oscclk = gd->cpu_clk / multiplier;
>
>         if ((immr->im_clkrst.car_sccr & SCCR_RTSEL) == 0 || factor > 2) {
>                 return (oscclk / 4);
>         }
>         return (oscclk / 16);
> }
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
