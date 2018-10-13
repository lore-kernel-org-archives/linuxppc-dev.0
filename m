Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2F1C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 05:55:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0649C205F4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 05:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iptJbN9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0649C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XrQd6JFnzF3CR
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 16:55:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iptJbN9c";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iptJbN9c"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XSQq4QsnzF3DW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 01:54:24 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id u12-v6so7578612pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=qRIE2f33zVx7l+zax50LPFwdkUfPKlzQ2ecUdzjJB3w=;
 b=iptJbN9c7EXhdMtLuNVDWpdEX79VyhZ/htZ+sDq/0gR2dP1AIYzptr3iNcS4dIhKuE
 gKw0scn4icIEQk2lUAZ2WgG/ONCcoYfNbDD4oYWQfMASgZKFuZjGjOA4PRN7GaECv8ck
 n/2kTGtpkX8cnOiPay1nwjGWywFo4yOAGytbQfkZwU2tg0ewFBKfSh4JEH7fgTcNBwrc
 eGHD3EwzUxJ3gViIkr7q00cmyxGixm8OBwWOPUEZH6uvOyR8FlWKtsQNRJ2u6hGGQBlu
 a80KlkxdLjlR2NpXkH6zCVl+LXrXD6GK0Y+vwxzGldrKVK2BpTpUNoGAtxqIFg4xo6bA
 OOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qRIE2f33zVx7l+zax50LPFwdkUfPKlzQ2ecUdzjJB3w=;
 b=RASrKeYlpSVHXs+PWkGthwncBGX8EcWqZtlrtFVJaxg9rUdYDRKzr2dsgMGlN7iX0Y
 ZrZ2wlqte/RKK0FW7MLcNQQdIdle2MIJ17LC3x3ORPu6bFCbXT4QiARmZbtVTCAkVmpG
 hfiihoj4ORpgS51EY4fS9afoJ7IuBmuLSEKB5kNIJMCzmulUNTOR3maY0nPWtscx1fqV
 0AjnkovVd1FePKyF1fv9Z/cUiD/18/v8IlUh2F3S9pV8wrRhlGF+84qqVyPudUluJpMf
 wHVi3xw2h/k4cOHlfxzVa0auNzJY9NxSskKEGGhV5naKGX4BOLt3u2JmWZz7+aZwJUho
 swJA==
X-Gm-Message-State: ABuFfog+zP/PPC7SH76Eiu7L2wZS6vu72bNTWIE2l+FRT1HtAon6lyyL
 9NOiUPlQT8jI0X0fwtUpMQw=
X-Google-Smtp-Source: ACcGV61HMe2w0niUJncct3r9sXFquEOhFIAsw/cgsgxD0CgIn25ejhdalgbJmm99gXA+gxqlvxuKnQ==
X-Received: by 2002:a63:5605:: with SMTP id
 k5-v6mr9644403pgb.189.1539442462441; 
 Sat, 13 Oct 2018 07:54:22 -0700 (PDT)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 v81-v6sm8688724pfj.25.2018.10.13.07.54.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 13 Oct 2018 07:54:21 -0700 (PDT)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V4 00/15] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
Date: Sat, 13 Oct 2018 22:53:51 +0800
Message-Id: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
X-Mailman-Approved-At: Sun, 14 Oct 2018 16:51:35 +1100
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
Cc: linux-mips@linux-mips.org, linux@armlinux.org, kvm@vger.kernel.org,
 rkrcmar@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 sthemmin@microsoft.com, x86@kernel.org, michael.h.kelley@microsoft.com,
 mingo@redhat.com, catalin.marinas@arm.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, pbonzini@redhat.com,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 christoffer.dall@arm.com, ralf@linux-mips.org, paul.burton@mips.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

For nested memory virtualization, Hyper-v doesn't set write-protect
L1 hypervisor EPT page directory and page table node to track changes 
while it relies on guest to tell it changes via HvFlushGuestAddressLlist
hypercall. HvFlushGuestAddressLlist hypercall provides a way to flush
EPT page table with ranges which are specified by L1 hypervisor.

If L1 hypervisor uses INVEPT or HvFlushGuestAddressSpace hypercall to
flush EPT tlb, Hyper-V will invalidate associated EPT shadow page table
and sync L1's EPT table when next EPT page fault is triggered.
HvFlushGuestAddressLlist hypercall helps to avoid such redundant EPT
page fault and synchronization of shadow page table.


Change since v3:
	1) Remove code of updating "tlbs_dirty" in kvm_flush_remote_tlbs_with_range()
	2) Remove directly tlb flush in the kvm_handle_hva_range()
	3) Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
	4) Combine Vitaly's "don't pass EPT configuration info to
vmx_hv_remote_flush_tlb()" fix

Change since v2:
       1) Fix comment in the kvm_flush_remote_tlbs_with_range()
       2) Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
	hyperv-tlfs.h.
       3) Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
       4) Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
	struct hv_guest_mapping_flush_list.

Change since v1:
       1) Convert "end_gfn" of struct kvm_tlb_range to "pages" in order
          to avoid confusion as to whether "end_gfn" is inclusive or exlusive.
       2) Add hyperv tlb range struct and replace kvm tlb range struct
          with new struct in order to avoid using kvm struct in the hyperv
	  code directly.



Lan Tianyu (15):
  KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
  KVM/MMU: Add tlb flush with range helper function
  KVM: Replace old tlb flush function with new one to flush a specified
    range.
  KVM: Make kvm_set_spte_hva() return int
  KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to
    kvm_mmu_notifier_change_pte()
  KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
  KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
  KVM/MMU: Flush tlb directly in kvm_mmu_zap_collapsible_spte()
  KVM: Add flush_link and parent_pte in the struct kvm_mmu_page
  KVM: Add spte's point in the struct kvm_mmu_page
  KVM/MMU: Replace tlb flush function with range list flush function
  x86/hyper-v: Add HvFlushGuestAddressList hypercall support
  x86/Hyper-v: Add trace in the
    hyperv_nested_flush_guest_mapping_range()
  KVM/VMX: Change hv flush logic when ept tables are mismatched.
  KVM/VMX: Add hv tlb range flush support

 arch/arm/include/asm/kvm_host.h     |   2 +-
 arch/arm64/include/asm/kvm_host.h   |   2 +-
 arch/mips/include/asm/kvm_host.h    |   2 +-
 arch/mips/kvm/mmu.c                 |   3 +-
 arch/powerpc/include/asm/kvm_host.h |   2 +-
 arch/powerpc/kvm/book3s.c           |   3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |   3 +-
 arch/x86/hyperv/nested.c            |  85 ++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  |  32 +++++++++
 arch/x86/include/asm/kvm_host.h     |  12 +++-
 arch/x86/include/asm/mshyperv.h     |  16 +++++
 arch/x86/include/asm/trace/hyperv.h |  14 ++++
 arch/x86/kvm/mmu.c                  | 138 ++++++++++++++++++++++++++++++------
 arch/x86/kvm/paging_tmpl.h          |  10 ++-
 arch/x86/kvm/vmx.c                  |  70 +++++++++++++++---
 virt/kvm/arm/mmu.c                  |   6 +-
 virt/kvm/kvm_main.c                 |   5 +-
 17 files changed, 360 insertions(+), 45 deletions(-)

-- 
2.14.4

