Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED07EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 09:34:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83F1218E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 09:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k27rEf2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83F1218E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Lk3F0MnBzDrDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 20:34:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k27rEf2d";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=paolo.bonzini@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="k27rEf2d"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Lk0S4PTXzDrC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 20:31:33 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id a62so4625189wmh.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NqJ1ZygM7d32i2cesM1IybGBm3lDm82mQWpm0w8o7Dw=;
 b=k27rEf2dEMdOw8CifYQdHb6l0R/Ct5jDpDLUktt87xsdWlSUULeZ6u1oTxTj1BCckG
 eswffTZBgDauF8o5o/x08jdVp7zmqR5iELP+onraOtYNyq/q+ARAhQRlJjIPIbbqaIBV
 vVt0/eRb3JKpdw3Udd72BoBMD+aujZ1yYHBraa2e34m8D0EuftVSFUYDDRV65mGGx8Zn
 VDNmna9w8H1nqNZ/joLNIVe64HMltHZ5p8Hdn3gl79/rvNq49Tkh44LSClsf0rBjxtRc
 5p4pZnXPpgDkBAfnPMdfl5SnhQLFxRDkDhks52UHlon0cZa0uPlclXpcMFbxYtFqihI9
 ZNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NqJ1ZygM7d32i2cesM1IybGBm3lDm82mQWpm0w8o7Dw=;
 b=W2ICYCrn9xwtbs1qXJ+AcKT4PCF1s/9NVElRkrzR1gmpXw9Qv9PEHV0+NeCHaT+nmg
 AapDCoD6eQD7pHzUMTfSjp7qZ1If/PZJ8fdLnULzH6lEyxjRPQGvsOuhLfrVYf2MxRje
 tCFSkyw9UjiHJ0HEvzjgU6lD2xfuuyoldgSM8bGMz4IXy1saYeo95jpbTD2UGoE1a+9I
 /PyEfwGl4+iYnE0ujPZzzV6WHUfE19gSIe2HwLuectBMe3VZcnoTu1yp+ZUnH+duvrZu
 DUUP6d8Oqf/bybokSI6Hp/sD/iZpeMc+u92fkinVafYfRM9FjReEy7H4Qswb1VTTgLEl
 elSQ==
X-Gm-Message-State: AA+aEWYqKf/nvnSlTY4nG3qYsyJo49BSmgqOn3TVTj7i2FrTwkLSWrKq
 YPC8VGqOC7dyjk5SF2sAEAE=
X-Google-Smtp-Source: ALg8bN6NfrY196JuieUaeE6s+5jl/wtM29CTI3sruqQ1pYmXCc0PTNoEy9oJIgWl/0cgwZfjFuqjZg==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr2138988wmd.143.1545384690047; 
 Fri, 21 Dec 2018 01:31:30 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.googlemail.com with ESMTPSA id j8sm8329569wrt.40.2018.12.21.01.31.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 01:31:29 -0800 (PST)
Subject: Re: [Resend PATCH V5 0/10] x86/KVM/Hyper-v: Add HV ept tlb range
 flush hypercall support in KVM
To: lantianyu1986@gmail.com
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <36f1e16f-2390-fa61-e5e0-07320abea9ba@redhat.com>
Date: Fri, 21 Dec 2018 10:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 will.deacon@arm.com, christoffer.dall@arm.com, hpa@zytor.com,
 kys@microsoft.com, kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
 x86@kernel.org, linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 mingo@redhat.com, catalin.marinas@arm.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, paul.burton@mips.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 06/12/18 14:21, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> For nested memory virtualization, Hyper-v doesn't set write-protect
> L1 hypervisor EPT page directory and page table node to track changes 
> while it relies on guest to tell it changes via HvFlushGuestAddressLlist
> hypercall. HvFlushGuestAddressLlist hypercall provides a way to flush
> EPT page table with ranges which are specified by L1 hypervisor.
> 
> If L1 hypervisor uses INVEPT or HvFlushGuestAddressSpace hypercall to
> flush EPT tlb, Hyper-V will invalidate associated EPT shadow page table
> and sync L1's EPT table when next EPT page fault is triggered.
> HvFlushGuestAddressLlist hypercall helps to avoid such redundant EPT
> page fault and synchronization of shadow page table.
> 
> This patchset is based on the Patch "KVM/VMX: Check ept_pointer before
> flushing ept tlb"(https://marc.info/?l=kvm&m=154408169705686&w=2).
> 
> Change since v4:
>        1) Split flush address and flush list patches. This patchset only contains
>        flush address patches. Will post flush list patches later.
>        2) Expose function hyperv_fill_flush_guest_mapping_list()
>        out of hyperv file
>        3) Adjust parameter of hyperv_flush_guest_mapping_range()
>        4) Reorder patchset and move Hyper-V and VMX changes ahead.
> 
> Change since v3:
>         1) Remove code of updating "tlbs_dirty" in kvm_flush_remote_tlbs_with_range()
>         2) Remove directly tlb flush in the kvm_handle_hva_range()
>         3) Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
>         4) Combine Vitaly's "don't pass EPT configuration info to
> vmx_hv_remote_flush_tlb()" fix
> 
> Change since v2:
>        1) Fix comment in the kvm_flush_remote_tlbs_with_range()
>        2) Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
>         hyperv-tlfs.h.
>        3) Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
>        4) Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
>         struct hv_guest_mapping_flush_list.
> 
> Change since v1:
>        1) Convert "end_gfn" of struct kvm_tlb_range to "pages" in order
>           to avoid confusion as to whether "end_gfn" is inclusive or exlusive.
>        2) Add hyperv tlb range struct and replace kvm tlb range struct
>           with new struct in order to avoid using kvm struct in the hyperv
>           code directly.
> 
> 
> 
> Lan Tianyu (10):
>   KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
>   x86/hyper-v: Add HvFlushGuestAddressList hypercall support
>   x86/Hyper-v: Add trace in the
>     hyperv_nested_flush_guest_mapping_range()
>   KVM/VMX: Add hv tlb range flush support
>   KVM/MMU: Add tlb flush with range helper function
>   KVM: Replace old tlb flush function with new one to flush a specified
>     range.
>   KVM: Make kvm_set_spte_hva() return int
>   KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to
>     kvm_mmu_notifier_change_pte()
>   KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
>   KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
> 
>  arch/arm/include/asm/kvm_host.h     |  2 +-
>  arch/arm64/include/asm/kvm_host.h   |  2 +-
>  arch/mips/include/asm/kvm_host.h    |  2 +-
>  arch/mips/kvm/mmu.c                 |  3 +-
>  arch/powerpc/include/asm/kvm_host.h |  2 +-
>  arch/powerpc/kvm/book3s.c           |  3 +-
>  arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
>  arch/x86/hyperv/nested.c            | 80 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h  | 32 +++++++++++++
>  arch/x86/include/asm/kvm_host.h     |  9 +++-
>  arch/x86/include/asm/mshyperv.h     | 15 ++++++
>  arch/x86/include/asm/trace/hyperv.h | 14 ++++++
>  arch/x86/kvm/mmu.c                  | 96 +++++++++++++++++++++++++++++--------
>  arch/x86/kvm/paging_tmpl.h          |  3 +-
>  arch/x86/kvm/vmx.c                  | 63 +++++++++++++++++-------
>  virt/kvm/arm/mmu.c                  |  6 ++-
>  virt/kvm/kvm_main.c                 |  5 +-
>  17 files changed, 292 insertions(+), 48 deletions(-)
> 

Queued, thanks.

Paolo
