Return-Path: <SRS0=hyM8=TB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74949C43219
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 02:27:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09612087B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 02:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09612087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44v2NP1Zc8zDqSW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 12:27:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux-mips.org
 (client-ip=148.251.95.138; helo=cvs.linux-mips.org;
 envelope-from=macro@linux-mips.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-mips.org
X-Greylist: delayed 305 seconds by postgrey-1.36 at bilbo;
 Wed, 01 May 2019 12:25:51 AEST
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by lists.ozlabs.org (Postfix) with ESMTP id 44v2Ll0FvnzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2019 12:25:50 +1000 (AEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
 with ESMTP id S23990394AbfEACUhiM2bj (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Wed, 1 May 2019 04:20:37 +0200
Date: Wed, 1 May 2019 03:20:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/41] drivers: tty: serial: dz: use dev_err() instead
 of printk()
In-Reply-To: <20190429131224.GA27385@kroah.com>
Message-ID: <alpine.LFD.2.21.1905010255070.30973@eddie.linux-mips.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-2-git-send-email-info@metux.net>
 <20190427133117.GC11368@kroah.com>
 <bae3f23b-8823-f089-c40e-024ba225555f@metux.net>
 <20190429131224.GA27385@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
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
Cc: linux-ia64@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, andrew@aj.id.au,
 khilman@baylibre.com, sudeep.holla@arm.com, liviu.dudau@arm.com,
 linux-kernel@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz,
 linuxppc-dev@lists.ozlabs.org, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, linux-serial@vger.kernel.org,
 slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk,
 linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 29 Apr 2019, Greg KH wrote:

> > >>  drivers/tty/serial/dz.c | 8 ++++----
> > > 
> > > Do you have this hardware to test any of these changes with?
> > 
> > Unfortunately not :(
> 
> Then I can take the "basic" types of patches for the driver (like this
> one), but not any others, sorry.

 I can verify changes to dz.c, sb1250-duart.c and zs.c with real hardware, 
but regrettably not right away: the hardware is in a remote location and 
while I have it wired for remote operation unfortunately its connectivity 
has been cut off by an unfriendly ISP.

 I'm not sure if all the changes make sense though: if there is a compiler 
warning or a usability issue, then a patch is surely welcome, otherwise: 
"If it ain't broke, don't fix it".

  Maciej
