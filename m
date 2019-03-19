Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52680C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 15:47:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014CC20854
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 15:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="RqG/mpSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014CC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ny9k2gHSzDqD3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 02:47:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.142.92; helo=alln-iport-5.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="RqG/mpSY"; 
 dkim-atps=neutral
X-Greylist: delayed 430 seconds by postgrey-1.36 at bilbo;
 Wed, 20 Mar 2019 02:45:59 AEDT
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ny7q70gGzDqD3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:45:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=5151; q=dns/txt; s=iport;
 t=1553010360; x=1554219960;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ualcYx1fUp04g4KteUthNHAzkK28jXy8eukTQKIHMCU=;
 b=RqG/mpSYpChwgch9OJ7kt0xlbccufrhfH6ao5ZxlCPD3Eitwoo3OW+Kk
 BO8irif5kzgJ8xB3nlZQgqhtDyDr0kDYC4wljh1Ssq2BCn2Ee+ii/hG/p
 wooi9oUQjgJIQB5Kw0pIu04DmWFNkP0UTQkr+xnZf6MmqDx6nvYGCUDAS M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAAAhDJFc/4oNJK1jGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBgWEFKmhQMyeMJ4sqgg2OP4lzFIFnCwE?=
 =?us-ascii?q?BI4RJAoRrIjQJDQEBAwEBCQEDAm0cDIVKAQEBAwE6PwULCw4EBgklDy0NDgY?=
 =?us-ascii?q?TgyOBbQgPqRCCMIoyBSKBDQGLMReBQD+EI4EoGQGBXAKBLgESAYYAA4ouIId?=
 =?us-ascii?q?Okk0JgkuFEodOg3UlDIFwKYVJi3CRB40IAgQGBQIVb1g4ZXEzGggbFYMngiK?=
 =?us-ascii?q?BCwEMgj6Kcx8DMI0jgj4BAQ?=
X-IronPort-AV: E=Sophos;i="5.58,498,1544486400"; d="scan'208";a="247194103"
Received: from alln-core-5.cisco.com ([173.36.13.138])
 by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 19 Mar 2019 15:38:43 +0000
Received: from zorba ([10.41.50.85])
 by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id x2JFcfl5029540
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 19 Mar 2019 15:38:42 GMT
Date: Tue, 19 Mar 2019 08:38:42 -0700
From: Daniel Walker <danielwa@cisco.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PULL REQUEST] powerpc generic command line
Message-ID: <20190319153842.vgrm5dc7wwc4u44l@zorba>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
 <878sxb7jck.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sxb7jck.fsf@concordia.ellerman.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Outbound-SMTP-Client: 10.41.50.85, [10.41.50.85]
X-Outbound-Node: alln-core-5.cisco.com
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
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 19, 2019 at 12:18:03PM +1100, Michael Ellerman wrote:
> Hi Daniel,
> 
> Daniel Walker <danielwa@cisco.com> writes:
> > Here are the generic command line changes for powerpc. 
> >
> > These changes have been in linux-next for two cycles, with few problems reported.
> > It's also been used at Cisco Systems, Inc. in production products for many many
> > years with no problems.
> >
> > Please pull these changes.
> 
> Sorry I didn't reply to this earlier, have been busy with merge window
> bugs and so on.
> 
> As I imagine you noticed, I didn't pull this. There are a few reasons.
> 
> Firstly you sent it a bit late, about a day before the 5.0 release, and
> at 6am Saturday my time :) In future if you want me to merge something
> please send a pull at least the ~Wednesday before the release.
  
Ok .. It was Friday morning my time.

> Secondly I had no idea this code was even in linux-next. I'm not sure if
> I was Cc'ed at some point when you added it, if so sorry I missed it,
> but I get lots of email. If you're going to add changes to arch/powerpc
> in your next tree I'd appreciate some notice, or preferably an explicit
> ack.
 
Can I have an ack now ? Since your looking at it. Do you think this has no use,
certainly Cisco has use for it. It's still in linux-next as of now.

> The main reason I didn't merge it is that it's adding a bunch of code
> outside of arch/powerpc, into files which I'm not the maintainer for,
> and the patches doing so have no acks or reviews from anyone.

With the exception of the Kconfig the header file is brand new, so I'm not sure
who would ack that. From a maintainer perspective I think you could add new
files without issues from other maintainers.

> It's also adding a generic implementation with no indication that any
> other arches are willing/able to use the generic implementation, which
> begs the question whether it will actually used.
 
It would have been used by powerpc ;) I've gotten feedback in the past from
Ralf Baechle who thought this was useful, however that was years ago when
this was first submitted and the code around this area in mips has changed and
it would require a fair amount of new work to function properly on mips.

Also , no other platforms need to use this. Powerpc could be the only user of
it. This isn't really a question of a new exciting implementation of
something. This is really simple, it's just consolidation across architectures.
The implementation is vanilla, non-exciting stuff.

> I appreciate it's hard to get these sort of cross architecture changes
> into mainline, but I don't think this is the way to do it.
> 
> I'd suggest you post a patch series to linux-arch with the generic
> changes and as many architecture conversions as you can manage, then get
> some review/acks for the generic changes and chase arch maintainers for
> some acks.
 
I didn't post to linux-arch , but the code has been around for years, submitted
multiple times with more architectures than powerpc. It was scaled down to just
powerpc to simplify it's submission.

It's really a simple set of changes, I don't think it needs as much thought as
other cross architecture changes.

> I realise you have posted the series before, it may require some
> persistence. There were also quite a few comments from Christophe, so
> replying to those would be a good place to start.
 
I've looked at his comments, but I think he was more worried about conflicts with
his debugging enablement, not something to stop a pull request.

> > The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
> >
> >   Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
> >
> > are available in the git repository at:
> >
> >   https://github.com/daniel-walker/cisco-linux.git for-powerpc
> >
> > for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:
> >
> >   powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)
> >
> > ----------------------------------------------------------------
> > Daniel Walker (3):
> >       add generic builtin command line
> >       powerpc: convert to generic builtin command line
> >       powerpc: convert config files to generic cmdline
> >
> >  arch/powerpc/Kconfig                          | 23 +--------
> >  arch/powerpc/configs/44x/fsp2_defconfig       | 29 ++++++-----
> >  arch/powerpc/configs/44x/iss476-smp_defconfig | 24 ++++-----
> >  arch/powerpc/configs/44x/warp_defconfig       | 12 ++---
> >  arch/powerpc/configs/holly_defconfig          | 12 ++---
> >  arch/powerpc/configs/mvme5100_defconfig       | 25 +++++-----
> >  arch/powerpc/configs/skiroot_defconfig        | 48 +++++++++---------
> >  arch/powerpc/configs/storcenter_defconfig     | 15 +++---
> 
> Also if you're updating defconfigs please don't include any unrelated
> changes. Trimming the defconfigs can silently drop symbols and break
> people's setups so needs to be done carefully.
 
> It's safer to just sed the defconfig files directly, rather than running
> savedefconfig on them.
 
Ok.

Daniel
