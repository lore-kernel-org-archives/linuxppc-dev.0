Return-Path: <SRS0=iUs8=TI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3416FC004C9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2019 00:27:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCF4205ED
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2019 00:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1PFYvwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCF4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44zHNq3Q3zzDqNX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2019 10:27:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44zHMP3p2xzDqLn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2019 10:26:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="R1PFYvwt"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44zHMP0M1Sz8t9K
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2019 10:26:09 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44zHMN4Xtkz9s4V; Wed,  8 May 2019 10:26:08 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="R1PFYvwt"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44zHMM4jqxz9s00
 for <linuxppc-dev@ozlabs.org>; Wed,  8 May 2019 10:26:07 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id a5so4044297pls.12
 for <linuxppc-dev@ozlabs.org>; Tue, 07 May 2019 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=kvOyCdiEJO64YDtcCeq/xW+FPoCF7P+PRplhKTkwBRE=;
 b=R1PFYvwtam8LWNQx1YbJpSQ4UBNRjqYbvXaAjD1OGGJyirthYKgpJosiSHhqM2ou8u
 Nmt86zdfBFs0FJH8p1bGpjzGhBebD7NNGj9czbgBOmlfXJwpB5J/7AAJcNVRf28OemzB
 GL9SyBghYr4om/n1yM8eLQUjuY7wt9oBPEcIXqBGVcZZJ5r77MRWDIMyLILvuNaXydFa
 pbkOIDd76zHU0gy8QMTOnbrXB4jVikt0xOfM41RpT4qSbZr3Fw+ZU/mgBH0zjFmybDOs
 EH4fyRITMsDC2C6LO0MFauSXCguzQvO/c0KCawEaIXnwHHITg9IkkUvf8mr7sryeF+uW
 FtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=kvOyCdiEJO64YDtcCeq/xW+FPoCF7P+PRplhKTkwBRE=;
 b=oNLv6JiA1bQsA40Wp7nhP8BpTc3MvSUa0qJDarSyrU6lZ1JL1G019UItUq1WEdF63d
 SuecW2RyXye93dTtJFL6P9XNMiewrLIwc3LRepnWnQlqJtATbDTxLaC9L0K1K47YYZoL
 LQOVkoJF6ZhR9daY3KdvNRyCw9OgmaHAdN+lzJC2nuKbdnT8mcROBEzQccmW2aaZhdEF
 Bm4mvwzetwayBbeE3SafD1CfL6xE3dfwWNy24Zf6/hVPJn0zZwsTMiVF/RxHFbTCQTDb
 5HLT1X3fDI98oy2Awfg+jqqQB+9D7LMgXfQJRkOHVBe/6mRW2/jpFZaqhFEmiNFeZD8C
 PRbg==
X-Gm-Message-State: APjAAAUqu+1p1CCsGcUhIIckqgyXYpgsZ4ea+EJ3KNArO3/13gSybXaL
 4Y4IKDyPmfbIwyROMHMVOSw=
X-Google-Smtp-Source: APXvYqy5KW0OrY/D+P9rRmAFGC3vsX7gMAD3LmwrRz1eEjt7/IaAr7/7rzQEZ4zdwrdGQxLQ+hSPFQ==
X-Received: by 2002:a17:902:441:: with SMTP id
 59mr43802550ple.242.1557275164092; 
 Tue, 07 May 2019 17:26:04 -0700 (PDT)
Received: from localhost ([203.63.161.72])
 by smtp.gmail.com with ESMTPSA id a129sm18311191pfa.152.2019.05.07.17.26.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 07 May 2019 17:26:03 -0700 (PDT)
Date: Wed, 08 May 2019 10:25:55 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 12/16] powerpc/powernv: export /proc/opalcore for
 analysing opal crashes
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
References: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
 <155541094306.812.15406965699701118702.stgit@hbathini.in.ibm.com>
In-Reply-To: <155541094306.812.15406965699701118702.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1557274986.rnb0tqdbuc.astroid@bobo.none>
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 Stewart Smith <stewart@linux.ibm.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hari Bathini's on April 16, 2019 8:35 pm:
> From: Hari Bathini <hbathini@linux.vnet.ibm.com>
>=20
> Export /proc/opalcore file to analyze opal crashes. Since opalcore can
> be generated independent of CONFIG_FA_DUMP support in kernel, add this
> support under a new kernel config option CONFIG_OPAL_CORE. Also, avoid
> code duplication by moving common code used for processing the register
> state data to export /proc/vmcore and/or /proc/opalcore file(s).

Can this go in /sys/firmware/opal/core or similar?

Thanks,
Nick

=
