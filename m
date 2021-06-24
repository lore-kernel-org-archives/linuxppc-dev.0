Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA56EC49EA5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 10:42:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF7D613FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 10:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF7D613FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9cCp6XWfz3bTh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 20:42:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Kt+9hz5Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Kt+9hz5Z; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9cCJ6ZgRz2xvV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jun 2021 20:42:18 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id n12so4359985pgs.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jun 2021 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=NfjdhOW72m4TGpvzWGEQF11KzSsneVbaVBvFK0bGPzo=;
 b=Kt+9hz5Z8hf17MTaP2NEbCNsixEB/2vtcneDIWMxInZE3wFpBTCY4arVW85yk4tRHF
 qWXnzq5TbY8JfmQrKqxmZnou8HmT8i1seCjd1BlC3DaEQNjDAwV+HQjRqrh2wSC5wL59
 gRrb2rxjfZldQEn+6eMb0tmL7unUZmTBjbxFxwf6fUug4isZHK1CcpQ0getq8GAd87FC
 3RcDqKD/Mv0yWnn2UAF2jMZ1K/PXC5Gqwy+wDcve3LXPzWTqm+dcHR3tVukvmCrbGHtj
 N0va4eRcYEBOnrKc/XVLBME0xL1myho/N5KENcJl2Jx0DUZHv582U2/2wqKp+nzNi87p
 llKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=NfjdhOW72m4TGpvzWGEQF11KzSsneVbaVBvFK0bGPzo=;
 b=pCh9C0o/PxkdSyCbzQfT787iAKFAF4PSiU5nKDJj4POJufh2yFL9W6wzPa1UvSqbNP
 H1ffeACnjQb0XtfRDuQnCukD5PmElVAo6TAv0r1snszz5VE7TZXVww9wMTCQfRMFGjbD
 isNqoK2YIqn/WZjYl44VGh61gwLxy4LHOGXTrwqEdH55TCpitF7PIMdZYHw8+deJzclZ
 FtBO55US9k4cCszL9MCM+oLwuOq/ERAkrj35sbHROpYMNmGmYHT8RRFtruk7tY/MEHFX
 0X+GjvusEn74wifAF+yVQ/dtkJg9/8J2cMl+Wqztx/Kt60ni6r2sh2CwyJPae8uF5Rp+
 Cpug==
X-Gm-Message-State: AOAM532lbjP5FOJ0owP4oU5Jk2jAi+ldA9Se1n1taxif5TJFB30AkWG4
 otDKhUbS09UDoZJivsQj9Cc=
X-Google-Smtp-Source: ABdhPJx+bbBfj2pzk/mB2ERG+jW9T31gVCsxpF6k7D325eLHwjfeRucb+BobnHJ3y5XGrFTWG6Ebcw==
X-Received: by 2002:a63:586:: with SMTP id 128mr4140080pgf.366.1624531334522; 
 Thu, 24 Jun 2021 03:42:14 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id i8sm2522609pfq.165.2021.06.24.03.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 03:42:14 -0700 (PDT)
Date: Thu, 24 Jun 2021 20:42:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/6] KVM: mmu: also return page from gfn_to_pfn
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, Marc Zyngier <maz@kernel.org>, Paul Mackerras
 <paulus@ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>, David Stevens
 <stevensd@chromium.org>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang
 <zhi.a.wang@intel.com>
References: <20210624035749.4054934-1-stevensd@google.com>
 <20210624035749.4054934-3-stevensd@google.com>
 <1624524331.zsin3qejl9.astroid@bobo.none>
 <201b68a7-10ea-d656-0c1e-5511b1f22674@redhat.com>
 <1624528342.s2ezcyp90x.astroid@bobo.none>
 <1624529635.75a1ann91v.astroid@bobo.none>
 <fc2a88ed-6a98-857d-bb1f-73260b01ac30@redhat.com>
In-Reply-To: <fc2a88ed-6a98-857d-bb1f-73260b01ac30@redhat.com>
MIME-Version: 1.0
Message-Id: <1624531085.fax3fcqpgc.astroid@bobo.none>
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
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, intel-gfx@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvmarm@lists.cs.columbia.edu,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 kvm-ppc@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linux-mips@vger.kernel.org,
 intel-gvt-dev@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Paolo Bonzini's message of June 24, 2021 8:21 pm:
> On 24/06/21 12:17, Nicholas Piggin wrote:
>>> If all callers were updated that is one thing, but from the changelog
>>> it sounds like that would not happen and there would be some gfn_to_pfn
>>> users left over.
>>>
>>> But yes in the end you would either need to make gfn_to_pfn never retur=
n
>>> a page found via follow_pte, or change all callers to the new way. If
>>> the plan is for the latter then I guess that's fine.
>>
>> Actually in that case anyway I don't see the need -- the existence of
>> gfn_to_pfn is enough to know it might be buggy. It can just as easily
>> be grepped for as kvm_pfn_page_unwrap.
>=20
> Sure, but that would leave us with longer function names=20
> (gfn_to_pfn_page* instead of gfn_to_pfn*).  So the "safe" use is the one=20
> that looks worse and the unsafe use is the one that looks safe.

The churn isn't justified because of function name length. Choose g2pp()=20
if you want a non-descriptive but short name.

The existing name isn't good anyway because it not only looks up a pfn=20
but also a page, and more importantly it gets a ref on the page. The
name should be changed if you introduce a new API.

>> And are gfn_to_page cases also
>> vulernable to the same issue?
>=20
> No, they're just broken for the VM_IO|VM_PFNMAP case.

No they aren't vulnerable, or they are vunlerable but also broken in=20
other cases?

Thanks,
Nick
