Return-Path: <SRS0=xixs=JR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B55CC433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 03:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591866101C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 03:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591866101C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FPTHK5qL2z30CS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 13:11:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=cmFm54dB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=cmFm54dB; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FPTGq2ZBVz2xYk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2021 13:11:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AqTuRNKIkAmLe8Av3ztkUAdmYLIeq8PftziUxkdnED4=; b=cmFm54dBhWL/FJIZPa1qLdPQCh
 Hw3d+6yeN1BRhVLA8lXi0+OxBNGlwLN0iOxnz1tNw19z7dwED70uUHLHZ0QHCfVKNKBQenpL6sjTp
 RiTDO60rG0H/+Io0sMW2Sl9Yi8uXuQbOmHCm5NzIBmET6uhHQgkerVA9dwlFEY8qLE05GHB/V0PuZ
 Ao/jqa8j5AAd9wR8FIZ6K7RUe8Zya2Y8SayHTkT8KDCcVbyrGWXzGbXLEMb2IexWdlSkgwpOFyitu
 JUjQ4dGrsXV5WoOuWngimlVppnjX5FKsAVbm0+zGZtX6LrP+cU2NI9VCFMIOrg0zh0XBFnqcrMJKV
 Y0NuvgGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lYgmT-00Ee86-KY; Tue, 20 Apr 2021 03:10:34 +0000
Date: Tue, 20 Apr 2021 04:10:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 1/2] mm: Fix struct page layout on 32-bit systems
Message-ID: <20210420031029.GI2531743@casper.infradead.org>
References: <20210416230724.2519198-1-willy@infradead.org>
 <20210416230724.2519198-2-willy@infradead.org>
 <20210417024522.GP2531743@casper.infradead.org>
 <9f99b0a0-f1c1-f3b0-5f84-3a4bfc711725@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f99b0a0-f1c1-f3b0-5f84-3a4bfc711725@synopsys.com>
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
Cc: "arnd@kernel.org" <arnd@kernel.org>,
 "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "mhocko@kernel.org" <mhocko@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "mgorman@suse.de" <mgorman@suse.de>,
 "brouer@redhat.com" <brouer@redhat.com>,
 "mcroce@linux.microsoft.com" <mcroce@linux.microsoft.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 20, 2021 at 02:48:17AM +0000, Vineet Gupta wrote:
> > 32-bit architectures which expect 8-byte alignment for 8-byte integers
> > and need 64-bit DMA addresses (arc, arm, mips, ppc) had their struct
> > page inadvertently expanded in 2019.
> 
> FWIW, ARC doesn't require 8 byte alignment for 8 byte integers. This is 
> only needed for 8-byte atomics due to the requirements of LLOCKD/SCOND 
> instructions.

Ah, like x86?  OK, great, I'll drop your arch from the list of
affected.  Thanks!
