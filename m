Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C0BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:09:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE3E2070B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHeHpCpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE3E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445ZW81BwgzDqW5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:09:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oHeHpCpv"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445ZSK1RbZzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:06:56 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y5so1217983plk.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 07:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=EiQBCSDAIf/suoeIwapm+FX4BR230o85XgcWooq6xpo=;
 b=oHeHpCpvC2AoMktGH/FylVXGTrHXAAlZwXTLNGNTPVr+jXY93hFWcuEeceYTyB2prt
 2rvvFgZ3gQU9hBYqEtXQWn4hXd7/3XkuVewfkGv86mW/NUOf2IvLU9H7mEBwl9Gp1u5L
 +jVImO1D2WzSZMxc7RsGxQtHnhV52l0CIjRzNeg1ujDJqpuVFpblk6qFUaS5lAJagbAQ
 BAyxleQsFdr6Gar/VUDt0QtIf4RMlt73YvIZG7rrHMOcsQUVh68pS/QQCfbhRVvtNJN7
 yZbM5BhQLh6tbXzh5iSAT/wgHpkQqs+pDJZ27Fh8wqM/R9hDywOjjUORLVOpG/utNIkI
 X0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EiQBCSDAIf/suoeIwapm+FX4BR230o85XgcWooq6xpo=;
 b=Hq72lyYa3neuWhekzCPB1oVWVbDFrJH68qwUXTgKQZf7gVqx5YlZoGuF+7s283D+GX
 M9m9JvmemljYOsKDfVj7w72E9/9Udiut2j0cAqLnvVZ/HvLAkV3nJ4ZXgTPFZOD8S+hg
 Hbjzazl1UQjYfZipI2AKX9ZHrElgt/AAiziNZe/20zDehPIXINs/itLLpGpasQMPrzxO
 1/0lt88EjLsfA06zlRiG63ewA/fKPSwQHp+fROSvVd/eswSRodVVhLCKqoOGZYztiFf6
 EQ2Vngxac4l1j6wFtpjn3yju72ORDG8kdU9okANt/5siy2pJvSFnWspSCvbl7QaZ9V+u
 OM8A==
X-Gm-Message-State: AHQUAuYA6vqf2vVL7yD8TVNibKsdU13N/7bbsMHonvYBTQcDMZxINwwk
 bVFR4MyjI1LzTGgdMvzV38k=
X-Google-Smtp-Source: AHgI3IZbPWlYQzuwjEhbQFDPOboaR5xFVm1PNF+pNbeBeCaY7FX4MLfmcdiKb1W6D3NMvqNF02xA3A==
X-Received: by 2002:a17:902:2de4:: with SMTP id
 p91mr4658872plb.215.1550848015074; 
 Fri, 22 Feb 2019 07:06:55 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.06.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:06:54 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM 
Date: Fri, 22 Feb 2019 23:06:27 +0800
Message-Id: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
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

This patchset is based on the fix patch "x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT".
(https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1939455.html)

Change since v2:
	1) Fix calculation of flush pages in the kvm_fill_hv_flush_list_func()
	2) Change the logic of setting/clearing last_level flag

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
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Use range flush in sync_page()
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM: Add kvm_get_memslot() to get memslot via slot id
  KVM: Use tlb range flush in the kvm_vm_ioctl_get/clear_dirty_log()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Use tlb range flush in the kvm_age_hva()
  KVM/MMU: Add last_level flag in the struct mmu_spte_page

 arch/arm/include/asm/kvm_host.h     |  3 +-
 arch/arm64/include/asm/kvm_host.h   |  3 +-
 arch/mips/include/asm/kvm_host.h    |  3 +-
 arch/mips/kvm/mmu.c                 | 11 ++++++--
 arch/powerpc/include/asm/kvm_host.h |  3 +-
 arch/powerpc/kvm/book3s.c           | 10 +++++--
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            |  4 +--
 arch/x86/include/asm/kvm_host.h     | 11 +++++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 55 ++++++++++++++++++++++++++++++-------
 arch/x86/kvm/mmu.h                  |  7 +++++
 arch/x86/kvm/paging_tmpl.h          |  5 ++--
 arch/x86/kvm/vmx/vmx.c              | 18 ++++++++++--
 arch/x86/kvm/x86.c                  | 16 ++++++++---
 include/linux/kvm_host.h            |  1 +
 virt/kvm/arm/mmu.c                  | 13 +++++++--
 virt/kvm/kvm_main.c                 | 51 ++++++++++++++--------------------
 18 files changed, 156 insertions(+), 63 deletions(-)

-- 
2.14.4

