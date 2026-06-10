Return-Path: <linuxppc-dev+bounces-22412-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82542CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 13:05:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5bl1sG8z2yfD;
	Wed, 10 Jun 2026 23:05:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781096707;
	cv=none; b=f3FOQllAxQ63IXMo29WlJjTHu7OuF4KRJUsvIqojJdG/pFe0PnUZpogU9D7KB3C3mygXM3h44gmk2hELBpSn/vAP20LUnkeRHj969ZRSRzriRLBxkYCfj+/JZrlaUHVYQSFuyQRjzS77TX9IANB+AsXwYm6BxamYkNfp2uc6bexXrI9fTm4/DLMucWOo0q5sW/5qMwRyyYL9dAtyzb2k1fxqj714PPUEzNZbicApCiC+SHThe2f5ULUz5NtQCPaIpxIIqmYTJBn+Rm4Mi3dU2i12QdYsn+rRMQtHD4W1uDPeq6qR3yfkjbrjiLCpMBg5buDrkB+PtkrIxlcOpikqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781096707; c=relaxed/relaxed;
	bh=BhOF/rw2NLmHZ4tMIcOqKhkPNZ2ah5k2exN/z5Da1iM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jOf9ispUz1af4B+7uM2SpDsM7IRIG53OSXmmYzXZ1YxKRPNQ+u7lSpn482cx46CsPQ9GGy7FI36fn20hk0aRFPs+8ZQHQEeKGGq0gJNo40DqipwcH/5d5AWKvMk8oUMU+m0XvuW+OFFuArDC/cpZOSXpTREmA3WRbQg6Nfp39ww1mZ9sxFHHglXzoJt63eQyDGRI+Qz7NxEleceGmw8pHcCU5kuYP+Du9bFaFYyrw6zPCLQslMKofJuRSTpd8WsUQeQ72vC5bokLDBgsuYKmEpZuVMkCLRfAzhP2koTIBhGQxj0udftdTX+7gJ0i2USj6lKRm41xtbO78NX7eFMSYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HySVIF+Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HySVIF+Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5bk2Mh4z2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 23:05:05 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7267755a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096703; x=1781701503; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhOF/rw2NLmHZ4tMIcOqKhkPNZ2ah5k2exN/z5Da1iM=;
        b=HySVIF+Zh5gad2rCLtru6ONBmgQdDMpHOoCCllVfFK9FxSy7eyBRMENkxqf1g6k8t4
         znxxyfjSt3/N82i4Xjwdc6lIPeKzEC6xeDJ0gqBcYrfRpxRy/sNvPzb9FkV2Vo8jNQHs
         Xqkw50WgSndiiJbPV0oTBCpsjVX9D8+kOa0oAUpi5jpPBgrav5dI4UEcekt4HhpCrhSJ
         9GlVrr9xMKOH2exs/PFjjx/MhuoOJnqFNMb9b+mT8PG9eQyfdwDY+7QF3t9bII5Ub4b2
         2lEYHYSdYdaSAh9PXd0HJoP0W4DucTGWBxKuW9pWzwhE0ZmcbEODxm2c0kjLs8w6pdwQ
         ooTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096703; x=1781701503;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhOF/rw2NLmHZ4tMIcOqKhkPNZ2ah5k2exN/z5Da1iM=;
        b=s+2+RJkWgRy6TQzZSArjxIZ2j5euSkZDHNqcRyBFZ/fuhIV+1QQCcyjU7bQCI7CwHK
         7nusVG2MbTKxJUYM5YGx2UoiOrM+fIU94lsLL33ijRvfYhlD0yBRaf70yBWm/QHUgqnu
         i1CKwGYHdA5NoOITXchF8+I5ryHvJ19Ib9XGIoOUS1Q3CnRE131CbqKJvoyI9DBmnYlo
         NybsYn+vh7cddP9ih9kxhnQSfszBGxnS25ykaFYPJ+Yu2wVcy6tlcqh/q5RBqphxPc3K
         saDcPs9Mvw7Hxv14s6uNwV/6jW4FVMqNLtgHs6iC9xgUU7sL8jkXDpGRUtM1bO4sqVCs
         ARTg==
X-Forwarded-Encrypted: i=1; AFNElJ+0aJ6ViR5k3jsRnZm7tJamHQbLj2uHCMkCe3dsSctOZnhyDWnm9IeT5IuIAzzO69cHAr3ZYfInq3AQyX8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFRcGcTctzH2/EolJvAO6YlsrowqXQ48AbtAVHwLJmoH1nNW4u
	IByJFlm44s1pdwoiE+lyhttY5ajhkDKx3+bXlhHVeAl1ESc4PrBxDmr4
X-Gm-Gg: Acq92OEJTiqJnaumth/22TrQQ7lC5kDUwVcIkktpg5LxzHJ6RWZdaRL4o/lX7t/C7aJ
	SHL8SDwp2FLhWeQjpemT1kbqngB49sGJ0lSAf+alG4ScDQ2qyuX9V3KA/i3WKWaijKbHIIEwvvV
	mg74z4GCxv5CBXfTCTKNYKoG9GSy/N5RZJydymttELuuPObIsRxFI3T+hRPBbYeCrTZ9w3BGmFv
	Vnys/p7J2zX5uLzkyLd3hofPM95ohDQzu/ffGL+4uOzNUk2vazReNs9jWwx8puCjWLsl8a909Pe
	GH3AiJI1WjNDXvrGaYPM8Na+T3hB6K8OUt8CrfiWfesTF7M31kMrY/zv45fqhVuon3nzGKUt8rS
	PS0M1Bn/MTw2ActbZlckoftE3FnFG5Ry4SonYBonk9rQuwvS0CSiGxLO2dTEPSmhqbWI9CMbVmK
	asnjmCKs+yvMPG29KEu4lZlE9DQxk07W0R
X-Received: by 2002:a17:90b:54ce:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-370ee82fe77mr27086714a91.7.1781096703627;
        Wed, 10 Jun 2026 06:05:03 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37625ecfed4sm1493221a91.0.2026.06.10.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:05:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
In-Reply-To: <aildxtZhqEFYygp2@google.com>
Date: Wed, 10 Jun 2026 18:23:48 +0530
Message-ID: <o6hieeub.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <aildxtZhqEFYygp2@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> Nicholas Piggin (4):
>>   KVM: selftests: Move pgd_created check into virt_pgd_alloc
>>   KVM: selftests: Add aligned guest physical page allocator
>>   KVM: PPC: selftests: add support for powerpc
>>   KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
>> 
>> Ritesh Harjani (IBM) (6):
>>   KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
>>   KVM: PPC: selftests: Use u64 instead of uint64_t
>>   KVM: PPC: selftests: Use s64 instead of int64_t
>>   KVM: PPC: selftests: Use u32 instead of uint32_t
>>   KVM: PPC: selftests: Use u8 instead of uint8_t
>>   KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and
>>     gva_t
>
> Squash these typedef changes into the patch where the "bad" typedefs are used.
> Give yourself attribution for Co-developed-by if desired, but don't introduce
> code only to immediately fix it.

This was noticed only later in v2->v3, and I wanted to keep the original
patch from Nick the same. But no issues, I can squash this in the main
patch in the next revision.

However I was hoping if I can get some feedback on the overall patch
series as well especially the non-powerpc patches (1,2).
One other question - Should this go via powerpc tree or via kvm tree?

-ritesh


