Return-Path: <linuxppc-dev+bounces-28777-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2029CA5FE5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 20:39:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxLHQ5gMLz30DK;
	Sat, 03 Oct 2026 06:39:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::647"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790973570;
	cv=none; b=OMGN+pPpdp/CdHBFj+Z8cbmD2wTaeItrtfJ9xlAIFq/FTg5oI3WxSeNbFMbl787MDAzoFVW/oj/QJKTjwoIBpBwrf/dSPyacxsqAYgZPdHHXzcx9jzT2PDr3hQ/LuX8QB0C1mE3aJPpgJbAWy4In2NrqM4vV5ja2NAZcXRQeTyKnoerZn+j6BmTCxcDot4kWPzu1SAlCdOwDCxDMzRiHWDbuNezGv8+f3/dHOgBbiaB7H7IT3FT1w6Nw16sdzU9JcUewH43HPwbhsb3fq5jLon6tSCHGes/GItPt59zCn5w27yEJo+7S3REabinaEQS3othp+2eg/mXw0NGwwOeuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790973570; c=relaxed/relaxed;
	bh=J0j9tHQdvgPyeE7kOurEk+4M8mVRW7MJtC+t0YWufic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMJwbMN1yElKllmA8kqdHPzBQO2nYFVNO2IBkRWb+IcNIc4i9d7X0Bh6O9LrUiJu5MPxgFY7RQ5Nd8dTZvKoZRIOm6RB1TvY0p7bKCm/qaTroUdWbX/DHRmW1F8Xf67CdK/kvwSw2VA+zSiVp0M6UyX/uFnBTGHlGphPbAGuJ8Ti4KgbQxBt1RmT6OiXbblh+Dh3UhTzABaTBf9acCAd/cN7PQd9vmxftiQl85xrA988I0rJg5GxnlYW4kk+i06bj+rA4Pd542VwUSSFm1Xp/SeqzCQ57LhzD7sKVikI2Ne8ac8j3wAXCCgap4qAlSWmdAwd0b2W+410d01RoLHY9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tP9Lk+CO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3fhbaagykdak1njwslpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tP9Lk+CO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::647; helo=mail-pl1-x647.google.com; envelope-from=3fhbaagykdak1njwslpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x647.google.com (mail-pl1-x647.google.com [IPv6:2607:f8b0:4864:20::647])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxLHP6TRkz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 06:39:29 +1000 (AEST)
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2d7443e0f0bso101625ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790973567; x=1791578367; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0j9tHQdvgPyeE7kOurEk+4M8mVRW7MJtC+t0YWufic=;
        b=tP9Lk+COi85fE+jwNBurQGmNVWmVYrHNkwuiafCjgDQ9I88zXyZ8grjpu9Bv0QEBGP
         dyyPxaacKGlDc3V461No3Oy42Enh4oJEgHXRO8eTeRZ7ws48xfSJf6p2mWHFhDhpsUf6
         EhHg0845Nrf9zqA+RgK970YD8b52MhEh/x5WK1fbjb22kAcxjoA8DcwO4JgLeFPcM21o
         I1dlyiqgVSVi08tFZcIgZgb/97qR+Ly8a8AuwAIruZj9f45QMALo5Zb44RnKkpiLryh1
         l6hruR4lMdKOuRXgSZhYIj8TDZGIOzqjoaeEmkVBA+bvZXyeg0pPH0jcOc6rXEphQqxP
         CTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973567; x=1791578367;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0j9tHQdvgPyeE7kOurEk+4M8mVRW7MJtC+t0YWufic=;
        b=YK6bKnC1nHauXu5WO7DkzOACDEU85wLgt996uj87otz5cNcNPISfsokhj1ODkEB7CK
         YRg0186ZY+bKf+5r9CYQpX8BulirapzXYFinOBYuerfxCwx8O9lvh4zFqyt+IAoln8lV
         prRzakCs0FQfu+jDmAc4VtbL50O4ATASM0+RNuWezp92rb6jg9I4alHZLSJbSP7WlkbU
         DrJVP/mICO9qjNA/dceEQnHeBfZlAB/EE1bPxJ4/kEkVI1xaZZYXQu3KeyDjdG3raEmR
         28F9TPxOA/Psmqd0qtaF7i/6jKsCo+Vt9/uMaIvdhtPlJ/HAGZAfDdv21BdUuNT9cYe1
         xU0w==
