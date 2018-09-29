Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DC2C43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 04:14:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BC12073F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 04:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BC12073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MZtJ4rpHzF3R3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 14:14:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MZr93GSzzF3Ld
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 14:12:08 +1000 (AEST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Sep 2018 21:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,317,1534834800"; 
 d="gz'50?scan'50,208,50";a="93105877"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2018 21:11:57 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1g66bk-000B52-IO; Sat, 29 Sep 2018 12:11:56 +0800
Date: Sat, 29 Sep 2018 12:11:05 +0800
From: kbuild test robot <lkp@intel.com>
To: Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc/time: Only cap decrementer when watchdog is
 enabled
Message-ID: <201809291259.kKJKngb9%fengguang.wu@intel.com>
References: <20180929012607.10204-2-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20180929012607.10204-2-anton@ozlabs.org>
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
Cc: mikey@neuling.org, npiggin@gmail.com, paulus@samba.org, kbuild-all@01.org,
 oohall@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anton,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.19-rc5 next-20180928]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anton-Blanchard/powerpc-time-Use-clockevents_register_device-fixing-an-issue-with-large-decrementer/20180929-093322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/time.c: In function 'timer_interrupt':
>> arch/powerpc/kernel/time.c:580:44: error: 'watchdog_cpumask' undeclared (first use in this function); did you mean 'proc_watchdog_cpumask'?
         cpumask_test_cpu(smp_processor_id(), &watchdog_cpumask))
                                               ^~~~~~~~~~~~~~~~
                                               proc_watchdog_cpumask
   arch/powerpc/kernel/time.c:580:44: note: each undeclared identifier is reported only once for each function it appears in

vim +580 arch/powerpc/kernel/time.c

   549	
   550	/*
   551	 * timer_interrupt - gets called when the decrementer overflows,
   552	 * with interrupts disabled.
   553	 */
   554	void timer_interrupt(struct pt_regs *regs)
   555	{
   556		struct clock_event_device *evt = this_cpu_ptr(&decrementers);
   557		u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
   558		struct pt_regs *old_regs;
   559		u64 now;
   560	
   561		/* Some implementations of hotplug will get timer interrupts while
   562		 * offline, just ignore these and we also need to set
   563		 * decrementers_next_tb as MAX to make sure __check_irq_replay
   564		 * don't replay timer interrupt when return, otherwise we'll trap
   565		 * here infinitely :(
   566		 */
   567		if (unlikely(!cpu_online(smp_processor_id()))) {
   568			*next_tb = ~(u64)0;
   569			set_dec(decrementer_max);
   570			return;
   571		}
   572	
   573		/* Ensure a positive value is written to the decrementer, or else
   574		 * some CPUs will continue to take decrementer exceptions. When the
   575		 * PPC_WATCHDOG (decrementer based) is configured, keep this at most
   576		 * 31 bits, which is about 4 seconds on most systems, which gives
   577		 * the watchdog a chance of catching timer interrupt hard lockups.
   578		 */
   579		if (IS_ENABLED(CONFIG_PPC_WATCHDOG) &&
 > 580		    cpumask_test_cpu(smp_processor_id(), &watchdog_cpumask))
   581			set_dec(0x7fffffff);
   582		else
   583			set_dec(decrementer_max);
   584	
   585		/* Conditionally hard-enable interrupts now that the DEC has been
   586		 * bumped to its maximum value
   587		 */
   588		may_hard_irq_enable();
   589	
   590	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--qMm9M+Fa2AknHoGS--
