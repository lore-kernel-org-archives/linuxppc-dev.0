Return-Path: <linuxppc-dev+bounces-20966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64BBCD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 08:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH1Kp2lM0z2yHT;
	Fri, 15 May 2026 18:57:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778835438;
	cv=none; b=l2EF1zJeujb6IYsOIyaxjF81jAJU+JM9yzV4N7DVqKe0rjGEDmD/wQC8ivk8cSUwGT3pp4Zql7N24/P9qnZsKoCnICI50TrSx/OmA2v9uyeTELYKd2piT1zK5Z9OYRmduFnqIENMicC8WvT26erwxCbvvSaheJG0FNKzOgjR9OAGUL3qBFLj01IlL9xJRp0eu/Dhsl9n94xWH7BUUdzJQna/EzC91/XSASIBGvKtszTsknbiQfpe0TwrSqtbcIzlU5Ji3ZJQgZb5TaiWBfKD32/+r785UHeRLUb4Z4gyYXKDg0O3RB97j8XHIhFR6LTjEdUCA+OoJMbIzHCZrGFmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778835438; c=relaxed/relaxed;
	bh=7sWxarbYzwPZs5t0dd33EUc3E5e85TSbQnZaAs7xPlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtNDo1Nw5QIbOMnWCGlg0EYoQju1Y/Fq1/GRkU/lYIuYvTyNiNcaa0n6eV5yixMohrhIxjMBhkP1Ca45jy6FFA/XKWPtxIpsCjynxEBPKwfvWECuwWzJgS36w4KZdSrZnAXmxEqUZqxPskBFRXLjd3YI5O2heNWGqGIdd/sG/Dls7uLN9wdVrroWp3l1I6tGsnXn/kIKSaMYyUVbw9Ci9HUceGzDssZEDzO7Tttpj64bzOi35VzIUXqH1bfHYtnFESx9c468cEfVKApPJkbBRjY++3elxAMjD49IQhzSX7JCWwgPJwY+ZZPjkOVgzVELHYNm+G613WMgepJhe5Rruw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e7Mwj3IA; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e7Mwj3IA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH1Kk3Q2Rz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 18:57:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778835435; x=1810371435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZAmE1TlWVSf8earAcSnNud/qyU3STr7upmmNnk1CFZs=;
  b=e7Mwj3IARgfUnLso5oDgx59SQvstpCneqxONqaww9NHBplxZiG3Y8eW8
   0zja35nsQOjBG0guvTg4U8eXn0B72RqV2Rlj/53RvTJj0iYW2KEZ0q9SA
   kChJ3pgZK5M0z3Vwj16Xho/hJz+YpqDa6vf0sjobDax9tQ5y8wEwLuRpf
   bmn3710AlNsgS/6JtRztWGXluJN3NAFgAiNJ5+yh7M1q/tfDqzQH+EjU4
   h0XJImIhKPTkG+5CyF1wW0I4sdfSyLjOacEB4I/f+danb8a405MH6HwJb
   CcFjPjG/+gdh1HWiNHXLXpsEUlXNYMaAixxwo704XHr8RBRsoKgDZzIfx
   w==;
X-CSE-ConnectionGUID: jfs9nPTBRj+kCJkNqH4wJQ==
X-CSE-MsgGUID: zXMCNWxUT0C4MWxhoPKldA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91150212"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="91150212"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 20:11:58 -0700
X-CSE-ConnectionGUID: cG7x5w9FRku+pLtuvvhHmA==
X-CSE-MsgGUID: jfwwuftCS1aH47xxQssZLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238446336"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2026 20:11:56 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNiwq-000000000hR-2aAG;
	Fri, 15 May 2026 03:11:04 +0000
Date: Fri, 15 May 2026 11:05:07 +0800
From: kernel test robot <lkp@intel.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch,
	chleroy@kernel.org, qiang.zhao@nxp.com, horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <202605151029.MIApM8zq-lkp@intel.com>
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>

Hi Holger,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on v7.1-rc3 next-20260508]
[cannot apply to net/main linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Holger-Brunck/net-wan-fsl_ucc_hdlc-free-tx_skbuff-in-uhdlc_memclean/20260514-055007
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260504161145.2217950-1-holger.brunck%40hitachienergy.com
patch subject: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260515/202605151029.MIApM8zq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605151029.MIApM8zq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605151029.MIApM8zq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/wan/fsl_ucc_hdlc.c:775:32: error: expected ';' in 'for' statement specifier
     775 |         for (i = 0; i < TX_BD_RING_LEN) {
         |                                       ^
>> drivers/net/wan/fsl_ucc_hdlc.c:775:14: warning: variable 'i' used in loop condition not modified in loop body [-Wfor-loop-analysis]
     775 |         for (i = 0; i < TX_BD_RING_LEN) {
         |                     ^
   1 warning and 1 error generated.


vim +775 drivers/net/wan/fsl_ucc_hdlc.c

   740	
   741	static void uhdlc_memclean(struct ucc_hdlc_private *priv)
   742	{
   743		int i;
   744	
   745		qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
   746		qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
   747	
   748		if (priv->rx_bd_base) {
   749			dma_free_coherent(priv->dev,
   750					  RX_BD_RING_LEN * sizeof(struct qe_bd),
   751					  priv->rx_bd_base, priv->dma_rx_bd);
   752	
   753			priv->rx_bd_base = NULL;
   754			priv->dma_rx_bd = 0;
   755		}
   756	
   757		if (priv->tx_bd_base) {
   758			dma_free_coherent(priv->dev,
   759					  TX_BD_RING_LEN * sizeof(struct qe_bd),
   760					  priv->tx_bd_base, priv->dma_tx_bd);
   761	
   762			priv->tx_bd_base = NULL;
   763			priv->dma_tx_bd = 0;
   764		}
   765	
   766		if (priv->ucc_pram) {
   767			qe_muram_free(priv->ucc_pram_offset);
   768			priv->ucc_pram = NULL;
   769			priv->ucc_pram_offset = 0;
   770		 }
   771	
   772		kfree(priv->rx_skbuff);
   773		priv->rx_skbuff = NULL;
   774	
 > 775		for (i = 0; i < TX_BD_RING_LEN) {
   776			kfree(priv->tx_skbuff[i]);
   777			priv->tx_skbuff[i] = NULL;
   778		}
   779	
   780		kfree(priv->tx_skbuff);
   781		priv->tx_skbuff = NULL;
   782	
   783		if (priv->uccf) {
   784			ucc_fast_free(priv->uccf);
   785			priv->uccf = NULL;
   786		}
   787	
   788		if (priv->rx_buffer) {
   789			dma_free_coherent(priv->dev,
   790					  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
   791					  priv->rx_buffer, priv->dma_rx_addr);
   792			priv->rx_buffer = NULL;
   793			priv->dma_rx_addr = 0;
   794	
   795			priv->tx_buffer = NULL;
   796			priv->dma_tx_addr = 0;
   797	
   798		}
   799	}
   800	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