X-Forwarded-Encrypted: i=1; AKwUvBxKw8E8kdLet7FFSmCZ+gF5fUzjN+jpYx2Qd2Siua10YxA4sn2Z5UvTcdSDbHjYZT5HaaUT+bJ8fioF5lY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKhYdl7Wz7tr+GjVz7KbUnf+b5Sr/8UsifHk+sWefwujpuzwgX6
	7eXtH/supYs8/z/qCk5nkQjHWN5HthZMeCZUf3liisPwwLXf/CNeXKOx+aQRzT31rLDkwrzrfEL
	/5Xm3OA==
X-Received: from plhd13.prod.google.com ([2002:a17:903:230d:b0:2df:8053:e258])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2e3:1bb4:611d
 with SMTP id d9443c01a7336-2e49b6771e7mr42633885ad.49.1790973566345; Fri, 02
 Oct 2026 13:39:26 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:39:25 -0700
In-Reply-To: <6ac0145f.34119e79.2f92f3.0003.GAE@google.com>
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
References: <20261001202234.3794060-1-seanjc@google.com> <6ac0145f.34119e79.2f92f3.0003.GAE@google.com>
Message-ID: <asAWfZ0N1MXgwQtn@google.com>
Subject: Re: [syzbot ci] Re: KVM: Fix+harden against bad uaccess using dying VM
From: Sean Christopherson <seanjc@google.com>
To: syzbot ci <syzbot+ci69d67bf25886d3bd@syzkaller.appspotmail.com>
Cc: jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, npiggin@gmail.com, 
	pbonzini@redhat.com, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 02, 2026, syzbot ci wrote:
> ------------[ cut here ]------------
> !__kvm_can_do_uaccess(kvm)
> WARNING: ./include/linux/kvm_host.h:1360 at kvm_can_do_uaccess include/linux/kvm_host.h:1360 [inline], CPU#1: syz.1.18/5858
> WARNING: ./include/linux/kvm_host.h:1360 at kvm_is_guest_access_ok virt/kvm/kvm_main.c:3216 [inline], CPU#1: syz.1.18/5858
> WARNING: ./include/linux/kvm_host.h:1360 at __kvm_read_guest_page+0x38e/0x440 virt/kvm/kvm_main.c:3226, CPU#1: syz.1.18/5858
> Modules linked in:
> CPU: 1 UID: 0 PID: 5858 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:kvm_can_do_uaccess include/linux/kvm_host.h:1360 [inline]
> RIP: 0010:kvm_is_guest_access_ok virt/kvm/kvm_main.c:3216 [inline]
> RIP: 0010:__kvm_read_guest_page+0x38e/0x440 virt/kvm/kvm_main.c:3226
> Code: f2 ff ff ff 0f 44 d8 31 ff e8 5e a4 89 00 89 d8 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 09 ac a8 0a cc e8 83 9e 89 00 90 <0f> 0b 90 bb f2 ff ff ff eb da e8 73 9e 89 00 90 0f 0b 90 bb f2 ff
> RSP: 0018:ffffc90003157778 EFLAGS: 00010293
> RAX: ffffffff813e2d22 RBX: 0000000000000000 RCX: ffff888174382580
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 1ffff1102217d82a R08: ffff888110bee183 R09: 1ffff1102217dc30
> R10: dffffc0000000000 R11: ffffed102217dc31 R12: ffff888110bee180
> R13: ffff888174382b40 R14: 1ffff1102217dc30 R15: 0000000000000000
> FS:  000055557c0db500(0000) GS:ffff8882a8cda000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f458dfeb840 CR3: 000000016c9d0000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  kvm_vcpu_read_guest+0x64/0x140 virt/kvm/kvm_main.c:3284
>  nested_vmx_load_msr+0x133/0x4d0 arch/x86/kvm/vmx/nested.c:1107

Oh man.  vmx_leave_nested() is so broken.  If loading MSRs on nested VM-Exit is
broken (and it obviously is), then storing MSRs on nested VM-Exit is also broken,
i.e. there's at least a second case where nVMX can write to random process memory
on vCPU teardown (shadow vmcs12 being the other one).

It probably makes sense to go straight to open coding punting the vCPU out of L2
in vmx_leave_nested() instead of hack-a-fixing a bunch of flows.  I.e. replace
patch 8 and 9 with a proper fix.

