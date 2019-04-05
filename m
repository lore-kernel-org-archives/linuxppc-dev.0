Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C5C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 16:05:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFD7204EC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 16:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFD7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bPmf1M3mzDqSq
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 03:05:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bPkp1SwxzDqSV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 03:04:02 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38D03307E061;
 Fri,  5 Apr 2019 16:04:00 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24E665D9E1;
 Fri,  5 Apr 2019 16:03:54 +0000 (UTC)
Date: Fri, 5 Apr 2019 11:03:51 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC 5/5] arm64/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405160351.5l4wbmool5m4rkua@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
 <20190405144414.GB7662@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405144414.GB7662@fuggles.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 05 Apr 2019 16:04:00 +0000 (UTC)
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 05, 2019 at 03:44:14PM +0100, Will Deacon wrote:
> Hi Josh,
> 
> On Thu, Apr 04, 2019 at 11:44:15AM -0500, Josh Poimboeuf wrote:
> > Configure arm64 runtime CPU speculation bug mitigations in accordance
> > with the 'cpu_spec_mitigations=' cmdline options.  This affects
> > Meltdown and Speculative Store Bypass.
> > 
> > The default behavior is unchanged.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 2 ++
> >  arch/arm64/kernel/cpu_errata.c                  | 4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 6 ++++++
> >  3 files changed, 12 insertions(+)
> 
> Just wanted to make you aware that this is probably going to conflict badly
> with some patches we have pending to hook up the sysfs entries:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/640326.html
> 
> That patch series isn't quite there yet, so I'm expecting a v7, but I think
> it will change the shape of this patch quite a lot.

Thanks for the heads up Will.  I will drop the arm64 patch for now then.

-- 
Josh
