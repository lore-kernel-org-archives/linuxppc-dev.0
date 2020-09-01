Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5E2C433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35A9207D3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vkH+jqka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35A9207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BgvdQ60YkzDqWg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 03:46:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BgvXn4NV4zDqGg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 03:42:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=b2ed4kKOHBE6qB3WmU3cuZU1WUsaY/IfPchrSUMqTzk=; b=vkH+jqkaaXHPFcoC+6AYwSwZ55
 cL8pberSXUZvGfrHlSm5svroGmEItBMRukBfiGAyGWzzsFs2JlIoJET0AjGynUvzoRuuD9EsFwXSO
 rpu2LLzH/Z3ELTKczZYrEsmmrKwgkIGFF07QI0osyEqvGqt2ry2oIIUALpo7x08P3iueFHzVT6YIC
 pYcxWLqVVwPXrNAHNRJREfFmnbq9QvS2rv6Yoaw088D4/II4Uk7hMNZOVagL8M+s/W/u/VlaA4JdW
 aH5bnGd4XpvLHTLqX3ShGe32/Fc/7Kkn2Kf1JYKxSTTApeUToFe9GoqbqrR8NBt2Xhc9I3rGIr/M2
 MWobY3sg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kDAIS-0005Yb-9R; Tue, 01 Sep 2020 17:42:16 +0000
Date: Tue, 1 Sep 2020 18:42:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v2
Message-ID: <20200901174216.GT14765@casper.infradead.org>
References: <20200827150030.282762-1-hch@lst.de>
 <a8bb0319-0928-4687-9e9c-777c5860dbdd@csgroup.eu>
 <20200901172512.GI1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901172512.GI1236603@ZenIV.linux.org.uk>
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
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 01, 2020 at 06:25:12PM +0100, Al Viro wrote:
> On Tue, Sep 01, 2020 at 07:13:00PM +0200, Christophe Leroy wrote:
> 
> >     10.92%  dd       [kernel.kallsyms]  [k] iov_iter_zero
> 
> Interesting...  Could you get an instruction-level profile inside iov_iter_zero(),
> along with the disassembly of that sucker?

Also, does [1] make any difference?  Probably not since it's translating
O flags into IOCB flags instead of RWF flags into IOCB flags.  I wonder
if there's a useful trick we can play here ... something like:

static inline int iocb_flags(struct file *file)
{
        int res = 0;
	if (likely(!file->f_flags & O_APPEND | O_DIRECT | O_DSYNC | __O_SYNC)) && !IS_SYNC(file->f_mapping->host))
		return res;
        if (file->f_flags & O_APPEND)
                res |= IOCB_APPEND;
        if (file->f_flags & O_DIRECT)
                res |= IOCB_DIRECT;
        if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
                res |= IOCB_DSYNC;
        if (file->f_flags & __O_SYNC)
                res |= IOCB_SYNC;
        return res;
}

Can we do something like force O_DSYNC to be set if the inode IS_SYNC()
at the time of open?  Or is setting the sync bit on the inode required
to affect currently-open files?

[1] https://lore.kernel.org/linux-fsdevel/95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk/ 
