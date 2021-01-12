Return-Path: <SRS0=j7bs=GP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BFFC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 12:34:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFF92222B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 12:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFF92222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFVQB0sjPzDr4D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 23:34:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=vkoul@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rz8SebBY; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFVLB42TBzDqyg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2021 23:31:13 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D25421D93;
 Tue, 12 Jan 2021 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610454670;
 bh=EptgfiHYt6xGNsbmNtRX9LOhlDhS7JjIKitMyr9pz1U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rz8SebBY2hyY6tSaQrcbqEsiBzn1EKAhAK4cQ+pVHn/zT2Q2Ui+OqCztY6/aw5mZ/
 ZXvIwNXq/fhrH2A1Jd6oj8mBbe9VzaPoue/fixkHEEG67C1PPJ26nXrAkV63fXhRq1
 11EGaPLBAGxyezGWYkXR3l4AMEPH+iemdXaEDFXLrWdeESvUoQ8q/XlRjGO5M+p+Vx
 8Jfbr5q0NywitAdQnUoMSHQ4T4KKnDGSPgsivxkHH+06jxjF0ufLmnRrzLk4OQYpR8
 T2GHrCZVz/Yog5uWOkCc9XTG9JkN/uLvccgGVFRwcS0zKSyr24fZ5P7C9nVb+2yRgK
 WnND0THzJXZfw==
Date: Tue, 12 Jan 2021 18:00:57 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/2] dmaengine: fsldma: Fix a resource leak in the remove
 function
Message-ID: <20210112123057.GS2771@vkoul-mobl>
References: <20201212160516.92515-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212160516.92515-1-christophe.jaillet@wanadoo.fr>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, zw@zh-kernel.org, dmaengine@vger.kernel.org,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org, timur@freescale.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12-12-20, 17:05, Christophe JAILLET wrote:
> A 'irq_dispose_mapping()' call is missing in the remove function.
> Add it.
> 
> This is needed to undo the 'irq_of_parse_and_map() call from the probe
> function and already part of the error handling path of the probe function.
> 
> It was added in the probe function only in commit d3f620b2c4fe ("fsldma:
> simplify IRQ probing and handling")

Applied both, thanks

-- 
~Vinod
