Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B2C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 01:18:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DA720873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 01:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DA720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fjp33blGzDqLn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:18:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=ricardo.neri-calderon@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fjm43x79zDqLn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 11:16:35 +1000 (AEST)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Apr 2019 18:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; d="scan'208";a="160127386"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 18:16:32 -0700
Date: Wed, 10 Apr 2019 18:15:21 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 10/14] kernel/watchdog: Add a function to obtain
 the watchdog_allowed_mask
Message-ID: <20190411011521.GB9936@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20190409113421.GU4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409113421.GU4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>,
 x86@kernel.org, David Rientjes <rientjes@google.com>,
 Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>,
 Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>,
 Byungchul Park <byungchul.park@lge.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Babu Moger <babu.moger@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 09, 2019 at 01:34:21PM +0200, Peter Zijlstra wrote:
> On Wed, Feb 27, 2019 at 08:05:14AM -0800, Ricardo Neri wrote:
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index 8fbfda94a67b..367aa81294ef 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -44,7 +44,7 @@ int __read_mostly soft_watchdog_user_enabled = 1;
> >  int __read_mostly watchdog_thresh = 10;
> >  int __read_mostly nmi_watchdog_available;
> >  
> > -struct cpumask watchdog_allowed_mask __read_mostly;
> > +static struct cpumask watchdog_allowed_mask __read_mostly;
> >  
> >  struct cpumask watchdog_cpumask __read_mostly;
> >  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> 
> Hurmph, more struct cpumask, ideally this would get converted to
> cpumask_var_t, I don't think we need this before the allocators work, do
> we?

I see mm_init() is called before lockup_detector_init(); both from start_kernel().
Thus, IMHO, kzalloc should work at this point.

Thanks and BR,
Ricardo
