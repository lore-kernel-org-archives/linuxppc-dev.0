Return-Path: <linuxppc-dev+bounces-28813-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719D5CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 06:45:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxbkz2Gmqz2y1W;
	Sat, 03 Oct 2026 16:45:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791009947;
	cv=none; b=K3E3Q9sDsahuO0xhK+3ErUJ6vRzmQtZVSwjVEsz/4u7f2NLWZL0GFPSVj2/HYnktu6Jfiku9AiH1vFYKEDWuQ9L0+s/z3hPCS+62FVSFbVIMOXemk0SzI8FMjVaB+LY6grmCQbvJmykuOJ4Og4z2pPeswfTouHpH2zAOxS547r0cunAIno3ngny7kr25w0HUMlzkqC0P8zTvdT9GGeusQUV0KgDequTtnKC3mIlT6Q9Pze3Xqby+DU84SUDtys0M/4L0MGmyWS4t+wBsmFVVbWv6emrn64Nu7yQIsh3O0p7AyHj3NzkRC2qf6rdSoIJ0xT+jpe7DORtaC9/tiScGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791009947; c=relaxed/relaxed;
	bh=UaD3I2b18bISdUANA1NJwXoHAKKgZBgwLSormdRjXBI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=elVwXVLdvBrhULUO+RZPUm8b41RwIgBHzE3u+s/yHz3lv2o2I6ovK79pKcJ5A6j3aDCFjvE3A9rYXtWmNx4R8qubDhErIRuWFWOLd8jxKHV9KtV379iPOufP1EuYlM5C3+hWoqWWjeTkSRkaJgExwwE0kX9nxy6aHzYdJL+xHM/vqfn6kOLK7dBURMskK8WjDF74MWd9LVKZWOVlvGlwCqNt/BGz5x5EuRVPTK9ziDhYsGG89hiRnyIMw5Rr+MmIvnIwnPA1N7XFAXeBU1R68xm9UnwHqL62i8pFeuouV6IRtQNwi7UClrrbMSpj0VwkGWpqg1Ua4jmBSCWWR4rM7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M05qLL0p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M05qLL0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0d.google.com (mail-dy2-x0d.google.com [IPv6:2607:f8b0:4864:36::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxbky1mxnz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 16:45:44 +1000 (AEST)
Received: by mail-dy2-x0d.google.com with SMTP id 5a478bee46e88-344447f9c3dso46476eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009943; x=1791614743; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UaD3I2b18bISdUANA1NJwXoHAKKgZBgwLSormdRjXBI=;
        b=M05qLL0pfysv07wxwWExeYTGYTU8DDwdmnfl2MVVjmnSFjjbUtRaFh5HYtA0+CehI5
         goXedAH7bjJ0NzueGNOogqIAmRWmSrLvQjMg0A7UquyITZ3mjyU+HTBNGPjEjmB4pVyB
         t1XWzuqtaNWOyxX8gazlxnS7YvgsbOi2R1+T0c3zW67ouXnyufCKa3IdVAwHE2x4Dkj2
         RgJdVuW+rj9eJ/Q+uDweBlFI6DEW6GszmDnjQnwWyjUpczHGlF9ST9F6HQ/xXGcanbiy
         o/eYp4r3v4PxD6E/kvs2eRLIKSiJ9JzQOwvcTpQ8sL1vBddgjcNGESwGF6oYXwTFf8ck
         zx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009943; x=1791614743;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaD3I2b18bISdUANA1NJwXoHAKKgZBgwLSormdRjXBI=;
        b=ALN9tfCECBl54T9jXmuXpV78vKT8wvToY5RiFpVK/izn8L+izh3PcEa/ynJ2HwaBhl
         Hes6oF4QjBGx8MKOl4Wb4fiyICIJR9CK7/Ik2NKc5OW5VdcasLzfFnkcoYaFtN8+7FaJ
         /AKJfYj5VhiKCMfyaGOV47GxcR+qlytXtM2Bthl9rG0pNdLTD/vEJVzPMZPhC/imrjMu
         +YUBjP9PIptldWDS3YjGwu03xao8u9oBBCWwb/JzMcpIMu7KlxrslAHQ7fltfFqUnKNI
         yTz3Vlcp4BiqOmzj0C+IN5T1gqNEzzzMLqRnGmgINEUz39kz/DGUDhXgIbT7a24CmBAh
         Nn0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwaCkb8Q2G0DiPLiui75iN+w0C0m5PJRKb0F1HikR+chEWsHso3OuknnXUC9wr85G6Ev8pwDGv1pONRh+k=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLRYJP7czShP6+iWSYezyHNBNyeuqBQkWpdPci92LJStRifjBm6
	4ML6j/JhncHSQyhvGwTbpEcPqxfXWR/u9/5sHYhTcK2R/7ZpqBygRjQJ
X-Gm-Gg: AYBFou2uykjIbn3nROZAfwDUdwzKgdpJB3lkirTqAfaQVwDwsMGAxLQXJctvwdxqAiB
	mqg81UcbJTDqxpk9PB9a/NwAEk97o8ovbMrWYJIP85Dmgpaw1R3qteMqNLhDgpeKmMgjUTL8aPE
	I5Z9HUCO35ZT+hLp7axJh/RNOsNac09cSl+a8F9j4CYFqxJ2d5UFetI4OZC2VfJ1+6YQbCb1XiF
	FYKrHSnFFDt/wE2eFNw48XhLSTadudUsbBUtkKU0T6hwb/TO+jSZpKrw4WV2uvdWaeNUJNMME/L
	pjZJPj1QJlgdqEnDlK65mR55PiGVlTGJ1FWwqBeDJrEfG3kw6xJzkCgha5Imh4kZ/foUYbNlEJL
	VeOq8kQmQAO8o/9t/MC4UTg2y7wvyS/PBUxWiMx7a/ZbFRMfjkyRMDAhfdNoEw2JYYfUulJnNBN
	HTJXA4rB8CPjNQYwtcJmJts+jdqvPMcqhczYemptSnduERnZO0Qhk2m+Uep8Q943ucQTHAHr0wG
	+kbz5Uzku0P0Nkmf9pr9KJoBxU6A4jF7TfCAYvJ3Z8CDUXSMtOTA9/yaSS3+xbK
X-Received: by 2002:a05:7300:f801:b0:351:1170:3481 with SMTP id 5a478bee46e88-35111703551mr2454740eec.29.1791009942568;
        Fri, 02 Oct 2026 23:45:42 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3511b6f3a32sm522073eec.2.2026.10.02.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 23:45:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] KVM: selftests: Limit the number of VM creates in hardware_disable_test
In-Reply-To: <asAt1NhGFs5HNbvl@google.com>
Date: Sat, 03 Oct 2026 11:31:23 +0530
Message-ID: <ik3jjpak.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com> <asAt1NhGFs5HNbvl@google.com>
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

> On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
>> hardware_disable_test forks several VMs (NR_IERATIONS=512). This patch
>> limits that number to 4 when we know that we are running in constraint
>> host environment. The number 4 is just a safe minimum when
>> kvm_arch_vm_create_may_enomem() can be true.
>
> Please actually explain *why* this is necessary, and where the magic '4' comes.
> I assume there's some system-wide resource at play?

Yes, this is the similar issue of limited resources at L0 for nested-v2
case. This test actually forks and each child creates a VM. Here, the
parent queues the SIGKILL for the child, however it does not waitpid
before the next fork. That means the VM can still be eating the guest
management space at L0 for the nested-v2 guests (until the VM is
completely destroyed).

I agree the number 4 is a bit ugly here. It was just a safe limit. I was
able to spawn multiple VMs ofcourse - but for the sake of enabling this
test I went with some safe minimum.

BTW, since you suggested that in the initial enablement of the kvm PPC
selftests, we need not land this hardware_disable_test, so I will skip
this for now.

-ritesh


