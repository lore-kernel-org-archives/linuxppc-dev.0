Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E26C6786F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 01:53:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078CD20664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 01:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078CD20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lBFp3tCTzF2Dw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 12:53:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lBCk5JkqzDrYb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 12:51:59 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2018 18:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
 d="gz'50?scan'50,208,50";a="92535584"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2018 18:51:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gHffh-000F3L-IV; Wed, 31 Oct 2018 09:51:49 +0800
Date: Wed, 31 Oct 2018 09:51:16 +0800
From: kbuild test robot <lkp@intel.com>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <201810310910.2tQCnmCV%fengguang.wu@intel.com>
References: <20181030221843.121254-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 Jason Wessel <jason.wessel@windriver.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Vineet Gupta <vgupta@synopsys.com>, Douglas Anderson <dianders@chromium.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, kbuild-all@01.org,
 Philippe Ombredanne <pombredanne@nexb.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Douglas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kgdb/kgdb-next]
[also build test WARNING on v4.19 next-20181030]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181031-063733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git kgdb-next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/srcu.h:175: warning: Function parameter or member 'p' not described in 'srcu_dereference_notrace'
   include/linux/srcu.h:175: warning: Function parameter or member 'sp' not described in 'srcu_dereference_notrace'
   include/linux/gfp.h:1: warning: no structured comments found
>> include/linux/kgdb.h:188: warning: Function parameter or member 'ignored' not described in 'kgdb_call_nmi_hook'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4381: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'
   include/net/cfg80211.h:4869: warning: Excess function parameter 'ptr' description in 'reg_query_regdb_wmm'

vim +188 include/linux/kgdb.h

 > 188	
   189	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wac7ysb48OaltWcw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wac7ysb48OaltWcw--
