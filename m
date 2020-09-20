Return-Path: <SRS0=1NAR=C5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E1DC43463
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 19:04:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CEB20897
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 19:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5wq+0/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CEB20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BvcSk1Gl2zDqj1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 05:04:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=g5wq+0/n; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BvcQ63b0pzDqSQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2020 05:02:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IDW3RmS0RDwF1PxkMWRCY+cTnTy0vBsZViqlQFFmOdo=; b=g5wq+0/nR7te7B4gJNw+xxZEh4
 vIYebQdoarMEpWmpRDhj1bWsfYD36OHjLCErlQNaLSUq8CTrXuLatwHN9B+K+KO1QIhzWqG7Z6waK
 del3pmKFJAAuj35sQYQznNEe+qO0m5iu5fRGSMsKcikhX7RyrIn/RWw/VFHRk4mWe6oZMZa9R6Je1
 oGcYf/SOT5wxGjakHifLpr17yPf4i9EhX/Cy94JdQ9a5xDZHTyc0bbRlyh+8XGfdroAgldwfZpb7H
 4VqjUhxS1EFiueOXW0SA9H6gHtPsQs2vFJVBdst+6vs08n2gMA9frgF4VF0y0tLMDhkql0UrCuprC
 yBGQJbwg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kK4b1-0000nk-2G; Sun, 20 Sep 2020 19:01:59 +0000
Date: Sun, 20 Sep 2020 20:01:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <20200920190159.GT32101@casper.infradead.org>
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200920151510.GS32101@casper.infradead.org>
 <20200920180742.GN3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920180742.GN3421308@ZenIV.linux.org.uk>
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
Cc: linux-aio@kvack.org, linux-mips@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 keyrings@vger.kernel.org, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Sep 20, 2020 at 07:07:42PM +0100, Al Viro wrote:
> 	2) a few drivers are really fucked in head.  They use different
> *DATA* layouts for reads/writes, depending upon the calling process.
> IOW, if you fork/exec a 32bit binary and your stdin is one of those,
> reads from stdin in parent and child will yield different data layouts.
> On the same struct file.
> 	That's what Christoph worries about (/dev/sg he'd mentioned is
> one of those).
> 
> 	IMO we should simply have that dozen or so of pathological files
> marked with FMODE_SHITTY_ABI; it's not about how they'd been opened -
> it describes the userland ABI provided by those.  And it's cast in stone.
> 
> 	Any in_compat_syscall() in ->read()/->write() instances is an ABI
> bug, plain and simple.  Some are unfixable for compatibility reasons, but
> any new caller like that should be a big red flag.

So an IOCB_COMPAT flag would let us know whether the caller is expecting
a 32-bit or 64-bit layout?  And io_uring could set it based on the
ctx->compat flag.

> 	Current list of those turds:
> /dev/sg (pointer-chasing, generally insane)
> /sys/firmware/efi/vars/*/raw_var (fucked binary structure)
> /sys/firmware/efi/vars/new_var (fucked binary structure)
> /sys/firmware/efi/vars/del_var (fucked binary structure)
> /dev/uhid	(pointer-chasing for one obsolete command)
> /dev/input/event* (timestamps)
> /dev/uinput (timestamps)
> /proc/bus/input/devices (fucked bitmap-to-text representation)
> /sys/class/input/*/capabilities/* (fucked bitmap-to-text representation)
