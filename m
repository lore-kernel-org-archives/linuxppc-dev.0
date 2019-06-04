Return-Path: <SRS0=V6lO=UD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A7AC282CE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 07:29:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFAD24708
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 07:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFAD24708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45J3TL1yd9zDqZ2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Jun 2019 17:29:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45J3R9673GzDqPN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2019 17:27:33 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id A57CC68B02; Tue,  4 Jun 2019 09:27:06 +0200 (CEST)
Date: Tue, 4 Jun 2019 09:27:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [PATCH 01/16] uaccess: add untagged_addr definition for other
 arches
Message-ID: <20190604072706.GF15680@lst.de>
References: <20190601074959.14036-1-hch@lst.de>
 <20190601074959.14036-2-hch@lst.de>
 <431c7395-2327-2f7c-cc8f-b01412b74e10@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431c7395-2327-2f7c-cc8f-b01412b74e10@oracle.com>
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
Cc: x86@kernel.org, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 Andrey Konovalov <andreyknvl@google.com>, sparclinux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 03, 2019 at 09:16:08AM -0600, Khalid Aziz wrote:
> Could you reword above sentence? We are already starting off with
> untagged_addr() not being no-op for arm64 and sparc64. It will expand
> further potentially. So something more along the lines of "Define it as
> noop for architectures that do not support memory tagging". The first
> paragraph in the log can also be rewritten to be not specific to arm64.

Well, as of this patch this actually is a no-op for everyone.

Linus, what do you think of applying this patch (maybe with a slightly
fixed up commit log) to 5.2-rc so that we remove a cross dependency
between the series?
