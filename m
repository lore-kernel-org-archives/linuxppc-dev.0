Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3AAC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:25:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606AC218D3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvrFVzgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606AC218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w4xH6rppzDqP2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:25:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w4vZ6hQNzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:24:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LvrFVzgj"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w4vZ5Wklz8tZk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:24:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w4vZ58xxz9sMM; Thu,  7 Feb 2019 15:24:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LvrFVzgj"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w4vY4tVQz9sLw
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 15:24:09 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id z10so3943038pgp.7
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 20:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=BcuaK6GGZ2ucirYuHbx+hf3HZY+32MpxF91MqNG75HM=;
 b=LvrFVzgj674vdzdztkGtGggFdfg1zDROfoUfjgMFIdbZ2rps40fhAH9nsyNSxSsbC2
 /ZxLZhIdr5MkfielMhad5MDPFB07kqV+Svmjd2nrrIWhsK8gF1bnEXEsF8RZKU8W9AU9
 8zZJ4RoqhrXGgH8wiUCdArgwpEFcCzTFlKw+O45sRIsTs0klyMqReW32YAWkM8ig5LXe
 62aryL9KWJwV4bPIUahJZ/9WPXT0IMxqLhTmnN7ZurPnwHWk82bmXE43o7hlVMt047ag
 Vxdz34IoYY8bo1znC9JAjIMfhWxtLd+1PNoEZkzw53KWvOzmwsCJ1v+Hi0p5G3QQi3qZ
 o8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=BcuaK6GGZ2ucirYuHbx+hf3HZY+32MpxF91MqNG75HM=;
 b=XZKivD5FyIYWf40C6QE+sWrYrceMARD/T+cftSd09FQwytOlpM6T/7Bkf8SKO0QIIO
 xsYteijsMXzSle6M1xF0WEaCkLLajh9MCZgt+Sl1cvYfEEIcBbWwJaV3e6TOWc+wj0V3
 uU4KSrdjWN6MlZW5ouF/dFm2Q+9NRBpscUREafng1bdkDgfcaXAMtBHW1mHsUn8D5w5m
 Tzkhg5djglhtAXuyOKJIZ4OVq18Idbhho1nWxUftJZKgXpVA8uRUa8JN5XUpq463bjEQ
 KfWPQ5dOObXdubbPeb3EEGS28Hhwo7U0gd5cIBRFfcZLnP2+inJYE0g8jcFCX7cqqzu2
 fmpg==
X-Gm-Message-State: AHQUAubXNNXxL6zxiiKrtPjdJ68h9/eHa35hVJI1lgtf1lgMAssylp2o
 UXIElXRQA743aoPQd8xSIMMFT4TL
X-Google-Smtp-Source: AHgI3IZ3k5xVqSFV7DVlFvxwNIu4BxMZaj/4ZgiRQGbUIT7KvmvogSHc1m24iZUDpUI+qjyXq3GcoA==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr14412600pfb.66.1549513447794; 
 Wed, 06 Feb 2019 20:24:07 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id z15sm10631635pgc.77.2019.02.06.20.24.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:24:07 -0800 (PST)
Date: Thu, 07 Feb 2019 14:24:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 20/21] powerpc/64: Replace CURRENT_THREAD_INFO with
 PACA_CURRENT_TI
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-21-mpe@ellerman.id.au>
In-Reply-To: <20190205113219.17903-21-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549513370.le8kb4nwk6.astroid@bobo.none>
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

Michael Ellerman's on February 5, 2019 9:32 pm:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> Now that current_thread_info is located at the beginning of 'current'
> task struct, CURRENT_THREAD_INFO macro is not really needed any more.
>=20
> This patch replaces it by loads of the value at PACA_CURRENT_TI(r13).
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> [mpe: Add PACA_CURRENT_TI rather than using PACACURRENT]

Okay. Does it need to be CURRENT_TI not just TI (or THREAD_INFO may be=20
more descriptive)? TI/THREAD_INFO implies the current one I think.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
=
