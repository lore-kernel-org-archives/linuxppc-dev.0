Subject: patch for cpu/mpc8xx/cpu.c:get_tbclk
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFFF069FF9.720525F3-ON85256EA1.00688E39-85256EA1.0069104C@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Thu, 27 May 2004 15:07:34 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang,

The last if condition is wrong in this function.   The change is made
against 0.4.8.  AFAIK, 1.0.2 still has the same problem.

And I wonder why it has to reverse engineer the oscclk when I pass the
value as a define to come up with the gd->cpu_clk for the MPC866 family...
It is a bit useless I think.

David



/*
 * Get timebase clock frequency (like cpu_clk in Hz)
 *
 * See table 15-5 pp. 15-16, and SCCR[RTSEL] pp. 15-27.
 */
unsigned long get_tbclk (void)
{
        DECLARE_GLOBAL_DATA_PTR;

        volatile immap_t *immr = (volatile immap_t *) CFG_IMMR;
        ulong oscclk, factor, mf;

        if (immr->im_clkrst.car_sccr & SCCR_TBS) {
                return (gd->cpu_clk / 16);
        }
#define PLPRCR_val(a) (((CFG_PLPRCR) & PLPRCR_ ## a ## _MSK) >> PLPRCR_ ##
a ## _SHIFT)
#ifdef CONFIG_MPC866_et_al
        /*                   MFN
                     MFI + -------
                           MFD + 1
          factor =  -----------------
                     (PDF + 1) * 2^S
         */

        mf     = (PLPRCR_val(MFI) + PLPRCR_val(MFN)/(PLPRCR_val(MFD)+1));

        factor = (PLPRCR_val(MFI) + PLPRCR_val(MFN)/(PLPRCR_val(MFD)+1))/
                 (PLPRCR_val(PDF)+1) / (1<<PLPRCR_val(S));
#else
        factor = PLPRCR_val(MF)+1;
#endif

        oscclk = gd->cpu_clk / factor;

        if ((immr->im_clkrst.car_sccr & SCCR_RTSEL) == 0 || mf > 2) {
                return (oscclk / 4);
        }
        return (oscclk / 16);
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
