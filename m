Return-Path: <SRS0=bUW7=VN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F20C7618F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 18:55:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8843720665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 18:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="EInCxkcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8843720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p8jB6WMLzDqcD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jul 2019 04:55:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stackframe.org
 (client-ip=2001:470:70c5:1111::170; helo=smtp.duncanthrax.net;
 envelope-from=svens@stackframe.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stackframe.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=duncanthrax.net header.i=@duncanthrax.net
 header.b="EInCxkcX"; dkim-atps=neutral
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net
 [IPv6:2001:470:70c5:1111::170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45p8g73QJvzDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2019 04:53:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date;
 bh=dKHH4h/q3QG6V+WLSyHa/70tf/GFmuqAjtSnkGY7D2U=; b=EInCxkcX8/U7HJUwQX6zQawdSA
 3En7UuZMxWmfpQQF+KD4KM1ZhQkrsY8ilze4mu+wmEjt4CDQ5zYqbUN3KgJVT6QaszCyuS3hR9bBO
 qU7MV+VzceEfmsLdf7RLymVUnFZS5OewOtK76S4aHj4tYo94hhMXGfxzrzYwOcQMJw1Y=;
Received: from [134.3.44.134] (helo=t470p.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1hnSZc-0000Wk-IO; Tue, 16 Jul 2019 20:53:12 +0200
Date: Tue, 16 Jul 2019 20:53:10 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190716185310.GA12537@t470p.stackframe.org>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
 <20190716130631.tohj4ub54md25dys@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716130631.tohj4ub54md25dys@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, arnd@arndb.de,
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Vasily Gorbik <gor@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

[Adding Helge to CC list]

On Tue, Jul 16, 2019 at 03:06:33PM +0200, Christian Brauner wrote:
> On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> > I think Vasily already has a clone3 patch for s390x with 435. 
> 
> A quick follow-up on this. Helge and Michael have asked whether there
> are any tests for clone3. Yes, there will be and I try to have them
> ready by the end of the this or next week for review. In the meantime I
> hope the following minimalistic test program that just verifies very
> very basic functionality (It's not pretty.) will help you test:
> [..]

On PA-RISC this seems to work fine with Helge's patch to wire up the
clone3 syscall.

root@c3750:/# clonetest
Parent process received child's pid 84 as return value
Parent process received child's pidfd 3
Parent process received child's pid 84 as return argument
Child process with pid 84
root@c3750:/# echo $?
0

Regards
Sven
