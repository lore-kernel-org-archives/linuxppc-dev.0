Return-Path: <SRS0=t5Sp=D6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1651DC388F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 08:05:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E851F22253
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 08:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E851F22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CHcGl2593zDqsW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:05:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.185; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0185.hostedemail.com
 [216.40.44.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CHcDb43kqzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2020 19:03:25 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 76F86182CED2A;
 Fri, 23 Oct 2020 08:03:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sort57_5a0f0a927258
X-Filterd-Recvd-Size: 2339
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Fri, 23 Oct 2020 08:03:20 +0000 (UTC)
Message-ID: <64b49cd3680f45808dad286b408e7b196c31ec79.camel@perches.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Oct 2020 01:03:18 -0700
In-Reply-To: <CANiq72nfHjXkN65jy+unz0k66qvAALNhhhDZsxqPRLdtLKOW_Q@mail.gmail.com>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
 <CANiq72nfHjXkN65jy+unz0k66qvAALNhhhDZsxqPRLdtLKOW_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
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
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-10-23 at 08:08 +0200, Miguel Ojeda wrote:
> On Thu, Oct 22, 2020 at 4:36 AM Joe Perches <joe@perches.com> wrote:
> > 
> > Use a more generic form for __section that requires quotes to avoid
> > complications with clang and gcc differences.
> 
> I performed visual inspection (one by one...) and the only thing I saw
> is that sometimes the `__attribute__` has a whitespace afterwards and
> sometimes it doesn't, same for the commas inside, e.g.:
> 
> -  __used __attribute__((section(".modinfo"), unused, aligned(1)))  \
> +  __used __section(".modinfo") __attribute__((unused, aligned(1)))  \
> 
> and:
> 
> -    __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
> +    __section("__param") __attribute__ ((unused, aligned(sizeof(void *)))) \
> 
> I think the patch tries to follow the style of the replaced line, but
> for the commas in this last case it didn't. Anyway, it is not
> important.

Here the change follows the kernel style of space after comma.

> I can pick it up in my queue along with the __alias one and keep it
> for a few weeks in -next.

Thanks Miguel, but IMO it doesn't need time in next.

Applying it just before an rc1 minimizes conflicts.


