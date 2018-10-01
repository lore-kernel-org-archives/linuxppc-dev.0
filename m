Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C02AC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:26:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078C92089D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUFp/Cqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078C92089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P1jp1WzYzF35X
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:26:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QUFp/Cqs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QUFp/Cqs"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P1ZD3936zF31s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 22:20:04 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id h6-v6so12501121eds.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ee9pxe1qM/FM7hhNAyF6gpe/cunUB0mcwaK0zp/xdYo=;
 b=QUFp/CqsOVdjSqzp6bmfS0hfy7+pGiRuiJyPW88CLfxQRpB4G7vH72Z4EuVs6L3+x+
 IlvxmuR8JRNTAP+9wivA7Wn7lGj88ywRgoKc7oU/seZx7cIkAxZmih6b1YobUBmhTEUe
 1hnNVzoek/w6YGSnJMz0QwChTs5WmjU3W9Hk2pIDs7Q/o3m6bevf+t6k6IS7kBICFZY2
 xkKcGO5CDW3D/w5ffk6iEk3Cm4VxN5SSo/0zuDlUEfn3u2vlJTYb7KyIa6fskbj3hUKf
 0gbfzXrynNA/AmqiUZGWX70ytfdPhgEIDG9rWvuspGvwI3RRbc8WHwkwJm67coFwMwLn
 XBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ee9pxe1qM/FM7hhNAyF6gpe/cunUB0mcwaK0zp/xdYo=;
 b=UR+ksPmVAA+ZgGKWQu3Oliti/rZqd381NvVVRMB+CahoqQa1xIxoDG0xBWjtYedGLJ
 R1zvt/HYSpNnL8bBSUkNGaXhgbWB++UTvsclv2cWY5HQ5+0S9gnftRF9z4DpSjo56Pst
 VASeow+9RY8tkrhrlShVzi616nwVGM32awbDkRGW7zfIjdNV7DcO28ki+bDlBI/rrjQ3
 FptcxJE8BtwS9Ew1GjTiwuGV1YA5/ZZ1WAEfBFxMxiYuXgU1y9x2jn6F2Isc20lbfIYk
 5LPB2zIh8zSSq2hQzrxdMuYAV4nzH8QTnlpQc6FQ/jjWS7HJbMWClrUXOlxc7KJO8ypM
 q6fQ==
X-Gm-Message-State: ABuFfoi44vd3IYh7WBvqjlQAW90AhPDRhEYr/ybqi4H92L4iKZgj5NLh
 EdXuPxltgri6OCmIcwBm6xgFMjpyPSbefZesW/w=
X-Google-Smtp-Source: ACcGV62KVF2Tx2zNtUodmgPChbmdJSeNID7dtcwn2qYxjfORGQLa1E5fi8zw8lBSp3AQau30+1jH3SpacmLqoME2ZZg=
X-Received: by 2002:a17:906:25e:: with SMTP id
 30-v6mr9855623ejl.105.1538396401425; 
 Mon, 01 Oct 2018 05:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <20181001085915.GC23155@gate.crashing.org>
In-Reply-To: <20181001085915.GC23155@gate.crashing.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 1 Oct 2018 20:19:48 +0800
Message-ID: <CAEUhbmUa5HCW=HDNhOq7jynjPVEjWuROOxxauWB3dpShRSAxBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64: Remove duplicated -mabi=elfv2 for little
 endian targets
To: segher@kernel.crashing.org
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 1, 2018 at 4:59 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sat, Sep 29, 2018 at 11:25:19PM -0700, Bin Meng wrote:
> > The -mabi=elfv2 is currently specified twice in the makefile. Remove
> > the one that does not test compiler.
>
> This was
>
> ifdef CONFIG_PPC64
> cflags-$(CONFIG_CPU_BIG_ENDIAN)         += $(call cc-option,-mabi=elfv1)
> cflags-$(CONFIG_CPU_BIG_ENDIAN)         += $(call cc-option,-mcall-aixdesc)
> aflags-$(CONFIG_CPU_BIG_ENDIAN)         += $(call cc-option,-mabi=elfv1)
> aflags-$(CONFIG_CPU_LITTLE_ENDIAN)      += -mabi=elfv2
> endif
>
> and the later setting is
>
> ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
> CFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
> AFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv2)
> else
> CFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv1)
> CFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mcall-aixdesc)
> AFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv1)
> endif
>
> Maybe these two pieces should be joined completely?
>

Ah, yes! I was only looking at elfv2 stuff before :)

Regards,
Bin
