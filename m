Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F54AC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:37:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99959206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eVAFhku/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99959206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lTs42xp1zDqTM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 05:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=matthewgarrett@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="eVAFhku/"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lTqL5BvXzDqS8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 05:35:51 +1000 (AEST)
Received: by mail-it1-x142.google.com with SMTP id a190so5090274ite.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mRy99qz2AMkYVZFv425R2doBAop8CHsZxNlVLtfW3eQ=;
 b=eVAFhku/XdVgMCLGF1pWwGePMOzh4kN+765FPgQ5wWCskNuETlJ/ljtK04DZ8DAMYA
 6KirlgWILO8UcOP7+VAIZfQY9YhW+mMFNpgTqK/s89RNKQNChTyEsMd5znxj6hEuLrDF
 F+LGCwhNW0tI+wknP6IPzs1pf5uJv4qR3elhxX+g4+NxUhKPVjc3+4GA7cPWKPaj0TFy
 l/WBggm3UjrrQI21FfbCJQWzBnfMvL8/xYW7aRcgkJK/CiH4WRIefhST2cUZ75EJXuM7
 x2MmFIi/peTST374MP6ex5Ys97JTlVh5hzQhWqhtH9IPGYcZMTZvdDEovy2VgyFVtyri
 Tn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mRy99qz2AMkYVZFv425R2doBAop8CHsZxNlVLtfW3eQ=;
 b=hXrP3DEop32uxQc+jIm29OMG5jmZUWcy3UMC2RLwzj7WVnedWnF5PrIUD7XV5Ru7D7
 +BAVFh/rSvOIyxlAObz2Q1tEyhli7BZ5WI3ZzCIO2SnPSRMhRQ7hqUHxEJ7g9FWIVFqh
 En2NHbQR7sd4L7/WrqBVZLFvMDmepQRysEgaGnQj/wIdC13KbrmI9fgL8lTkSP8fxy4u
 FKmEwkrMJPT/PZXj8KL+jLeZUn+oggkanzQIM8yrJAsCk2IaAqy5S1yDf0aVkNMHnG1m
 7qKVl3iMa6UdTGZGEEAwb9U5GDwzY7IWHRx4YC/qT0Ei2U+ml9CAGqfXc/LAxL/G5HYP
 ZJJg==
X-Gm-Message-State: APjAAAUOjXSIC1AEpWJla8dqHP6VNIfDbkSm1skb4yiJmencolaKznAG
 1sbL6ld4XY517Qq/Pa4lwL91PW6B6yQrE8BCVcNAtw==
X-Google-Smtp-Source: APXvYqyScEeuSVEoRXwlwqC9hN5nB+zKXCchKqADZb8Nc3q9sc3gR9XiN4iPfEkmpvi69xHp7KmFjOENqmEZBNnhlLU=
X-Received: by 2002:a02:b38f:: with SMTP id p15mr9719050jan.103.1555616147577; 
 Thu, 18 Apr 2019 12:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-2-matthewgarrett@google.com>
 <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
In-Reply-To: <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 18 Apr 2019 12:35:36 -0700
Message-ID: <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
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
Cc: Linux API <linux-api@vger.kernel.org>, cmr <cmr@informatik.wtf>,
 James Morris <jmorris@namei.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 1:40 AM Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> I'm thinking about whether we should lock down the powerpc xmon debug
> monitor - intuitively, I think the answer is yes if for no other reason
> than Least Astonishment, when lockdown is enabled you probably don't
> expect xmon to keep letting you access kernel memory.

The original patchset contained a sysrq hotkey to allow physically
present users to disable lockdown, so I'm not super concerned about
this case - I could definitely be convinced otherwise, though.
