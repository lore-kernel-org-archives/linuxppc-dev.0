Return-Path: <SRS0=ugCm=VQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FDC76188
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 03:27:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E9D21849
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 03:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAzd3DTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E9D21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qbz71xGrzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uAzd3DTO"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qbwh4SRnzDqhK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 13:25:06 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id n9so5657190wrr.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2019 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jIYPnkgBs5i86rbWUSwNdiw65NtG6kE0hp4IepPNimw=;
 b=uAzd3DTOad8sm8SbAbgLpLuIhEdXSKzEZq0uAVNPjjgfCGSTsFIK7uIaPbM+AILI1T
 JAvFnrZaC3ngiU7GDa/hEQeMeNf62aTdCJ+/2tou3cwabyOoq/c3eQ/8GQtN2xa9r/QT
 sO3MrrlkW6O4cJY1gi4NgKsLjlmNRdsQSf2bXYAtuZHNIYXLvrR+NuTJ6DebYT4mdRKZ
 AVujvuw0kIDZdVfrjhrlx0cnJs8IlapWBSMutWKM5GwfeHuzZ/hI//2duR/hsTNY7WcM
 zvbcqleNRVXUwGRmxYi6jv7nrMFYn3OF2YwOBRjzz6xER/YP8caUuLYdu5MwbHFCaXMg
 FwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jIYPnkgBs5i86rbWUSwNdiw65NtG6kE0hp4IepPNimw=;
 b=Jg8DYjA91biEKdhm4op/zvnmHxh71phhY31tT1MKmmspG6aYYjgM3GyyuM4BNKPxqK
 rYWiKSojrRWh6X+DIT0BNSa0xMPz2sQdogMK+PloOILXiS30csne8m4TKhBeG3QIiu5N
 2BZvIVNp0GysgQdRXQjnobAZXjfkTgNeOfj59LZoEps74cMH7+ei782BD/exNP97VSH1
 XNfhLu9PTT2aznFTpUl78XVKxAm3BbSF1rLHG3CXiRC+biXYrCphOpIYj7AqG4N+p1OE
 8hdYBLRTfEDIM36TN2lzAjZK4mJb2DvkjC+TxQ6/0ju6OLXXNBYgiC857hgjTTT+j8/L
 BpRg==
X-Gm-Message-State: APjAAAW0Xiix4e7vGK7f1Gk5g96oln5GDvGerbr/HiaNr/ulztZA9gfr
 NSRAoBL/iRwoFP6SMcATovE=
X-Google-Smtp-Source: APXvYqyT8jgZuM/70vXITnsp6orU2Gbote6On0qrgGrBbjMKFgK5AbQwBSEInRvsJG2tx8AWq8pyaQ==
X-Received: by 2002:adf:f883:: with SMTP id u3mr52455389wrp.0.1563506698857;
 Thu, 18 Jul 2019 20:24:58 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
 by smtp.gmail.com with ESMTPSA id r14sm27007800wrx.57.2019.07.18.20.24.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 20:24:58 -0700 (PDT)
Date: Thu, 18 Jul 2019 20:24:56 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190719032456.GA14108@archlinux-threadripper>
References: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
 <45hnfp6SlLz9sP0@ozlabs.org>
 <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
 <20190709064952.GA40851@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709064952.GA40851@archlinux-threadripper>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 08, 2019 at 11:49:52PM -0700, Nathan Chancellor wrote:
> On Tue, Jul 09, 2019 at 07:04:43AM +0200, Christophe Leroy wrote:
> > Is that a Clang bug ?
> 
> No idea, it happens with clang-8 and clang-9 though (pretty sure there
> were fixes for PowerPC in clang-8 so something before it probably won't
> work but I haven't tried).
> 
> > 
> > Do you have a disassembly of the code both with and without this patch in
> > order to compare ?
> 
> I can give you whatever disassembly you want (or I can upload the raw
> files if that is easier).
> 
> Cheers,
> Nathan

Hi Christophe and Segher,

What disassembly/files did you need to start taking a look at this? I
can upload/send whatever you need.

If it is easier, we have a self contained clang build script available
to make it easier to reproduce this on your side (does assume an x86_64
host):

https://github.com/ClangBuiltLinux/tc-build

Cheers,
Nathan
