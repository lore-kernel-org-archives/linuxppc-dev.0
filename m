Return-Path: <linuxppc-dev+bounces-28694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BF4CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:23:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjym1VLMz3c2t;
	Fri, 02 Oct 2026 06:22:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886176;
	cv=none; b=ASsJguXNP74OwRvfrpho7vufJodyBmfPdqMpbSATSJwue9A3k55x+ZzOrBuje7+dvKh5n+9rs/wlFfk5rzbHwmi0W2OrcGUYnF0kDsHtCK9vUNGUEOQnmUli6kslM/hsibV6miM2706AijCNRtr3iHGfKhAmuzOzmgD4Eu2gB39e240S4BLywrdaMt6dH/19fFUb6a6JwYf37/e2zxBXV7JEHDzPTQIIXD224aneOp50xAh8WEa0q2/IwfiPeFH8aA7ocODBVaadMDECbvHXa3KsF6sp9UWiJwmEuUBegfDwmF785+dzT5VfpCis/1VOxMhUBvNlMaFf54l6GrYhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886176; c=relaxed/relaxed;
	bh=O1dYN1wI4HG9y2GFEUVnSNvGtGU2lNVK3HnhJ9Mxy30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOUlzuE7APCtJiyfpL+Don6id/erJ6nYKXcdPH6gFHeKCq4vkKJxVvLE+SuiH/vQogIg6QYSuEqOU5TMLOVaJFgSrWwX8myN2SPVfxPuLomBJv5q7uH0qAkdhJidITchSMqTNy6oucO9fOsBqVdfzqjw2d9nLD3JQfuUy2M+ZjpwCWenB2KMsrKClKJVwgcKtNnnNUMXhsD8yBlgdFpQkQGavw4l7t4IVuEyONIhms4L2Sff+eCyFftAySIVciVFyJ5bFs0DPGhJJwwqULNcnH65z4GTNi90rWum4QvjSEgAIEGzEb0YwBw/MZTAvR0W9j2Hq9QZ0ZcbsDuLramDLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bZKg+Kyp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3hmg-agykdpupbxkgzdlldib.zljifkrummz-absifpqp.lwixyp.lod@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bZKg+Kyp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::547; helo=mail-pg1-x547.google.com; envelope-from=3hmg-agykdpupbxkgzdlldib.zljifkrummz-absifpqp.lwixyp.lod@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com [IPv6:2607:f8b0:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyl3DsJz3c2G
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:55 +1000 (AEST)
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-ca8aee88725so3839443a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886173; x=1791490973; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O1dYN1wI4HG9y2GFEUVnSNvGtGU2lNVK3HnhJ9Mxy30=;
        b=bZKg+KypEQJRaqrZxHyY3bJkKIFrWofvR+0wEn9kAwZsm6IukxfZFSfskDnSSdLDSY
         +KlPVTkdbYAcXWe3qCtCsNbotukPgE4HUl5nHcyr7Rjj1fnqw+psVD6+S6E6844boGMS
         VbgOIPwkTTbVFWcki1b/RvQIVXWIqcdzmX/TI55lmCMuMM6YG7BUf4BBzB4LAhzU3AJa
         tTduV0cNpd+NG9xWEMKBXISghsUWuCr4urGG3AWOUa5ZvFJfkIQ1tQJSa+M+AWezemXZ
         QjG6I2CTKgwM8TnBbMiKX636AoXwBIZx7CTq+lyNQFbJg0GDn+P76QxLQ2lQv4M3Jrmw
         74mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886173; x=1791490973;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O1dYN1wI4HG9y2GFEUVnSNvGtGU2lNVK3HnhJ9Mxy30=;
        b=fG9WwLKHx/s/DjpROg0xkDy6QOSGmupb8zz0UisatQpRCjHOFXJA/uW+uVTy043juw
         Aej7HXXnkhNRC5KRhgGLOLl0EKrJe+Bv9nxWxrMn5c6vhaKUh3+Eay/bNcm9VM9spuZV
         DhKjMJmsDuaKZBmUzhtsjS8e4s5N1QHCFK6ccwxDeS4FagzIKP0bU69EnVk4nuygxtfg
         CZ5JxTwqNpa5HHh79cWMYtpU90ZQFw1B/8/jZQz12A1F4Er/IwoFzey5PbgYn0eJHFpZ
         3dg77gID3/WD1gLADKLY80OZeM3WJNpHIMu++pnc1nmzoVxyM4qE1QmBzH/v+NkOIg9c
         zjwg==
X-Forwarded-Encrypted: i=1; AKwUvByiRWjH4bYafBQihpKPN1UQZYB0Bw4NXEb0McOefcvZoNTpBLePlGi861gI+sLI4QZgv5vP3DejODq7IcQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIDJlqhTshh4R5GMUrEDzf7xCKr52rtzctV9dgVdkDMiIbOGLBg
	+lKmz/ZZaKsLsZwb9/85vXYuKdtSooYBWBfsy3w3mfySIN8CAsaDnqTBdw+za8AnL+QRZQGqssy
	+0oD9ww==
X-Received: from pjbic4.prod.google.com ([2002:a17:90b:4144:b0:3a4:c30b:2845])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a92:b0:3a4:9d98:f973
 with SMTP id 98e67ed59e1d1-3a6ceab2518mr406933a91.11.1790886172949; Thu, 01
 Oct 2026 13:22:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:33 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-10-seanjc@google.com>
Subject: [PATCH v2 09/10] KVM: nVMX: Don't try to load eVMCS12 page when the
 VM is dying
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't try to get/load the eVMCS12 page when KVM can't do uaccesses to guest
memory, i.e. when the VM dying, as reading/writing guest memory via the
associated userspace address space is obviously broken if the address space
is inactive and/or has already been torn down.

Hack-a-fix the eVMCS code even though KVM now protects against bad uaccess
reads/writes in the core APIs, as doing so will allow adding WARNs in said
APIs to help detect other buggy code.  Add a TODO to call out that checking
if KVM can do a uaccess for the VM is a hack; nVMX really needs to stop
abusing __nested_vmx_vmexit() when destroying a vCPU.

E.g. without the "fix", adding the sanity checks will trigger:

  ------------[ cut here ]------------
  WARNING: ./include/linux/kvm_host.h:1359 at kvm_read_guest_offset_cached+0x1b0/0x200 [kvm], CPU#14: hyperv_evmcs/27428
  Call Trace:
   <TASK>
   nested_get_evmptr+0x4f/0x80 [kvm_intel]
   nested_vmx_handle_enlightened_vmptrld+0x2a/0x130 [kvm_intel]
   __nested_vmx_vmexit+0xbe/0x8e0 [kvm_intel]
   nested_vmx_free_vcpu+0x36/0x50 [kvm_intel]
   vmx_vcpu_free+0x73/0x120 [kvm_intel]
   kvm_arch_vcpu_destroy+0x81/0x1a0 [kvm]
   kvm_destroy_vcpus+0x9d/0x160 [kvm]
   kvm_arch_destroy_vm+0x25/0x90 [kvm]
   kvm_put_kvm+0x342/0x460 [kvm]
   kvm_vm_stats_release+0x12/0x20 [kvm]
   __fput+0xfe/0x280
   __se_sys_close+0x76/0xe0
   do_syscall_64+0xfe/0x440
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x4a3822
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: f5c7e8425f18 ("KVM: nVMX: Always make an attempt to map eVMCS after migration")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8e31eba4d9fa..07ec0dd014b5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5091,8 +5091,13 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 * Enlightened VMCS after migration and we still need to
 		 * do that when something is forcing L2->L1 exit prior to
 		 * the first L2 run.
+		 *
+		 * TODO: Drop the explicit check on being able to access guest
+		 *       memory once KVM no longer abuses the nested VM-Exit
+		 *       flow when destroying a vCPU.
 		 */
-		(void)nested_get_evmcs_page(vcpu);
+		if (__kvm_can_do_uaccess(vcpu->kvm))
+			(void)nested_get_evmcs_page(vcpu);
 #endif
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


