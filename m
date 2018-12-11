Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A92C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:09:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2585120811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2585120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DcdQ1t5szDr1R
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:08:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dcb32W4DzDr0T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 22:06:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Dcb21q6Qz9s3Z;
 Tue, 11 Dec 2018 22:06:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
In-Reply-To: <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
 <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
Date: Tue, 11 Dec 2018 22:06:53 +1100
Message-ID: <87bm5sxqya.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

[ Reviving old thread. ]

Andrew Murray <andrew.murray@arm.com> writes:
> On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
>> Andrew Murray <andrew.murray@arm.com> writes:
>> 
>> > Update design.txt to reflect the presence of the exclude_host
>> > and exclude_guest perf flags.
>> >
>> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> > ---
>> >  tools/perf/design.txt | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
>> > index a28dca2..7de7d83 100644
>> > --- a/tools/perf/design.txt
>> > +++ b/tools/perf/design.txt
>> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
>> >  way to request that counting of events be restricted to times when the
>> >  CPU is in user, kernel and/or hypervisor mode.
>> >  
>> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
>> > +to request counting of events restricted to guest and host contexts when
>> > +using virtualisation.
>> 
>> How does exclude_host differ from exclude_hv ?
>
> I believe exclude_host / exclude_guest are intented to distinguish
> between host and guest in the hosted hypervisor context (KVM).

OK yeah, from the perf-list man page:

           u - user-space counting
           k - kernel counting
           h - hypervisor counting
           I - non idle counting
           G - guest counting (in KVM guests)
           H - host counting (not in KVM guests)

> Whereas exclude_hv allows to distinguish between guest and
> hypervisor in the bare-metal type hypervisors.

Except that's exactly not how we use them on powerpc :)

We use exclude_hv to exclude "the hypervisor", regardless of whether
it's KVM or PowerVM (which is a bare-metal hypervisor).

We don't use exclude_host / exclude_guest at all, which I guess is a
bug, except I didn't know they existed until this thread.

eg, in a KVM guest:

  $ perf record -e cycles:G /bin/bash -c "for i in {0..100000}; do :;done"
  $ perf report -D | grep -Fc "dso: [hypervisor]"
  16


> In the case of arm64 - if VHE extensions are present then the host
> kernel will run at a higher privilege to the guest kernel, in which
> case there is no distinction between hypervisor and host so we ignore
> exclude_hv. But where VHE extensions are not present then the host
> kernel runs at the same privilege level as the guest and we use a
> higher privilege level to switch between them - in this case we can
> use exclude_hv to discount that hypervisor role of switching between
> guests.

I couldn't find any arm64 perf code using exclude_host/guest at all?

And I don't see any x86 code using exclude_hv.

But maybe that's OK, I just worry this is confusing for users.

cheers
