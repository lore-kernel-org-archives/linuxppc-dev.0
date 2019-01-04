Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6379C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239BC206C0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7OB0Rv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239BC206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJYv1qcXzDqFS
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 19:56:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="X7OB0Rv6"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJW13jMQzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:54:20 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y4so17212865pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=s54CWoMBwC/zNmAKjZOvrFS4zL5cc4VeheWOnWbsbcs=;
 b=X7OB0Rv6x6K201MwLVR0NTSf1nCzTgQvzvZlrHC9jbh5Yn/NUxF7S9JpxOff2/a67c
 /3NkSl0D7Dactf3miq3lgBXrXbLPGEYwZVcNhlX9gbH+ahhnogWtMfnIir2t1FU8P0Ep
 Bd8uWIIrc5Y/CScBFsHSrpZCa+TXWV2fnc2zaG8foh9m/Ngph5755U9dYDS7+Hb/1hB/
 XaiDrEZD3zQ8RXSYE5FyIYQ4/xzDvNRbFkPIuonph7cd8cx7O6TAG7GpskNlktUtzTaz
 gvohfnLVuQvGbT8ubil3v+QMn68aLirQOnws2NCk1cvyGbQihEcAF2esmC+//BFrOhJs
 bGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=s54CWoMBwC/zNmAKjZOvrFS4zL5cc4VeheWOnWbsbcs=;
 b=Or5WF1ja0mu64ABpAIacHBNzkzWZUSbK7PWQy71c7OH+O/XeLA0LbjY+unkR66+v84
 dg0ML8Ozif9iVYGsw/UbFuMRwiWWQ46Sdm/Nxt4dGuSy58LxrFja4QWqLpOFTgJtUczb
 ZQi6ed/qmct7E2BiSzp4JklPqklokoZaB9QTFewBHOkH7brrxloZv1YCB8wTCpSeyhJh
 5IxSLket7vcVmfrldaeENyPxZHaqHxUyZTo8pYDXYaGamYs6Ic6TQNCuvPbObVsW2AHN
 2y513PhCWY+1Oi03rS6FFNvMAp2Pc7RiILm+cEjLxZYlLEWKv4DSAqHzeq3znL57vr2v
 EluA==
X-Gm-Message-State: AJcUukchNkOQpw3wpmVeRlYb+ZEJfgAOEB9sU4sNaKLfVo76A9vDY5zj
 MXG1/WfnH0I1KIrRjyE+N5U=
X-Google-Smtp-Source: ALg8bN6TKO/FbJdy9H6pHPilkdPA0uBYPyFKYsWoLiF0HM2Gb0AxFE+KDE3IQXIY+upyYE2K8qdZag==
X-Received: by 2002:a63:554b:: with SMTP id f11mr923300pgm.37.1546592059172;
 Fri, 04 Jan 2019 00:54:19 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:18 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 00/11] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM
Date: Fri,  4 Jan 2019 16:53:54 +0800
Message-Id: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 catalin.marinas@arm.com, jhogan@kernel.org, linux-mips@vger.kernel.org,
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

This patchset is to introduce hv ept tlb range list flush function
support in the KVM MMU component. Flushing ept tlbs of several address
range can be done via single hypercall and new list flush function is
used in the kvm_mmu_commit_zap_page() and FNAME(sync_page). This patchset
also adds more hv ept tlb range flush support in more KVM MMU function.

Lan Tianyu (11):
  X86/Hyper-V: Add parameter offset for
    hyperv_fill_flush_guest_mapping_list()
  KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
  KVM: Add spte's point in the struct kvm_mmu_page
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM/MMU: Flush tlb with range list in sync_page()
  KVM: Remove redundant check in the kvm_get_dirty_log_protect()
  KVM: Make kvm_arch_mmu_enable_log_dirty_pt_masked() return value
  KVM/MMU: Flush tlb in the kvm_mmu_write_protect_pt_masked()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Flush tlb in the kvm_age_rmapp()

 arch/arm/include/asm/kvm_host.h     |  3 +-
 arch/arm64/include/asm/kvm_host.h   |  3 +-
 arch/mips/include/asm/kvm_host.h    |  3 +-
 arch/mips/kvm/mmu.c                 |  8 +++-
 arch/powerpc/include/asm/kvm_host.h |  3 +-
 arch/powerpc/kvm/book3s.c           |  3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            |  4 +-
 arch/x86/include/asm/kvm_host.h     | 11 +++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 73 ++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/paging_tmpl.h          | 18 ++++++++-
 arch/x86/kvm/vmx/vmx.c              | 18 ++++++++-
 include/linux/kvm_host.h            |  2 +-
 virt/kvm/arm/mmu.c                  |  8 +++-
 virt/kvm/kvm_main.c                 | 18 ++++-----
 16 files changed, 141 insertions(+), 39 deletions(-)

-- 
2.14.4

