Return-Path: <SRS0=iKE2=CL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B811C433E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 04:53:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7A42075D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 04:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="DTR+woOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7A42075D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BhBQk6lgrzDqLS
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BhBNX1yHFzDqcJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 14:51:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=DTR+woOO; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4BhBNW4Sxsz9sV8; Wed,  2 Sep 2020 14:51:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1599022283; bh=WOfp9otDnweaCa9QqM2OIoG8iDSDoTlcwj+EuEhBVJA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DTR+woOO6qeYDsljobUQVGIbaihDCn3rXPf03LnF7I6kLqQhgbaMpLTeQ07etO+c5
 xwZ67OX3DnhiFTAEQwIUQdLGKkFbf9xj4HGPbZl6RdlOrL7gpXntDESOju2lESBUdC
 aGv0ZsYaPG3y1E3dKV47QPQe79W26HvGEhs977pmdWQOfcRXS1yyg0yIQ/qFjATM7d
 TkXtzQyKya6L3YWtB1VOLoOFaGD8KOED50c1V1ps4UETTC8BooW5uZYnI3wHZrlJ8M
 QO5+R5GfyNTFzk7NRVkMM94NZdgZoSHl6M0lf8GZ4tJMBtRK4qCPXEI7WtewThoGTz
 NdJMOilWIYc2A==
Date: Wed, 2 Sep 2020 14:51:18 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] powerpc: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200902045118.GD272502@thinks.paulus.ozlabs.org>
References: <20200716090712.14375-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090712.14375-1-miaoqinglang@huawei.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 16, 2020 at 05:07:12PM +0800, Qinglang Miao wrote:
> From: Chen Huang <chenhuang5@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>

For the arch/powerpc/kvm part:

Acked-by: Paul Mackerras <paulus@ozlabs.org>

I expect Michael Ellerman will take the patch through his tree.

Paul.
