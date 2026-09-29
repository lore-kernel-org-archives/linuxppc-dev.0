Return-Path: <linuxppc-dev+bounces-28428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BDFCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 01:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv1Nr03s8z2yMn;
	Tue, 29 Sep 2026 11:51:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790646667;
	cv=none; b=e29XRmuVqDkCH4xZVZmXvFXPfXVrMUdq+THoRbJ/s5/70cWtf9uPrwqVaTn795BB58C0zdIG7iJ/1jHKIZMvI7LwzPFYHOtkISMz7yJAzU9wn/l/J9QpfcmApSz8OZfmH86yT7Y3HQe8k9Ym7UIOWfa9i5ayrji8E+KLJz4PfqEv2YTDEX5Ods5UBimowiEQvtGv048IEszkcLLI8Fo2QmiAMTR06JgIuyc4DvrGiNgwrUm1r+dd5E2jl+8hWejngPYlfVC/IAy8CHtoVCe3hY3Wy906EACyRCX74U6yIXRlhONNPBtyA7J2eWEG8XXsbUkAGhQH+59eT9xe4Ymohw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790646667; c=relaxed/relaxed;
	bh=defNTj3mi7sHrxVRjwLhgcyKIEsYh8Z0QM3DyUvlMZY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=P/xhLb6XLGBDN+wrW9Y3X4M8+GSAeq708Dihx1p1Fwk1IanctdPFPZ4yW8UJdHIBiAEma2DALWHMPr7L1RcM+PR8lRJURsykfk1RnL4KNFphKt3mZQ32GnJ98OqLOCRiDvrMipVOCRteo8HR7vWjX3QgCGIXdBruGtC3RtBw2SK+mC6iSyP5N+6RBqx5vGOCPwN1geRPxTOh8O54LcshJOB/p7ypqNYoUiRnwoLj7Coy3Wa9qcKFcibuPcqBCKEGMhLT/wTlU20woX6dG47O13igYfgGVDTaBNvJ0yqg8ZtxhwMnQN5pVZEu64LEGwJiEwgFldf+lY1rUh9y3Zk2HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PETq2V+V; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PETq2V+V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv1Np4j83z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 11:51:05 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33bfb26865fso3760854eec.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790646663; x=1791251463; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=defNTj3mi7sHrxVRjwLhgcyKIEsYh8Z0QM3DyUvlMZY=;
        b=PETq2V+VNmi9F53JV9OwBAS4x5iN1EdA31b6VLbXKFkyGCxkPBMSyurIEFIfIgLc7p
         L3RLWWc0XYiZw2eZh7JJmD7MRtJgLRUWYOXTbV8cgXylX/OkU51jd6/rqZ+XfhKoGyXc
         usaRKLWjQfBJKguW+yxQVs44+VWt6b5gydCWzwdqfrm57eujRpE6Wu+LNVG525X0Tbik
         3hEO9agc/2WHqyPcGyWSSBdBEyP4afCXDsdlwilk1/37QULR5hEHx+lPhLdONDAp8noh
         /AsjJLOEJpDVWUy2RpvCfdyGMp5HzYc+CCCL4u4Re9xO57+BUrGrJyXbrtzXIJiEn9aA
         h/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790646663; x=1791251463;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=defNTj3mi7sHrxVRjwLhgcyKIEsYh8Z0QM3DyUvlMZY=;
        b=h5mniP7haEYKd5aDz2eBaNzraX6uL+RNZ7EU0Wg6tg6Qmi3d+SFI6C93Q//ji1wtPx
         yH69SfutZhsmfwL74LAkqiTOI29EkzBxI7BUpu4gq4ovQrQD/gMOUWkyxzvnwq3DH5uQ
         7/XGw4EogfEkjecbupskl/LzKwNsezWSlyZM2Fbf7VrLQ8RKRPyBawELBgSCw/BMqb62
         6d2/9UiKYOQz+/2OKsvXwNTL56KIhSn1bCSyG7Sxhvz9r+WInM2Zh6Oel/Y8tdexEJ5X
         MkpD9aqOKIaEiJhEB/wQsbxC3/b7NI0ZmzDl5d8nv9eRZEWIrRGU8TA8ubVt/6tgCvVe
         GmgA==
X-Forwarded-Encrypted: i=1; AKwUvBzHttzQ9PYhQhKf5+z5TCVwdOhcDbi9U/ayDl4+Luf9bvcq+V8ZoLOErt5v4ytvKEmxQ//BHsXteqZzQIU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKmu3K9LFdJyXTBq1lS3/QmhaXRsLR1TccTJ99KesViXMcUvYuU
	Tk0LMsbMZ9NU4Mv2c2sGYtHxX8bXn1wmXSWLaPEZ8wwY3F/25XlpUM4s
X-Gm-Gg: AYBFou2x6AoUhE2nEYYLeg/RphTzmq7JwzIZvKsj0ceKS9JfQGXyocbGqMUF5mRUOWC
	0rkEgh89y/H5OaTQFQt0kSWD9FsCeklFoEVWeV2D87bjqGMn4tPbum7jdpTW7RhnEOGYf7I+d2K
	0TuyvMpZiXFXNiR6Hm5XVfPA0XOTjupYu1+VAOK214EixKN5ochDcO4TNbiNgmqZUBYA1wr0NsG
	nsmN0WACIOooJ7RVyhS8UA1UG/CTnLOvXimD5AspM4agd0SKcDMpjo0BPhhohW0/1qSvHyQH6he
	3puYlHZ2lvkvlWCHlOtZtIO9JlW26hWmeZ99phHJTlvYZ7IlQgKYTjlljzYvi1jFBiIl53AUjCY
	+txEcsCdIJWCX0dxFaoaMT41OxGcMLkPRc782wIWJhIq1017ULKgRSxNtX5zzfa/KVByU9abh+k
	vO/d4v/ckpDIcMzb1we5+ReNglOnWudmh2AtY2ogZxGuHA8dqFJCLriw5Uj90cvLvT0MPAs32DM
	Tq9sFUR3FKTcGYeny6f/1EwdFNxrNWVx7u2t2WowgpHg7KHY4nPx5odzGyCJJTBEA==
X-Received: by 2002:a05:7300:ed06:b0:33c:e61:e1e5 with SMTP id 5a478bee46e88-34739c07e6dmr8293196eec.21.1790646662193;
        Mon, 28 Sep 2026 18:51:02 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341f2b18cbfsm29834837eec.30.2026.09.28.18.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:51:01 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
Date: Tue, 29 Sep 2026 07:05:35 +0530
Message-ID: <pkxwkffc.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> Hi All,
>
> This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
> radix MMU).
>

Hello Sean,

Just wanted to check what's our plan on this one? Are we planning for
both PPC pre-enablement series of yours and this one to be taken for
v7.4 merge? Do you think this can go in too?

Thanks for your help!

-ritesh

