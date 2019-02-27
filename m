Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5662DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:58:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE8E2147C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Wq3Deb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE8E2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448f2K5LbwzDqNW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 01:58:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="K/Wq3Deb"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448dxD2FykzDqRL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 01:54:07 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id n22so8133850pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=S9j0YOQBdyOL8hLYMPV74+7RuCP7wPF4MTbEw96SxL8=;
 b=K/Wq3Deb130Puh0BrnmsvV2ZSI29/uvENrnZzLB84wee4noby24t3d0KbH10bU2sbR
 lH36qQVT5sGrtgueFLVFFH2ju34e4dvACKAIGMF5GvXPB9ZzQMOQIsyRh2c2vPFk02Wh
 e/r537cQxR9H6ZCttyqT2DS5xrLRViZhyhXrJ8SNgOxUJmgHv6kzrV2+/pulrgRJhJRA
 QkE/hcqKfoq6SjnC7K886Bnz64jTtkYXCeCSFqJKrCZzfnDjTD0VtGUvZthMJlaK841a
 +h5AY/9+KakzHw/Dm4sh2RlPvwc0HMer5THG+daC0iBwhiOYCluNs3lvFDh0tgvIwtqP
 K0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=S9j0YOQBdyOL8hLYMPV74+7RuCP7wPF4MTbEw96SxL8=;
 b=B8AForSQsGTntVRUOND8QAcHfXjXb1QbYBu6gTLuvA2gbAj7GMyHka90JH3BrHX3vn
 RhVzzqTTovisMuFvffTyKqoKN4Cn6RjI+CyUKqUWskxtw8ziRESWBTYPEnlcbnwIe8qg
 /W0VWA7A8Nw8oe3eADApQElDoiQVRJZVJnEa90BTV3AKd8B5phLNNgZ3bujVijaqEKQt
 1BkbA5EvaTEzMkwO6WaWhW5WgyvGz5Sk8yPIToR5C4rmMEZJdbC91wXwgU0dicRZVtjn
 SVr9P1tXJY9RZNlLPtNSNSQ3+NUKjPt0SOfYfBE4SQKD87UBu6PIiJN7wha9FjRvY67V
 ErGg==
X-Gm-Message-State: AHQUAuYjhKrSYjzxq8VkW7er/+dk56/Qv7wTpRQaWCnfI8Ub2DsUuogA
 dTtIcNis/87kmS7A7wkHbsnIs5S/
X-Google-Smtp-Source: AHgI3IaeOkRDvH8G+d90jqaOAkZzfpZm8thYzXySTsawBB/Ypug6T4XMwtpWHRrpgpA/+5kX+6Ku5Q==
X-Received: by 2002:a62:b248:: with SMTP id x69mr2023161pfe.256.1551279242525; 
 Wed, 27 Feb 2019 06:54:02 -0800 (PST)
Received: from localhost (60-240-164-4.tpgi.com.au. [60.240.164.4])
 by smtp.gmail.com with ESMTPSA id f193sm30135704pgc.3.2019.02.27.06.54.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Feb 2019 06:54:01 -0800 (PST)
Date: Thu, 28 Feb 2019 00:53:55 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv/idle: Restore IAMR after idle
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
References: <20190208111103.4901-1-ruscur@russell.cc>
In-Reply-To: <20190208111103.4901-1-ruscur@russell.cc>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551271665.t9k4qh3o3r.astroid@bobo.none>
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

Russell Currey's on February 8, 2019 9:11 pm:
> Without restoring the IAMR after idle, execution prevention on POWER9
> with Radix MMU is overwritten and the kernel can freely execute userspace=
 without
> faulting.
>=20
> This is necessary when returning from any stop state that modifies user
> state, as well as hypervisor state.
>=20
> To test how this fails without this patch, load the lkdtm driver and
> do the following:
>=20
>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
>=20
> which won't fault, then boot the kernel with powersave=3Doff, where it
> will fault.  Applying this patch will fix this.
>=20
> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
> space")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> Since v1:
>       - no longer use paca to save IAMR, instead use _DAR (thanks mpe)
>       - remove isync and pnv_wakeup_noloss section (thanks Nick)

Thanks for that, looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

=
