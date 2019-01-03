Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40894C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 22:09:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E84621479
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 22:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E84621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43W2CP1g0LzDqNC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:09:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43W29Z4pP0zDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 09:08:18 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id C119B2A185;
 Thu,  3 Jan 2019 17:08:12 -0500 (EST)
Date: Fri, 4 Jan 2019 09:08:13 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v8 05/25] char/nvram: Adopt arch_nvram_ops
In-Reply-To: <20190103080229.GB11147@infradead.org>
Message-ID: <alpine.LNX.2.21.1901040844380.658@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au>
 <20190103080229.GB11147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 3 Jan 2019, Christoph Hellwig wrote:

> > +
> > +const struct nvram_ops arch_nvram_ops = {
> > +	.read_byte      = nvram_read_byte,
> > +	.write_byte     = nvram_write_byte,
> > +	.get_size       = nvram_get_size,
> > +};
> > +EXPORT_SYMBOL(arch_nvram_ops);
> 
> I think something this internal should always be EXPORT_SYMBOL_GPL.
> 

By "internal" do you mean "not involving interests outside of the Linux 
Foundation"? TBH, I don't know who's affected.

Anyway, this patch series is mostly refactoring. So the policy it enforces 
towards the use of arch_nvram_ops just reflects the policy already in 
place:

$ git grep -w EXPORT_SYMBOL_GPL | grep nvram
$ git grep -w EXPORT_SYMBOL | grep nvram
...
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_read_byte);
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_write_byte);
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_get_size);
arch/powerpc/kernel/setup_32.c:EXPORT_SYMBOL(nvram_sync);
arch/powerpc/platforms/powermac/nvram.c:EXPORT_SYMBOL(pmac_get_partition);
arch/powerpc/platforms/powermac/nvram.c:EXPORT_SYMBOL(pmac_xpram_read);
arch/powerpc/platforms/powermac/nvram.c:EXPORT_SYMBOL(pmac_xpram_write);
drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_read_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(nvram_read_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_write_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(nvram_write_byte);
drivers/char/nvram.c:EXPORT_SYMBOL(__nvram_check_checksum);
drivers/char/nvram.c:EXPORT_SYMBOL(nvram_check_checksum);
...
$ 

-- 
