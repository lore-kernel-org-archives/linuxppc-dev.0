Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85038C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:28:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33BE20657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33BE20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fG3N4s2szDqZ2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 03:28:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fG1T2d6dzDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:26:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fG1T19J6z8tP4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:26:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fG1T0p4dz9sDB; Wed, 16 Jan 2019 03:26:21 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fG1S3jxRz9sCs
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 03:26:20 +1100 (AEDT)
Received: by mail-qk1-f196.google.com with SMTP id 68so1869681qke.9
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2019 08:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qknWprULXS5ZMwGB0JvJF1uclh+H3nN6M8i/psXlFeA=;
 b=l5q/z9M+KXCl9EoJ2EEDItyCsLS4NcPeGLtxyZWQJyi+43sD28M3VDyNRfL/z7U2jq
 xO3g1Hd3py+TGtSPmpKfSpNIR/JXKzhd4b+gnz9PiW8MaMO+DfPrB1/ka3jVkyTETq5x
 Kl2H79rHKOvLIy3/4WXHTFPEFc6anPgO97rmvweFPu17a3oSPB/OFLjJC+QXa5Jq0k2s
 mWg6AGZvH3azQ/aaOJg6DyZkmKl1H52wxEn4hKfJu+jWZ7u31B2YWJVuSchHt3XCLwJc
 D0mBKEACPlqFjyznmyZBpQHYY1wNSaClk6wbNC+S8uQWeZ2D2KfI0ZCIqGlUd/I1g9Zf
 WFwQ==
X-Gm-Message-State: AJcUukdw+FWPgUn2Un16+scbkW9utHqlrtQt+VYLvjVIdj3M1WgVZJhi
 bgelQQzXtTOYuNob87ug1LwhaJVJByEBBWHkYDM=
X-Google-Smtp-Source: ALg8bN4zybYKxyH+DrcgWeo/ohf4dk/XQCRL+WsQTAxvnmIetN0Vtfw1Xo80aQHB2fvkqko5KIJwPEo/EGtTLa9XxO8=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr3287869qkf.330.1547569578404; 
 Tue, 15 Jan 2019 08:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20190114113620.17558-1-mpe@ellerman.id.au>
 <20190114113620.17558-5-mpe@ellerman.id.au>
In-Reply-To: <20190114113620.17558-5-mpe@ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 17:26:01 +0100
Message-ID: <CAK8P3a0vX9akQvhApqzLxh8zNFjCUj7kH1uTZmRder=X_sspkA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] powerpc/syscalls: Use the number when building
 SPU syscall table
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
Cc: linuxppc-dev@ozlabs.org, Firoz Khan <firoz.khan@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 14, 2019 at 12:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Currently the macro that inserts entries into the SPU syscall table
> doesn't actually use the "nr" (syscall number) parameter.
>
> This does work, but it relies on the exact right number of syscall
> entries being emitted in order for the syscal numbers to line up with
> the array entries. If for example we had two entries with the same
> syscall number we wouldn't get an error, it would just cause all
> subsequent syscalls to be off by one in the spu_syscall_table.
>
> So instead change the macro to assign to the specific entry of the
> array, meaning any numbering overlap will be caught by the compiler.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
