Return-Path: <xyzzy@speakeasy.org>
Date: Fri, 1 Aug 2008 14:14:43 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
In-Reply-To: <9e4733910808010732u48ed06a4vc2121c133d91bbbd@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0808011400020.10341@shell4.speakeasy.net>
References: <4891F4D8.9090905@grandegger.com> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
	<20080801020303.GA30947@secretlab.ca>
	<9e4733910807311935n1f81f18dw135372d97d3dcb45@mail.gmail.com>
	<ed82fe3e0808010625q53680d42l83f28a6df835f959@mail.gmail.com>
	<9e4733910808010732u48ed06a4vc2121c133d91bbbd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 1 Aug 2008, Jon Smirl wrote:
> I don't like the third choice. Keep a simple Linux driver for i2c and
> the platform, and then move all of the messy code into uboot.  BTW,
> the messy code is about 10 lines. It's going to take more than 10
> lines to hide those 10 lines.

It's not being _moved_ to u-boot, it's already there.  U-boot needs it
because u-boot uses i2c.

It would need to be duplicated in linux, and then both u-boot and linux
would need to be updated each time a new platform is added.

It's pretty much a given that a u-boot binary will only work on one
platform.  The same is not true with a compiled kernel.  That makes it
harder to all the platform specific stuff in linux.  It's a little more
than 10 lines too.  Keep in mind that accessing all these devices registers
isn't as easy in linux as u-boot.  In linux you have to look up the
register location in device tree and map the registers.  All this code uses
a system clock as a starting point, which u-boot already passes to linux.

#if defined(CONFIG_MPC83XX)
        volatile immap_t *im = (immap_t *) CFG_IMMR;
        sccr = im->clk.sccr;
#if defined(CONFIG_MPC834X) || defined(CONFIG_MPC831X) || defined(CONFIG_MPC837X)
        switch ((sccr & SCCR_TSEC1CM) >> SCCR_TSEC1CM_SHIFT) {
        case 0:
                tsec1_clk = 0;
                break;
        case 1:
                tsec1_clk = csb_clk;
                break;
        case 2:
                tsec1_clk = csb_clk / 2;
                break;
        case 3:
                tsec1_clk = csb_clk / 3;
                break;
        default:
                /* unkown SCCR_TSEC1CM value */
                return -2;
        }
#endif
#if defined(CONFIG_MPC834X) || defined(CONFIG_MPC837X) || defined(CONFIG_MPC8315)
        switch ((sccr & SCCR_TSEC2CM) >> SCCR_TSEC2CM_SHIFT) {
        case 0:
                tsec2_clk = 0;
                break;
        case 1:
                tsec2_clk = csb_clk;
                break;
        case 2:
                tsec2_clk = csb_clk / 2;
                break;
        case 3:
                tsec2_clk = csb_clk / 3;
                break;
        default:
                /* unkown SCCR_TSEC2CM value */
                return -4;
        }
#elif defined(CONFIG_MPC8313)
        tsec2_clk = tsec1_clk;

        if (!(sccr & SCCR_TSEC1ON))
                tsec1_clk = 0;
        if (!(sccr & SCCR_TSEC2ON))
                tsec2_clk = 0;
#endif
        switch ((sccr & SCCR_ENCCM) >> SCCR_ENCCM_SHIFT) {
        case 0:
                enc_clk = 0;
                break;
        case 1:
                enc_clk = csb_clk;
                break;
        case 2:
                enc_clk = csb_clk / 2;
                break;
        case 3:
                enc_clk = csb_clk / 3;
                break;
        default:
                /* unkown SCCR_ENCCM value */
                return -7;
        }
#if defined(CONFIG_MPC837X)
        switch ((sccr & SCCR_SDHCCM) >> SCCR_SDHCCM_SHIFT) {
        case 0:
                sdhc_clk = 0;
                break;
        case 1:
                sdhc_clk = csb_clk;
                break;
        case 2:
                sdhc_clk = csb_clk / 2;
                break;
        case 3:
                sdhc_clk = csb_clk / 3;
                break;
        default:
                /* unkown SCCR_SDHCCM value */
                return -8;
        }
#endif
#if defined(CONFIG_MPC834X)
        i2c1_clk = tsec2_clk;
#elif defined(CONFIG_MPC8360)
        i2c1_clk = csb_clk;
#elif defined(CONFIG_MPC832X)
        i2c1_clk = enc_clk;
#elif defined(CONFIG_MPC831X)
        i2c1_clk = enc_clk;
#elif defined(CONFIG_MPC837X)
        i2c1_clk = sdhc_clk;
#endif
#if !defined(CONFIG_MPC832X)
        i2c2_clk = csb_clk; /* i2c-2 clk is equal to csb clk */
#endif

#elif defined (CONFIG_MPC85XX)

#if defined(CONFIG_MPC8540) || defined(CONFIG_MPC8541) || \
        defined(CONFIG_MPC8560) || defined(CONFIG_MPC8555)
        gd->i2c1_clk = sys_info.freqSystemBus;
#elif defined(CONFIG_MPC8544)
        volatile ccsr_gur_t *gur = (void *) CFG_MPC85xx_GUTS_ADDR;
        /*
         * On the 8544, the I2C clock is the same as the SEC clock.  This can be
         * either CCB/2 or CCB/3, depending on the value of cfg_sec_freq. See
         * 4.4.3.3 of the 8544 RM.  Note that this might actually work for all
         * 85xx, but only the 8544 has cfg_sec_freq, so it's unknown if the
         * PORDEVSR2_SEC_CFG bit is 0 on all 85xx boards that are not an 8544.
         */
        if (gur->pordevsr2 & MPC85xx_PORDEVSR2_SEC_CFG)
                gd->i2c1_clk = sys_info.freqSystemBus / 3;
        else
                gd->i2c1_clk = sys_info.freqSystemBus / 2;
#else
        /* Most 85xx SOCs use CCB/2, so this is the default behavior. */
        gd->i2c1_clk = sys_info.freqSystemBus / 2;
#endif
        gd->i2c2_clk = gd->i2c1_clk;

#elif defined(CONFIG_MPC86XX)

#ifdef CONFIG_MPC8610
        gd->i2c1_clk = sys_info.freqSystemBus;
#else
        gd->i2c1_clk = sys_info.freqSystemBus / 2;
#endif
        gd->i2c2_clk = gd->i2c1_clk;

#endif
