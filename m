Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1261AC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:38:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1702077C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bSJRSo5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1702077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fWbc66nbzDqFh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:38:36 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fWYd5KP4zDqBj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:36:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="bSJRSo5M"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44fWYd2snFz8sxQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:36:53 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44fWYd2NxSz9sBr; Thu, 11 Apr 2019 03:36:53 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=matthewgarrett@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="bSJRSo5M"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44fWYd0DgDz9sBV
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2019 03:36:52 +1000 (AEST)
Received: by mail-it1-x144.google.com with SMTP id u65so4818169itc.2
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2019 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fsdwxzllgm3TZiNS2RBUzUWgv7Kl8/L4XW2AecOXicU=;
 b=bSJRSo5MsFgno1KgFsAA0YK3rrv031WHLUUGrO3xbQk7/2nDnoqhvqCJ15Ey02vmDN
 Hxk/8IqQAkGzzQ3RlVdOSQn4H8INleO5W/ThQpK7vUqwbxb2+jCr7keiDXwFtAWpkfNg
 4hD9j7FmHX7letmuEOZ4IDSOF/QivdG51ubmLFeGqbYbQ9clMSR1PhFfW/qE8KibK+8n
 SoWGBelTt+/DKTHDgSuq1WRucP6zbuqnPF2e3eqSAq4rMjWweTMpOp4pCDSu6FCEESOu
 cWqbWQeM5QscA0I5BMqRgU6XQnly8tSmYOXLaNcPtKQvF6my5Rx67jZ5R2MBRepNeR4B
 dMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fsdwxzllgm3TZiNS2RBUzUWgv7Kl8/L4XW2AecOXicU=;
 b=NPO2OBSCbi4e8tVrDzkh43LsBLxx7BQ94NGRYcI+5kiR3UVHqXtxV3B2wjc2tYX7u+
 cWpiY6y13b6BvVyoUyq/7eE/LvWdphL7aS8JqffV1gWArOxg7kl+X0wiiSW9GzIlAKbs
 4ATSRQOrvADbb6DB5ml7Pay4ataiBWKK588hVMPqEVe7Yp0X1CkA2T3+KmeF/OK6EOnj
 d/mQMB3Bp2XwQaZGxXghKYk6hpC4Lrf32DYlil3WES/rUCXqkewhHUQbnQd+yiT8G1o1
 s1VfFgEk3lh4/2yHDusd1oKP6wychVzelFANrapbUS++ep5Qlz96xgWuXe76XCkpJfkN
 09qA==
X-Gm-Message-State: APjAAAWoMBVyYQYmUi1VCo5kv5MwP44TdqAJS1vJJWw67E+6DWkeq2VF
 /3rRUg+ibWjLF5dJF+fR5cOlKRxU9RjzykoyqLCEuQ==
X-Google-Smtp-Source: APXvYqwcxj9ETT2fC97ngGmh7CcsBy2+YL6kB6AnKQJasNCbUVIV8fGBdWEIhNBMFR1OZOiEkz1I6DPnF3iTkLVIYjE=
X-Received: by 2002:a24:7294:: with SMTP id x142mr4445023itc.7.1554917808975; 
 Wed, 10 Apr 2019 10:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
 <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com>
 <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com>
 <CACdnJusBm93zwDqTXTx_QYsg1-aGUAAHm_qq8Lcx3TvGTxdmbg@mail.gmail.com>
 <2208f156-d441-3082-2f4c-8030c84ef788@linux.ibm.com>
 <CACdnJuu8OqMrSs0esOmf=ro9n00aYEQ-nikAh6v6sk+YAQw4cQ@mail.gmail.com>
 <d79f47f8-9006-3a47-2bdc-58012cef5c7e@linux.ibm.com>
 <CACdnJuv_5A1_6CH1+Jn7SCrmW8Y6JuzsMmJoc1=_vn0nKdYMjQ@mail.gmail.com>
 <28bfc0a7-9ae5-2c99-e472-ea53f856bafc@linux.ibm.com>
