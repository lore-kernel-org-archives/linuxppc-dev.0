Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE5C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 07:22:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4E6613E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 07:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4E6613E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G40BY2vDHz308l
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 17:22:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=M3Ahny1k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+01b1093948f83d17b939+6505+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=M3Ahny1k; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G40B10kY7z303J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 17:21:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=K3tN2FjwClDMueW/dRkNP1gpJFA+mQVQcAmzf0tIJNU=; b=M3Ahny1kf0WKwr4OCsfkABA5RB
 BhOOn6WUW0NNSN5nh+IUSvjf85CwKW5zkCadIHC0gIGYsMGgCCnEKgxmVV7/kKmzBHQiel7QXzmgN
 AffxNp3lSLO+M0koptUSEfY8SgmAoiPuRERr/kxz5IMuqh9NgZxatJh7Jv/BideoWbA7SRJkqIivi
 3+Vfdq596W3L7bIT2IITpsePNy45clkFzu/R4orBNgmrtuW5YzMl54fOnk9dMmaXqf+fMb4X0Enb/
 wTC4gW4hHGUXmdPJhKZBdtm3NFXykddIMWWfM7ax3j1St5U689fWd4PMHh+ZRbpVxEp5JQke5CalO
 5U65+/ww==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lt3Nc-006CQF-SX; Tue, 15 Jun 2021 07:21:05 +0000
Date: Tue, 15 Jun 2021 08:21:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 5/7] signal: Add unsafe_copy_siginfo_to_user()
Message-ID: <YMhU3Df7foVo9BaM@infradead.org>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <684939dcfef612fac573d1b983a977215b71f64d.1623739212.git.christophe.leroy@csgroup.eu>
 <YMhOMoKKvew0YYCt@infradead.org>
 <7061fbee-cc82-2699-cf12-e5a4ae46940f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7061fbee-cc82-2699-cf12-e5a4ae46940f@csgroup.eu>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 15, 2021 at 09:03:42AM +0200, Christophe Leroy wrote:
> 
> 
> Le 15/06/2021 ?? 08:52, Christoph Hellwig a ??crit??:
> > On Tue, Jun 15, 2021 at 06:41:01AM +0000, Christophe Leroy wrote:
> > > +	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
> > > +			    sizeof(struct kernel_siginfo), label);	\
> > > +	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
> > > +} while (0)
> > 
> > unsafe_clear_user does not exist at this point, and even your later
> > patch only adds it for powerpc.
> > 
> 
> You missed below chunck I guess:
> 
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index c05e903cef02..37073caac474 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -398,6 +398,7 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count);
> >   #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
> >   #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
> >   #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
> > +#define unsafe_clear_user(d, l, e) unsafe_op_wrap(__clear_user(d, l), e)

That doesn't help with architectures that define user_access_begin but
do not define unsafe_clear_user. (i.e. x86).
