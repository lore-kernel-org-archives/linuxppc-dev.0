Return-Path: <SRS0=UVon=TW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAA6C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 12:17:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DC420675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DC420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458BTH1DYZzDqLT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 22:17:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.46; helo=mail-ot1-f46.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458BRL5qTPzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2019 22:15:25 +1000 (AEST)
Received: by mail-ot1-f46.google.com with SMTP id r10so1843529otd.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2019 05:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=Pkv/6jgF6KGjWcUcgwv8K8nZLWrJis2y2gjD+lKoZAk=;
 b=BKkoZe2jZdWoQED93at4c75MiVSLi/FJD5ngOGCwICXG9Hfc7ynBQeyD8R+OpP3Jb1
 GPHDRmZRlYX3caGLb+XBuXMMyLlMwkt09FpzdMiurwaxFWQ3y/ccmA+VqFFUlZ9OHBNe
 Dwqn7/jnGK/g4uXjFCZvD/s+XEiauyOtHOyDSjbwi8kqd1jxNET1cnALK//xLDFLZMAe
 fy9Vy5VX3LWNvXmlQQZsJX0fTN3bmKzh9gSdx3ZVOka6FgKO8LDkdIOi85u5y+6pDqo2
 EaIPXHWEHd2vKf6yvK4FJl0HBlQ+nzZpAHZLdfvswJwUSv/EjUHbM0lp7ya6+f1sfE/5
 56zQ==
X-Gm-Message-State: APjAAAV19kCgVle24mkDrTHFlAINI+GZSNUU1PGWTD+RvBcYuCr3yAw5
 a+bqOw0ChKWNGYKWsOTYbWGoN5n+5mHuJi+MFPK0IkTT
X-Google-Smtp-Source: APXvYqyAAXKihqe6NlSFyUbPolxVBseGqzjd7Lma+0B9xBvJPUJ/4axFEmdMNt/Y/qgCc7tcgoPICZNRptTRnkmWvJE=
X-Received: by 2002:a9d:1a5:: with SMTP id e34mr26364908ote.59.1558527322408; 
 Wed, 22 May 2019 05:15:22 -0700 (PDT)
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 22 May 2019 14:15:11 +0200
Message-ID: <CA+7wUszwugJeS_x_ExaHPUb8p23D7Zo2f2qqXfLQwr8EiLsk2g@mail.gmail.com>
Subject: Failure to boot G4: dt_headr_start=0x01501000
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

I have not boot my G4 in a while, today using master here is what I see:

done
Setting btext !
W=3D640 H=3D488 LB=3D768 addr=3D0x9c008000
copying OF device tree...
starting device tree allocs at 01401000
otloc_up(00100000, 0013d948)
  trying: 0x01401000
  trying: 0x01501000
 -=E2=80=BA 01501000
  alloc_bottom : 01601000
  alloc_top    : 20000000
  alloc_top_hi : 20000000
  nmo_top      : 20000000
  ram_top      : 20000000
Building dt strings...
Building dt structure...
reserved memory map:
  00d40000 - 006c1000
Device tree strings 0x01502000 -> 0x00000007
Device tree struct 0x01503000 -> 0x00000007
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x001400000
->dt_headr_start=3D0x01501000

Any suggestions before I start a bisect ?

Thanks
