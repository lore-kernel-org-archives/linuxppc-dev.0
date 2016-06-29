Return-Path: <yuantian.tang@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0089.outbound.protection.outlook.com [157.55.234.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfYyN5p3YzDqpZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:21:48 +1000 (AEST)
From: Yuantian Tang <yuantian.tang@nxp.com>
To: Scott Wood <oss@buserror.net>, Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li
 <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
Date: Wed, 29 Jun 2016 05:50:26 +0000
Message-ID: <DBXPR04MB49546917495DA33834B05D7F0230@DBXPR04MB495.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
In-Reply-To: <1466058085-19353-1-git-send-email-oss@buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch is acked by clock maintainer. If no comments from anyone else, w=
e will merge it in next week.

Thanks,
Yuantian

> -----Original Message-----
> From: Scott Wood [mailto:oss@buserror.net]
> Sent: Thursday, June 16, 2016 2:21 PM
> To: Russell King <linux@armlinux.org.uk>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>;
> Viresh Kumar <viresh.kumar@linaro.org>; Rafael J. Wysocki
> <rjw@rjwysocki.net>
> Cc: linux-clk@vger.kernel.org; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Yuantian Tang <yuantian.tang@nxp.com>; Yang-Leo Li
> <leoyang.li@nxp.com>; Xiaofeng Ren <xiaofeng.ren@nxp.com>; Scott Wood
> <scottwood@freescale.com>
> Subject: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
> parent clocks
>=20
> From: Scott Wood <scottwood@freescale.com>
>=20
> Commit fc4a05d4b0eb ("clk: Remove unused provider APIs") removed
> __clk_get_num_parents() and clk_hw_get_parent_by_index(), leaving only
> true provider API versions that operate on struct clk_hw.
>=20
> qoriq-cpufreq needs these functions in order to determine the options it =
has
> for calling clk_set_parent() and thus populate the cpufreq table, so revi=
ve
> them as legitimate consumer APIs.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: Add missing 'static inline' to stub functions.
>=20
> v3: no changes
>=20
>  drivers/clk/clk.c   | 19 +++++++++++++++++++
>  include/linux/clk.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c index d584004..d61a3fe=
 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -290,6 +290,12 @@ struct clk_hw *__clk_get_hw(struct clk *clk)  }
> EXPORT_SYMBOL_GPL(__clk_get_hw);
>=20
> +unsigned int clk_get_num_parents(struct clk *clk) {
> +	return !clk ? 0 : clk->core->num_parents; }
> +EXPORT_SYMBOL_GPL(clk_get_num_parents);
> +
>  unsigned int clk_hw_get_num_parents(const struct clk_hw *hw)  {
>  	return hw->core->num_parents;
> @@ -358,6 +364,19 @@ static struct clk_core
> *clk_core_get_parent_by_index(struct clk_core *core,
>  	return core->parents[index];
>  }
>=20
> +struct clk *clk_get_parent_by_index(struct clk *clk, unsigned int
> +index) {
> +	struct clk_core *parent;
> +
> +	if (!clk)
> +		return NULL;
> +
> +	parent =3D clk_core_get_parent_by_index(clk->core, index);
> +
> +	return !parent ? NULL : parent->hw->clk; }
> +EXPORT_SYMBOL_GPL(clk_get_parent_by_index);
> +
>  struct clk_hw *
>  clk_hw_get_parent_by_index(const struct clk_hw *hw, unsigned int index)
> { diff --git a/include/linux/clk.h b/include/linux/clk.h index 0df4a51..a=
cd115f
> 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -392,6 +392,26 @@ int clk_set_parent(struct clk *clk, struct clk *pare=
nt);
> struct clk *clk_get_parent(struct clk *clk);
>=20
>  /**
> + * clk_get_parent_by_index - get a possible parent clock by index
> + * @clk: clock source
> + * @index: index into the array of possible parents of this clock
> + *
> + * Returns struct clk corresponding to the requested possible
> + * parent clock source, or NULL.
> + */
> +struct clk *clk_get_parent_by_index(struct clk *clk,
> +				    unsigned int index);
> +
> +/**
> + * clk_get_num_parents - get number of possible parents
> + * @clk: clock source
> + *
> + * Returns the number of possible parents of this clock,
> + * which can then be enumerated using clk_get_parent_by_index().
> + */
> +unsigned int clk_get_num_parents(struct clk *clk);
> +
> +/**
>   * clk_get_sys - get a clock based upon the device name
>   * @dev_id: device name
>   * @con_id: connection ID
> @@ -461,6 +481,17 @@ static inline struct clk *clk_get_parent(struct clk =
*clk)
>  	return NULL;
>  }
>=20
> +static inline struct clk *clk_get_parent_by_index(struct clk *clk,
> +						  unsigned int index)
> +{
> +	return NULL;
> +}
> +
> +static inline unsigned int clk_get_num_parents(struct clk *clk) {
> +	return 0;
> +}
> +
>  #endif
>=20
>  /* clk_prepare_enable helps cases using clk_enable in non-atomic context=
.
> */
> --
> 2.5.0
