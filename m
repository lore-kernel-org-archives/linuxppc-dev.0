Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B57C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 13:15:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D406420867
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 13:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y6knBWlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D406420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435vyK057jzDrdS
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 00:15:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="y6knBWlH";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="y6knBWlH"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435vvX3Rd5zDrGp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 00:12:56 +1100 (AEDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC8FF20867
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543583574;
 bh=LXwXqLekSeNAZZYD2UxBeDpBGkbH4NpD6saLxwjH27s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=y6knBWlHelfxJxrpmYMHuzx4w8Ug/Hvfjd/o69wct6dWsN6kZZ2h3xydmXVrQaXI+
 N5uYdApXRmeP8MMWHVIqkLn781OTJsAvAs9BZM+bBtPh7Ah5t2hw80JywSmpH6o7CU
 UftSg4veCArRhN8yrAmrkCBUeIH9yroV6SyHyMog=
Received: by mail-qt1-f171.google.com with SMTP id n32so5778944qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 05:12:53 -0800 (PST)
X-Gm-Message-State: AA+aEWYertoxjgBNT8nfcpBDSdFcs7EKCKInNPdPpzovubU4EYcv4Vs2
 V5fwEedSsGQmo2p3gGB7qFYKOof/QU4U2fbzyw==
X-Google-Smtp-Source: AFSGD/XSZ7yhkV2R10ZCm7C929Bp1RbmeObJRY3I/JQCKC7Vksebx2luJxMwEXyU8xV/++fYeyY0gA3C4RKrP8ZfB0I=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr4550459qtj.76.1543583573152; 
 Fri, 30 Nov 2018 05:12:53 -0800 (PST)
MIME-Version: 1.0
References: <d3aa7c5adee1e3cedeb65661545c82d30faafc8f.camel@kernel.crashing.org>
In-Reply-To: <d3aa7c5adee1e3cedeb65661545c82d30faafc8f.camel@kernel.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Nov 2018 07:12:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1A+mscejj9T00isK4O0U9b2jbf56PYFPegezd9uJadQ@mail.gmail.com>
Message-ID: <CAL_JsqJ1A+mscejj9T00isK4O0U9b2jbf56PYFPegezd9uJadQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Look for "stdout-path" when setting up legacy
 consoles
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 29, 2018 at 9:54 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Commit 78e5dfea8 "powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'"
> broke the default console on a number of embedded PowerPC systems, because it
> failed to also update the code in arch/powerpc/kernel/legacy_serial.c to
> look for that property in addition to the old one.
>
> This fixes it.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 78e5dfea8 powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'

Reviewed-by: Rob Herring <robh@kernel.org>
