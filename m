Return-Path: <john.stultz@linaro.org>
Subject: Re: [PATCH V12 2/4] ptp: Added a clock that uses the eTSEC found
	on the MPC85xx.
From: John Stultz <john.stultz@linaro.org>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <aa97e94c82ebd8953d83b53f64cbfef66c81b7be.1298878618.git.richard.cochran@omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<aa97e94c82ebd8953d83b53f64cbfef66c81b7be.1298878618.git.richard.cochran@omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Mar 2011 14:30:04 -0700
Message-ID: <1300915804.848.40.camel@work-vm>
Mime-Version: 1.0
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-28 at 08:57 +0100, Richard Cochran wrote:
> The eTSEC includes a PTP clock with quite a few features. This patch adds
> support for the basic clock adjustment functions, plus two external time
> stamps, one alarm, and the PPS callback.

Just a minor question on the locking, but otherwise looks ok.

> --- /dev/null
> +++ b/drivers/net/gianfar_ptp.c
> @@ -0,0 +1,579 @@
[snip]
> +/*
> + * Register access functions
> + */

So what are the locking rules on the functions below? I assume the
etsects->lock needs to be held prior to calling, so that should be made
explicit in a comment.

> +static u64 tmr_cnt_read(struct etsects *etsects)
> +{
> +	u64 ns;
> +	u32 lo, hi;
> +
> +	lo = gfar_read(&etsects->regs->tmr_cnt_l);
> +	hi = gfar_read(&etsects->regs->tmr_cnt_h);
> +	ns = ((u64) hi) << 32;
> +	ns |= lo;
> +	return ns;
> +}
> +
> +static void tmr_cnt_write(struct etsects *etsects, u64 ns)
> +{
> +	u32 hi = ns >> 32;
> +	u32 lo = ns & 0xffffffff;
> +
> +	gfar_write(&etsects->regs->tmr_cnt_l, lo);
> +	gfar_write(&etsects->regs->tmr_cnt_h, hi);
> +}
> +
> +static void set_alarm(struct etsects *etsects)
> +{
> +	u64 ns;
> +	u32 lo, hi;
> +
> +	ns = tmr_cnt_read(etsects) + 1500000000ULL;
> +	ns = div_u64(ns, 1000000000UL) * 1000000000ULL;
> +	ns -= etsects->tclk_period;
> +	hi = ns >> 32;
> +	lo = ns & 0xffffffff;
> +	gfar_write(&etsects->regs->tmr_alarm1_l, lo);
> +	gfar_write(&etsects->regs->tmr_alarm1_h, hi);
> +}
> +
> +static void set_fipers(struct etsects *etsects)
> +{
> +	u32 tmr_ctrl = gfar_read(&etsects->regs->tmr_ctrl);
> +
> +	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl & (~TE));
> +	gfar_write(&etsects->regs->tmr_prsc,   etsects->tmr_prsc);
> +	gfar_write(&etsects->regs->tmr_fiper1, etsects->tmr_fiper1);
> +	gfar_write(&etsects->regs->tmr_fiper2, etsects->tmr_fiper2);
> +	set_alarm(etsects);
> +	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl|TE);
> +}
> +

[snip]

> +static int gianfar_ptp_probe(struct platform_device *dev)
> +{
> +	struct device_node *node = dev->dev.of_node;
> +	struct etsects *etsects;
> +	struct timespec now;
> +	int err = -ENOMEM;
> +	u32 tmr_ctrl;
> +
> +	etsects = kzalloc(sizeof(*etsects), GFP_KERNEL);
> +	if (!etsects)
> +		goto no_memory;
> +
> +	err = -ENODEV;
> +
> +	etsects->caps = ptp_gianfar_caps;
> +	etsects->cksel = DEFAULT_CKSEL;
> +
> +	if (get_of_u32(node, "fsl,tclk-period", &etsects->tclk_period) ||
> +	    get_of_u32(node, "fsl,tmr-prsc", &etsects->tmr_prsc) ||
> +	    get_of_u32(node, "fsl,tmr-add", &etsects->tmr_add) ||
> +	    get_of_u32(node, "fsl,tmr-fiper1", &etsects->tmr_fiper1) ||
> +	    get_of_u32(node, "fsl,tmr-fiper2", &etsects->tmr_fiper2) ||
> +	    get_of_u32(node, "fsl,max-adj", &etsects->caps.max_adj)) {
> +		pr_err("device tree node missing required elements\n");
> +		goto no_node;
> +	}
> +
> +	etsects->irq = platform_get_irq(dev, 0);
> +
> +	if (etsects->irq == NO_IRQ) {
> +		pr_err("irq not in device tree\n");
> +		goto no_node;
> +	}
> +	if (request_irq(etsects->irq, isr, 0, DRIVER, etsects)) {
> +		pr_err("request_irq failed\n");
> +		goto no_node;
> +	}
> +
> +	etsects->rsrc = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!etsects->rsrc) {
> +		pr_err("no resource\n");
> +		goto no_resource;
> +	}
> +	if (request_resource(&ioport_resource, etsects->rsrc)) {
> +		pr_err("resource busy\n");
> +		goto no_resource;
> +	}
> +
> +	spin_lock_init(&etsects->lock);
> +
> +	etsects->regs = ioremap(etsects->rsrc->start,
> +				1 + etsects->rsrc->end - etsects->rsrc->start);
> +	if (!etsects->regs) {
> +		pr_err("ioremap ptp registers failed\n");
> +		goto no_ioremap;
> +	}
> +	getnstimeofday(&now);
> +	ptp_gianfar_settime(&etsects->caps, &now);
> +
> +	tmr_ctrl =
> +	  (etsects->tclk_period & TCLK_PERIOD_MASK) << TCLK_PERIOD_SHIFT |
> +	  (etsects->cksel & CKSEL_MASK) << CKSEL_SHIFT;
> +
> +	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl);
> +	gfar_write(&etsects->regs->tmr_add,    etsects->tmr_add);
> +	gfar_write(&etsects->regs->tmr_prsc,   etsects->tmr_prsc);
> +	gfar_write(&etsects->regs->tmr_fiper1, etsects->tmr_fiper1);
> +	gfar_write(&etsects->regs->tmr_fiper2, etsects->tmr_fiper2);
> +	set_alarm(etsects);
> +	gfar_write(&etsects->regs->tmr_ctrl,   tmr_ctrl|FS|RTPE|TE);

Does any of the above need a lock should an irq land in the middle of
the writes?



thanks
-john
