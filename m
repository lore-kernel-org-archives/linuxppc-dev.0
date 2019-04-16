Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB6C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 04:08:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87342075B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 04:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87342075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jsKY0ldnzDqGg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 14:08:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jsHk2QTVzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 14:06:19 +1000 (AEST)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Apr 2019 21:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; d="scan'208";a="223881150"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 15 Apr 2019 21:06:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1hGFMJ-000Ae1-4V; Tue, 16 Apr 2019 12:06:11 +0800
Date: Tue, 16 Apr 2019 12:05:48 +0800
From: kbuild test robot <lkp@intel.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH RFT V2 1/8] clk: divider: add explicit big endian support
Message-ID: <201904161252.kWbdH4TW%lkp@intel.com>
References: <20190415101046.5872-2-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415101046.5872-2-jonas.gorski@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
 Stephen Boyd <sboyd@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Michael Turquette <mturquette@baylibre.com>, Paul Mackerras <paulus@samba.org>,
 kbuild-all@01.org, Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 NXP Linux Team <linux-imx@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jonas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v5.1-rc5 next-20190415]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jonas-Gorski/clk-make-register-endianness-a-run-time-property/20190415-235847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   drivers/clk/clk-divider.c:317:18: sparse: expression using sizeof(void)
   drivers/clk/clk-divider.c:317:18: sparse: expression using sizeof(void)
>> drivers/clk/clk-divider.c:391:44: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct clk_divider *divider @@    got voistruct clk_divider *divider @@
   drivers/clk/clk-divider.c:391:44:    expected struct clk_divider *divider
   drivers/clk/clk-divider.c:391:44:    got void [noderef] <asn:2>*reg
   drivers/clk/clk-divider.c:416:16: sparse: expression using sizeof(void)
   drivers/clk/clk-divider.c:416:16: sparse: expression using sizeof(void)
   drivers/clk/clk-divider.c:441:44: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct clk_divider *divider @@    got voistruct clk_divider *divider @@
   drivers/clk/clk-divider.c:441:44:    expected struct clk_divider *divider
   drivers/clk/clk-divider.c:441:44:    got void [noderef] <asn:2>*reg

vim +391 drivers/clk/clk-divider.c

   289	
   290	static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
   291				       unsigned long rate,
   292				       unsigned long *best_parent_rate,
   293				       const struct clk_div_table *table, u8 width,
   294				       unsigned long flags)
   295	{
   296		int i, bestdiv = 0;
   297		unsigned long parent_rate, best = 0, now, maxdiv;
   298		unsigned long parent_rate_saved = *best_parent_rate;
   299	
   300		if (!rate)
   301			rate = 1;
   302	
   303		maxdiv = _get_maxdiv(table, width, flags);
   304	
   305		if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
   306			parent_rate = *best_parent_rate;
   307			bestdiv = _div_round(table, parent_rate, rate, flags);
   308			bestdiv = bestdiv == 0 ? 1 : bestdiv;
   309			bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
   310			return bestdiv;
   311		}
   312	
   313		/*
   314		 * The maximum divider we can use without overflowing
   315		 * unsigned long in rate * i below
   316		 */
 > 317		maxdiv = min(ULONG_MAX / rate, maxdiv);
   318	
   319		for (i = _next_div(table, 0, flags); i <= maxdiv;
   320						     i = _next_div(table, i, flags)) {
   321			if (rate * i == parent_rate_saved) {
   322				/*
   323				 * It's the most ideal case if the requested rate can be
   324				 * divided from parent clock without needing to change
   325				 * parent rate, so return the divider immediately.
   326				 */
   327				*best_parent_rate = parent_rate_saved;
   328				return i;
   329			}
   330			parent_rate = clk_hw_round_rate(parent, rate * i);
   331			now = DIV_ROUND_UP_ULL((u64)parent_rate, i);
   332			if (_is_best_div(rate, now, best, flags)) {
   333				bestdiv = i;
   334				best = now;
   335				*best_parent_rate = parent_rate;
   336			}
   337		}
   338	
   339		if (!bestdiv) {
   340			bestdiv = _get_maxdiv(table, width, flags);
   341			*best_parent_rate = clk_hw_round_rate(parent, 1);
   342		}
   343	
   344		return bestdiv;
   345	}
   346	
   347	long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
   348				       unsigned long rate, unsigned long *prate,
   349				       const struct clk_div_table *table,
   350				       u8 width, unsigned long flags)
   351	{
   352		int div;
   353	
   354		div = clk_divider_bestdiv(hw, parent, rate, prate, table, width, flags);
   355	
   356		return DIV_ROUND_UP_ULL((u64)*prate, div);
   357	}
   358	EXPORT_SYMBOL_GPL(divider_round_rate_parent);
   359	
   360	long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
   361					  unsigned long rate, unsigned long *prate,
   362					  const struct clk_div_table *table, u8 width,
   363					  unsigned long flags, unsigned int val)
   364	{
   365		int div;
   366	
   367		div = _get_div(table, val, flags, width);
   368	
   369		/* Even a read-only clock can propagate a rate change */
   370		if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
   371			if (!parent)
   372				return -EINVAL;
   373	
   374			*prate = clk_hw_round_rate(parent, rate * div);
   375		}
   376	
   377		return DIV_ROUND_UP_ULL((u64)*prate, div);
   378	}
   379	EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
   380	
   381	
   382	static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
   383					unsigned long *prate)
   384	{
   385		struct clk_divider *divider = to_clk_divider(hw);
   386	
   387		/* if read only, just return current value */
   388		if (divider->flags & CLK_DIVIDER_READ_ONLY) {
   389			u32 val;
   390	
 > 391			val = clk_div_readl(divider->reg) >> divider->shift;
   392			val &= clk_div_mask(divider->width);
   393	
   394			return divider_ro_round_rate(hw, rate, prate, divider->table,
   395						     divider->width, divider->flags,
   396						     val);
   397		}
   398	
   399		return divider_round_rate(hw, rate, prate, divider->table,
   400					  divider->width, divider->flags);
   401	}
   402	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
