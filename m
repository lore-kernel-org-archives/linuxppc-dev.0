Return-Path: <SRS0=u8mG=CE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E4C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 14:14:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228D22078D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 14:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpI5KGjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228D22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bc7C85YgWzDqV4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 00:14:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=bpI5KGjz; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bc6ly4ktbzDqTV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2020 23:54:06 +1000 (AEST)
Received: from localhost (unknown [70.37.104.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A842722BF3;
 Wed, 26 Aug 2020 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598450043;
 bh=kU7ge/9mQ72oSrg06PTJXEX3RAeejjof4qtPaDRKe8s=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
 b=bpI5KGjzPsjGUZY+w2ellC84h7zobWVqKQYZbEKfg/4OWpMw1MaD+j/69d8p+S7mq
 EgNpRbzFsmXl4MSKjslWgZyKuVZAh7edsrlCTs/F8yLCtrKTQak1XUKcpDrNTsEEMF
 Y29zhjyhl+Q67NaSXFDnAiAKPkES/BE03imF07+Q=
Date: Wed, 26 Aug 2020 13:54:03 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Do not initiate shutdown when system is
 running on UPS
In-Reply-To: <20200818105424.234108-1-hegdevasant@linux.vnet.ibm.com>
References: <20200818105424.234108-1-hegdevasant@linux.vnet.ibm.com>
Message-Id: <20200826135403.A842722BF3@mail.kernel.org>
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
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 79872e35469b ("powerpc/pseries: All events of EPOW_SYSTEM_SHUTDOWN must initiate shutdown").

The bot has tested the following trees: v5.8.2, v5.7.16, v5.4.59, v4.19.140, v4.14.193, v4.9.232, v4.4.232.

v5.8.2: Build OK!
v5.7.16: Build OK!
v5.4.59: Build OK!
v4.19.140: Build OK!
v4.14.193: Build OK!
v4.9.232: Build OK!
v4.4.232: Failed to apply! Possible dependencies:
    b4af279a7cba ("powerpc/pseries: Limit EPOW reset event warnings")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
