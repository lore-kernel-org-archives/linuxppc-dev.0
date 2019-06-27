Return-Path: <SRS0=L8Yn=U2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60572C48BD6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 01:13:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B32220B1F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 01:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJuiI6dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B32220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Z22M34jmzDqWX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 11:12:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rJuiI6dg"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Z20J4LBYzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2019 11:11:11 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id s7so947379iob.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2019 18:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5fu2ndC7u5HuTRDlJrW8Tvoz/59+NYdpQwJKKH6YMUQ=;
 b=rJuiI6dgoMpwj0XEKhepaSfQL6/zOGKisrNsLnqQPq4KMQ6oNlLRBjNCYwh3u0apcG
 Qok/OR9d2vHfrGwS/T79EI8yvWQklcUaGtBZy6nxU3wjYQmD2fbPHgNVxxalYhErF76X
 Lr15ho7xCaf970aHic3Hvns5BYbHmC7HUqnm+zOWrRGjCMh76MAJqzTNsfcJypZnze2n
 UniMtqe+02yxXnMBIp1bmZBlD07dFn3vwggmxlQXJGLd4veboXvwhAxqsoCQcsy1Q0qT
 qBqfdAmJ2RC1oVECvOr7tLuf0qq44eh1MgkpfrFg3keR5AgEPOhoM/DA93jnxPpvNokI
 Cn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5fu2ndC7u5HuTRDlJrW8Tvoz/59+NYdpQwJKKH6YMUQ=;
 b=q3BsLnEnJIvCRpn76vB5qvoRqS8QqxBLirf2S9ik+AyeJni9fIJKV+0ynYeg57arnj
 Wg1wGNJieQgcqHVbMHonp5/VxLiolgbWFdbJLc87EQj5wbWOAhOqvoumpv4Nzlb3Yb/Z
 8LW9ELXnljwAfrtqEpPWPJcUSRp639WLGAGNZD4fFB9hEeFWJ7BA7T79Ux+62Mp1ELQ9
 HNkdB15rOkGX7Dw7dqvN9X2eeM0bnzbEXFaUZaU489xlENQgfSyLc85YS926oYDZwIny
 9h7iin/1aTkMh+SYNzDd8OgJKhko0thG703UMNBKuZRizJ2VRZd7N3SGeHXEvHxkQwY2
 TGVg==
X-Gm-Message-State: APjAAAUvRGHMomZ8dzmSok84kSUIRV1Zz7ZtD8yR8Z9fsNcySPH6GtXN
 2utU24E7cQ9Ed6zBTwzRKdKYbWM9tKsdRjL96Nw=
X-Google-Smtp-Source: APXvYqzpzu8Ve5r411sS+U/GWOr//3HkqQBUXjOKKLrlLnYLB8LscLHSKxK/8S+UavIvc9PWw7FYAGpyylMMwcZsJhM=
X-Received: by 2002:a5d:9047:: with SMTP id v7mr1322985ioq.18.1561597868385;
 Wed, 26 Jun 2019 18:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190626140404.27448-1-vaibhav@linux.ibm.com>
 <20190626140404.27448-2-vaibhav@linux.ibm.com>
 <87mui4z3t2.fsf@linux.ibm.com>
In-Reply-To: <87mui4z3t2.fsf@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 27 Jun 2019 11:10:57 +1000
Message-ID: <CAOSf1CGiAnyJ63Q47rEtOApuJ99X5FqjS4R_VbuRbUuzzavnvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] powerpc/pseries: Update SCM hcall op-codes in
 hvcall.h
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 27, 2019 at 2:53 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
> > Update the hvcalls.h to include op-codes for new hcalls introduce to
> > manage SCM memory. Also update existing hcall definitions to reflect
> > current papr specification for SCM.
> >
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>
>
> Why split this as a separate patch? You should fold this to the next one
> where we actually use the constant.

I figured if you're going to update the hcall numbers to reflect
reality then it should be done in a separate patch. Single logical
change per patch and all that.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
