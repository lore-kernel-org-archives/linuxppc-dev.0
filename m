Return-Path: <linuxppc-dev+bounces-2019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375B6CFC5EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Oct 2024 18:28:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPdVj3XjMz3c4h;
	Fri, 11 Oct 2024 05:26:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728584765;
	cv=none; b=RnQ0gJaoLDpT2Gf6aIntRl5m4mLWkt6bvBDHx6vsDylCKdfx8oT2L8A3yn0AGba4H/N/QWNZPiLdh2Za+fUGhFsv1uOy5wqQpcBMWbXzr6h5il1iJjnWps1CIc2OpuhKgDZO+rVFGN76br829+x0Bkmm+3ln4VG/w07QmJmDWB8NEN/LORGoNU18ySOgrpnLG2eMrMY/0GHtJkEY5Kthlq/zOxkGwZp1EU3Ceog2yocqTuIq4MCLfy571LS7wHYFYydFUJQ8XzsCU9M/nCpm8D9lDaaDWJjm37YlWigUAKGX++4uSTpfhv1dBt3EUaQxRsyYlD7rUnwJ1e1jsv2iLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728584765; c=relaxed/relaxed;
	bh=w3u38MFKj4Hgu0NiviVwRjtFpk/ioMNBGBDQlt4DAgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L9n7xT3149ihi39DgzbThsYsrmCLcl/9MRxAziTKfekh8jIGk1qbi3+Lop1uC3Adg+XI1cNj+LSLkjPEVgfloNkKO6lmaCVJrqa/hXEEJJdaASz/wsbSDxbWh3AFCoOi82v6zA8M4PWWYhNlDZqBe4tBPB4W87HBk48/cnZFLx5Qq1MmMPBgueMUWegyIkMEoO+XXVQ8fh3y8l2pbfm8Hrm+g+0RM2k5Q5wzzqkW6Brv0L4A9kYjdHCpx0Deb94tO0RJWLtyJYZk6c/lw57op2FRqFSifnU8p/EeStaE+Bp29LFgtbyWPsf64HxzAXBZykG6doOPUg+fMyL0SXZhcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=1Xaw2lBs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3ohwizwykdnef1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=1Xaw2lBs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3ohwizwykdnef1xa6z3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPdVh4M6xz3bkL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2024 05:26:04 +1100 (AEDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-71dfda86c8dso1460315b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2024 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584763; x=1729189563; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3u38MFKj4Hgu0NiviVwRjtFpk/ioMNBGBDQlt4DAgY=;
        b=1Xaw2lBsglGUhx7hoB2tsGYkr3n4TIwQRy1+a3uCrbR7zbo4quJ1xrS7vz9oGmsMH/
         PWcz5IzgCeMdMkpE08Y95PnyCM8FW6vr+8c2WU3tu86VMJlLJtLtmayIiPbJo7PVNV5y
         41mfwzsAM2SKvJIc53MnYalGg0I/gJ8ZmTuXk80jFImKgBdyZdrA3M8H897uaDP03gZl
         2iFFM4MQHzlBwSgT5Nl1M/VfMbSUQ8OXy6iPRt7eVwwnBeD9yXD9Cf6YU+iOmt4KRi2k
         J7z21OBVgNsZTfyfE8ebGfA0KhoiY4UInQaU6HZIRiAfvs9I4+fuUTSFCKOXgcrDfoRB
         cUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584763; x=1729189563;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3u38MFKj4Hgu0NiviVwRjtFpk/ioMNBGBDQlt4DAgY=;
        b=cksIWOTTs2aXcCXe94qHuDY6FGFwCDlUYhz3nP68138Y70chFwtXp94iD9zm5SCzea
         ILvt2iKcKMD1YAi4t2aQ7wzGEgzHa4C+BnP+hjp7Y5K/Y2rWyEzb/OerkP6v+zf7NSzb
         qKUWagj77m1SVLfq3dZMpzmGb1PPlm1qomj7GwLpZ/3JdWZLFBOwjmNyFni2L6/CtSyh
         ligQDJfHrQv422d2uX3TYTtWML1/MbJjVKtvVbmve3dorbl69J3GQ7N9NVXqSBKrT6g7
         q3J4ogLLzCTE0ejLR1F1jCDrZmgwoDzxDPGJBw4GyAdLXFqAmaNGL/+BYjKDE8aBBIkj
         PH/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7jORoRjffCFtSElPfq52RJikwoGlRMmXqQoA7qBcP9+eu05pLQhcECJf2kvjG9cc+AN8XGld1xJzfiNQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7N/GxQV3affQm2MlyaQyIaxb9VK+/0oGHQPxl2jEt+Rsqpv4m
	s+Icbl40QrbPmbe+Axl25JNrVBPvuH7gob+MB7g0IOsE2akUOiKg96ZrBBWWrOssL3kqvXUUk1N
	XLQ==
X-Google-Smtp-Source: AGHT+IHthU1bxxWE76UmRU/cmSB/2b+tJYVulTyd1SGmZGLYBHQFEbukUNmDJAlwNs2CFth+SfvGFADhDCI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2f51:b0:71e:dd:8f9b with SMTP id
 d2e1a72fcca58-71e1dbe8750mr6976b3a.5.1728584762866; Thu, 10 Oct 2024 11:26:02
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:36 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-35-seanjc@google.com>
Subject: [PATCH v13 34/85] KVM: Get writable mapping for __kvm_vcpu_map() only
 when necessary
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When creating a memory map for read, don't request a writable pfn from the
primary MMU.  While creating read-only mappings can be theoretically slower=
,
as they don't play nice with fast GUP due to the need to break CoW before
mapping the underlying PFN, practically speaking, creating a mapping isn't
a super hot path, and getting a writable mapping for reading is weird and
confusing.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 080740f65061..b845e9252633 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3122,7 +3122,7 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, =
struct kvm_host_map *map,
 	struct kvm_follow_pfn kfp =3D {
 		.slot =3D gfn_to_memslot(vcpu->kvm, gfn),
 		.gfn =3D gfn,
-		.flags =3D FOLL_WRITE,
+		.flags =3D writable ? FOLL_WRITE : 0,
 		.refcounted_page =3D &map->pinned_page,
 		.pin =3D true,
 	};
--=20
2.47.0.rc1.288.g06298d1525-goog


