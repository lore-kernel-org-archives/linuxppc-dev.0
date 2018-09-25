Return-Path: <narmstrong@baylibre.com>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KCxN3qwwzF1nf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 17:53:27 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id s12-v6so12281156wmc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 00:53:27 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
To: Florian Fainelli <f.fainelli@gmail.com>,
 Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
 Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
 alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org,
 carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org,
 joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
 <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <6af26377-e2b8-3a1c-ca17-4932f636e01d@baylibre.com>
Date: Tue, 25 Sep 2018 09:53:22 +0200
MIME-Version: 1.0
In-Reply-To: <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Florian,

On 24/09/2018 21:17, Florian Fainelli wrote:
> On 09/24/2018 12:04 PM, Corentin Labbe wrote:
>> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
>>
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>> ---
>>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>>  1 file changed, 22 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> index c5979569fd60..abcf65588576 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/stmmac.h>
>> +#include <linux/setbits.h>
>>  
>>  #include "stmmac_platform.h"
>>  
>> @@ -75,18 +76,6 @@ struct meson8b_dwmac_clk_configs {
>>  	struct clk_gate		rgmii_tx_en;
>>  };
>>  
>> -static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
>> -				    u32 mask, u32 value)
>> -{
>> -	u32 data;
>> -
>> -	data = readl(dwmac->regs + reg);
>> -	data &= ~mask;
>> -	data |= (value & mask);
>> -
>> -	writel(data, dwmac->regs + reg);
>> -}
> 
> Why not make mseon8b_dwmac_mask_bits() a wrapper around
> clrsetbits_le32() whose purpose is only to dereference dwmac->regs and
> pass it to clrsetbits_le32()? That would be far less changes to review
> and audit for correctness, same goes with every other patch in this
> series touching the meson drivers.
> 

Personally, I'll prefer dropping my custom writel_bits_relaxed() with something
more future proof (I also use it in spi-meson-spicc and ao-cec),
and I think the same for dwmac-meson8b.c

Neil
