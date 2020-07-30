Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:28:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB83D2067D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB83D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHWSr2cs1zDr6t
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 23:28:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHVd204vlzDqxW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 22:50:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BHVd10Gfxz9sTK; Thu, 30 Jul 2020 22:50:28 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200727010127.23698-1-oohall@gmail.com>
References: <20200727010127.23698-1-oohall@gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Squash spurious errors due to device
 removal
Message-Id: <159611327088.1601380.3781080553407767826.b4-ty@ellerman.id.au>
Date: Thu, 30 Jul 2020 22:50:28 +1000 (AEST)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 27 Jul 2020 11:01:27 +1000, Oliver O'Halloran wrote:
> For drivers that don't have the error handling callbacks we implement
> recovery by removing the device and re-probing it. This causes the sysfs
> directory for the PCI device to be removed which causes the following
> spurious error to be printed when checking the PE state:
> 
> Breaking 0005:03:00.0...
> ./eeh-basic.sh: line 13: can't open /sys/bus/pci/devices/0005:03:00.0/eeh_pe_state: no such file
> 0005:03:00.0, waited 0/60
> 0005:03:00.0, waited 1/60
> 0005:03:00.0, waited 2/60
> 0005:03:00.0, waited 3/60
> 0005:03:00.0, waited 4/60
> 0005:03:00.0, waited 5/60
> 0005:03:00.0, waited 6/60
> 0005:03:00.0, waited 7/60
> 0005:03:00.0, Recovered after 8 seconds
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: Squash spurious errors due to device removal
      https://git.kernel.org/powerpc/c/5f8cf6475828b600ff6d000e580c961ac839cc61

cheers
