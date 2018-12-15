Return-Path: <SRS0=/PaX=OY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=BODY_SINGLE_WORD,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B57C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 08:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00251206A2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 08:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzkyc5Eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00251206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43H11Q3mcvzDr8R
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 19:34:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="uzkyc5Eu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d2f; helo=mail-io1-xd2f.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uzkyc5Eu"; 
 dkim-atps=neutral
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43H0yd5JKRzDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 19:32:09 +1100 (AEDT)
Received: by mail-io1-xd2f.google.com with SMTP id o13so2863009iom.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 00:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
 b=uzkyc5EuxmUYSHlpsKLitWrK4CjcSAbt43UQVGiUc6w6BJsbqYk0iAPY0Qu8V+u6up
 AgUiXsAwBS2EQiVZD5PznGPE7BwQbNjKJACH3FzPUtGqsgf233HyepU5PEEqk1kqjyym
 fW9j1NC66K6p8BT4mCvD14TOlJlVwbmoWxSGcFDrrFS3iqadRAmgaGFtJSmi/PacJDFu
 yrew67hNxS5Tq+j+Sg2qHGsVqiCU1UIIIAjkCdFqu8Xb+5t3pzJYPOnIWffkeFvIvqk1
 S4OEFVdTWrZK0aS8H+xqV0rMCSNmetLVESvFgA5On8DdMYBNcyFnYhj30xHDyv1va3wS
 Unbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
 b=LH5RzUBLfVye6rLZg/kt73tdTJ2rE1rmdzzRVHnJefZrIAUnB2y0BFWaBTzA9l1gmR
 WSz2wtXDskBavME257+B89y4AUM9Zlk/icmG5SeZC7u9OyIuFHQsQbL0oUBoDAlIHEZ5
 47tSv4gFs2hdBC48xQdDA4nlvkZwTS23ObURQTKuF2HX5WOyuuKN0HqmKdAr6wj5mcxy
 S9AteCdNYBaEKBa/VYNM+DUUtqFRt3xFyBspoJNaaz4ynqTFBBEQxoHOcy4Zu/gPg3f0
 0mmx958faWCwwF3ToD1Ek7EpAe5WefSeN8tbxQDZGFB4F3hYBsY7N+q3EjaeW12r7Ns5
 TYNw==
X-Gm-Message-State: AA+aEWYTG3pcjnX46okr2f7g6IbTiByyTKO033xsv7+nAWU8B3PLAZX3
 ZE/aAZpzar4XAut7GHR4h9xJBrHbu5ROmGLYoK0=
X-Google-Smtp-Source: AFSGD/WE50kMJeazQCzsdVor4W+XkrOkACmhkn1khozXMuCp/7+UhX026s3sQ2as3o4b7axjLIcMn5wKA3dcpE7Xeyg=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr5261914iod.40.1544862727047; 
 Sat, 15 Dec 2018 00:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20181105144717.6233-1-tiny.windzz@gmail.com>
In-Reply-To: <20181105144717.6233-1-tiny.windzz@gmail.com>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Sat, 15 Dec 2018 16:31:56 +0800
Message-ID: <CAEExFWvoF+Rj43emhQQ7NpAXY_A_w0wTTNMjQ2JeHmYrBU0Y0w@mail.gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To: paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ping...
