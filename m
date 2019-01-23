Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F7C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:32:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D1220870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4ZuomQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D1220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kz7Y1psyzDqQL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:32:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kz5j4GqszDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:31:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H4ZuomQL"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43kz5j3RKSz8tP4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:31:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43kz5j3FJ0z9s9h; Wed, 23 Jan 2019 19:31:21 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H4ZuomQL"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43kz5h6qHXz9s3q
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 19:31:20 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id t13so724372pgr.11
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 00:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=kKTn4tyCZB4T73oukdtK47IP8YeKEokyHeZJLtA2Rgc=;
 b=H4ZuomQLhJSfXv80lIArYg1zQXupEiMGUm8DHvBejMCyfJcB0Xb+GiPy8+QEzQv1s9
 GfdMhLWEoQHE6aIGGe7sZNC+6KfOuoJ0eYCBuYj0XgjRfD1CztNgLr7OEQKGbVbyhkW3
 K7NrrxE4wwgLSSMwZoPyoMiQAP0vxHAa3N8Cq1E5bwW0k6NIGrs3AxHkL63SMcQCI1vJ
 cF7VL488F98aekja+7FZFeKOrQze+sfvwPdArJO60aQzyueW5xN3Bk0K67E8s8RQsSm8
 jDC+JdsImusHXAv9U5q7A2hbQhejS/Ub52A9n3B8ZlvhI9B7k4WLvIzQ2ZuzUgt6QTOG
 HheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=kKTn4tyCZB4T73oukdtK47IP8YeKEokyHeZJLtA2Rgc=;
 b=n3reRbrbpdal5mnnLRKGO3DvMtNGpcLZybdMifd+feUjDi8FC0skhBGHiH3WsBkVhi
 S3LyAybrw8HMK91MrKhOyHUG3tCkA2P8cVay91dJ3IVgov05HEYNy5s9JsmFQQv2PbSY
 NVDIe7FVO6aKMN+McdCBYpercVQeHeUsreUYtItjGrW6ua2OV9Yox3YKUtSDXIJLe1I/
 CqdXmMvdkbBbBBX8EnTLdiQqp3iMuAuELZXQRVipHZJ8thUX+Xk/nxq12aRINzynJZq5
 8DiP12D4FJudSJ9FyDXfBNrgJFZSJfQzfOlMv095TSdtS9O8VGAHm3pc132YsM1I+mn3
 oHqA==
X-Gm-Message-State: AJcUukdpk1mK8jAhKkZvWfqMSQk/CQsicmoUPRPVO1BKo7JE9z2MdG5C
 Kz9uZ5fapZ+666XSU0LGg04AwEevbbA=
X-Google-Smtp-Source: ALg8bN4jVbrrx232Hw/bt+qnAcwcGG3mSgPoe2L4I6T6c6jaNl8gfq0GXSo/UBRcGUHd8w6EkbgcKg==
X-Received: by 2002:a62:7042:: with SMTP id l63mr1298827pfc.89.1548232279183; 
 Wed, 23 Jan 2019 00:31:19 -0800 (PST)
Received: from localhost (193-116-78-72.tpgi.com.au. [193.116.78.72])
 by smtp.gmail.com with ESMTPSA id l5sm29034078pgu.86.2019.01.23.00.31.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 00:31:18 -0800 (PST)
Date: Wed, 23 Jan 2019 18:31:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Remove MSR_RI optimisation in
 system_call_exit()
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190117113510.4265-1-mpe@ellerman.id.au>
In-Reply-To: <20190117113510.4265-1-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1548232157.y0q1xpn4sp.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on January 17, 2019 9:35 pm:
> Currently in system_call_exit() we have an optimisation where we
> disable MSR_RI (recoverable interrupt) and MSR_EE (external interrupt
> enable) in a single mtmsrd instruction.
>=20
> Unfortunately this will no longer work with THREAD_INFO_IN_TASK,
> because then the load of TI_FLAGS might fault and faulting with MSR_RI
> clear is treated as an unrecoverable exception which leads to a
> panic().
>=20
> So change the code to only clear MSR_EE prior to loading TI_FLAGS,
> leaving the clear of MSR_RI until later. We have some latitude in
> where do the clear of MSR_RI. A bit of experimentation has shown that
> this location gives the least slow down.
>=20
> This still causes a noticeable slow down in our null_syscall
> performance. On a Power9 DD2.2:
>=20
>   Before        After         Delta     Delta %
>   955 cycles    999 cycles    -44	-4.6%
>=20
> On the plus side this does simplify the code somewhat, because we
> don't have to reenable MSR_RI on the restore_math() or
> syscall_exit_work() paths which was necessitated previously by the
> optimisation.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

But only because spectre and meltdown broke my spirit.

=
