Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E134C169C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:46:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C41E217D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDAZophP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C41E217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xFJf0sjMzDqcV
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 12:46:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=deepa.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDAZophP"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xFGm75RvzDqZW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 12:44:48 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id c9so13846943itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ll6utr+E4KfSWBkxlzzCxCgAe0VO4EUDQW3TXLdDpGY=;
 b=MDAZophPccpEBkwjEu0yNdj8ZjsQxHZoRWnzwamVRcFu8r7Ig0NhQlK0YvmzjRF5QR
 TgcKGXaP4ee1P+S/a0rQ2+7UiyxnPbjp7wIKXUfbI1A+R0bjOHRwHykEAbVrKlZ5XMRy
 lW4dGvuT+IedIGdh5nShDzxnMDdGO0txe51ksvaZbMsLRx23d76MnlG3BBi4Gmn69thl
 xWzvM2aGsPw94MO+MhX6e4G6gJeopOb0pawYb13EVs+xmYELU+XgOdMRl1pmrIiKuJsU
 tlFuRb0FOFESQgKh3xQyw6O3xR2F2JKb17js6wJUSX6C95W2N71tiA5RCxZ2f4L4Gh8H
 cqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ll6utr+E4KfSWBkxlzzCxCgAe0VO4EUDQW3TXLdDpGY=;
 b=hH+TbDFcyItJpylSJN0gYb4UjWH8NuIPkLsv3N0VPqjbYWwb9AlDlJVWJat10SRi4Y
 VxQLzKReOz8MDxHwurh5M3x/Zus/vEIgmaQZiEzYvnkEP4EkctQMcz6F+AiUhZsU6V7I
 RAocuf3HVhK1tQbOcgv1xdpYMs9f+ApY/PjiX3QeyVmRtcNUdti5xleFIwlr3EY3r0wf
 huWZaMzxotg8RmxBRUOFk5NKQ2mIhhySHAMcYa99VVtGE/gN+78SEaIDB48qg2ZFRV0/
 nBiQVIIMxh/5aFHr3PmH21I/sNAXQqM4fUAm+Z50U4JzOHUEqy8niWjQELdTD7Xu/PhI
 BF/w==
X-Gm-Message-State: AHQUAuZmNQ3NvrZjDpjSsk3ixtXBBRyRGoNJ3z/b3E5x+8GyT7PXqemb
 K5oRCwu4i7bMrJQZk+ghc6f27yesCvgiGrBKZr8=
X-Google-Smtp-Source: AHgI3IY6QR0TgFBSRnx7k50PrdwZjR9n6uuI2e6b4PsPo9m4Lv9EuBSpIZeO3O5wiWXMtobd9tOzC4xAVsLdS+zi4Xs=
X-Received: by 2002:a24:955:: with SMTP id 82mr788760itm.58.1549676686827;
 Fri, 08 Feb 2019 17:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
 <87r2clku4j.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2clku4j.fsf@concordia.ellerman.id.au>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 8 Feb 2019 17:44:34 -0800
Message-ID: <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Network Devel Mailing List <netdev@vger.kernel.org>,
 Helge Deller <deller@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
 cluster-devel <cluster-devel@redhat.com>, ccaulfie@redhat.com,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> You touched powerpc in the previous patch but not this one.
>
> That's because we use the asm-generic version I assume.

That is correct.

> Would be good to mention in the change log though to avoid any confusion.

I'm not sure how to do that now. It looks like the series has already
been applied to net-next with a couple of merge conflicts fixed.

-Deepa
