Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D180BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:39:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC8C204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtoKDihI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC8C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KBHt4zvhzDqKT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 23:39:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=omosnacek@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtoKDihI"; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KBFc2WvvzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 23:37:51 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id y18so1357101lfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=CdYfUfttsF/kySMHWgoDShevDsGvHaOxDNgj07I8HEc=;
 b=OtoKDihId7zj6hePTz9cJkfEJLrZdwGeXZvSlkOgp7wMslBc7cdxiM9G5Hvj6V46Nk
 lGDg62OhjeKE50hklQXqWtBldJhGHU+j9tY5A1jJ2LY53Tskj/j7PGGIHNvKEpMK8QtL
 O4nQLcUaLzZHnu1sDH6EhsLwwcXPDt6SyXf3H2ZBi4bp1tx355ENxA6QK23kRkNaVr7p
 QTT/jPIALns5DtpCdzv5cALfNoS+3/QHrE89aPKh20PbThH0FDeUF2HASmu9Cm6LO+q9
 VbImadloR5FznH78WT7u/5gmGomRh7Lh7iuJydavicLpeqFwK7aojTUOkCOaMeVqMws/
 pMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=CdYfUfttsF/kySMHWgoDShevDsGvHaOxDNgj07I8HEc=;
 b=aK7PX+ZcIWE3qKgcH+dqcgzzQNJL13ga1FWhuyDqBeue/icZQQ5HGMQcDYzaoiovgs
 RR5r95sXBwqIGmVJ4AuCROpWDJNltGrqjN6aI6uQdg7aLtmw5o85pWS183sss+1z/WDg
 g4AT7DmrSYiKD5qB8PQyphfaq6ZXtewmYL38vXK8cJSsWiyrYQjoRPmTI7LLHzGp5A/x
 3leKXWyOLw67cNSGzDE9vfyB+uVzhk4+hYcWTiVmHY5HAud76AbtRRLTGXJ7cNwuFuZo
 92DN32mOpjdYx/I/wec1X7am0T/XW/6JFDu3QkLM0aQnYXDTHcm4IbRQ/GEWZglII5zM
 iDwA==
X-Gm-Message-State: APjAAAXk2/AiFXp5dcSuOXTnebt2OzQHoAHlrey5Dvy7etlslOvG1wUK
 kzfsj011D3YNZDw0ZqsL6f9UmFQvzAFgbNvDDrc=
X-Google-Smtp-Source: APXvYqxuChVgXckB6598UiGr0KDlGQ2kznb8aJV2vk9rPcqc/QTO0cNWhMyXL86C3HpYG+S/aPme3UjGUulqZvLOnws=
X-Received: by 2002:ac2:5542:: with SMTP id l2mr21398076lfk.136.1552480665706; 
 Wed, 13 Mar 2019 05:37:45 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Wed, 13 Mar 2019 13:37:34 +0100
Message-ID: <CAAUqJDtsx6Sdv=6xAb1VWWjDF08y8wh2nsAypR8_x_e99a1Uwg@mail.gmail.com>
Subject: BUG: p8_aes_ctr randomly returns wrong results
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
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
Cc: marcelo.cerri@canonical.com, Stephan Mueller <smueller@chronox.de>,
 leo.barbosa@canonical.com, linuxppc-dev@lists.ozlabs.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

FYI, the p8_aes_ctr crypto driver (drivers/crypto/vmx/aes_ctr.c) seems
to be seriously broken. When I do repeated encryption using libkcapi
multiple times in a row, I sometimes get a wrong result. This happens
more often with long messages (e.g. at 16 KiB it already happens very
frequently).

To reproduce:
1. Install or locally build libkcapi [1] (you will need the kcapi-enc
binary in PATH) on a ppc64le system.
2. Run the following in bash:
for i in {1..100}; do head -c $((16*1024)) /dev/zero | kcapi-enc -e -c
'ctr(aes)' -p test -s test --pbkdfiter 1 2>/dev/null | sha256sum; done
| sort -u

Expected result:
All invocations produce output with identical checksum.

Actual result:
Multiple different checksums are produced.

When I run 'rmmod vmx_crypto' before running the reproducer, I get
only one (correct) checksum, so this is definitely a bug in the
driver. Other ciphers (cbc(aes), xts(aes)) are not affected, even
though the glue code is very similar. That leads me to believe the
problem is somewhere in the assembly code.

[1] http://github.com/smuellerDD/libkcapi

Cheers,
Ondrej
