Return-Path: <SRS0=XOTo=LL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA15AC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 23:22:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1BE6113E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 23:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1BE6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5dQ41gZ1z3c43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 09:22:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ir87RIq6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a;
 helo=mail-pg1-x52a.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ir87RIq6; dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5dPX6ZCBz307T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 09:22:23 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id t17so6222969pga.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2021 16:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=qOGxnA+w295Zfdqp/3EIV/boS8jDDN3t7281bqtmFyk=;
 b=ir87RIq6aaUio14CEQu9Dg1UaOAcsDflyOo8FkKXldN9ZoQ6I5wCPknP5NKvSLrgZ8
 t8BYa+PWl82kqVa54W6ujKqy6QJ7UZBzBSfX+Nj7eS9ic5bV8Tc4UwlmeHIDGsDa06zP
 w/+oD6UxaC7Jgppy2kI84XBk2XlYkFZaf9rKObE58oUt2H5+ugOphi/86/uv+GM1HtEz
 JCzQ0h8IproccM3LZvzrvOQ/BSuNYeiqCf5xd6YYbxNaB96z+vZQ3Y74R1tlwTWPoTSv
 11o64cpOt78exCXXsHQ2pqcboPNq4B8oCD5VHFMyRmTpvkLusvMKANhSPbWx2oF9rapL
 arVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=qOGxnA+w295Zfdqp/3EIV/boS8jDDN3t7281bqtmFyk=;
 b=SR/zk1AjhkN0R+IZPxCGD4BGRO7dybKBNlmRJBrCJZbJRH2KvduBbcvzMl5NoEFo1/
 VE/+ojO5lcUd3ZWzLYuE6i4YXYgJT/CSx0/w4FucWtfDXibe4oB9XNmcm/nxvIYvcUmy
 Z2Avf7v5aF9Xz/IL9GuGfXEt9lRnGY+X/6eAig/vUJARnIBhKt9Uk681V3PFTAfGHvM9
 lPAgL7khXTyRZIl4eJ6z0u2Z4JQlv0Bigc4KH/o38ZS5r/ZjWzakJDynyjMa9jC2vGOv
 janDLfuv8jQp6YU7Mi7gI399ZdIFkWLrmdJI1NFPp5+vMrWzBlYPOIwSR6pUrjnTTkSf
 R4Aw==
X-Gm-Message-State: AOAM530Bjc+3fIxVsHn9jl13Atzy4WOv3LiFsMfDOKZq9JP9l/TfVZmD
 0M0Co+qX6E2Ql3BZQ32DZrRaM9qTEVU=
X-Google-Smtp-Source: ABdhPJwE60/Y4E6j3nji1MEMxB2Cct2NTycPxkX9/ObI/VKAnysIJ+z0vJFNrcQ/kCJ6yBi7kXnvpQ==
X-Received: by 2002:a63:f13:: with SMTP id e19mr6955047pgl.112.1623972138656; 
 Thu, 17 Jun 2021 16:22:18 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id b65sm6087820pfa.32.2021.06.17.16.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jun 2021 16:22:18 -0700 (PDT)
Date: Fri, 18 Jun 2021 09:22:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 12/17] powerpc/pseries/vas: Integrate API with
 open/close windows
To: Haren Myneni <haren@linux.ibm.com>, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <827bf56dce09620ebecd8a00a5f97105187a6205.camel@linux.ibm.com>
 <e8d956bace3f182c4d2e66e343ff37cb0391d1fd.camel@linux.ibm.com>
In-Reply-To: <e8d956bace3f182c4d2e66e343ff37cb0391d1fd.camel@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1623971609.844odc55aw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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

Excerpts from Haren Myneni's message of June 18, 2021 6:36 am:
>=20
> This patch adds VAS window allocatioa/close with the corresponding
> hcalls. Also changes to integrate with the existing user space VAS
> API and provide register/unregister functions to NX pseries driver.
>=20
> The driver register function is used to create the user space
> interface (/dev/crypto/nx-gzip) and unregister to remove this entry.
>=20
> The user space process opens this device node and makes an ioctl
> to allocate VAS window. The close interface is used to deallocate
> window.
>=20
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Unless there is some significant performance reason it might be simplest
to take the mutex for the duration of the allocate and frees rather than=20
taking it several times, covering the atomic with the lock instead.

You have a big lock, might as well use it and not have to wonder what if=20
things race here or there.

But don't rework that now, maybe just something to consider for later.

Thanks,
Nick

