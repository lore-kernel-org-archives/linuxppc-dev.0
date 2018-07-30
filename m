Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQ0v12WKzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:25:50 +1000 (AEST)
Date: Mon, 30 Jul 2018 09:25:45 -0700 (PDT)
Message-Id: <20180730.092545.225621578249887012.davem@davemloft.net>
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 richardcochran@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180730100154.27906-3-yangbo.lu@nxp.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Mon, 30 Jul 2018 18:01:54 +0800

> +static unsigned int cksel = DEFAULT_CKSEL;
> +module_param(cksel, uint, 0644);
> +MODULE_PARM_DESC(cksel, "Select reference clock");
> +
> +static unsigned int clk_src;
> +module_param(clk_src, uint, 0644);
> +MODULE_PARM_DESC(clk_src, "Reference clock frequency (if clocks property not provided in dts)");
> +
> +static unsigned int tmr_prsc = 2;
> +module_param(tmr_prsc, uint, 0644);
> +MODULE_PARM_DESC(tmr_prsc, "Output clock division/prescale factor");
> +
> +static unsigned int tmr_fiper1 = 1000000000;
> +module_param(tmr_fiper1, uint, 0644);
> +MODULE_PARM_DESC(tmr_fiper1, "Desired fixed interval pulse period (ns)");
> +
> +static unsigned int tmr_fiper2 = 100000;
> +module_param(tmr_fiper2, uint, 0644);
> +MODULE_PARM_DESC(tmr_fiper2, "Desired fixed interval pulse period (ns)");

Sorry, there is no way I am every applying something like this.  Module
parameters are to be avoided at all costs.

And you don't need it here, you have DTS, please use it.

You are required to support the existing DTS cases, in order to
avoid breaking things, anyways.
