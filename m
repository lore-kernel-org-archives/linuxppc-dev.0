Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E0BC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:12:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D522081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D522081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DWP14Q4szDqsX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 18:12:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DWLk23swzDqsD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 18:10:50 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Dec 2018 23:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
 d="gz'50?scan'50,208,50";a="99735331"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 10 Dec 2018 23:10:44 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gWcBn-000E5Y-TA; Tue, 11 Dec 2018 15:10:43 +0800
Date: Tue, 11 Dec 2018 15:09:39 +0800
From: kbuild test robot <lkp@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix bogus usage of MSR_RI on BookE and 40x
Message-ID: <201812111548.RRtYMhOT%fengguang.wu@intel.com>
References: <61ad3646674e6bf541a8f7fb420cdf556d0b2152.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <61ad3646674e6bf541a8f7fb420cdf556d0b2152.camel@kernel.crashing.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Benjamin,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.20-rc6 next-20181210]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Herrenschmidt/powerpc-Fix-bogus-usage-of-MSR_RI-on-BookE-and-40x/20181211-110017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-ppa8548_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
>> arch/powerpc/sysdev/fsl_rio.c:115:17: error: 'MSR_RI' undeclared (first use in this function); did you mean 'MSR_BE'?
       regs->msr |= MSR_RI;
                    ^~~~~~
                    MSR_BE
   arch/powerpc/sysdev/fsl_rio.c:115:17: note: each undeclared identifier is reported only once for each function it appears in

vim +115 arch/powerpc/sysdev/fsl_rio.c

a52c8f52 Alexandre Bounine 2010-05-26   96  
ff33f182 Li Yang           2010-06-18   97  #ifdef CONFIG_E500
cce1f106 Shaohui Xie       2010-11-18   98  int fsl_rio_mcheck_exception(struct pt_regs *regs)
a52c8f52 Alexandre Bounine 2010-05-26   99  {
82a9a480 Scott Wood        2011-06-16  100  	const struct exception_table_entry *entry;
82a9a480 Scott Wood        2011-06-16  101  	unsigned long reason;
82a9a480 Scott Wood        2011-06-16  102  
82a9a480 Scott Wood        2011-06-16  103  	if (!rio_regs_win)
82a9a480 Scott Wood        2011-06-16  104  		return 0;
a52c8f52 Alexandre Bounine 2010-05-26  105  
a52c8f52 Alexandre Bounine 2010-05-26  106  	reason = in_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR));
a52c8f52 Alexandre Bounine 2010-05-26  107  	if (reason & (RIO_LTLEDCSR_IER | RIO_LTLEDCSR_PRT)) {
a52c8f52 Alexandre Bounine 2010-05-26  108  		/* Check if we are prepared to handle this fault */
a52c8f52 Alexandre Bounine 2010-05-26  109  		entry = search_exception_tables(regs->nip);
a52c8f52 Alexandre Bounine 2010-05-26  110  		if (entry) {
a52c8f52 Alexandre Bounine 2010-05-26  111  			pr_debug("RIO: %s - MC Exception handled\n",
a52c8f52 Alexandre Bounine 2010-05-26  112  				 __func__);
a52c8f52 Alexandre Bounine 2010-05-26  113  			out_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR),
a52c8f52 Alexandre Bounine 2010-05-26  114  				 0);
a52c8f52 Alexandre Bounine 2010-05-26 @115  			regs->msr |= MSR_RI;
61a92f70 Nicholas Piggin   2016-10-14  116  			regs->nip = extable_fixup(entry);
a52c8f52 Alexandre Bounine 2010-05-26  117  			return 1;
a52c8f52 Alexandre Bounine 2010-05-26  118  		}
a52c8f52 Alexandre Bounine 2010-05-26  119  	}
a52c8f52 Alexandre Bounine 2010-05-26  120  
cce1f106 Shaohui Xie       2010-11-18  121  	return 0;
a52c8f52 Alexandre Bounine 2010-05-26  122  }
cce1f106 Shaohui Xie       2010-11-18  123  EXPORT_SYMBOL_GPL(fsl_rio_mcheck_exception);
ff33f182 Li Yang           2010-06-18  124  #endif
a52c8f52 Alexandre Bounine 2010-05-26  125  

:::::: The code at line 115 was first introduced by commit
:::::: a52c8f521fed43bce53451d7dfddf2b42a2af689 rapidio, powerpc/85xx: Add MChk handler for SRIO port

:::::: TO: Alexandre Bounine <alexandre.bounine@idt.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Uj1QPWeK+R9DiBswiM4AAA==

--J2SCkAp4GZ/dPZZf--
