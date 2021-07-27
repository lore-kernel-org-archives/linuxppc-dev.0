Return-Path: <SRS0=LxjK=MT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E628C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 15:08:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD2461B23
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 15:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDD2461B23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZ0Yc3VFrz3bT7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 01:08:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZBdwDYui;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+120c431586dc67e47307+6547+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=ZBdwDYui; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZ0Y36qSkz2ymN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 01:08:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wVt0blQj5cMNKK3RgGAsWldsmx4Nl3QUZ8dtyk7ITIw=; b=ZBdwDYuic7LwFr25GXHm7eDLta
 83Fh/NTGn8WFh+rf+r8oSPxdv/zHWOdR+URvLjid7yh0XEkw6LcHg5G0vemJJgT24meRxB8QAZO4X
 05eZDwqoEkZN+9SKIK61Q0Ak+2miPYCwN3X87QCboCnyBQVCg6pNmnz7Odu114s2wM+N2SrU8GXqf
 SWnomiaZeXM4Elw2F5p08FKGCvXVnE2mDoByrj5wFEKlalaoT7OUFCkLXW3eM+gT3cL7/F0tq9faq
 B13XbrPu1WdAAKAlaABUE0rPrOi/I4snCG0mAJhB6kKA4SRWaA6wCH3a9yxKaqU+IUkciUfsYQOnT
 VRbSOgSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m8OYl-00F7jB-UP; Tue, 27 Jul 2021 15:00:05 +0000
Date: Tue, 27 Jul 2021 15:59:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v5 0/6] compat: remove compat_alloc_user_space
Message-ID: <YQAfa6iObAwwIpzb@infradead.org>
References: <20210727144859.4150043-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727144859.4150043-1-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Feng Tang <feng.tang@intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 27, 2021 at 04:48:53PM +0200, Arnd Bergmann wrote:
> Since these patches are now all that remains, it would be nice to
> merge it all through Andrew's Linux-mm tree, which is already based
> on top of linux-next.

Is it?
