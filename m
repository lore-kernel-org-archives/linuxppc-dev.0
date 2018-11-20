Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE786C04EBC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:34:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F67C206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F67C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zmrw0WP4zF3Ln
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 00:34:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42zmpJ5X7pzF3Wr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:32:06 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF1FEBD;
 Tue, 20 Nov 2018 05:32:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25EE83F5A0;
 Tue, 20 Nov 2018 05:32:04 -0800 (PST)
Date: Tue, 20 Nov 2018 13:32:02 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
Message-ID: <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnv00yuf.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
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
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, "paulus@samba.org" <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
> Andrew Murray <andrew.murray@arm.com> writes:
> 
> > Update design.txt to reflect the presence of the exclude_host
> > and exclude_guest perf flags.
> >
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  tools/perf/design.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> > index a28dca2..7de7d83 100644
> > --- a/tools/perf/design.txt
> > +++ b/tools/perf/design.txt
> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
> >  way to request that counting of events be restricted to times when the
> >  CPU is in user, kernel and/or hypervisor mode.
> >  
> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> > +to request counting of events restricted to guest and host contexts when
> > +using virtualisation.
> 
> How does exclude_host differ from exclude_hv ?

I believe exclude_host / exclude_guest are intented to distinguish
between host and guest in the hosted hypervisor context (KVM).
Whereas exclude_hv allows to distinguish between guest and
hypervisor in the bare-metal type hypervisors.

In the case of arm64 - if VHE extensions are present then the host
kernel will run at a higher privilege to the guest kernel, in which
case there is no distinction between hypervisor and host so we ignore
exclude_hv. But where VHE extensions are not present then the host
kernel runs at the same privilege level as the guest and we use a
higher privilege level to switch between them - in this case we can
use exclude_hv to discount that hypervisor role of switching between
guests.

Thanks,

Andrew Murray

> 
> cheers
