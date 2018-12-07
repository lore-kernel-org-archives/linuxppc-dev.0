Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2841DC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:46:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCE420837
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRv/mQfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCE420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439z0x4kC8zDrVb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:46:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fRv/mQfd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fRv/mQfd"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yxQ6fS6zDrVM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:43:38 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id u18so1169057plq.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=lwiWJZfhOyAHt1ODL6V/fEDofR0eXpF/13/v5GCC6x0=;
 b=fRv/mQfdhu6ZGHl/PMxVsva1fMjOgwqdJ2w40Lm2gyPK5u0yHB8Pgwl9/0fI7hylUd
 WsIrNhXhKBfrz7KQspVWR02vrDGzOh0e/2YwAO3cihdi+c0z7awRdlcCHNFeM0sv9E/r
 U00zWY1NltHa0Fz4Z1LNQuuLjSKJJwyZqIfIvbd/5VCktZVNUOuNchyASzXZgx+KW1mL
 N6ImnXVAj1YqTGlatZeZPOWfW/AqpUiIjUExJuQgsiUxD1LvZmGRpRwBmJFhv919U18v
 MLVkcm0lBHfFzUR0t/3rvhat3tAL4lKQ8evX/IorxiDCNb0yWn1QIVICfKNse7gqhCCJ
 T1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lwiWJZfhOyAHt1ODL6V/fEDofR0eXpF/13/v5GCC6x0=;
 b=eGN91qUalvHOeAi2NItVCOVRgK30nieSLyT08E4vEw9JW7p/l8ard0jjn3zlL4pEts
 bOvqW/DwLpPoQAo1kY+MVcVlwWNniSaWlKcy/0qxfW/E8ELnctigiSrnkoNcDQuETJP9
 fLAEiU2NC9En+p3fYU3DaNKxMnkdw9qQpoCaORJvwCerP+xOI2dF8Wk6QQxlK2slLPDB
 y+qVrTsAGMq4QXCSZR0n1y4yxJoVBt+ldVSDQvGs8AW7uaPlV6h1xfasU79tqxuEWKFo
 VQDjPVE9+aLBvNB4DvaUKQydkTlMI5oYdOdo+CG+VZ3BNuZR+w66T9dpV6vmtVQA0RhO
 Zn2Q==
X-Gm-Message-State: AA+aEWaJ+J8qjZQcGGoBem/9iVaiLqEQbkjIoCh2so8vYlRYjNr9lHlQ
 EhQet+bmp57ItcZpr5ius5k=
X-Google-Smtp-Source: AFSGD/U0ob+zvBZYYa3RITIdRk/T8/ZrjWzd1bu7Dky6znC385k2A3buxaX3NCzK4lrrXA+iOHlN0w==
X-Received: by 2002:a17:902:a9c4:: with SMTP id
 b4mr648409plr.298.1544154217082; 
 Thu, 06 Dec 2018 19:43:37 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.43.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:43:36 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 0/8] KVM: PPC: Implement passthrough of emulated devices for
 nested guests
Date: Fri,  7 Dec 2018 14:43:17 +1100
Message-Id: <20181207034326.3564-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series allows for emulated devices to be passed through to nested
guests, irrespective of at which level the device is being emulated.

Note that the emulated device must be using dma, not virtio.

For example, passing through an emulated e1000:

1. Emulate the device at L(n) for L(n+1)

qemu-system-ppc64 -netdev type=user,id=net0 -device e1000,netdev=net0

2. Assign the VFIO-PCI driver at L(n+1)

echo 0000:00:00.0 > /sys/bus/pci/drivers/e1000/unbind
echo 0000:00:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
chmod 666 /dev/vfio/0

3. Pass the device through from L(n+1) to L(n+2)

qemu-system-ppc64 -device vfio-pci,host=0000:00:00.0

4. L(n+2) can now access the device which will be emulated at L(n)

Suraj Jitindar Singh (8):
  KVM: PPC: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machines
  KVM: PPC: Book3S HV: Add function kvmhv_vcpu_is_radix()
  KVM: PPC: Book3S HV: Implement functions to access quadrants 1 & 2
  KVM: PPC: Add load_from_eaddr and store_to_eaddr to the kvmppc_ops
    struct
  KVM: PPC: Update kvmppc_st and kvmppc_ld to use quadrants
  KVM: PPC: Book3S HV: Allow passthrough of an emulated device to an L2
    guest
  KVM: PPC: Introduce new hcall H_COPY_TOFROM_GUEST to access quadrants
    1 & 2
  KVM: PPC: Book3S HV: Allow passthrough of an emulated device to an L3
    guest

 arch/powerpc/include/asm/hvcall.h        |   1 +
 arch/powerpc/include/asm/kvm_book3s.h    |  10 ++-
 arch/powerpc/include/asm/kvm_book3s_64.h |  13 ++++
 arch/powerpc/include/asm/kvm_host.h      |   3 +
 arch/powerpc/include/asm/kvm_ppc.h       |   4 ++
 arch/powerpc/kernel/exceptions-64s.S     |   9 +++
 arch/powerpc/kvm/book3s_64_mmu_radix.c   |  97 ++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c             |  58 ++++++++++++++--
 arch/powerpc/kvm/book3s_hv_nested.c      | 114 +++++++++++++++++++++++++++++--
 arch/powerpc/kvm/powerpc.c               |  28 +++++++-
 arch/powerpc/mm/fault.c                  |   1 +
 11 files changed, 323 insertions(+), 15 deletions(-)

-- 
2.13.6

