Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA0606A31F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 09:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF2JJ2L8kz2xwL;
	Wed, 28 Oct 2026 20:34:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793179117;
	cv=none; b=Ns8j3uVqvuW73m/JiZRCtpyfkWzoxvleV2jmM5UTTw27ZznTiTGi+npLEw+7EwriH1cojHGWWQ9Ngfof85SrrsQpydnvQCSneXPBI7NqrWWMfcUStwj9XmmUWw84kNVG30MnBUB+IQMAYItj8wgVp5dU0SDYARVIQ5E9aK1nlo0IYGRcBeNYSVJs51s9A+h2xKzjmTGT1eMEFIkzJ7KrU0jNG5JK7sjJKcKKrtNlSTaYe3l+GPVCKpjsoU7Fu9PZ2pm69gWGT2dVObUr/Ag8f7ngeE9Vt1rpuP282iKYf6KujbN//VcMWyEl3FE0yWVtYxgyj9Hw7fCD980+5qTxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793179117; c=relaxed/relaxed;
	bh=l7lrYcEGz7yh1S6DURIldpkH4Iej6k+y8xqTeXsmih8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JWmWRbZZEDlCFTQEhL2/bn3M+B5Cj+9NpIo5TCLLs3J9gRgVRTC7+QDFHNTCzkYqWGQJWLP8WcnqRAMwwieXBe7h0deIOnCQo/wzii3YeI6Itbha5wHmAT22rtMQzF5+9OWXupNnlUVE8Qp1HUGSP5tLOwp4urlTmkwS6UQzvVYc0itm1ff0ob3OCEzKOiwSzB7FqEkplI7Awnmrm2RCVTBRagDOCq5mR2jCLE5hY+kbi4NoPf7v2goqTK6Nz68QdSV+g9FlhxZIkuerI3XUhIzm3/rNSwEouByKlbtYnYCo0mZZqg7iqGpFeWJZKxsZAXUAArMxVrHsxv4s/6sBXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.160.70; helo=mail-oa1-f70.google.com; envelope-from=36l3hagkbaek39avlwwp2l00to.rzzrwp53p2nzy4py4.nzx@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.160.70; helo=mail-oa1-f70.google.com; envelope-from=36l3hagkbaek39avlwwp2l00to.rzzrwp53p2nzy4py4.nzx@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF1xl5Kr7z2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 20:18:34 +1100 (AEDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-49e379ab077so901136fac.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 02:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179112; x=1793783912;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l7lrYcEGz7yh1S6DURIldpkH4Iej6k+y8xqTeXsmih8=;
        b=UZNdx6jG8BY9ILWACOwaHdrCHpj3JDLkAxO1p+pcUp0X9worZ4A7ph9koeLbK0DW96
         grzi11yVII/2Vsb6fUV0iGhowprkUM6TGvEudzyOBjUFWkh2ESFHRGEGsEEuHZgE5jgu
         iupo+uwalCwJVSuCjlmUysk9WSpFm1Yef7bFCeSG1xanDzph+2m4n8d0HNAQPSxPRe2K
         bz0MN57a2NiNxAp7Qu8001pYHIPnlq+SZ6UXqMP9DRTwamE4dj0/DvRHZuUlBr46Xwmw
         g9CguuPRW7+PYYw+HrH6Rdlw1gK2IZQMn5pOnoRN5/HPsSrfGNsjbHFF03TTFWMHhWn1
         OctA==
X-Forwarded-Encrypted: i=1; AKwUvByQPSiyZTYSXn4GNiBBW/UV3KOY8GMOhfFCsLOIrgcwM0CUsJCqt5u0+wfFO+3q7Y2B9iUcPd5yfiT3hws=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIoHWNfAu1DXjBYgRKx567vGiJGOStTQK2YHeeSeO/5alRJa8cN
	DJOyKhTTnsQpUuBzFSYrmxC+pwMlaIfuwzJQF1Sl0krHf0qdXhnlpBUfTut52p07NJJigyokYW4
	jL4BTbsk0Q+r0b2V9kXwxVAkPfWpuJY4DEc8z8ANMh3ZEbZlSWIUhYYvrzBc=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c133:b0:55b:fcf7:61f8 with SMTP id
 5614622812f47-56383598cfamr956832b6e.40.1793179112073; Wed, 28 Oct 2026
 02:18:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 02:18:32 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae1bde8.f0fe5aea.79aa1.00a0.GAE@google.com>
Subject: [syzbot ci] Re: KVM: Fix+harden against bad uaccess using dying VM
From: syzbot ci <syzbot+ci372bc25d95b65291@syzkaller.appspotmail.com>
To: jmattson@google.com, jthoughton@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, mason@kernel.org, npiggin@gmail.com, pbonzini@redhat.com, 
	seanjc@google.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

syzbot ci has tested the following series

[v3] KVM: Fix+harden against bad uaccess using dying VM
https://lore.kernel.org/all/20261027221209.1560865-1-seanjc@google.com
* [PATCH v3 01/15] KVM: Reject user accesses to guest memory if current->mm != kvm->mm
* [PATCH v3 02/15] KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
* [PATCH v3 03/15] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
* [PATCH v3 04/15] KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is freed
* [PATCH v3 05/15] KVM: Disallow setting memslots when the VM is being destroyed
* [PATCH v3 06/15] KVM: Destroy memslots immediately after mmu_notifiers are unregistered
* [PATCH v3 07/15] KVM: WARN if KVM attempts to do guest-related uaccess with "wrong" process
* [PATCH v3 08/15] KVM: WARN and reject guest-based uaccess if VM is dying
* [PATCH v3 09/15] KVM: Pre-check uaccesses in KVM's APIs to read/write guest memory
* [PATCH v3 10/15] KVM: VMX: Explicility free vmcs01, not the current VMCS, in vCPU free paths
* [PATCH v3 11/15] KVM: nVMX: Don't explicitly VMCLEAR+free() vmcs01's shadow VMCS when freeing vCPU
* [PATCH v3 12/15] KVM: nVMX: Cancel the nested VMX Preemption Timer's hrtimer in free_nested()
* [PATCH v3 13/15] KVM: VMX: Explicitly remove dying vCPUs from the PI wakeup list
* [PATCH v3 14/15] KVM: nVMX: Don't switch to vmcs01 when freeing a vCPU
* [PATCH v3 15/15] KVM: nVMX: Don't load+put the vCPU when freeing nested state for a dying vCPU

and found the following issue:
WARNING in vt_vcpu_pi_remove_from_wakeup_list

Full report is available here:
https://ci.syzbot.org/series/c648fc23-f4c2-4346-93cd-b717ef38b27c

***

WARNING in vt_vcpu_pi_remove_from_wakeup_list

tree:      kvm-next
URL:       https://kernel.googlesource.com/pub/scm/virt/kvm/kvm/
base:      7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/e4ed6c4f-9b58-4549-9ac6-525add47e472/config
syz repro: https://ci.syzbot.org/findings/320f356a-c5e9-41ff-b8f5-3f0866e300b7/syz_repro

------------[ cut here ]------------
refcount_read(&vcpu->kvm->users_count)
WARNING: arch/x86/kvm/vmx/posted_intr.c:154 at vt_vcpu_pi_remove_from_wakeup_list+0x142/0x1f0 arch/x86/kvm/vmx/posted_intr.c:154, CPU#1: syz.2.19/5870
Modules linked in:
CPU: 1 UID: 0 PID: 5870 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:vt_vcpu_pi_remove_from_wakeup_list+0x142/0x1f0 arch/x86/kvm/vmx/posted_intr.c:154
Code: 48 85 db 74 2d e8 ee 1b 64 00 eb 0c e8 e7 1b 64 00 eb 05 e8 e0 1b 64 00 5b 41 5e 41 5f 5d e9 c5 b5 87 0a cc e8 cf 1b 64 00 90 <0f> 0b 90 e9 2b ff ff ff e8 c1 1b 64 00 e8 ac 60 cf ff eb da 44 89
RSP: 0018:ffffc900037cf8c8 EFLAGS: 00010293
RAX: ffffffff816404a1 RBX: ffff88816ada8000 RCX: ffff888110eb0000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffff88810fb01f83 R09: 1ffff11021f603f0
R10: dffffc0000000000 R11: ffffed1021f603f1 R12: dffffc0000000000
R13: 00000000fffffff8 R14: ffff88810fb01f80 R15: dffffc0000000000
FS:  00007f9e487ab6c0(0000) GS:ffff8882a7cbf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f07a7ed4870 CR3: 000000010eea9000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 vmx_vcpu_free+0x28/0x400 arch/x86/kvm/vmx/vmx.c:7517
 kvm_arch_vcpu_destroy+0x154/0x380 arch/x86/kvm/x86.c:9556
 kvm_vm_ioctl_create_vcpu+0x76f/0x9f0 virt/kvm/kvm_main.c:4384
 kvm_vm_ioctl+0x442/0xcb0 virt/kvm/kvm_main.c:5294
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e4799f1eb
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f9e487aaed0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f9e4799f1eb
RDX: 0000000000000003 RSI: 000000000000ae41 RDI: 0000000000000085
RBP: 00007f9e47a36b20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000c00000 R11: 0000000000000246 R12: 00000000000004ce
R13: 0000200000c00000 R14: 0000200000001040 R15: 00007ffeb7342be8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.

