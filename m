Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58834C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:38:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C265420700
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cgxH1p9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C265420700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ykdk5rwbzDqRD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 09:38:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yjb56Z7bzDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 08:51:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="cgxH1p9h"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Yjb516Kkz8t7s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 08:51:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Yjb50t3kz9sSV; Wed,  3 Apr 2019 08:51:29 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=matthewgarrett@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="cgxH1p9h"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Yjb40wwYz9sPb
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 08:51:27 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id v8so3819252itf.0
 for <linuxppc-dev@ozlabs.org>; Tue, 02 Apr 2019 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xywp59diGGhpDkbiKwDy1z/p41TsJGCT04l9clYa/bw=;
 b=cgxH1p9hR+Q06JJs5kFBfM9Kyh5DPamsWYdVF0dOKK8prPxsq3lgTyOaY7YDCicOWA
 T488n5X1XcxSkrl0ukEtFGi+xPCJQJyQHBue/DNa1uXTEPoo05oAgpFuei/QDfJRCyyq
 t9FsqC7+HgEDi1sT636+7YZnoy1JpZ8TDmu9iXyxMUkDuvo0s1RZ5ru4csy0g0f4k5iM
 1AiLgmJZKN3SfNQfXEKMjmbVvFqsV7CZbF3SmMx+eU2XvavP0JM/EG2NUI4gg/T7HG8G
 2gQW9vzgCcSihzMmWJL2dvHpG7HP2BzimvQN5myrNc1Xjq2n2r95Ar8Uhu0gPOdX+nfZ
 ewhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xywp59diGGhpDkbiKwDy1z/p41TsJGCT04l9clYa/bw=;
 b=J2nspt94xq+rMMAXARYl78+NfNGlM+82+weYQsRD0X963YfJu5+Za+jn+uTNYHpjtx
 p5ElrC017BHE87LRR9jsLERXGzMeHfl+cWfGsaBSbZToBn+OmReVpTP+qJbX3o43ZFFs
 VqLvAP+W/wx7alqg07VoAHIiG+zPc0v3g+uBSeMs5S7+ejn5MNTqdISpbM5QYpbmQOak
 bw0eTodsTnQ1JF28ZoqlD08VulR8o7RSOvjDucMgt1fFqeTCzrkTzeJR7/MVPLPlpwgy
 CSgKd6IcUrjmwi0DKN9UjT3nTY0c/IyBe+VfClrHSRFG6qP54k0mUMyNkK4YvRMalzac
 q7VA==
X-Gm-Message-State: APjAAAXQxgnfeaJav3Of/TAhUvfdaraF2Tln510J4j+numBFs1gnuFXI
 VuA7o61J7TovXGGOzbx7+lxffswpHIxPGhmQXwmulg==
X-Google-Smtp-Source: APXvYqwVbk00Uxfr2Ccq7oUAtn2vcYmrClo21irGD94orTqlL5kNd4RQPDNFpoHH/oLVy0nmdWbZDpwKN1y9YP7iqxk=
X-Received: by 2002:a24:7294:: with SMTP id x142mr6230609itc.7.1554241885398; 
 Tue, 02 Apr 2019 14:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
 <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com>
 <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com>
In-Reply-To: <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 2 Apr 2019 14:51:14 -0700
Message-ID: <CACdnJusBm93zwDqTXTx_QYsg1-aGUAAHm_qq8Lcx3TvGTxdmbg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 03 Apr 2019 09:36:03 +1100
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Nayna Jain <nayna@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Garret <matthew.garret@nebula.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 linux-integrity <linux-integrity@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 2, 2019 at 2:11 PM Claudio Carvalho <cclaudio@linux.ibm.com> wrote:
> We want to use the efivarfs for compatibility with existing userspace
> tools. We will track and match any EFI changes that affect us.

So you implement the full PK/KEK/db/dbx/dbt infrastructure, and
updates are signed in the same way?

> Our use case is restricted to secure boot - this is not going to be a
> general purpose EFI variable implementation.

In that case we might be better off with a generic interface for this
purpose that we can expose on all platforms that implement a secure
boot key hierarchy. Having an efivarfs that doesn't allow the creation
of arbitrary attributes may break other existing userland
expectations.
