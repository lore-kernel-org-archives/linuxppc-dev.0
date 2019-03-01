Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FCC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:18:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2E320643
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2E320643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449Wlc4sSDzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 12:18:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=ricardo.neri-calderon@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449Wjt57ngzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 12:17:21 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2019 17:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; d="scan'208";a="323065276"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2019 17:17:17 -0800
Date: Thu, 28 Feb 2019 17:17:13 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH v2 09/14] watchdog/hardlockup: Make
 arch_touch_nmi_watchdog() to hpet-based implementation
Message-ID: <20190301011713.GA8058@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20190227161758.GE4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227161758.GE4072@linux.ibm.com>
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
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
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
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 27, 2019 at 08:17:58AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 27, 2019 at 08:05:13AM -0800, Ricardo Neri wrote:
> > CPU architectures that have an NMI watchdog use arch_touch_nmi_watchdog()
> > to briefly ignore the hardlockup detector. If the architecture does not
> > have an NMI watchdog, one can be constructed using a source of non-
> > maskable interrupts. In this case, arch_touch_nmi_watchdog() is common
> > to any underlying hardware resource used to drive the detector and needs
> > to be available to other kernel subsystems if hardware different from perf
> > drives the detector.
> > 
> > There exists perf-based and HPET-based implementations. Make it available
> > to the latter.
> > 
> > For clarity, wrap this function in a separate preprocessor conditional
> > from functions which are truly specific to the perf-based implementation.
> > 
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Andi Kleen <andi.kleen@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Don Zickus <dzickus@redhat.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Babu Moger <babu.moger@oracle.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Colin Ian King <colin.king@canonical.com>
> > Cc: Byungchul Park <byungchul.park@lge.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Christoffer Dall <cdall@linaro.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: x86@kernel.org
> > Cc: sparclinux@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  include/linux/nmi.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > index 5a8b19749769..bf5ebcfdd590 100644
> > --- a/include/linux/nmi.h
> > +++ b/include/linux/nmi.h
> > @@ -94,8 +94,16 @@ static inline void hardlockup_detector_disable(void) {}
> >  # define NMI_WATCHDOG_SYSCTL_PERM	0444
> >  #endif
> > 
> > -#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > +#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF) || \
> > +    defined(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET)
> 
> Why not instead make CONFIG_X86_HARDLOCKUP_DETECTOR_HPET select
> CONFIG_HARDLOCKUP_DETECTOR_PERF?  Keep the arch-specific details
> in the arch-specific files and all that.

Thanks for your feedback, Paul! The HPET implementation does not use
perf. Thus, in my opinion is not correct for the HPET HLD to select
the perf implementation. Patch 8 of this series splits the perf-specific
code and the generic hardlockup detector code. Does this make sense?

Thanks and BR,
Ricardo
