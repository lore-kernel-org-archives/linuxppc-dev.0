Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E1C282CE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 22:21:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B242175B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Bc0tJq9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B242175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bZ645L8zzDqSg
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 09:21:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bZ3w4JB9zDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 09:19:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Bc0tJq9N"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44bZ3w11n3z8sxQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 09:19:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44bZ3w0NL6z9sPd; Sat,  6 Apr 2019 09:19:24 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=matthewgarrett@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Bc0tJq9N"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44bZ3v0bzFz9sPP
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Apr 2019 09:19:22 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id x132so1726563itf.2
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Apr 2019 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p70rh8DzLMoO9YQR1wIHClyyXHDpqpEks55cuvOjfCY=;
 b=Bc0tJq9N/sPYw85QXGSIH0hbEtzljs8EWItZ9MIwCmNwpRUoa/Wpc5hsHoxnO/te/o
 O3F7X0+2bCdaluN6rPhO4hAZPUmPfFaaJIknDhttv3aW3vSR2RBpC49xL+P10rlIABz2
 FtRzhFhWl+sdRw1u7SF5C+Ul/CUNeqzj2OmmTtoUzMM/nubLgmCHk1xDxXr9CenY1pcQ
 b0moIO332HU3WYNlXK8fBIj84fYUgtIGZOcp9farU3QDzoBMhwPPDbrro6c1+P9Jk9BI
 dtakwadfwEhfde93OHQh09dc8rKxnXgvtSMn54RFzPcjbCcm/hATCmPV1sGr1TIM37QO
 ZEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p70rh8DzLMoO9YQR1wIHClyyXHDpqpEks55cuvOjfCY=;
 b=Oh40TWzF/ELpsqGYK7ZtOGn23Tlr7YVEP4oL7srBUAAHL7LfLIcO7Uyyj2AR6mjwvg
 99miSI3KCmXxD2fHSCDapPbqlkXyJ9s/0e4YNKSEn51VydzuW/8lvWsr3X8TURjJvkqr
 9iKfSbz9qFdgkVMtK2aVqrEIaf1beFLayGqQJu8zjBBOIKa+6M/7dln4YyIE3KetQ6Jt
 +kkzPU82kAwqUmi8qru4Zb0g0lRUB3rLu5KmnGkhhz+5Zr2/lm/vAk+pEK9MintER08P
 Tjr7WjlzZAhjWCNU4EdC8ZtpyeLcFnat5U+GZgcLbQ1MQ+P8p2eYLHY36yA3y5Rdfoi1
 XVkA==
X-Gm-Message-State: APjAAAXh7tgaSx2H1a/VtIYjupWA+1MRNBxxVH3KB+AISV0urDUgkKd1
 40jbgQvKpLt3i80F0cCptcpVPbngHqbETGIK7ac1AA==
X-Google-Smtp-Source: APXvYqz8L0DRIH950OrISsoMW75m56cdjyA82W8JwtiaTtpNLc8MeWdCquXt/H6qVstvEF2gn6aGUbrGlapaBmieosc=
X-Received: by 2002:a02:1a45:: with SMTP id 66mr11594981jai.124.1554502759204; 
 Fri, 05 Apr 2019 15:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
 <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com>
 <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com>
 <CACdnJusBm93zwDqTXTx_QYsg1-aGUAAHm_qq8Lcx3TvGTxdmbg@mail.gmail.com>
 <2208f156-d441-3082-2f4c-8030c84ef788@linux.ibm.com>
 <CACdnJuu8OqMrSs0esOmf=ro9n00aYEQ-nikAh6v6sk+YAQw4cQ@mail.gmail.com>
 <d79f47f8-9006-3a47-2bdc-58012cef5c7e@linux.ibm.com>
In-Reply-To: <d79f47f8-9006-3a47-2bdc-58012cef5c7e@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 5 Apr 2019 15:19:07 -0700
Message-ID: <CACdnJuv_5A1_6CH1+Jn7SCrmW8Y6JuzsMmJoc1=_vn0nKdYMjQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To: Claudio Carvalho <cclaudio@linux.ibm.com>
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Nayna Jain <nayna@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Garret <matthew.garret@nebula.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 linux-integrity <linux-integrity@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 5, 2019 at 2:11 PM Claudio Carvalho <cclaudio@linux.ibm.com> wrote:
>
>
> On 4/3/19 7:27 PM, Matthew Garrett wrote:
> > Not supporting dbx seems like a pretty significant shortcoming. How
> > are signatures meant to be revoked?
>
>
> We began by focusing on certificates for keys that can be added at
> runtime.  Before adding support for revocation, we plan to gather
> additional use cases.  In the meantime, unwanted certificates can be
> removed by the administrator.

Based on our experience doing this in UEFI, that's insufficient - you
want to be able to block individual binaries or leaf certificates
without dropping trust in an intermediate certificate entirely.

>
> >
> >> PK, KEK and db updates will be signed the same way, that is, using
> >> userspace tooling like efitools in PowerNV. As for the authentication
> >> descriptors, only the EFI_VARIABLE_AUTHENTICATION_2 descriptor will be
> >> supported.
> > Is this API documented?
>
>
> The API is still a work in progress.  We are planning to publish a document
> describing the current API and overall design shortly.

Ok. How are the attributes interpreted by the API?

> Perhaps the biggest departure is that the secure variables are stored in
> flash memory that is not lockable.  In order to protect the secure
> variables, hashes of the flash regions where they're stored are written to
> TPM NVRAM indices.  The TPM NVRAM indices we use are write locked at
> runtime.  The sysadmin enqueues update commands in flash.  During the next
> boot, the firmware verifies and processes the commands to update the
> certificate store and accompanying integrity hashes in the TPM NVRAM
> indices and write locks them.  Before certificates read from flash are
> used, the certificate store is hashed and compared against the hashes
> stored from the TPM.  The one exception is the PK. We store it in a TPM
> NVRAM index by itself rather than flash because updates to it must be
> guaranteed to be atomic.

What's the behaviour if multiple updates are enqueued? Does reading
back show a mocked up updated variable or the original state?

> > I think that depends on exactly what problem you're trying to solve.
> > Some aspects of the EFI secure boot design end up mirroring the
> > economics of the PC ecosystem rather than being inherently good design
> > goals, so it'd be helpful to know whether you're taking this solution
> > because you want the same three-level key infrastructure or because
> > that just leaves you compatible with the tooling.
>
>
> In our use case,  the three-level key hierarchy conveniently supports the
> concept of (1) an administrator authority, who authorizes (2) other
> organizations, e.g., distros, to provide (3) certificates for their code
> signing keys.   By using efivars, we leverage pre-existing userspace EFI
> tools to generate authenticated updates and certificates.  Additionally,
> pre-existing kernel infrastructure simplifies efivars processing.

I'm not really clear on the workflow here. Who's the administrator
authority? When would they be updating the second level of keys? If
there's no support for revocation, why would distributions need two
levels of key in the system database rather than just distributing a
single intermediate and signing their actual signing certs with that?
