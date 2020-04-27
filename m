Return-Path: <SRS0=vPFq=6L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA01EC81857
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 23:01:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642E22072D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 23:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642E22072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49B0dF0XJ4zDqHV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 09:01:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49B0Zz6PSNzDqRg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 08:59:23 +1000 (AEST)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1jTCeO-00063X-4Q; Mon, 27 Apr 2020 17:54:56 -0500
Message-ID: <4da39cdb0bb2b6a840c15560c4144e788f57fee4.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Rob Herring <robh@kernel.org>, Wang Wenhu <wenhu.wang@vivo.com>
Date: Mon, 27 Apr 2020 17:54:53 -0500
In-Reply-To: <CAL_JsqK3fpM_tUjHvAMbNzf_nry_iORLXaQBFC8xDK+mxhHDRQ@mail.gmail.com>
References: <20200420030538.101696-1-wenhu.wang@vivo.com>
 <CAL_JsqK3fpM_tUjHvAMbNzf_nry_iORLXaQBFC8xDK+mxhHDRQ@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: robh@kernel.org, wenhu.wang@vivo.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, christophe.leroy@c-s.fr,
 mpe@ellerman.id.au, rdunlap@infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2,RESEND] misc: new driver sram_uapi for user level
 SRAM access
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel@vivo.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2020-04-27 at 09:13 -0500, Rob Herring wrote:
> On Sun, Apr 19, 2020 at 10:06 PM Wang Wenhu <wenhu.wang@vivo.com> wrote:
> > 
> > A generic User-Kernel interface that allows a misc device created
> > by it to support file-operations of ioctl and mmap to access SRAM
> > memory from user level. Different kinds of SRAM alloction and free
> > APIs could be registered by specific SRAM hardware level driver to
> > the available list and then be chosen by users to allocate and map
> > SRAM memory from user level.
> > 
> > It is extremely helpful for the user space applications that require
> > high performance memory accesses, such as embedded networking devices
> > that would process data in user space, and PowerPC e500 is a case.
> > 
> > Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> > Cc: Scott Wood <oss@buserror.net>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> > Changes since v1: addressed comments from Arnd
> >  * Changed the ioctl cmd definitions using _IO micros
> >  * Export interfaces for HW-SRAM drivers to register apis to available
> > list
> >  * Modified allocation alignment to PAGE_SIZE
> >  * Use phys_addr_t as type of SRAM resource size and offset
> >  * Support compat_ioctl
> >  * Misc device name:sram
> > 
> > Note: From this on, the SRAM_UAPI driver is independent to any hardware
> > drivers, so I would only commit the patch itself as v2, while the v1 of
> > it was wrapped together with patches for Freescale L2-Cache-SRAM device.
> > Then after, I'd create patches for Freescale L2-Cache-SRAM device as
> > another series.
> 
> There's work to add SRAM support to dma-buf heaps[1]. Take a look and
> see if that works for you.
> 
> Rob
> 
> [1] https://lore.kernel.org/lkml/20200424222740.16259-1-afd@ti.com/
> 

The dma heap API itself (what makes it specific to DMA, rather than any
special-purpose allocator?) seems like it could be what we're looking for. 
The issue with drivers/misc/sram.c is that it seems like its main purpose is
to get sram description from the device tree, but this sram isn't static (it's
a reconfiguration of L2 cache into SRAM mode) and thus can't be described by
mmio-sram.

-Scott


