Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 642C71A00FA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 16:14:12 +1000 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kx10so2342192pab.24
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Sep 2014 23:14:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1409758317-20564-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1409758148-20104-2-git-send-email-tomeu.vizoso@collabora.com>
 <1409758317-20564-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20140908061355.19023.47997@quantum>
Subject: Re: [PATCH v9 2/6] clk: Move all drivers to use internal API
Date: Sun, 07 Sep 2014 23:13:55 -0700
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 "Stephen Warren  <swarren@wwwdotorg.org>,
 Thierry Reding  <thierry.reding@gmail.com>, tomasz.figa@gmail.com,
 Peter De Schrijver  <pdeschrijver@nvidia.com>, rabin@rab.in,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jason Cooper  <jason@lakedaemon.net>,  Andrew Lunn  <andrew@lunn.ch>,
 Sebastian Hesselbarth  <sebastian.hesselbarth@gmail.com>,
 Russell King  <linux@arm.linux.org.uk>,
 Shawn Guo  <shawn.guo@freescale.com>,
 Sascha Hauer  <kernel@pengutronix.de>,
 David Brown  <davidb@codeaurora.org>,  Daniel Walker  <dwalker@fifo99.com>,
 Bryan Huntsman  <bryanh@codeaurora.org>,  Paul Walmsley  <paul@pwsan.com>,
 Tony Lindgren  <tony@atomide.com>,
 =?utf-8?q?=22_Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Kevin Hilman" <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Paul Mackerras <paulus@samba.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arch@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Kukjin Kim <kgene.kim@samsung.com>,
 =?utf-8?b?IiBFbWlsaW8gTMOzcGV6?= <emilio@elopez.com.ar>,
 patches@opensource.wolfsonmicro.com, Michal Simek <michal.simek@xilinx.com>,
 Takashi Iwai <tiwai@suse.de>, Santosh Shilimkar <santosh.shilimkar@ti.com>,
 Anatolij Gustschin <agust@denx.de>, Dinh Nguyen <dinguyen@altera.com>,
 linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm@vger.kernel.org, spear-devel@list.st.com,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 Barry Song <baohua@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Viresh Kumar <viresh.linux@gmail.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Tomeu Vizoso (2014-09-03 08:31:57)
> In preparation to change the public API to return a per-user clk structur=
e,
> remove any usage of this public API from the clock implementations.
> =

> The reason for having this in a separate commit from the one that introdu=
ces
> the implementation of the new functions is to separate the changes genera=
ted
> with Coccinelle from the rest, and keep the patches' size reasonable.
> =

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Tested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Hi Tomeu,

Looks like the Coccinelle script had a false-positive.
asm-generic/clkdev.h was converted from clk->clk_core and this blowed up
clock drivers for architectures that don't provide an asm-specific
clkdev.h implementation. This fixes x86's LPSS and a Microblaze driver.

I've rolled the following fix into your 2/9 patch. No action is
necessary.

Regards,
Mike



diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
index 4320225..90a32a6 100644
--- a/include/asm-generic/clkdev.h
+++ b/include/asm-generic/clkdev.h
@@ -15,10 +15,10 @@

 #include <linux/slab.h>

-struct clk_core;
+struct clk;

-static inline int __clk_get(struct clk_core *clk) { return 1; }
-static inline void __clk_put(struct clk_core *clk) { }
+static inline int __clk_get(struct clk *clk) { return 1; }
+static inline void __clk_put(struct clk *clk) { }

 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
