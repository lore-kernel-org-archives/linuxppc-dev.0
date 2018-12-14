Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E282C67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:32:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42252086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 05:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNK/MBjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42252086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GK1p4yv5zDrBH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 16:32:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UNK/MBjp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UNK/MBjp"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GJyQ6pxjzDr0C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 16:29:34 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id c123so2273808pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 21:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=iYskH9+rG7/3gZ1CITpa56PTQTCBpW3ek3wSb7T6OWs=;
 b=UNK/MBjpHubwOaBO/qVieUuPDrkxfAGdtiN7jfy2o4KNwemf2ULghuiHzNb26Bmz8K
 m6PX/gA3c66N3c/baoz+vsKAPSWRHR+hADWyjTHmpyFlz3kq/Waw+/WE8CKVn51gN+ki
 OWkx4gBe1bxUf0PA+zxSan8l9l6qNrpZnHeDpyoTH6bdk8uDvNhJQGGN8UGxIuvXJ/tp
 wI2skTWWLWC9WU8mDdoDGbhhoCnp8ATSldNmcNELMPuGEwitYNDyEFL9/5ib8JXKh8hO
 4sYavxwQAMMO2odYFsBtaTxd6TiGMXBphMns5FTcDvwQXT1UEY66K+3gninWx301Qn8V
 j9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=iYskH9+rG7/3gZ1CITpa56PTQTCBpW3ek3wSb7T6OWs=;
 b=skQlae8VyqlpIWjQ0o7Z9IqeFzXx5kz+Mv7dJiZg9rdjlpQNNK/iL+X9EF4iRq5cvj
 rmyXBbASJObXh2Rdf0mAHOQuHy0h1ZHXVRqyyzqJHutvLMcfwuFJX3gRUUh38cQ+zy+I
 dbbjlg/1UPteA6rIJdivsy9H2SDPssYAvDgzZG8ZTizwySwOwLOyVdbugOsEdWg9Gkc0
 GnJnLVaPR+WT3go/QcYuGb1jB1YYk7h1UTmsUhDSFJPilPogVoVQrcdVtxg1GqYYrvjw
 EYq+G5M6BmRPoFuNXzydlLoB9Q9D093NAT6bI10g1srNa9LdiOlNfMrEwu2uFDTvEr54
 7VpA==
X-Gm-Message-State: AA+aEWb+t4PjJnu2WE7yEiRekJG6IadFlNxM/yjmkUqipl4RSkznJSqp
 OSfRYkhp46kjC2o90+sRLn8=
X-Google-Smtp-Source: AFSGD/VQeGh1iRMBFZ3jDkJF9XCOQ+c0k0spyRLrLdJoGKbcd2uGEtmVAd+/OfOs4Ercf2Y7hNLYyA==
X-Received: by 2002:a62:36c1:: with SMTP id d184mr1602260pfa.242.1544765372503; 
 Thu, 13 Dec 2018 21:29:32 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d21sm5358697pgv.37.2018.12.13.21.29.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 21:29:31 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V4 0/8] KVM: PPC: Implement passthrough of emulated devices
 for nested guests
Date: Fri, 14 Dec 2018 16:29:02 +1100
Message-Id: <20181214052910.23639-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm@vger.kernel.org
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

echo vfio-pci > /sys/bus/pci/devices/0000:00:00.0/driver_override
echo 0000:00:00.0 > /sys/bus/pci/drivers/e1000/unbind
echo 0000:00:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
chmod 666 /dev/vfio/0

3. Pass the device through from L(n+1) to L(n+2)

qemu-system-ppc64 -device vfio-pci,host=0000:00:00.0

4. L(n+2) can now access the device which will be emulated at L(n)

V2 -> V3:
1/8: None
2/8: None
3/8: None
4/8: None
5/8: None
6/8: Add if def to fix compilation for some platforms
7/8: None
8/8: None

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
 arch/powerpc/kvm/powerpc.c               |  32 ++++++++-
 arch/powerpc/mm/fault.c                  |   1 +
 11 files changed, 327 insertions(+), 15 deletions(-)

-- 
2.13.6

