Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986CC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 19:27:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE28520700
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n673wRqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE28520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pjP852n8zDr5l
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 06:27:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n673wRqw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="n673wRqw"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pjLS2DcXzF1Qy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 06:25:04 +1100 (AEDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0CFA20825
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 19:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541445896;
 bh=JUwiEmbXq+H4MsWlLFBgjQ1WC+Ur5DvVP/wFVjoTg9k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=n673wRqwHXSw8UDWjGUtVCx8mC+Zf4Vlv+ROSMkeNkmA/daGwN8sCvx/PqXdbqr3B
 idstWz+UFPVhi0AMTtnO30fRV6S6SZ2EsvEcQggMV4re9OHR9rwVeoEmCNFf53yh7g
 UT5Rp6iQ61KfMIiBnx0mGiZq4fqg3jqWXVJYxBew=
Received: by mail-qk1-f172.google.com with SMTP id o125so16886175qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 11:24:55 -0800 (PST)
X-Gm-Message-State: AGRZ1gLtUMM6ycke7qSd1/KzSZ1x9YO3jb/DNE0FfmOSRqMdskgikIPA
 wgFXZTEYNByDhYzboxlGq0IkzHU5n8c0/zev4A==
X-Google-Smtp-Source: AJdET5ebYs1JEHWQ97qMnQxD1a0zK5Q3YTaEGWHQJjd5cz4rULLqoFIA9EMwk7Dq03RcXr0lkO0COFFOALHeG+DQXgQ=
X-Received: by 2002:a37:9201:: with SMTP id
 u1-v6mr20549576qkd.29.1541445883088; 
 Mon, 05 Nov 2018 11:24:43 -0800 (PST)
MIME-Version: 1.0
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 5 Nov 2018 13:24:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
Message-ID: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
To: Frank Rowand <frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 5, 2018 at 9:26 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
>
> The checks revealed bugs in existing code.  Fixed the bugs.
>
> While fixing bugs, noted other issues, which are fixed in
> separate patches.
>
> *****  Powerpc folks: I was not able to test the patches that
> *****  directly impact Powerpc systems that use dynamic
> *****  devicetree.  Please review that code carefully and
> *****  test.  The specific patches are: 03/16, 04/16, 07/16

I'm waiting for this to happen. Send me a pull req when it does or
when you give up waiting for a response.

Rob
