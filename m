Return-Path: <ulf.hansson@linaro.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36B441A0028
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 17:13:19 +1000 (EST)
Received: by mail-la0-f44.google.com with SMTP id hz20so7237870lab.31
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Sep 2014 00:13:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409585574-26673-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1409585377-26091-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409585574-26673-1-git-send-email-tomeu.vizoso@collabora.com>
Date: Tue, 2 Sep 2014 09:13:14 +0200
Message-ID: <CAPDyKFq2vzUT+NSkC8ZTau=sbFW_frpQ+paLM_EsYLyp_5ivag@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] clk: Move all drivers to use internal API
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>,
 Tomasz Figa <t.figa@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>,
 =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>,
 Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kevin Hilman <khilman@deeprootsystems.com>,
 linux-omap <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 patches@opensource.wolfsonmicro.com, Viresh Kumar <viresh.linux@gmail.com>,
 David Brown <davidb@codeaurora.org>, Anatolij Gustschin <agust@denx.de>,
 Dinh Nguyen <dinguyen@altera.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 spear-devel@list.st.com, Barry Song <baohua@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Ben Dooks <ben-linux@fluff.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>,
 Paul Walmsley <paul@pwsan.com>, Peter De Schrijver <pdeschrijver@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rabin@rab.in,
 Bryan Huntsman <bryanh@codeaurora.org>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, linux-media@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1 September 2014 17:32, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> In preparation to change the public API to return a per-user clk structure,
> remove any usage of this public API from the clock implementations.
>
> The reason for having this in a separate commit from the one that introduces
> the implementation of the new functions is to separate the changes generated
> with Coccinelle from the rest, and keep the patches' size reasonable.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Tested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Hi Tomeu,

Huh, what a patch. :-) Great work you are doing here!

By just looking at the ux500 changes, I realize that you now have
removed the dependency to "struct clk", thus we shouldn't include the
header file linux/clk.h in any file located in driver/clk/ux500/*,
right!?

I suppose this comment may also applicable for others than the ux500
clk driver, but haven't checked.

Kind regards
Uffe
