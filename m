Return-Path: <SRS0=+cnT=UT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E41C43613
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 07:09:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AC12084A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 07:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYQXMd9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AC12084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TtHC3cSfzDr8v
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 17:09:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dYQXMd9p"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Tqz12q18zDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 15:25:33 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id y72so931835pgd.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=zlU77qurwFBHY4ItXISiY+NZzcjBbiD22X4dtBHNWtU=;
 b=dYQXMd9pHNzHz6HK2pXYsrRhHBwvsP7wJdPtTqX4UcubHVwuffRExKOkpyrHJ5Qx4W
 0hktkH8dgpFWn35KG4U5iMQEvPgXirPaWCN2d5Cy5p8qgIOLY/B/74d+vx15hj0xrrzb
 7pwHLsqTe+G6XqRL7WNcQRXZZbZtn7chXkzPPvGIn5U4UfufxM+jI4dsNcixbgL/RLAe
 6Vei0LuwvqnqlaRTateNDpYgHiEIkd2FXZhysojioH/5uKAP/YIhOxVu62TyAeU2eiUr
 JBViTIvys1+cM3VFgaNXViIefNGz6PUDGXU+Mb5WTT+aaNT4RjS5yadFnG0/URWikP8R
 M6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=zlU77qurwFBHY4ItXISiY+NZzcjBbiD22X4dtBHNWtU=;
 b=PiCZ4h2ZtjO9/MGNhEyHV7rpTDGk6my3wL1t2HOeDhvsImjViLWOuCAz1Oov0gOGKD
 Gn47BjIDJSZy/Y9i/MNzEkBUt7RTjMDBzKTsb77H85iMi+EM4Uo+6ZF1UEqPixPZxgUW
 6D2kiRLcyQJxNg7yGo1XBBx2IMf0Zq2B6X8ABrphlRp8+qm0vi2nW3vOHGSZkooZPC+4
 dpBi6/xKdAuIpO9/oRM8IVdOzAXmULtvXrx5unBD3zkUkIE3kPzyUDfpMjw5ba1Ki/JW
 1hVQgxagTliWJVco1bgY63AIYgwApw7XQRrwsqOcH3+tnixw7my34+5iixNvXAH3Fhn9
 77Vw==
X-Gm-Message-State: APjAAAV6tVYppunmTcGYIf9DZzxVQf5DnaUdtm+CnaQWS1NxGwTWxvBS
 KRLE52qcydvMkKvbaueFXqFtWMn4
X-Google-Smtp-Source: APXvYqwGlNIh3qGSCHGTDNRkebDfOHC9wPc4sz46s7V/6RQiPr6YS1ATNPfWQ2H4D+vJDveyDEuVjQ==
X-Received: by 2002:a63:c44f:: with SMTP id m15mr11085798pgg.34.1561008330349; 
 Wed, 19 Jun 2019 22:25:30 -0700 (PDT)
Received: from localhost (193-116-72-140.tpgi.com.au. [193.116.72.140])
 by smtp.gmail.com with ESMTPSA id s24sm20437852pfh.133.2019.06.19.22.25.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 22:25:29 -0700 (PDT)
Date: Thu, 20 Jun 2019 15:25:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] ocxl: Allow contexts to be attached with a NULL mm
To: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190620041203.12274-1-alastair@au1.ibm.com>
In-Reply-To: <20190620041203.12274-1-alastair@au1.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1561008239.9nxgz9ee3u.astroid@bobo.none>
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alastair D'Silva's on June 20, 2019 2:12 pm:
> From: Alastair D'Silva <alastair@d-silva.org>
>=20
> If an OpenCAPI context is to be used directly by a kernel driver, there
> may not be a suitable mm to use.
>=20
> The patch makes the mm parameter to ocxl_context_attach optional.
>=20
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Yeah I don't think you need to manage a kernel context explicitly
because it will always be flushed with tlbie, comment helps. For
the powerpc/mm bit,

Acked-by: Nicholas Piggin <npiggin@gmail.com>

=
