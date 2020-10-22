Return-Path: <SRS0=xaUg=D5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0CC388F9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 20:47:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3604E20756
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 20:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3604E20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CHKDR62FJzDqSK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 07:47:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.94; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0094.hostedemail.com
 [216.40.44.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CHKBH1M41zDqR2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2020 07:45:25 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9E644181D304D;
 Thu, 22 Oct 2020 20:45:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tree02_40096f527253
X-Filterd-Recvd-Size: 1501
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf01.hostedemail.com (Postfix) with ESMTPA;
 Thu, 22 Oct 2020 20:45:20 +0000 (UTC)
Message-ID: <cdd73bbd6360a72b1fd41ee5fefc6a3b4a4e7688.camel@perches.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
From: Joe Perches <joe@perches.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 22 Oct 2020 13:45:19 -0700
In-Reply-To: <CAKwvOdmUPA9XupXwYHy_qT7P+LrUc+wseT79K_oqw=3y6bwLfg@mail.gmail.com>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
 <CAKwvOdmUPA9XupXwYHy_qT7P+LrUc+wseT79K_oqw=3y6bwLfg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: clang-built-linux <clang-built-linux@googlegroups.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-10-22 at 13:42 -0700, Nick Desaulniers wrote:
> .On Wed, Oct 21, 2020 at 7:36 PM Joe Perches <joe@perches.com> wrote:
> > Use a more generic form for __section that requires quotes to avoid
> > complications with clang and gcc differences.
[]
> >  a quick test of x86_64 and s390 would be good.

x86_64 was compiled here.
I believe the robot tested the others.

