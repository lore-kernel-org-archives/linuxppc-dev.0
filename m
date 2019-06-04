Return-Path: <SRS0=V6lO=UD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC26C282CE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 07:28:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0B124708
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 07:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0B124708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45J3Rx6Wk7zDqWY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 17:28:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45J3Q710ZszDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2019 17:26:39 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 89A2368B02; Tue,  4 Jun 2019 09:26:10 +0200 (CEST)
Date: Tue, 4 Jun 2019 09:26:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 03/16] mm: simplify gup_fast_permitted
Message-ID: <20190604072610.GE15680@lst.de>
References: <20190601074959.14036-1-hch@lst.de>
 <20190601074959.14036-4-hch@lst.de>
 <CAHk-=whusWKhS=SYoC9f9HjVmPvR5uP51Mq=ZCtktqTBT2qiBw@mail.gmail.com>
 <20190603074121.GA22920@lst.de>
 <CAHk-=wg5mww3StP8HqPN4d5eij3KmEayM743v-nDKAMgRe2J6g@mail.gmail.com>
 <CAHk-=wjU3ycY2FvhKmYmOTi95L0qSi9Hj+yrzWTAWepW-zdBOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjU3ycY2FvhKmYmOTi95L0qSi9Hj+yrzWTAWepW-zdBOA@mail.gmail.com>
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
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-sh list <linux-sh@vger.kernel.org>, James Hogan <jhogan@kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Khalid Aziz <khalid.aziz@oracle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Linux-MM <linux-mm@kvack.org>,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 Andrey Konovalov <andreyknvl@google.com>, sparclinux@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 03, 2019 at 10:02:10AM -0700, Linus Torvalds wrote:
> On Mon, Jun 3, 2019 at 9:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The new code has no test at all for "nr_pages == 0", afaik.
> 
> Note that it really is important to check for that, because right now we do

True.  The 0 check got lost.  I'll make sure we do the right thing for
the next version.
