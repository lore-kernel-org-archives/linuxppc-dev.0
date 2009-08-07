Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3286AB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 02:03:37 +1000 (EST)
MIME-Version: 1.0
Date: Fri, 7 Aug 2009 12:03:33 -0400
Message-ID: <9e4733910908070903p539b8987p8351df5b3d328fdd@mail.gmail.com>
Subject: PSC clock divider
From: Jon Smirl <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc52xx_set_psc_clkdiv() has problems. It take the clk divider as a
parameter. But this divisor is not always gettting calculated
correctly. My code in i2s was doing it wrong.

Take this snippet from the SPI driver, it just assumes a fsystem of
512Mhz. fsystem is 533Mhz on my boards.

	/* default sysclk is 512MHz */
	mclken_div = (mps->sysclk ? mps->sysclk : 512000000) / MCLK;
	mpc52xx_set_psc_clkdiv(psc_id, mclken_div);

Is it also not accounting for the hardware adding one to the divisor.

I've change i2s to this:

			if (!fsystem) {
				np = of_find_matching_node(NULL, mpc52xx_cdm_ids);
				mpc52xx_cdm = of_iomap(np, 0);
				fsystem = mpc5xxx_get_bus_frequency(np);
				of_node_put(np);
				val = in_be32(&mpc52xx_cdm->rstcfg);
				if (val & (1 << 5))
					fsystem *= 8;
				else
					fsystem *= 4;
				iounmap(mpc52xx_cdm);
			}
			clkdiv = fsystem / freq;
			err = fsystem % freq;
			if (err > freq / 2)
				clkdiv++;

			dev_dbg(psc_dma->dev, "psc_i2s_set_sysclk(clkdiv %d freq error=%dHz)\n",
					clkdiv, (fsystem / clkdiv - freq));

			/* PSC is 1-6 */
			/* Hardware adds 1 to divisor */
			return mpc52xx_set_psc_clkdiv(psc_dma->id + 1, clkdiv - 1);


Should I modify mpc52xx_set_psc_clkdiv() to take in a frequency and
them move this code into mpc52xx_common.c? That allows the sysclk
parameter to be eliminated for SPI.


-- 
Jon Smirl
jonsmirl@gmail.com
