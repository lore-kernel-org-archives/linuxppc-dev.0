Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07028C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 22:47:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751CB21471
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 22:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="othPYRTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751CB21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZVmz1MpYzF3WS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 09:47:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="othPYRTU";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="othPYRTU"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZVkK4J5czF3Jb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 09:44:57 +1100 (AEDT)
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A34D21471;
 Tue, 16 Oct 2018 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539729895;
 bh=4VMf37uMjdp3mBF5xj0gUz66OpGyptXJbWGuzkeKgYA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=othPYRTUZ+cv9mZRzBCK+b/q8FB3zn37Qy7IlKp+zA80jc/Mdug6agHwCUX8ylkJk
 o15JZeO7XAp59VFPyuNJCjmLn98l8W8TIpNPHTCWPLA/cTktGGOSDJLp7MNkwmftpH
 pr7+10LF7zQjksSVLtJrV7JOLzLW12FD0eRtUqCg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Vabhav Sharma <vabhav.sharma@nxp.com>, arnd@arndb.de,
 catalin.marinas@arm.com, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mark.rutland@arm.com, mturquette@baylibre.com, oss@buserror.net,
 rjw@rjwysocki.net, robh+dt@kernel.org, shawnguo@kernel.org,
 sudeep.holla@arm.com, viresh.kumar@linaro.org, will.deacon@arm.com,
 yamada.masahiro@socionext.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153972989460.5275.12653601090217013634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 3/6] clk: qoriq: increase array size of cmux_to_group
Date: Tue, 16 Oct 2018 15:44:54 -0700
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
Cc: ulf.hansson@linaro.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 udit.kumar@nxp.com, pankaj.bansal@nxp.com, linux@armlinux.org.uk,
 adrian.hunter@intel.com, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Vabhav Sharma (2018-10-14 10:08:00)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Increase size of cmux_to_group array, to accomdate entry of
> -1 termination.
> =

> Added -1, terminated, entry for 4080_cmux_grpX.
> =

> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

