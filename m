Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135A5C282D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 14:50:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5BF20870
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 14:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VclUM1Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5BF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rg4y1q0gzDqhT
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:50:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VclUM1Gr"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rg3046DJzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 01:48:44 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id p4so42295plq.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
 b=VclUM1Gr6vplH2lc6Ex2uMcst7OpLUwzYdrhBjSpiDgIZg76ZHVjpKJ4U4SExjF3QV
 Od3ncVcWLzN8HgUVQB3KUYeup4HFmP2iE1LT+/OtaQTbCvbGUwggPiD6Pm/POl+Qa6BJ
 Md0Xm3LYjrStc9gxfllVcDGzfzcB78fp+FLJTEFRLG/J+Vi+TlYL2STO78l/1+ysLbe9
 gHtU5rJNNQMbJbNDj9yPz7VuQ6bZrSfnwP1kjrFJlgoKfVOTkOp5Qj/mst+wK1BwGFRm
 5YHV9KRzExaWbwjLj7uIzqTVFmXCxOB44fYAqN5swmaQaifUYQagLR1fr/V7merQuAco
 YdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
 b=Ui3SViOY271vLEvkYGG24jx/gQaabFutmTAXtmT3zsg2vY/cq1G+jtQwE8hXKUliZ9
 QcdVwAEXwMqP0YJJpf0Wo6A6NgeSw+Gw7oFUX8nlp1ZgAMlW5U7JNx0/01BlU90Rk4Dp
 srXL9b+qELjClHhmg9QGfea4yA0rMj07He67h9IVehHnXYA9MV2Tmumsm3FnaPCB8SI8
 nAIdBKEuTAkUrCUAvU28Lma4SBT3vQdcjYt69HHT2bIRGgFucAW+Pppmr6wG6vP+iwTC
 IyPk3qXo2iyEcgxD3WQSbvZxqgvgKfdpALaKmZGLu99d9ZU9VRzrCzizuAKuyXY6aTy6
 YMsw==
X-Gm-Message-State: AJcUukfuFNjsu8VwoGkGYtSAC+jMRYi7r5gPi8vsmdnU1hona+9tOcBE
 NS+mv5fPhSOM43fheWEIkig=
X-Google-Smtp-Source: ALg8bN5eyyO1GjD67omoBBXbC4wUV9Hny7kZddb4cDJA6juGAKguzsu8tLq3FRvPinM9K65VT/+xzg==
X-Received: by 2002:a17:902:8641:: with SMTP id
 y1mr39725750plt.159.1549032522270; 
 Fri, 01 Feb 2019 06:48:42 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id n74sm2309674pfi.163.2019.02.01.06.48.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 06:48:41 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM 
Date: Fri,  1 Feb 2019 22:48:12 +0800
Message-Id: <20190201144821.50409-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, will.deacon@arm.com,
 christoffer.dall@arm.com, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sashal@kernel.org, sthemmin@microsoft.com,
 x86@kernel.org, linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 mingo@redhat.com, catalin.marinas@arm.com, jhogan@kernel.org,
 linux-mips@vger.kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>,
 marc.zyngier@arm.com, haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
 bp@alien8.de, pbonzini@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, paul.burton@mips.com, devel@linuxdriverproject.org,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patchset is to introduce hv ept tlb range list flush function
support in the KVM MMU component. Flushing ept tlbs of several address
range can be done via single hypercall and new list flush function is
used in the kvm_mmu_commit_zap_page() and FNAME(sync_page). This patchset
also adds more hv ept tlb range flush support in more KVM MMU function.

Change since v1:
       1) Make flush list as a hlist instead of list in order to 
       keep struct kvm_mmu_page size.
       2) Add last_level flag in the struct kvm_mmu_page instead
       of spte pointer
       3) Move tlb flush from kvm_mmu_notifier_clear_flush_young() to kvm_age_hva()
       4) Use range flush in the kvm_vm_ioctl_get/clear_dirty_log()

Lan Tianyu (10):
  X86/Hyper-V: Add parameter offset for
    hyperv_fill_flush_guest_mapping_list()
  KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
  KVM/MMU: Add last_level in the struct mmu_spte_page
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Flush tlb with range list in sync_page()
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM: Add kvm_get_memslot() to get memslot via slot id
  KVM: Use tlb range flush in the kvm_vm_ioctl_get/clear_dirty_log()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Use tlb range flush  in the kvm_age_hva()

 arch/arm/include/asm/kvm_host.h     |  3 ++-
 arch/arm64/include/asm/kvm_host.h   |  3 ++-
 arch/mips/include/asm/kvm_host.h    |  3 ++-
 arch/mips/kvm/mmu.c                 | 11 ++++++--
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s.c           | 10 ++++++--
 arch/powerpc/kvm/e500_mmu_host.c    |  3 ++-
 arch/x86/hyperv/nested.c            |  4 +--
 arch/x86/include/asm/kvm_host.h     | 11 +++++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 51 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/mmu.h                  |  7 +++++
 arch/x86/kvm/paging_tmpl.h          | 15 ++++++++---
 arch/x86/kvm/vmx/vmx.c              | 18 +++++++++++--
 arch/x86/kvm/x86.c                  | 16 +++++++++---
 include/linux/kvm_host.h            |  1 +
 virt/kvm/arm/mmu.c                  | 13 ++++++++--
 virt/kvm/kvm_main.c                 | 51 +++++++++++++++----------------------
 18 files changed, 160 insertions(+), 65 deletions(-)

-- 
2.14.4

