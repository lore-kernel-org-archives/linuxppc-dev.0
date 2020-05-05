Return-Path: <SRS0=ZeYp=6T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA3C47256
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 06:13:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26A220721
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 06:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ49l5hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26A220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GTt46CR4zDqQY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 16:13:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sboyd@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=aJ49l5hS; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49GTr94LpczDqMr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 16:11:21 +1000 (AEST)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1722B206A5;
 Tue,  5 May 2020 06:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588659079;
 bh=HaEcQkyLeK+d1XU6QOn1lwuuBRNuVVKmxwhyolHI43s=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=aJ49l5hSTg84/ioZxXIX7Rptkf2Lp4cth2XlZchiP9tE0ZlmQFZ4hHLCbQzG4h17c
 hD172j5i1g6tDaBBDTKanbLxbycbQuSaRdzZ7K3wxvmqb/T3ZF/4DV3f2LzUZNln2S
 I+bazqyL2YHkfDQ6GvLd4vQu8WhYYNMArq8KWgFM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200421083000.16740-2-ykaukab@suse.de>
References: <20200421083000.16740-1-ykaukab@suse.de>
 <20200421083000.16740-2-ykaukab@suse.de>
Subject: Re: [PATCH v2 2/2] clk: qoriq: add cpufreq platform device
From: Stephen Boyd <sboyd@kernel.org>
To: Mian Yousaf Kaukab <ykaukab@suse.de>, andy.tang@nxp.com, leoyang.li@nxp.com,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 shawnguo@kernel.org
Date: Mon, 04 May 2020 23:11:18 -0700
Message-ID: <158865907823.24786.455613165650100774@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
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
Cc: Mian Yousaf Kaukab <ykaukab@suse.de>, viresh.kumar@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Mian Yousaf Kaukab (2020-04-21 01:30:00)
> Add a platform device for qoirq-cpufreq driver for the compatible
> clockgen blocks.
>=20
> Reviewed-by: Yuantian Tang <andy.tang@nxp.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
