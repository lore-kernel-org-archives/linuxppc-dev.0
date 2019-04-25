Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DEEC43218
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 19:38:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B7E205ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 19:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsvMmBVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B7E205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qnYB4rkkzDqZP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 05:38:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nsvMmBVw"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qnVj1TyQzDqV8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 05:36:28 +1000 (AEST)
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C7FC20685;
 Thu, 25 Apr 2019 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556220986;
 bh=lu3Gl4kYfadce26fIqlSb6esx/qPxezHI7oRC8rsMAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nsvMmBVwxBQALsyT0vDAx3VN7HQHk3kAjRwyMKrdHkBOhK9SqqE3uxOKfhUqJa9hW
 x6xVDtzRQ1VkRhGae2jwoRGeXYWyEWAExOIbx22QMP80CuKmhBfgNvE2RD85QIXQOg
 G9+Q9mL/kt4jntljf5T1HFETWBNOGXHqgXDEaPi0=
Date: Thu, 25 Apr 2019 21:36:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v10 00/18] Introduce the Counter subsystem
Message-ID: <20190425193624.GA11240@kroah.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <20190407152550.451a7f63@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407152550.451a7f63@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, linux-api@vger.kernel.org,
 lars@metafoo.de, daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 david@lechnology.com, William Breathitt Gray <vilhelm.gray@gmail.com>,
 robh+dt@kernel.org, tglx@linutronix.de, fabrice.gasnier@st.com,
 esben@haabendal.dk, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, knaack.h@gmx.de, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 07, 2019 at 03:25:50PM +0100, Jonathan Cameron wrote:
> On Tue,  2 Apr 2019 15:30:35 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > Changes in v10:
> >   - Fix minor typographical errors in documentation
> >   - Merge the FlexTimer Module Quadrature decoder counter driver patches
> > 
> > This revision is functionally identical to the last; changes in this
> > version were made to fix minor typos in the documentation files and also
> > to pull in the new FTM quadrature decoder counter driver.
> > 
> > The Generic Counter API has been and is still in a feature freeze until
> > it is merged into the mainline. The following features will be
> > investigated after the merge: interrupt support for counter devices, and
> > a character device interface for low-latency applications.
> 
> Hi William / al,
> 
> So the question is how to move this forwards?  I'm happy with how it turned
> out and the existing drivers we had in IIO are a lot cleaner under
> the counter subsystem (other than the backwards compatibility for those that
> ever existed in IIO).  For those  not following closely the situation is:

I've now sucked this into my staging-testing branch and if 0-day is fine
with it, I'll merge it to staging-next in a day or so.  This way you can
build on it for any iio drivers that might be coming.

I do have reservations about that one sysfs file that is multi-line, and
I think it will come to bite you in the end over time, so I reserve the
right to say "I told you so" when that happens...

But, I don't have a better answer for it now, so don't really worry
about it :)

thanks,

greg k-h
