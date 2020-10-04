Return-Path: <SRS0=Om5s=DL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCFEC41604
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2020 01:38:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580A72067B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2020 01:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVM81vLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580A72067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C3mZw5Xx1zDqTk
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2020 12:38:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=iVM81vLV; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C3mYD2xsZzDqQd
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Oct 2020 12:36:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NDQcs2sypgUb2kaljw/PLF9eyPJJqCCMKlV+6nk3qyA=; b=iVM81vLVhXohJ7qOoV+tDGUf5Y
 SKtcp4UP39tB0Axj/fhnx76xM9UduT8h8NuuwmPPI2fW3v/mtptxbfO2tzewdHuO6lPpYW+Aj+hH7
 ZH3++M4csNhhE5vPVviIUIkZY0/6PBnBvRx4AWYA0sinPAsWQDg9JvEp4gOFMrYXc0cSi33bRdc1l
 T7NPCMiJaVpAuXiuuZFV2CF/pFefDvXY9sqmtI4qrV+ieA/rZlivPwk3qDmNUNhvQIXvZk4GRmNbt
 VWblMIFSOQYERk6gOsg/lvRl3UCfj9tFR7whYVt5c62bFdmNc8L+Mv1u92CHPYlIqyQFgVn9Bx+ST
 SBST4P7w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kOsws-00012u-Sq; Sun, 04 Oct 2020 01:36:27 +0000
Date: Sun, 4 Oct 2020 02:36:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Subject: Re: Where is the declaration of buffer used in kernel_param_ops .get
 functions?
Message-ID: <20201004013626.GE20115@casper.infradead.org>
References: <cover.1601770305.git.joe@perches.com>
 <250919192de237dadf36218ee6b4dabf1bd4cbde.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250919192de237dadf36218ee6b4dabf1bd4cbde.camel@perches.com>
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
Cc: kvm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, rcu@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 03, 2020 at 06:19:18PM -0700, Joe Perches wrote:
> These patches came up because I was looking for
> the location of the declaration of the buffer used
> in kernel/params.c struct kernel_param_ops .get
> functions.
> 
> I didn't find it.
> 
> I want to see if it's appropriate to convert the
> sprintf family of functions used in these .get
> functions to sysfs_emit.
> 
> Patches submitted here:
> https://lore.kernel.org/lkml/5d606519698ce4c8f1203a2b35797d8254c6050a.1600285923.git.joe@perches.com/T/
> 
> Anyone know if it's appropriate to change the
> sprintf-like uses in these functions to sysfs_emit
> and/or sysfs_emit_at?

There's a lot of preprocessor magic to wade through.

I'm pretty sure this comes through include/linux/moduleparam.h
and kernel/module.c.
