Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C4EC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:08:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DB02145D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xRR8mflJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DB02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PGdT4hPxzF3B0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:08:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="xRR8mflJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="xRR8mflJ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PGXW2R4nzF3C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 08:04:27 +1000 (AEST)
Received: from localhost (unknown [104.132.0.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2CC24208AE;
 Mon,  1 Oct 2018 22:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538431465;
 bh=M4QEb9IYP+zC+lYJRAvAGqQYMArbTPHgExz5fEfwnq8=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=xRR8mflJ9iFaqVEtI5e0MYWDHWMhR3g5tUX5YM0UH7xGl6YewUS0i88xLL1fF7aGg
 QZNjVp6/9wbixD2+ukqAuQIk5Q68jmjrUKfnuvajfTi3oiK0g7KSy8OSPtCNuW7M1Z
 ZYMAe9OxDhqf8s27NRVRCHwDEGg4Yjv3QF9Re7Pc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Vabhav Sharma <vabhav.sharma@nxp.com>, arnd@arndb.de,
 catalin.marinas@arm.com, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com, mturquette@baylibre.com, 
 oss@buserror.net, rjw@rjwysocki.net, robh+dt@kernel.org,
 sudeep.holla@arm.com, viresh.kumar@linaro.org, will.deacon@arm.com,
 yamada.masahiro@socionext.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153843146463.119890.6551025813220021124@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 4/6] drivers: clk-qoriq: Add clockgen support for
 lx2160a
Date: Mon, 01 Oct 2018 15:04:24 -0700
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
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Tang Yuantian <andy.tang@nxp.com>,
 udit.kumar@nxp.com, linux@armlinux.org.uk, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Same subject comment.

Quoting Vabhav Sharma (2018-09-23 17:08:59)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Add clockgen support for lx2160a.
