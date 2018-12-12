Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984CDC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C926F20849
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C926F20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FC2K5W5tzDqHJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 20:59:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=christoffer.dall@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43F8Z114KXzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 19:07:45 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DFED80D;
 Wed, 12 Dec 2018 00:07:44 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAE0F3F614;
 Wed, 12 Dec 2018 00:07:43 -0800 (PST)
Date: Wed, 12 Dec 2018 09:07:42 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
Message-ID: <20181212080742.GA30263@e113682-lin.lund.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
 <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
 <87bm5sxqya.fsf@concordia.ellerman.id.au>
 <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Approved-At: Wed, 12 Dec 2018 20:56:40 +1100
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-alpha@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "paulus@samba.org" <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 11, 2018 at 01:59:03PM +0000, Andrew Murray wrote:
> On Tue, Dec 11, 2018 at 10:06:53PM +1100, Michael Ellerman wrote:
> > [ Reviving old thread. ]
> > 
> > Andrew Murray <andrew.murray@arm.com> writes:
> > > On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
> > >> Andrew Murray <andrew.murray@arm.com> writes:
> > >> 
> > >> > Update design.txt to reflect the presence of the exclude_host
> > >> > and exclude_guest perf flags.
> > >> >
> > >> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > >> > ---
> > >> >  tools/perf/design.txt | 4 ++++
> > >> >  1 file changed, 4 insertions(+)
> > >> >
> > >> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> > >> > index a28dca2..7de7d83 100644
> > >> > --- a/tools/perf/design.txt
> > >> > +++ b/tools/perf/design.txt
> > >> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
> > >> >  way to request that counting of events be restricted to times when the
> > >> >  CPU is in user, kernel and/or hypervisor mode.
> > >> >  
> > >> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> > >> > +to request counting of events restricted to guest and host contexts when
> > >> > +using virtualisation.
> > >> 
> > >> How does exclude_host differ from exclude_hv ?
> > >
> > > I believe exclude_host / exclude_guest are intented to distinguish
> > > between host and guest in the hosted hypervisor context (KVM).
> > 
> > OK yeah, from the perf-list man page:
> > 
> >            u - user-space counting
> >            k - kernel counting
> >            h - hypervisor counting
> >            I - non idle counting
> >            G - guest counting (in KVM guests)
> >            H - host counting (not in KVM guests)
> > 
> > > Whereas exclude_hv allows to distinguish between guest and
> > > hypervisor in the bare-metal type hypervisors.
> > 
> > Except that's exactly not how we use them on powerpc :)
> > 
> > We use exclude_hv to exclude "the hypervisor", regardless of whether
> > it's KVM or PowerVM (which is a bare-metal hypervisor).
> > 
> > We don't use exclude_host / exclude_guest at all, which I guess is a
> > bug, except I didn't know they existed until this thread.
> > 
> > eg, in a KVM guest:
> > 
> >   $ perf record -e cycles:G /bin/bash -c "for i in {0..100000}; do :;done"
> >   $ perf report -D | grep -Fc "dso: [hypervisor]"
> >   16
> > 
> > 
> > > In the case of arm64 - if VHE extensions are present then the host
> > > kernel will run at a higher privilege to the guest kernel, in which
> > > case there is no distinction between hypervisor and host so we ignore
> > > exclude_hv. But where VHE extensions are not present then the host
> > > kernel runs at the same privilege level as the guest and we use a
> > > higher privilege level to switch between them - in this case we can
> > > use exclude_hv to discount that hypervisor role of switching between
> > > guests.
> > 
> > I couldn't find any arm64 perf code using exclude_host/guest at all?
> 
> Correct - but this is in flight as I am currently adding support for this
> see [1].
> 
> > 
> > And I don't see any x86 code using exclude_hv.
> 
> I can't find any either.
> 
> > 
> > But maybe that's OK, I just worry this is confusing for users.
> 
> There is some extra context regarding this where exclude_guest/exclude_host
> was added, see [2] and where exclude_hv was added, see [3]
> 
> Generally it seems that exclude_guest/exclude_host relies upon switching
> counters off/on on guest/host switch code (which works well in the nested
> virt case). Whereas exclude_hv tends to rely solely on hardware capability
> based on privilege level (which works well in the bare metal case where
> the guest doesn't run at same privilege as the host).
> 
> I think from the user perspective exclude_hv allows you to see your overhead
> if you are a guest (i.e. work done by bare metal hypervisor associated with
> you as the guest). Whereas exclude_guest/exclude_host doesn't allow you to
> see events above you (i.e. the kernel hypervisor) if you are the guest...
> 
> At least that's how I read this, I've copied in others that may provide
> more authoritative feedback.
> 
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-December/033698.html
> [2] https://www.spinics.net/lists/kvm/msg53996.html
> [3] https://lore.kernel.org/patchwork/patch/143918/
> 

I'll try to answer this in a different way, based on previous
discussions with Joerg et al. who introduced these flags.  Assume no
support for nested virtualization as a first approximation:

  If you are running as a guest:
    - exclude_hv: stop counting events when the hypervisor runs
    - exclude_host: has no effect
    - exclude_guest: has no effect
  
  If you are running as a host/hypervisor:
   - exclude_hv: has no effect
   - exclude_host: only count events when the guest is running
   - exclude_guest: only count events when the host is running

With nested virtualization, you get the natural union of the above.

**This has nothing to do with the design of the hypervisor such as the
ARM non-VHE KVM which splits its execution across EL1 and EL2 -- those
are both considered host from the point of view of Linux as a hypervisor
using KVM, and both considered hypervisor from the point of view of a
guest.**


Thanks,

    Christoffer
