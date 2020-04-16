Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F2C2BB55
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 19:44:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155A720786
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 19:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4938nJ5LpSzDsMN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 05:44:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4938l62Q9kzDqF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 05:42:42 +1000 (AEST)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1jPANA-00078g-07; Thu, 16 Apr 2020 14:40:28 -0500
Message-ID: <54b97ce51fa3686d17a4b124c4deccb9939725b9.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 16 Apr 2020 14:40:26 -0500
In-Reply-To: <20200416063002.GA299193@kroah.com>
References: <20200415124929.GA3265842@kroah.com>
 <20200415152442.122873-1-wenhu.wang@vivo.com>
 <20200415152442.122873-6-wenhu.wang@vivo.com>
 <ef9f59f98f6bcf81891de87fd9cd0b5973bbd468.camel@buserror.net>
 <20200416063002.GA299193@kroah.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, wenhu.wang@vivo.com,
 linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, mpe@ellerman.id.au
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
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
Cc: linux-kernel@vger.kernel.org, kernel@vivo.com,
 Wang Wenhu <wenhu.wang@vivo.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-04-16 at 08:30 +0200, Greg KH wrote:
> On Wed, Apr 15, 2020 at 02:26:55PM -0500, Scott Wood wrote:
> > Instead, have module parameters that take the sizes and alignments you'd
> > like
> > to allocate and expose to userspace.  Better still would be some sort of
> > dynamic allocation (e.g. open a fd, ioctl to set the requested
> > size/alignment,
> > if it succeeds you can mmap it, and when the fd is closed the region is
> > freed).
> 
> No module parameters please, this is not the 1990's.
> 
> Use device tree, that is what it is there for.

Since when is the device tree for indicating desired allocations?  This is not
hardware description.

If module parameters are unacceptable, then I'd suggest dynamic allocation as
described above.

-Scott


