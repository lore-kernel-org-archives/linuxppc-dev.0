Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427TTf4zD5zF3CJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2018 21:29:10 +1000 (AEST)
To: Corentin Labbe <clabbe@baylibre.com>, kernel-janitors@vger.kernel.org
Cc: Coccinelle <cocci@systeme.lip6.fr>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Alistair Popple <alistair@popple.id.au>, Anatolij Gustschin <agust@denx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Carlo Caione <carlo@caione.org>, Chen-Yu Tsai <wens@csie.org>,
 "David S. Miller" <davem@davemloft.net>,
 Gilles Muller <Gilles.Muller@lip6.fr>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Julia Lawall <julia.lawall@lip6.fr>,
 Kevin Hilman <khilman@baylibre.com>, Kumar Gala <galak@kernel.crashing.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Marek
 <michal.lkml@markovi.net>, Nicolas Palix <nicolas.palix@imag.fr>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Tejun Heo <tj@kernel.org>, Vitaly Bordug <vitb@kernel.crashing.org>
References: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
Subject: Re: [PATCH RFC 3/5] coccinelle: add xxxsetbitsXX converting spatch
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <463dbbdc-7afc-bee8-8da1-bbe70b4aec26@users.sourceforge.net>
Date: Sun, 9 Sep 2018 13:13:25 +0200
MIME-Version: 1.0
In-Reply-To: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

How do you think about to add any more meta-data for this semantic patch script?

* SPDX identifier
* Copyright information
* Confidence level

https://bottest.wiki.kernel.org/coccicheck


> +virtual context

Further variables will be needed if you would like to use corresponding
operation modes (besides “patch”).


> +expression reg;
> +expression set;
> +expression clear;

I propose once more to avoid the repetition of (unnecessary) SmPL code.
This part could be written like the following instead.

+expression clear, set, reg;


If you would increase the usage of SmPL disjunctions, the specification
of duplicate SmPL code could be reduced considerably.

* Would you like to merge SmPL rules based on the distinction between
  the data types “u32” and “u64”?

* Did you identify any optional code in this transformation approach?


> +@@
> +expression base;
> +expression offset;
> +expression value;
> +@@
> +
> +- mtu3_setbits(base, offset, value);
> ++ setbits32(base + offset, value);
> +
> +@@
> +expression base;
> +expression offset;
> +expression mask;
> +@@
> +
> +- mtu3_clrbits(base, offset, mask);
> ++ clrbits32(base + offset, mask);

Another update suggestion:

+@replacement@
+expression base, offset;
+@@
+(
+-mtu3_clrbits
++clrbits32
+|
+-mtu3_setbits
++setbits32
+)(base
+-     ,
++ +
+  offset, ...);


Would you like to try further software fine-tuning out?

Regards,
Markus
