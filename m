Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EFDC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 20:14:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41ADC21841
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 20:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z8CxYuQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ADC21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dM801l53zDqMB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 06:14:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="z8CxYuQt"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dM6H6LCLzDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 06:12:39 +1000 (AEST)
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4851C2084F;
 Mon,  8 Apr 2019 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1554754357;
 bh=g4bO8v2UP3YEdIEgMgrotlGpLG4j0/B5hvlmYf6SHrY=;
 h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
 b=z8CxYuQt05iDTjya+Pt27E5lgJ6Af0nPzpWxY8bXDo/a0MbhwXVEGdtAh9YsBdVjB
 0vPo0Co1epFU9HdmeEU5+XXFNMB/dyreI6DbwlEL6vEfZKlMBlaxT9EEAGpi8tDBPg
 /yeDXN3+hc2a3DzB9WMqmmaJxVchBhUaz94V7J/o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190408102039.6366-2-jonas.gorski@gmail.com>
References: <20190408102039.6366-1-jonas.gorski@gmail.com>
 <20190408102039.6366-2-jonas.gorski@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RFC/RFT 1/6] clk: core: add support for generic big endian
 accesses
To: Jonas Gorski <jonas.gorski@gmail.com>, linux-clk@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <155475435645.20095.12989201302431823558@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date: Mon, 08 Apr 2019 13:12:36 -0700
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
Cc: Michael Turquette <mturquette@baylibre.com>,
 Anatolij Gustschin <agust@denx.de>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Jonas Gorski (2019-04-08 03:20:34)
> Add a generic flag to mark a clock as big endian register based, and add
> accessors following these.

I like the idea of getting rid of clk_readl() and clk_writel(), but I'd
rather see that this flag is per-basic clk type instead of global to all
clks. Mostly because I don't see it as a clk property that's applicable
in general. So we would either have a flag for dividers and gates that
goes into the respective CLK_{GATE,DIVIDER}_* flag space, or some
wrapper functions like:

	clk_gate_register_be()
	clk_divider_register_be()

that passes this information through to the basic clk types somehow.
Then if there's no other user left of clk_readl() and clk_writel() I'd
just slam in a patch to all the files that use it to convert them to
readl() and writel(). After that, it would be great to drop the io.h
include from clk-provider.h and push that include out to any code that's
relying on it implicitly.

