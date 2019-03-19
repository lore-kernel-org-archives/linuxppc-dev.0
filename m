Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB7C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 01:19:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A8E2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 01:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A8E2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NZw66qYVzDqLW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 12:19:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NZtN73NTzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 12:18:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44NZtN1SDSz9s71;
 Tue, 19 Mar 2019 12:18:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Walker <danielwa@cisco.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PULL REQUEST] powerpc generic command line
In-Reply-To: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
Date: Tue, 19 Mar 2019 12:18:03 +1100
Message-ID: <878sxb7jck.fsf@concordia.ellerman.id.au>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

Daniel Walker <danielwa@cisco.com> writes:
> Here are the generic command line changes for powerpc. 
>
> These changes have been in linux-next for two cycles, with few problems reported.
> It's also been used at Cisco Systems, Inc. in production products for many many
> years with no problems.
>
> Please pull these changes.

Sorry I didn't reply to this earlier, have been busy with merge window
bugs and so on.

As I imagine you noticed, I didn't pull this. There are a few reasons.

Firstly you sent it a bit late, about a day before the 5.0 release, and
at 6am Saturday my time :) In future if you want me to merge something
please send a pull at least the ~Wednesday before the release.
 
Secondly I had no idea this code was even in linux-next. I'm not sure if
I was Cc'ed at some point when you added it, if so sorry I missed it,
but I get lots of email. If you're going to add changes to arch/powerpc
in your next tree I'd appreciate some notice, or preferably an explicit
ack.

The main reason I didn't merge it is that it's adding a bunch of code
outside of arch/powerpc, into files which I'm not the maintainer for,
and the patches doing so have no acks or reviews from anyone.

It's also adding a generic implementation with no indication that any
other arches are willing/able to use the generic implementation, which
begs the question whether it will actually used.

I appreciate it's hard to get these sort of cross architecture changes
into mainline, but I don't think this is the way to do it.

I'd suggest you post a patch series to linux-arch with the generic
changes and as many architecture conversions as you can manage, then get
some review/acks for the generic changes and chase arch maintainers for
some acks.

I realise you have posted the series before, it may require some
persistence. There were also quite a few comments from Christophe, so
replying to those would be a good place to start.

> The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
>
>   Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
>
> are available in the git repository at:
>
>   https://github.com/daniel-walker/cisco-linux.git for-powerpc
>
> for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:
>
>   powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)
>
> ----------------------------------------------------------------
> Daniel Walker (3):
>       add generic builtin command line
>       powerpc: convert to generic builtin command line
>       powerpc: convert config files to generic cmdline
>
>  arch/powerpc/Kconfig                          | 23 +--------
>  arch/powerpc/configs/44x/fsp2_defconfig       | 29 ++++++-----
>  arch/powerpc/configs/44x/iss476-smp_defconfig | 24 ++++-----
>  arch/powerpc/configs/44x/warp_defconfig       | 12 ++---
>  arch/powerpc/configs/holly_defconfig          | 12 ++---
>  arch/powerpc/configs/mvme5100_defconfig       | 25 +++++-----
>  arch/powerpc/configs/skiroot_defconfig        | 48 +++++++++---------
>  arch/powerpc/configs/storcenter_defconfig     | 15 +++---

Also if you're updating defconfigs please don't include any unrelated
changes. Trimming the defconfigs can silently drop symbols and break
people's setups so needs to be done carefully.

It's safer to just sed the defconfig files directly, rather than running
savedefconfig on them.

cheers

>  arch/powerpc/kernel/prom.c                    |  4 ++
>  arch/powerpc/kernel/prom_init.c               |  8 +--
>  arch/powerpc/kernel/prom_init_check.sh        |  2 +-
>  include/linux/cmdline.h                       | 72 +++++++++++++++++++++++++++
>  init/Kconfig                                  | 69 +++++++++++++++++++++++++
>  13 files changed, 231 insertions(+), 112 deletions(-)
>  create mode 100644 include/linux/cmdline.h
