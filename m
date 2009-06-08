Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 76D2EB70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Jun 2009 17:46:43 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9DAE9DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2009 17:46:42 +1000 (EST)
Message-ID: <4A2CC1DE.5040704@grandegger.com>
Date: Mon, 08 Jun 2009 09:46:38 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
References: <1241641262-5202-1-git-send-email-wd@denx.de>	<1241641262-5202-6-git-send-email-wd@denx.de>	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>	<20090606221618.701E0832E416@gemini.denx.de>	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>	<20090606232148.4E0BD832E416@gemini.denx.de>	<4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
	<20090607203406.7C8BC832E416@gemini.denx.de>
In-Reply-To: <20090607203406.7C8BC832E416@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <Hong-jun.chen@freecale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear John,
> 
> in message <4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com> you wrote:
>>> The big question seems to be what the RefMan means when talking about
>>> the "system clock frequency". Obiously it is NOT  the  CPU  clock  as
> ...
>>> But which one is it?
>> My best guess is still that it is ips clock.  I think I stated in a previous
>> email ipb, but I meant ips.  5200 has ibp and 5121 has ips.  Have you looked
>> at he MII clock on a scope to see how the calculated values compare to
>> actual?
> 
> Yes, it seems very much as if you were right again.
> 
> When using ips/ibp everything makes sense, and works.
> 
> Hm... so that means on MPC512x we should use mpc512x_find_ips_freq(),
> while on MPC5200 we should use  mpc52xx_find_ipb_freq()  -  but  hey,
> apart from the name these two functions are identical.
> 
> Grant - how would you like to see this handled? Should we merge these
> two code-wise identical functions into one?  What should be the name,
> and in which file should we put it?
> 
> [We need this clock thing for "drivers/net/fs_enet/mii-fec.c"...]

I2C and MSCAN need it as well. What about implementing the more generic
clk api for the MPC5200 as done for the MPC512x?

http://lxr.linux.no/linux+v2.6.29/arch/powerpc/platforms/512x/clock.c

The MSCAN can also operate with other clock sources, e.g. the external
oscillator (ref_clk). This would avoid cumbersome frequency calculations
from the clock bit settings in the driver as shown below:

  /*
   * Get the frequency of the external oscillator clock connected
   * to the SYS_XTAL_IN pin, or retrun 0 if it cannot be determined.
   */
  static unsigned int  __devinit mpc52xx_can_xtal_freq(struct device_node *np)
  {
        struct mpc52xx_cdm  __iomem *cdm;
        struct device_node *np_cdm;
        unsigned int freq;
        u32 val;

        freq = mpc52xx_find_ipb_freq(np);
        if (!freq)
                return 0;

        /*
         * Detemine SYS_XTAL_IN frequency from the clock domain settings
         */
        np_cdm = of_find_matching_node(NULL, mpc52xx_cdm_ids);
        cdm = of_iomap(np_cdm, 0);
        of_node_put(np_cdm);
        if (!np_cdm) {
                printk(KERN_ERR "%s() failed abnormally\n", __func__);
                return 0;
        }

        if (in_8(&cdm->ipb_clk_sel) & 0x1)
                freq *= 2;
        val  = in_be32(&cdm->rstcfg);
        if (val & (1 << 5))
                freq *= 8;
        else
                freq *= 4;
        if (val & (1 << 6))
                freq /= 12;
        else
                freq /= 16;

        iounmap(cdm);

        return freq;
  }

Wolfgang.
