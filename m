Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F27C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:12:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE362082D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 04:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUA1+iIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE362082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439zZp6WtCzDqtV
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:12:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUA1+iIL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUA1+iIL"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439z063WcpzDrZD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:45:58 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id p8so1179786plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zzSebPlF9stYoovZD7pq+uxBNI+mOMCRQixpXZ/GVXc=;
 b=lUA1+iILkbHb8nOhzaU7311rCdgmtT6tmSdHuULAQj0Yj/8gqgeUl60kI+WGkRwOZC
 YHLf/zcdnZt8NrC9MgNBHtQTDkhONBX0s+iyd3WakzRL8q0h5tGuJvgMwr9AictZqnLf
 iMATfUsTsntTS+N3ryeoO5eZjnGLfg6Xx/+LlqbVxbyXT8KpPKwCAP2w+wF+0BFFconN
 2QF7OnzeF84R7bdD+aFMD53ryqzvIOWkg4ueYNxvtF+AImOJsjUfur57USsEhyD4rWpP
 ejUvgu5xo2FbCCaqWn2xNgwX1pg0W4blI0BxU+VqiPAHukel3GCEqFpymJchfzOAtBYy
 m7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zzSebPlF9stYoovZD7pq+uxBNI+mOMCRQixpXZ/GVXc=;
 b=eM52xkucqJAOjpBncQ9ctT+4ioxrI1L2/EtUrLtNyv63g/rJhFeYftGhhebvOPEHCH
 6chfyIN4zXnpYbrdlQkrlPU82J2/jmnEZ5KDXDjR9TaIWfvXoktGuuPjlfvtAltMtuKg
 PUvmwTE5whext94BAozypoBDa9s7hqi0XL4cuKCSkBJh1EMDsEgABjmObOH82b1jWwN5
 OYPaR4Z23fY0juGw87D2DztSkTESCGofFi1FXHeWcQrl6ysM3nwfjypmp+LCcfkIy2KY
 ePpWjiLLs8Z0h9al5HY3ohHMsWkxcpbaGmTcxh6anJmK9IeH58FJ9/5e50RzJ1AWqeul
 nZrA==
X-Gm-Message-State: AA+aEWbPKd1qLNRLjbCJh6BSxHBVHJQmhX5kW7qxB22jwdPSsY0PGQ3x
 W61A3MgF5vmWosjH75WQOEI=
X-Google-Smtp-Source: AFSGD/UdA0yHiRMsNznwuxNPOKUG2NX5uEDDNcoxK6DQGdiy/SxgoBntYagakrfjXBYLNRARgpDiZg==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr625673plp.19.1544154356777; 
 Thu, 06 Dec 2018 19:45:56 -0800 (PST)
Received: from localhost.localdomain ([1.129.148.150])
 by smtp.googlemail.com with ESMTPSA id x3sm4780916pgt.45.2018.12.06.19.45.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:45:56 -0800 (PST)
Message-ID: <1544154350.1865.0.camel@gmail.com>
Subject: Re: [PATCH 0/8] KVM: PPC: Implement passthrough of emulated devices
 for nested guests
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Date: Fri, 07 Dec 2018 14:45:50 +1100
In-Reply-To: <20181207034326.3564-1-sjitindarsingh@gmail.com>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-12-07 at 14:43 +1100, Suraj Jitindar Singh wrote:
> This patch series allows for emulated devices to be passed through to
> nested
> guests, irrespective of at which level the device is being emulated.
> 
> Note that the emulated device must be using dma, not virtio.
> 
> For example, passing through an emulated e1000:
> 
> 1. Emulate the device at L(n) for L(n+1)
> 
> qemu-system-ppc64 -netdev type=user,id=net0 -device e1000,netdev=net0
> 
> 2. Assign the VFIO-PCI driver at L(n+1)
> 
> echo 0000:00:00.0 > /sys/bus/pci/drivers/e1000/unbind
> echo 0000:00:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
> chmod 666 /dev/vfio/0
> 
> 3. Pass the device through from L(n+1) to L(n+2)
> 
> qemu-system-ppc64 -device vfio-pci,host=0000:00:00.0
> 
> 4. L(n+2) can now access the device which will be emulated at L(n)

Note,
[PATCH] KVM: PPC: Book3S PR: Set hflag to indicate that POWER9 supports
1T segments
is not supposed to be part of this series

> 
> Suraj Jitindar Singh (8):
>   KVM: PPC: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machines
>   KVM: PPC: Book3S HV: Add function kvmhv_vcpu_is_radix()
>   KVM: PPC: Book3S HV: Implement functions to access quadrants 1 & 2
>   KVM: PPC: Add load_from_eaddr and store_to_eaddr to the kvmppc_ops
>     struct
>   KVM: PPC: Update kvmppc_st and kvmppc_ld to use quadrants
>   KVM: PPC: Book3S HV: Allow passthrough of an emulated device to an
> L2
>     guest
>   KVM: PPC: Introduce new hcall H_COPY_TOFROM_GUEST to access
> quadrants
>     1 & 2
>   KVM: PPC: Book3S HV: Allow passthrough of an emulated device to an
> L3
>     guest
> 
>  arch/powerpc/include/asm/hvcall.h        |   1 +
>  arch/powerpc/include/asm/kvm_book3s.h    |  10 ++-
>  arch/powerpc/include/asm/kvm_book3s_64.h |  13 ++++
>  arch/powerpc/include/asm/kvm_host.h      |   3 +
>  arch/powerpc/include/asm/kvm_ppc.h       |   4 ++
>  arch/powerpc/kernel/exceptions-64s.S     |   9 +++
>  arch/powerpc/kvm/book3s_64_mmu_radix.c   |  97
> ++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_hv.c             |  58 ++++++++++++++--
>  arch/powerpc/kvm/book3s_hv_nested.c      | 114
> +++++++++++++++++++++++++++++--
>  arch/powerpc/kvm/powerpc.c               |  28 +++++++-
>  arch/powerpc/mm/fault.c                  |   1 +
>  11 files changed, 323 insertions(+), 15 deletions(-)
> 