In-Reply-To: <28bfc0a7-9ae5-2c99-e472-ea53f856bafc@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 10 Apr 2019 10:36:36 -0700
Message-ID: <CACdnJuvpUKiX5UgSOrzh+B9y68zKm+Bzu1c8KFJHd8diz=sm2Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Nayna Jain <nayna@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Garret <matthew.garret@nebula.com>, linuxppc-dev@ozlabs.org,
 Peter Jones <pjones@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, linux-integrity <linux-integrity@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(Cc:ing Peter Jones)

On Tue, Apr 9, 2019 at 3:55 PM Claudio Carvalho <cclaudio@linux.ibm.com> wr=
ote:
>
>
> On 4/5/19 7:19 PM, Matthew Garrett wrote:
> > Based on our experience doing this in UEFI, that's insufficient - you
> > want to be able to block individual binaries or leaf certificates
> > without dropping trust in an intermediate certificate entirely.
>
>
> We agree that a dbx would be useful for blacklisting particular kernels
> signed with given certificate. However, we have been avoiding doing so fo=
r
> the initial release of secure boot on OpenPOWER. We don't have individual
> firmware binaries in OpenPOWER. Kernels are currently the only concern fo=
r
> the OS secure boot certificates we're discussing here. Also, we have a ve=
ry
> limited keystore space in POWER9.
>
> Petitboot doesn't have standardized OS kernel verification at all right
> now.  Having the capability even without dbx seems valuable.

I don't see the benefit in attempting to maintain compatibility with
existing tooling unless you're going to be *completely* compatible
with existing tooling. That means supporting dbx and dbt.

> >> The API is still a work in progress.  We are planning to publish a doc=
ument
> >> describing the current API and overall design shortly.
> > Ok. How are the attributes interpreted by the API?
>
>
> We support a subset of standard EFI variable attributes, and we only use
> EFI variables that relate to secure boot. Our goal is not to implement
> UEFI.  However, we do seek to be compatible with user space tooling and
> reuse as much existing infrastructure as possible. We don=E2=80=99t suppo=
rt the
> following: EFI_VARIABLE_HARDWARE_ERROR_RECORD,
> EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS and
> EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS.

Ok. I think that's realistically fine.

>
> >
> >> Perhaps the biggest departure is that the secure variables are stored =
in
> >> flash memory that is not lockable.  In order to protect the secure
> >> variables, hashes of the flash regions where they're stored are writte=
n to
> >> TPM NVRAM indices.  The TPM NVRAM indices we use are write locked at
> >> runtime.  The sysadmin enqueues update commands in flash.  During the =
next
> >> boot, the firmware verifies and processes the commands to update the
> >> certificate store and accompanying integrity hashes in the TPM NVRAM
> >> indices and write locks them.  Before certificates read from flash are
> >> used, the certificate store is hashed and compared against the hashes
> >> stored from the TPM.  The one exception is the PK. We store it in a TP=
M
> >> NVRAM index by itself rather than flash because updates to it must be
> >> guaranteed to be atomic.
> > What's the behaviour if multiple updates are enqueued? Does reading
> > back show a mocked up updated variable or the original state?
>
>
> Our secure variable updates are only applied at boot time. If any one of
> them fails, they all fail.

So I do the following:

1) Boot
2) Extend the contents of db
3) Extend the contents of db again
4) Read back the contents of db through efivarfs
5) Reboot
6) Read back the contents of db through efivarfs

Is what I see in (4) and (6) the same? Does it contain the values form
both extensions?

> > I'm not really clear on the workflow here. Who's the administrator
> > authority? When would they be updating the second level of keys? If
> > there's no support for revocation, why would distributions need two
> > levels of key in the system database rather than just distributing a
> > single intermediate and signing their actual signing certs with that?
>
>
> In OpenPOWER systems, we enable our customers and business partners to
> establish and manage the platform key certificate, which is the root of o=
ur
> key hierarchy. From there, through the KEK, they can delegate authority t=
o
> intermediate level organizations, e.g. distros or IT departments or
> business operations. Those intermediate level organizations then manage t=
he
> code signing certificates in the DB. If this answer doesn=E2=80=99t addre=
ss your
> question, can you please rephrase?

Why would the intermediate level organisations not just have entries
in db? The main reason we don't do it this way in UEFI is because we
need to support dbx, and if you're not supporting dbx I'm not sure I
see the benefit.
