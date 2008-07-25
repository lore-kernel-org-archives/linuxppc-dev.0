Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807250804l7c16531dxe3a28664d40939aa@mail.gmail.com>
Date: Fri, 25 Jul 2008 11:04:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>,
	"Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/25/08, Timur Tabi <timur@freescale.com> wrote:
> On Fri, Jul 25, 2008 at 8:12 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>
>  > Yes, please use something like clock-frequency or current-speed and do
>  > the calculation.
>
> Ditto.  I already wrote the code that does that for U-Boot, so all you
>  need to do is port it.

I calculate the register values in the i2s driver. There is the issue
of requesting a frequency the hardware can't make exactly (Freescale -
more FractionalN dividers please!).

	if (dir == SND_SOC_CLOCK_OUT) {
		psc_i2s->sysclk = freq;
		if (clk_id == MPC52xx_CLK_CELLSLAVE) {
			psc_i2s->sicr |= MPC52xx_PSC_SICR_CELLSLAVE | MPC52xx_PSC_SICR_GENCLK;
		} else { /* MPC52xx_CLK_INTERNAL */
			psc_i2s->sicr &= ~MPC52xx_PSC_SICR_CELLSLAVE;
			psc_i2s->sicr |= MPC52xx_PSC_SICR_GENCLK;

			clkdiv = ppc_proc_freq / freq;
			err = ppc_proc_freq % freq;
			if (err > freq / 2)
				clkdiv++;

			dev_dbg(psc_i2s->dev, "psc_i2s_set_sysclk(clkdiv %d freq error=%ldHz)\n",
					clkdiv, (ppc_proc_freq / clkdiv - freq));
				
			return mpc52xx_set_psc_clkdiv(psc_i2s->dai.id + 1, clkdiv);
		}
	}

	if (psc_i2s->sysclk) {
		framesync = bits * 2;
		bitclk = (psc_i2s->sysclk) / (params_rate(params) * framesync);
		
		/* bitclk field is byte swapped due to mpc5200/b compatibility */
		value = ((framesync - 1) << 24) |
			(((bitclk - 1) & 0xFF) << 16) | ((bitclk - 1) & 0xFF00);
		
		dev_dbg(psc_i2s->dev, "%s(substream=%p) rate=%i sysclk=%i"
			" framesync=%i bitclk=%i reg=%X\n",
			__FUNCTION__, substream, params_rate(params), psc_i2s->sysclk,
			framesync, bitclk, value);
		
		out_be32(&psc_i2s->psc_regs->ccr, value);
		out_8(&psc_i2s->psc_regs->ctur, bits - 1);
	}

-- 
Jon Smirl
jonsmirl@gmail.com
