Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB0C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE973213F2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE973213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dW0V5x4qzDqKW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 12:08:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=ricardo.neri-calderon@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dVyc5SS3zDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 12:06:28 +1000 (AEST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Apr 2019 19:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; d="scan'208";a="221742090"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga001.jf.intel.com with ESMTP; 08 Apr 2019 19:06:24 -0700
Date: Mon, 8 Apr 2019 19:05:16 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 08/14] watchdog/hardlockup: Decouple the
 hardlockup detector from perf
Message-ID: <20190409020516.GA7165@ranerica-svr.sc.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-9-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <alpine.DEB.2.21.1903262213470.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903262213470.1789@nanos.tec.linutronix.de>
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Ricardo Neri <ricardo.neri@intel.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 x86@kernel.org, Andi Kleen <andi.kleen@intel.com>,
 Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 26, 2019 at 10:18:32PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Ricardo Neri wrote:
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Detect hard lockups on a system
> > + *
> > + * Copyright (C) Intel Corporation 2019
> > + *
> > + * Note: All of this code comes from the original perf-specific hardlockup
> > + * detector.
> 
> And because you copied it from there without modification this becomes
> automatically Copyrighted by Intel?

Yes, it does not look correct.

> 
> May I recommend that you talk to your legal departement about this.
> 
> Aside of that there is really no value in creating yet another file. The
> code in question can simply wrapped into a large #ifdef PERF in the old
> file.

Sure, I'll implement the change in this manner.

Thanks and BR,
Ricardo
