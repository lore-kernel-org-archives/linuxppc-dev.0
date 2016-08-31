Return-Path: <xdrudis@tinet.cat>
Received: from mx2.tinet.org (mx2.tinet.org [195.77.216.147])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sPRZd1lRSzDrfP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:49:29 +1000 (AEST)
Received: from smtp01.tinet.org (smtp01.tinet.org [195.77.216.131]) by
 mx2.tinet.org with ESMTP id 5JuBvbikhChnGoDx for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 15:49:26 +0200 (CEST)
Date: Wed, 31 Aug 2016 15:49:25 +0200
From: Xavi Drudis Ferran <xdrudis@tinet.cat>
To: Fabio Estevam <festevam@gmail.com>
Cc: Xavi Drudis Ferran <xdrudis@tinet.cat>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] Setting some clocks back to DUMMY fixes spdif
 output on imx6q wandboard rev B1
Message-ID: <20160831134925.GB1967@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut> <20160830111414.GA1968@begut>
 <20160831042100.GA3308@Asurada> <20160831091013.GA3185@begut>
 <CAOMZO5AoCo9Faq7oWgRQUE0Hg+Pg+i6z8eg-qeLFDvwpoEqz_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5AoCo9Faq7oWgRQUE0Hg+Pg+i6z8eg-qeLFDvwpoEqz_g@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

El Wed, Aug 31, 2016 at 10:11:13AM -0300, Fabio Estevam deia:
> 2. SPDIF clock rate not accurate. Probably using PLL4 as SPDIF source
> would help to get more accurate SPDIF clock rates.
> 
> Could you please try the untested change?
> 
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -623,7 +623,7 @@ static void __init imx6q_clocks_init(struct
> device_node *ccm_node)
>                 pr_warn("failed to set up CLKO: %d\n", ret);
> 
>         /* Audio-related clocks configuration */
> -       clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL],
> clk[IMX6QDL_CLK_PLL3_PFD3_454M]);
> +       clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL],
> clk[IMX6QDL_CLK_PLL4_AUDIO_DIV]);
> 
>         /* All existing boards with PCIe use LVDS1 */
>         if (IS_ENABLED(CONFIG_PCI_IMX6))
>

I'm going to try. I'll take a while. I'll report the result later.

Thank you very much.
