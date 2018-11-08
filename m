Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0148CECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:45:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B192081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 14:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiMOeM1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B192081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rR0w4VW1zF3R3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 01:45:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qiMOeM1/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qiMOeM1/"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rQy65NSHzF3PR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 01:43:26 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id q19-v6so6635507pll.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 06:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=vxBQF0dRycqPAI+VQ2b6lcauq3UFaNK9t6RBJmGboRo=;
 b=qiMOeM1/SRnEzVb1mu+meJt7JF3I6SihxbCjYz54cN7aYc1GeW9WAG1BcWzdp1k0g5
 U665cC9UHDXeEyUC0FSFYRdRlDWtZy/gXeVtopYcvhNOD709R+KNEDpZmC4wdEFyQKHl
 vSaATeWrsftXGX1/Erf7WeQOWtLn5a1u/A1Pb4rdFeOIee/gOrstDCBsS0cZ3WDtVlSz
 +u/q96UzlBdCFqJ/DX2pUQvtzXkXdqF6qG089Veox6w7Z94K5GfPpvPppN0LdwyGUYDL
 +bLmYnGMybj3EoncTSNIAu8v1auR72MHtoCo1pb1ZMTe37+5dSDLeUpruebW8DT0zsH9
 UM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=vxBQF0dRycqPAI+VQ2b6lcauq3UFaNK9t6RBJmGboRo=;
 b=aU+M0ukY9FfiFUHVR6SRhtz4PmWMh3s5fY6weEQTmwaLniJmpCLPZItY3GyIryUmu1
 qz6vu0bH0bKGifHZcn8livggu5kU7C9UH1s0t7icIO/Ie0FqfF5/JEiTzNlpr7AAsKbr
 BJ8LQiIW3soYsFFFLIS9ybkinJsqL1MfW68bhRdgCJoolMcYbMUtbkz302ZncP17Ewty
 VZTsNhHJK7zZd9UNz2QEb3oRS2JSwX9UGA4ir85/3U8GH92Gl/uW731Onix/LDq6RaZy
 EXv5rv2ZvvqmztScZaYtGvNlEvDnE/Pa2cfacoUmPmRkMRRk2IUEMF8067rlT4CV/tbU
 oVDA==
X-Gm-Message-State: AGRZ1gKErQ2CjoyUFFJYJf0vyYO2r9c6KA2i3KoSjYxX7LStvfRWti4G
 VhFTGm1oABaUC38FFsgD33WJuK6SJ9k=
X-Google-Smtp-Source: AJdET5exlz1SZ+ZiRFduKTmQ+stN9ujPhv6GOCDd3Pk1/rZFJygsbx+IqcZ1JrQMsjVlfARg3K4wdw==
X-Received: by 2002:a17:902:8689:: with SMTP id
 g9-v6mr4736173plo.44.1541688204606; 
 Thu, 08 Nov 2018 06:43:24 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id
 p62-v6sm4053565pfp.111.2018.11.08.06.43.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 08 Nov 2018 06:43:23 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V5 00/10] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
Date: Thu,  8 Nov 2018 22:42:59 +0800
Message-Id: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 will.deacon@arm.com, christoffer.dall@arm.com, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
 x86@kernel.org, linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 mingo@redhat.com, catalin.marinas@arm.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 pbonzini@redhat.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, paul.burton@mips.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Sorry. Some patches was blocked and I try to resend via another account.

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

This patchset is rebased on the Linux 4.20-rc1 and Patch "KVM/VMX: Check
ept_pointer before flushing ept tlb".(https://www.mail-archive.com/linux
-kernel@vger.kernel.org/msg1798827.html).

Change since v4:
       1) Split flush address and flush list patches. This patchset only contains
       flush address patches. Will post flush list patches later.
       2) Expose function hyperv_fill_flush_guest_mapping_list()
       out of hyperv file
       3) Adjust parameter of hyperv_flush_guest_mapping_range()
       4) Reorder patchset and move Hyper-V and VMX changes ahead.

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


Lan Tianyu (10):
  KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
  x86/hyper-v: Add HvFlushGuestAddressList hypercall support
  x86/Hyper-v: Add trace in the
    hyperv_nested_flush_guest_mapping_range()
  KVM/VMX: Add hv tlb range flush support
  KVM/MMU: Add tlb flush with range helper function
  KVM: Replace old tlb flush function with new one to flush a specified
    range.
  KVM: Make kvm_set_spte_hva() return int
  KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to
    kvm_mmu_notifier_change_pte()
  KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
  KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()

 arch/arm/include/asm/kvm_host.h     |  2 +-
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/mips/include/asm/kvm_host.h    |  2 +-
 arch/mips/kvm/mmu.c                 |  3 +-
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/powerpc/kvm/book3s.c           |  3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            | 80 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  | 32 +++++++++++++
 arch/x86/include/asm/kvm_host.h     |  9 +++-
 arch/x86/include/asm/mshyperv.h     | 15 ++++++
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++
 arch/x86/kvm/mmu.c                  | 96 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/paging_tmpl.h          |  3 +-
 arch/x86/kvm/vmx.c                  | 69 ++++++++++++++++++--------
 virt/kvm/arm/mmu.c                  |  6 ++-
 virt/kvm/kvm_main.c                 |  5 +-
 17 files changed, 295 insertions(+), 51 deletions(-)

-- 
2.14.4

