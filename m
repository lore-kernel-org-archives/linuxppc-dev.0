Return-Path: <SRS0=owsf=57=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B4EC2BA2B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 06:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00BA206D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 06:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00BA206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492C375ZNWzDqhT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 16:23:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492BzD0KTBzDr3G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2020 16:19:52 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9EE6768C4E; Wed, 15 Apr 2020 08:19:48 +0200 (CEST)
Date: Wed, 15 Apr 2020 08:19:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
Message-ID: <20200415061948.GB32392@lst.de>
References: <20200414070142.288696-1-hch@lst.de>
 <20200414070142.288696-5-hch@lst.de> <87y2qxih94.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2qxih94.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jeremy Kerr <jk@ozlabs.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 "Eric W . Biederman" <ebiederm@xmission.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 15, 2020 at 01:01:59PM +1000, Michael Ellerman wrote:
> > +	to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags());	\
> > +	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata); \
> > +} while (0)
> 
> This doesn't build on ppc (cell_defconfig):
> 
>   ../fs/binfmt_elf.c: In function 'fill_note_info':
>   ../fs/compat_binfmt_elf.c:44:39: error: implicit declaration of function 'compat_siginfo_flags'; did you mean 'to_compat_siginfo'? [-Werror=implicit-function-d
>   eclaration]
>     to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags()); \
>                                          ^~~~~~~~~~~~~~~~~~~~
>   ../fs/binfmt_elf.c:1846:2: note: in expansion of macro 'fill_siginfo_note'
>     fill_siginfo_note(&info->signote, &info->csigdata, siginfo);
>     ^~~~~~~~~~~~~~~~~
>   cc1: some warnings being treated as errors
>   make[2]: *** [../scripts/Makefile.build:266: fs/compat_binfmt_elf.o] Error 1
> 
> 
> I guess the empty version from kernel/signal.c needs to move into a
> header somewhere.

Yes, it should.  Odd that the buildbut hasn't complained yet so far..
