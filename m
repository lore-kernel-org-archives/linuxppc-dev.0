Return-Path: <SRS0=rwjh=CN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D9C43461
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 07:49:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F90206A5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 07:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F90206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BjVFD5HDNzDrLb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 17:49:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BjVCP13rbzDr0m
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2020 17:47:59 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id EBAAE68AFE; Fri,  4 Sep 2020 09:47:53 +0200 (CEST)
Date: Fri, 4 Sep 2020 09:47:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 12/14] x86: remove address space overrides using set_fs()
Message-ID: <20200904074753.GA14932@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-13-hch@lst.de>
 <20200904025510.GO1236603@ZenIV.linux.org.uk> <20200904063813.GA12204@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904063813.GA12204@lst.de>
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
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 04, 2020 at 08:38:13AM +0200, Christoph Hellwig wrote:
> > Wait a sec... how is that supposed to build with X86_5LEVEL?  Do you mean
> > 
> > #define LOAD_TASK_SIZE_MINUS_N(n) \
> > 	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
> > 		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
> > 
> > there?
> 
> Don't ask me about the how, but it builds and works with X86_5LEVEL,
> and the style is copied from elsewhere..

Actually, it doesn't any more.  Looks like the change to pass the n
parameter as suggested by Linus broke the previously working version.
