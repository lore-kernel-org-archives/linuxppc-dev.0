Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F052C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:01:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AFE2081F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFOfxJw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AFE2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CqBs60H2zDqmX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:01:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFOfxJw9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFOfxJw9"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cq7X3T44zDqfK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:58:48 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id s198so4336948pgs.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 19:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=GsTFIcVTzDDaHX++c2Kr7Xhn+UQEZoAVxahy2lMLQSw=;
 b=XFOfxJw9ESuS7rQT18DI0pkGV17rNFSzVuc08Lg1tM5F3Gnhosm0dm419M3R1JZ37p
 MA6oBCHNF0AAkNrcEFo+BbI597KkGm09ojzDhcjLIvCQhb42V+BIUj08swndumFrVMon
 fVinOJ0so95ROdTRIbwcZxppvQR+XilRLdlCJ5uCqGXzTHVzVS/xSN4Edd4rtJOxhYZK
 LWsLPM/ANrLpg2lUBSJDAh2PBJiMzFgtI7pVHCUevjDbj2qbirLXwdIiw91pE0354aJJ
 PGPguTe4Rx2wdV9LoVNX+san0wPsvuAan+yNJlh+HnrPSAg5dLh9/NEGqhiYYubbuTV/
 OZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GsTFIcVTzDDaHX++c2Kr7Xhn+UQEZoAVxahy2lMLQSw=;
 b=T+4LNvZJUF8M/gjFjks3s5SdFlaP45u3O7H6rSthh/Mjhp5slw8KcBvtaSVoIBIARa
 jt0hh1K4SGB6REYIFdGdrtUp/w+6OeapuIGa+W7CAJhV0QBFtDOfNohPMPY5wjTFy/m3
 L1quYUrIVO+m71EB1PkVGN6JEN4Z5fUUM+uaQEne/P682zCYfUmygS6KkEz4qxHhtT/R
 orI0ELkG+LDkiJmKgQJILmXZsyYVpZnz2E5r31sHWHjCjPFO+Wy1o6AmKSU8IU3iHnC2
 4MZ9ku5TYnD9M3OvmuMsYvT12dJO8tQ5MUTV3xbHyZC4xCmoqASTDrZwNEg2Tb4+7Z5x
 PLMw==
X-Gm-Message-State: AA+aEWYj9cCxugE6MJTFM5ag2xyHygeoFHNJUPIW4PQhqf6E36I52MuF
 UpbZxKaqECt8rhcYoAcn2Ao=
X-Google-Smtp-Source: AFSGD/WmQ8l0+VtkTQr1wQPKOJA2y08PR6E2dWmISbx4wSUj4hfqCgpOZVUk9lsgyPyE6tTFu0G16w==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr11019811pfi.172.1544414326545; 
 Sun, 09 Dec 2018 19:58:46 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f6sm14291899pfg.188.2018.12.09.19.58.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 19:58:45 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH V2 0/8] KVM: PPC: Implement passthrough of emulated devices
 for nested guests
Date: Mon, 10 Dec 2018 14:58:17 +1100
Message-Id: <20181210035825.29404-1-sjitindarsingh@gmail.com>
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

echo vfio-pci > /sys/bus/pci/devices/0000:00:00.0/driver_override
echo 0000:00:00.0 > /sys/bus/pci/drivers/e1000/unbind
echo 0000:00:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
chmod 666 /dev/vfio/0

3. Pass the device through from L(n+1) to L(n+2)

qemu-system-ppc64 -device vfio-pci,host=0000:00:00.0

4. L(n+2) can now access the device which will be emulated at L(n)

V1 -> V2:
1/8: None
2/8: None
3/8: None
4/8: None
5/8: None
6/8: Account for L1 differing in endianess in kvmppc_complete_mmio_load()
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
 arch/powerpc/kvm/powerpc.c               |  30 +++++++-
 arch/powerpc/mm/fault.c                  |   1 +
 11 files changed, 325 insertions(+), 15 deletions(-)

-- 
2.13.6

