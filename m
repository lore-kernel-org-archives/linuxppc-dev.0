Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2263C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 14:15:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2F76144E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 14:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2F76144E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQMyF14vTz30Gg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 00:15:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Htq4AavT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::731;
 helo=mail-qk1-x731.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Htq4AavT; dkim-atps=neutral
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQMxm0kT4z2y6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2021 00:14:33 +1000 (AEST)
Received: by mail-qk1-x731.google.com with SMTP id v7so14830515qkj.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=H0xUL+VFdyIa0ji4Th/5YMGTFHYr1jkOK9wBOItrp/Y=;
 b=Htq4AavTUvaIKjrSwYSgfk/9LOhsOQRau62GNNkBD79Sh4VxHePzD2L+B52RENCsHI
 4PL+nqqx70rsT6DneonIWLk2JgIAAKH4RYpwmo9Wn4GDqdmpAlfpjtk7jRllYJmXZiyo
 tnWbbNT+p3igXVTAx/jBF1NGPsOxeu1AmVb87QTHjEKTdSc2O7Jo3LKCuXXR0KpW4+Bg
 RW9awX3klxF+hBslxw/CUl5QEoKtY33EQ/HmP0wx4EJ0xHnjRpqiBjFbzcGxBnN5SQYr
 KgFfi77SLsFAOdNhi6+68ezGqnlxjq1tZBqUtfj/RhDFkEwEa14TQvGCRvorbKiVdznv
 Pi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=H0xUL+VFdyIa0ji4Th/5YMGTFHYr1jkOK9wBOItrp/Y=;
 b=hXBqCKXBQ59KRCUOwd1cVeQWqF5G9Uvgmzhg9hNSnyczn0FVu3PCq5qcyyN4FtJGgb
 fjir7x2MjmBG5V7DMUQTRnSjy0aYhjWOaYXSwzQb5vLRRcO8WOwqAKMNmDtJrZlZmDbG
 lyyqjC1GI6QYjyy1R3vXt6/gdV3iQoimiXwOJdBhim4uU3OBqAJqWjbqHpM4fE/Lq5pP
 XuJLiCtXt8uhkjsFxhBIANxLqKxFR9NlDGQrNBywKk+dVdg9hocJlO/Mtlba/q85Nv5q
 cQzF56OhMZDq6ldvLGgEEEKyKjLYawlHwb8auNNRsXH48n+1yrkW+L/equiGARWLW3dZ
 8E5A==
X-Gm-Message-State: AOAM531eOyN1cno0Ib4PK3F1SrzaXlwmbFw8DpHfjNxsNDFbfd2n3tZX
 TB6aM3lLn3Qt9JykbdN1JaA=
X-Google-Smtp-Source: ABdhPJw8CLguVFAPzF8l1/1q5ENNtjHkvPtfqw/PekYFKdTDnJWRL0D+IoF3dUIZdep6LDU4L/VqjQ==
X-Received: by 2002:a37:a5d6:: with SMTP id
 o205mr11119679qke.166.1619014469882; 
 Wed, 21 Apr 2021 07:14:29 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com
 ([177.35.200.187])
 by smtp.gmail.com with ESMTPSA id o12sm2150348qkg.36.2021.04.21.07.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 07:14:29 -0700 (PDT)
Message-ID: <5da23b1199c897b464c7bf7027ac50057d1cb5b6.camel@gmail.com>
Subject: Re: [PATCH 1/1] of/pci: Add IORESOURCE_MEM_64 to resource flags for
 64-bit memory addresses
From: Leonardo Bras <leobras.c@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Apr 2021 11:14:25 -0300
In-Reply-To: <CAL_JsqJXKVUFh9KrJjobn-jE-PFKN0w-V_i3qkfBrpTah4g8Xw@mail.gmail.com>
References: <20210415180050.373791-1-leobras.c@gmail.com>
 <CAL_Jsq+WwAeziGN4EfPAWfA0fieAjfcxfi29=StOx0GeKjAe_g@mail.gmail.com>
 <7b089cd48b90f2445c7cb80da1ce8638607c46fc.camel@gmail.com>
 <CAL_Jsq+m6CkGj_NYGvwxoKwoQ4PkEu6hfGdMTT3i4APoHSkNeg@mail.gmail.com>
 <b875ef1778e17a87ee1f4b71d26f2782831b1d07.camel@gmail.com>
 <CAL_JsqK83MFqZ4yCz+i7sunpXFmi+vvjCSxVmcCh1YG=mOxY9A@mail.gmail.com>
 <b56b8a5c8f02a2afea9554ebf16a423c182a9fc3.camel@gmail.com>
 <CAL_JsqJXKVUFh9KrJjobn-jE-PFKN0w-V_i3qkfBrpTah4g8Xw@mail.gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: devicetree@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 PCI <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2021-04-20 at 17:34 -0500, Rob Herring wrote:
> > [...]
> > I think the point here is bus resources not getting the MEM_64 flag,
> > but device resources getting it correctly. Is that supposed to happen?
> 
> I experimented with this on Arm with qemu and it seems fine there too.
> Looks like the BARs are first read and will have bit 2 set by default
> (or hardwired?). Now I'm just wondering why powerpc needs the code it
> has...
> 
> Anyways, I'll apply the patch.
> 
> Rob

Thanks Rob!


