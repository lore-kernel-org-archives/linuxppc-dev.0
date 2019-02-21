Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0156C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 07:14:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F0220838
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 07:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHx++5dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F0220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444m1J701bzDqP0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 18:14:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tHx++5dz"; 
 dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444lzV4wQmzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 18:12:38 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id p19so2475882plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 23:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=JqTYXULdP1KOqMzoQQtvRb8sH3tJ8KBuqHvaGhdSsUI=;
 b=tHx++5dzFlqHV1yo7IG0pTgWbocnx2qBv6eOvMv6Fu62kDXds2b/nZ8S+N9Aw2IBaS
 9cT8qjdVcrrx4dAtn3sSzBKRbaAbXYuwgaQ3MaXxCPpng3mQQ0fADZjgJCvSaHGBoqi5
 eaWfW9RYnDKhJ08Da9XXaaoGshGLiKLVPt9gtn3kUBdCnb6zFMBsAEnsKqfPwVElHZ/j
 wj6WfenUhNe3WFUszLjR0KGQsQelz5UGdeFk1d9ZrFYtKFM3dOPrAWHBfyMpHgNdsRSW
 qe7cVoRzQSGQ+S6EzwvyfWlv6vWf9RbdTtl30Fuk+n7mxMijoHZNAgamu0B8zbSYxUeO
 lOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=JqTYXULdP1KOqMzoQQtvRb8sH3tJ8KBuqHvaGhdSsUI=;
 b=aClirP3KlgU5OQgl2kHnqJrQqMhyaT9AqPGDBbAxBvGw8viReq/FVXVtaxQfYjrLNK
 5lpb3fVaOnhGMdQ5LFu0RwJ+VttPjhar6SOp2RJ7xAKh7IiIRdKovfgVz7eZ7bN4Rl07
 tLu5ndZd8+gQtPz8VuyrB8alBKNMfzw/45loJc3caoOi7L/eD2UIl518KrNzQc5sMrSd
 1ct0frc2q/b7tXZgJHy9sH2KI1wCnRVIr4k/mkh2hpwYcLiicPmidvohpzCsl9ajXN7W
 O+fxX8KJ/3I2df5KnhXVIF49Dcd0bhzjKmQSMPm3PiDkul2whHEMHGRY0AP+A1j/vJbx
 kzMw==
X-Gm-Message-State: AHQUAuZGfuuVObepWEwSDiKvAN0qQC3zFL0PD9xxzC2bp/OpHw0M6YEX
 2uCja1eT45bRGMxfvZ19UyA=
X-Google-Smtp-Source: AHgI3IY5P/cRTRdax23FWjMpgYcn80LUw8SbEqCzONlV5IpIG1KYQt443AQNOdnuNXMEFlk/gcmqRg==
X-Received: by 2002:a17:902:f302:: with SMTP id
 gb2mr16200402plb.51.1550733156342; 
 Wed, 20 Feb 2019 23:12:36 -0800 (PST)
Received: from localhost (115-64-81-26.tpgi.com.au. [115.64.81.26])
 by smtp.gmail.com with ESMTPSA id y21sm34696050pfi.150.2019.02.20.23.12.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 20 Feb 2019 23:12:35 -0800 (PST)
Date: Thu, 21 Feb 2019 17:12:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [powerpc:next-test 77/77]
 arch/powerpc/kernel/exceptions-64s.S:625: Error: Fixed entry overflow
To: kbuild test robot <lkp@intel.com>
References: <201902210123.2SzPFYRQ%fengguang.wu@intel.com>
In-Reply-To: <201902210123.2SzPFYRQ%fengguang.wu@intel.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550733083.htucira1he.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Yeah that's known, just forgot to send out the updated series. Will
do later today.

kbuild test robot's on February 21, 2019 3:40 am:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git=
 next-test
> head:   9a065d2e3633d2f443ec01427265098ebe3a0e1f
> commit: 9a065d2e3633d2f443ec01427265098ebe3a0e1f [77/77] powerpc/64s: Fix=
 data interrupts vs d-side MCE reentrancy
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
=
