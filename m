Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762CAC65BB3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C0221479
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C0221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D4KX5Qv3zDqjJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:53:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=catalin.marinas@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43D4Gf3mlVzDqfb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 00:50:49 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B336E1596;
 Mon, 10 Dec 2018 05:50:47 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 2AE5F3F575; Mon, 10 Dec 2018 05:50:42 -0800 (PST)
Date: Mon, 10 Dec 2018 13:50:39 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [REPOST PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
Message-ID: <20181210135038.GC4048@arrakis.emea.arm.com>
References: <20181205033828.6156-1-dianders@chromium.org>
 <20181207174231.GD11961@arrakis.emea.arm.com>
 <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WO2xMojkEqKCMkufwihUvnow3yEH4GZPh7hh8noNZ+=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mhocko@suse.com, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linux-mips@vger.kernel.org, dalias@libc.org, paulus@samba.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, ying.huang@intel.com, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org, Jason Wessel <jason.wessel@windriver.com>,
 rppt@linux.vnet.ibm.com, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 linux-hexagon@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Doug,

On Fri, Dec 07, 2018 at 10:40:24AM -0800, Doug Anderson wrote:
> On Fri, Dec 7, 2018 at 9:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Dec 04, 2018 at 07:38:24PM -0800, Douglas Anderson wrote:
> > > Douglas Anderson (4):
> > >   kgdb: Remove irq flags from roundup
> > >   kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
> > >   kgdb: Don't round up a CPU that failed rounding up before
> > >   kdb: Don't back trace on a cpu that didn't round up
> >
> > FWIW, trying these on arm64 (ThunderX2) with CONFIG_KGDB_TESTS_ON_BOOT=y
> > on top of 4.20-rc5 doesn't boot. It looks like they leave interrupts
> > disabled when they shouldn't and it trips over the BUG at
> > mm/vmalloc.c:1380 (called via do_fork -> copy_process).
> >
> > Now, I don't think these patches make things worse on arm64 since prior
> > to them the kgdb boot tests on arm64 were stuck in a loop (RUN
> > singlestep).
> 
> Thanks for the report!  ...actually, I'd never tried CONFIG_KGDB_TESTS
> before.  ...so I tried them now:
> 
> A) chromeos-4.19 tree on qcom-sdm845 without this series: booted up OK
> B) chromeos-4.19 tree on qcom-sdm845 with this series: booted up OK
> C) v4.20-rc5-90-g30002dd008ed on rockchip-rk3399 (kevin) with this
> series: booted up OK
> 
> Example output from B) above:
> 
> localhost ~ # dmesg | grep kgdbts
> [    2.139814] KGDB: Registered I/O driver kgdbts
> [    2.144582] kgdbts:RUN plant and detach test
> [    2.165333] kgdbts:RUN sw breakpoint test
> [    2.172990] kgdbts:RUN bad memory access test
> [    2.178640] kgdbts:RUN singlestep test 1000 iterations
> [    2.187765] kgdbts:RUN singlestep [0/1000]
> [    2.559596] kgdbts:RUN singlestep [100/1000]
> [    2.931419] kgdbts:RUN singlestep [200/1000]
> [    3.303474] kgdbts:RUN singlestep [300/1000]
> [    3.675121] kgdbts:RUN singlestep [400/1000]
> [    4.046867] kgdbts:RUN singlestep [500/1000]
> [    4.418920] kgdbts:RUN singlestep [600/1000]
> [    4.790824] kgdbts:RUN singlestep [700/1000]
> [    5.162479] kgdbts:RUN singlestep [800/1000]
> [    5.534103] kgdbts:RUN singlestep [900/1000]
> [    5.902299] kgdbts:RUN do_fork for 100 breakpoints
> [    8.463900] KGDB: Unregistered I/O driver kgdbts, debugger disabled
> 
> ...so I guess I'm a little confused.  Either I have a different config
> than you do or something is special about your machine?

I tried it now on a Juno board both as a host and a guest and boots
fine. It must be something that only triggers ThunderX2. Ignore the
report for now, if I find anything interesting I'll let you know.

-- 
Catalin
