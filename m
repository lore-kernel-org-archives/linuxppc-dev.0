Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D79C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:52:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350802339D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350802339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGD5T2NCbzDrfh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 03:52:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HGX4OqU+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGD3G0RQxzDq97
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2021 03:50:49 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F010D2339D;
 Wed, 13 Jan 2021 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610556647;
 bh=ysD0aOZlpy8PxTCm/xkip8tKV8y+DTQffVf/nrmIYqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HGX4OqU+XgYThqLOmnMF/3SKFuN0/EbxlBo4UN5oYFcdtYGCwM47sBa4DxS0YDdOm
 N+VcE0uKUDDmsT74qp394RYptOKGnTVXI9fGL+gadYFUkx0WpC9JQSm8XaAHly2iUf
 64iFQTLNZmCfx9m0nX6dlEiOpGadbeqI0p+szxpSAb88RCb8IiH0vbDKv55a43Ql94
 AQvZB9A5QalbDNaN8E2bjPqfLBgzi2JhvhIQJ647jNc85SC2igQ/JVS9412B1YP/zw
 JLNynrjaS6/BuUw0Pr2Ol6HEHMUoLPUG+nZ9nXKRlWwaFhGrMOC85rJAXMK9EKDdWQ
 tz69tPbWscC1g==
Date: Wed, 13 Jan 2021 11:50:45 -0500
From: Sasha Levin <sashal@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH for 5.10] powerpc/32s: Fix RTAS machine check with VMAP
 stack
Message-ID: <20210113165045.GR4035784@sasha-vm>
References: <790e46767a5f10ae991969b064682c8c82f96bc3.1610519852.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <790e46767a5f10ae991969b064682c8c82f96bc3.1610519852.git.christophe.leroy@csgroup.eu>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 13, 2021 at 06:40:20AM +0000, Christophe Leroy wrote:
>This is backport for 5.10
>
>(cherry picked from commit 98bf2d3f4970179c702ef64db658e0553bc6ef3a)
>
>When we have VMAP stack, exception prolog 1 sets r1, not r11.
>
>When it is not an RTAS machine check, don't trash r1 because it is
>needed by prolog 1.
>
>Fixes: da7bb43ab9da ("powerpc/32: Fix vmap stack - Properly set r1 before activating MMU")
>Cc: stable@vger.kernel.org # v5.10+
>Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>[mpe: Squash in fixup for RTAS machine check from Christophe]
>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>Link: https://lore.kernel.org/r/bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu

Queued up, thanks!

-- 
Thanks,
Sasha
