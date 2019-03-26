Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B98EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 07:50:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE5120828
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 07:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE5120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T3Fy2ljtzDqLK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 18:50:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T3Cz32gYzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 18:48:40 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Mar 2019 00:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
 d="gz'50?scan'50,208,50";a="332025868"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2019 00:48:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1h8gp1-00008u-NJ; Tue, 26 Mar 2019 15:48:35 +0800
Date: Tue, 26 Mar 2019 15:48:20 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Add force enable of DAWR on P9 option
Message-ID: <201903261547.dYN2kJcV%lkp@intel.com>
References: <20190326054022.5552-1-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190326054022.5552-1-mikey@neuling.org>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org,
 Cameron Kaiser <spectre@floodgap.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v5.1-rc2 next-20190326]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michael-Neuling/powerpc-Add-force-enable-of-DAWR-on-P9-option/20190326-135550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/process.c: In function '__set_breakpoint':
>> arch/powerpc/kernel/process.c:820:6: error: implicit declaration of function 'dawr_enabled'; did you mean 'radix_enabled'? [-Werror=implicit-function-declaration]
     if (dawr_enabled())
         ^~~~~~~~~~~~
         radix_enabled
   cc1: all warnings being treated as errors

vim +820 arch/powerpc/kernel/process.c

   815	
   816	void __set_breakpoint(struct arch_hw_breakpoint *brk)
   817	{
   818		memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
   819	
 > 820		if (dawr_enabled())
   821			// Power8 or later
   822			set_dawr(brk);
   823		else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
   824			// Power7 or earlier
   825			set_dabr(brk);
   826		else
   827			// Shouldn't happen due to higher level checks
   828			WARN_ON_ONCE(1);
   829	}
   830	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--oyUTqETQ0mS9luUI--
