Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4201MT0m2YzDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 17:57:56 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id h138-v6so396332qke.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 00:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-51-robh@kernel.org>
In-Reply-To: <20180828015252.28511-51-robh@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 Aug 2018 10:57:43 +0300
Message-ID: <CAHp75Vd2B47bMHOuDtFcRUbbMXekgxsG+WP5kj-E1Z_K09=C4w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Convert to using %pOFn instead of device_node.name
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, timur@kernel.org,
 nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Carlo Caione <carlo@caione.org>,
 Kevin Hilman <khilman@baylibre.com>, olivier.moysan@st.com,
 arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2018 at 4:57 AM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

> +       snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
> +                (unsigned long long) res.start, dma_channel_np);

I understand that is not the part of the change, but wouldn't be good
to replace that ugly casting with proper specifier as well?
I mean
%pa ... &res.start

> +                       dev_err(&pdev->dev, "%pOFn sync own reference\n",
> +                               np);

One line?

-- 
With Best Regards,
Andy Shevchenko
