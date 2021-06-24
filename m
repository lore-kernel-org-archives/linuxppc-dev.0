Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C86FC49EA5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 15:37:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B4A613DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 15:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B4A613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9klf4Mqyz3c8d
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 01:37:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20161025 header.b=bSQo4DhU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62a;
 helo=mail-pl1-x62a.google.com; envelope-from=seanjc@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=bSQo4DhU; dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9kl76Y3yz307c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 01:36:50 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id 69so3151867plc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jun 2021 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oSmcLkLaYmb30K4x2o5V0PgF5sReFf2n8jT9UaERRsg=;
 b=bSQo4DhU2KuL3CjUZN64j4WcwdggQch/R7XnEdix2NVuOf40qPGfYHBno8Xm619GAr
 wg2kvoNy4VPNerE1UJQqTO/mn+wSl2WW8B9f7dL8xOzOgdg74JEfehGKdbWSQ0+1rr/t
 2LEY4HKbsscIOGINiR9uO5OVpBxOglyxXqSvwqqzzZpKt1BhIehu/QDEuFSbgcAbmd1A
 2Vn5BfcWryEpw7ny/6e9BAwB13V5uLq3/TeIlPL3nNBaDSZ9vfocg3yuStOuQjDnW2a3
 vbLINUOPqFtht9Zb0kQj2xFTxtidhP/wmPjkGUm290ZvEfhGiSSc1t+MN7azCayA+NIy
 PYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oSmcLkLaYmb30K4x2o5V0PgF5sReFf2n8jT9UaERRsg=;
 b=oST2qb4+N8w+u2Njn3sK2NWi+VWmhWxA1/KUhzwSa7tC0cUDTEoB/h+8n4DxrUFQTL
 2yLjm+1iGgQ0AHxHmRY9UWJ/9kwk5geJP8kqBpKi6bmlb0BNvFAEBIZ4O2sJGf7TTgRu
 r/mk5Z7hj4Hq1nbeHqXVTAodoTM/qEb0EHD8h7v5S9hJEZ3nR4hIezugUhbvJC4L/abW
 67vsQ2ZfaHK+2K07c47/YieRRTaDnDJOjcHr2ym1p0BOxu/hOfiw8K1OPNY0yz1I9RyP
 WkErUPx2GM4uiEglT6qBX0wYbLMZEecFr67fn7eEVcffq1Pt3dtpF5cUwU9091UxIrNt
 onTw==
X-Gm-Message-State: AOAM53349QVdizjkpaXPGPgLQBwqTJa9os51Gg2CaQSoVkMATzAREVmZ
 JzeTCDD5BeU0jLDbn3SB24xbmg==
X-Google-Smtp-Source: ABdhPJxfmbtVti63yi0rwniZ/V3vp7ddChowhbbwk916pZwapRYWPu+wwBqr+2N8fYjWJaOb0U93+Q==
X-Received: by 2002:a17:90a:8542:: with SMTP id
 a2mr14115924pjw.185.1624549004763; 
 Thu, 24 Jun 2021 08:36:44 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id p1sm3132065pfp.137.2021.06.24.08.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 08:36:44 -0700 (PDT)
Date: Thu, 24 Jun 2021 15:36:40 +0000
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/6] KVM: x86/mmu: release audited pfns
Message-ID: <YNSmiOsmJin4UPcG@google.com>
References: <20210624035749.4054934-1-stevensd@google.com>
 <20210624035749.4054934-2-stevensd@google.com>
 <1624524156.04etgk7zmz.astroid@bobo.none>
 <4816287a-b9a9-d3f4-f844-06922d696e06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4816287a-b9a9-d3f4-f844-06922d696e06@redhat.com>
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
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 Zhenyu Wang <zhenyuw@linux.intel.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Huacai Chen <chenhuacai@kernel.org>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Zhi Wang <zhi.a.wang@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 intel-gfx@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, intel-gvt-dev@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 David Stevens <stevensd@chromium.org>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 24, 2021, Paolo Bonzini wrote:
> On 24/06/21 10:43, Nicholas Piggin wrote:
> > Excerpts from David Stevens's message of June 24, 2021 1:57 pm:
> > > From: David Stevens <stevensd@chromium.org>
> > 
> > Changelog? This looks like a bug, should it have a Fixes: tag?
> 
> Probably has been there forever... The best way to fix the bug would be to
> nuke mmu_audit.c, which I've threatened to do many times but never followed
> up on.

Yar.  It has only survived because it hasn't required any maintenance.
