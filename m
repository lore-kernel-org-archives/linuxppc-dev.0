Return-Path: <SRS0=25Ql=E3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B03C388F9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2020 03:54:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4815D22269
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2020 03:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EegFuB2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4815D22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdKKs5tCjzDr5J
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2020 14:54:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=EegFuB2M; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdKJ25rzRzDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2020 14:52:50 +1100 (AEDT)
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown
 [163.114.132.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 017F322269;
 Sat, 21 Nov 2020 03:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605930767;
 bh=50xL13QWys/2TwMmcLztBlckytj8sEvIsO0Oy/i5qWw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EegFuB2M94d1/gOFCRaJgmbp3glUdyWPshL0zqqvBC750lZ5yHjlMoHWHvCKlmgYL
 ImoNZ6/YP7L1rqo12tOGjTgjeJ7ZuvqJNy4aD58IQ0httk9Z+CtB+wrjPaONLec2JR
 IO6DiOJ3+rZOzcJGX5ssDKnJ1b+xCWCZIVGAjv7k=
Date: Fri, 20 Nov 2020 19:52:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: Re: [PATCH net-next v2 0/9] ibmvnic: Performance improvements and
 other updates
Message-ID: <20201120195246.18533062@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1605748345-32062-1-git-send-email-tlfalcon@linux.ibm.com>
References: <1605748345-32062-1-git-send-email-tlfalcon@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: cforno12@linux.ibm.com, netdev@vger.kernel.org, ljp@linux.vnet.ibm.com,
 ricklind@linux.ibm.com, dnbanerg@us.ibm.com, drt@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 18 Nov 2020 19:12:16 -0600 Thomas Falcon wrote:
> The first three patches utilize a hypervisor call allowing multiple 
> TX and RX buffer replenishment descriptors to be sent in one operation,
> which significantly reduces hypervisor call overhead. The xmit_more
> and Byte Queue Limit API's are leveraged to provide this support
> for TX descriptors.
> 
> The subsequent two patches remove superfluous code and members in
> TX completion handling function and TX buffer structure, respectively,
> and remove unused routines.
> 
> Finally, four patches which ensure that device queue memory is
> cache-line aligned, resolving slowdowns observed in PCI traces,
> as well as optimize the driver's NAPI polling function and 
> to RX buffer replenishment are provided by Dwip Banerjee.
> 
> This series provides significant performance improvements, allowing
> the driver to fully utilize 100Gb NIC's.

Applied, thanks!
