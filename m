Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 869801A01BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 03:51:14 +1000 (EST)
Message-ID: <53CEA483.6090704@wwwdotorg.org>
Date: Tue, 22 Jul 2014 11:50:59 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v4 6/6] clk: Add floor and ceiling constraints to clock
 rates
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>,
 Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>,
 =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>,
 Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kevin Hilman <khilman@deeprootsystems.com>,
 linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com,
 Viresh Kumar <viresh.linux@gmail.com>, David Brown <davidb@codeaurora.org>,
 Anatolij Gustschin <agust@denx.de>, Dinh Nguyen <dinguyen@altera.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm@vger.kernel.org, spear-devel@list.st.com,
 Barry Song <baohua@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>,
 Paul Walmsley <paul@pwsan.com>, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 rabin@rab.in, Bryan Huntsman <bryanh@codeaurora.org>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>,
 =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, linux-media@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2014 08:13 AM, Tomeu Vizoso wrote:
> Adds a way for clock consumers to set maximum and minimum rates. This can be
> used for thermal drivers to set ceiling rates, or by misc. drivers to set
> floor rates to assure a minimum performance level.

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c

> +struct rate_constraint {
> +	struct hlist_node	node;
> +	const char		*dev_id;
> +	const char		*con_id;
> +	enum constraint_type	type;
> +	unsigned long		rate;
> +};

I would personally still prefer either:

a) The struct rate_constraints be stored in struct clk rather than
struct clk_core, so they're stored in the container that "set" the
constraints. This would mean iterating over a struct clk_core's
associated struct clks, then iterating over the struct rate_constraints
within each struct clk.

or:

b) struct rate_constraint to contain a pointer to the struct clk that
created the constraint, rather than copying the dev_id/con_id from that
struct clk into the struct rate_constraint.

With either of those changes, the constraints are directly associated
with the clock client object that created the constraint much better
than right now, where the matching is only because the struct clk and
struct rate_constraint "happen to" have the same dev_id/con_id values.

Still, this is a pretty minor issue, and overall this series looks
reasonable to me at a quick look.
