Return-Path: <linuxppc-dev+bounces-7075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E19C282EC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Mar 2025 18:38:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDtR720bwz3cB5;
	Sat, 15 Mar 2025 05:38:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741977491;
	cv=none; b=T7QEN2BR/euE4N5bGm0fjdNUOePB54j3cDxX0QKJdc+mcTrizjRLQW2CDK4VwJtb2MVgK0fwafeWz0kx18xhTEgJnfcDrPG5o6oKxPUVMWvRwEc8qdMXes20Gjui9q5KzA234Pyy5xGCXU3nag9hljMITZOwNWnRCTs2PE8lp/UM8O1XUxb5AwtJiyUXel22BCOs+cWEk6lOx/aqFTFsr+Gh/CgIit+PTaaWd1sVg60C0yUGLnOvweL2+FDOjx3sGMgVQHetRVNkMRqVXpyndpv7v1phMqRJp0ALpPLBzWeRkcKLNPAU7XsoGduq21PGSMxSa+ejVAafPHY99j6GFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741977491; c=relaxed/relaxed;
	bh=MjzUYO+f0dEIfn0NqOku+3fnvEFXy2J1drD8gdq2Qzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKAkqiZDgzwcWuYEEA5dRed/NABE1vzIOY82acPWt4oLFgFopnkyXgoouFqFEpgynoSnIKMJHG67ewLQ3J2zEkll/tuv/BOpy05JBS8S7PTGDr/QdRiHMQHwppoivBVfaE9lyNzWOFCxp15F3pjAtJpFSRY/4A04r2+v6HrLVyZ8smY457a0GScDOALR2NGk6a4uN/PzN/XL1mNPE5UFDxAfm7/woXX8B7+kJerWToI2XZPBXQcECP1/Hktuy41Q0GIpTurWm1MrSV2VE9Njx4brI9FT8VKEI3yKDVwKdc3SCT9su3aGEw/wPn6FO719q/J3+icKyaSnamTmUiVWtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDtR60MJ0z3bsM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2025 05:38:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 555155C4C5C;
	Fri, 14 Mar 2025 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A66AC4CEE3;
	Fri, 14 Mar 2025 18:38:02 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	sudeep.holla@arm.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	mpe@ellerman.id.au,
	linux-arm-kernel@lists.infradead.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	pierre.gondois@arm.com,
	dietmar.eggemann@arm.com,
	Yicong Yang <yangyicong@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	morten.rasmussen@arm.com,
	msuchanek@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com,
	linuxarm@huawei.com,
	yangyicong@hisilicon.com,
	xuwei5@huawei.com,
	guohanjun@huawei.com,
	sshegde@linux.ibm.com
Subject: Re: [PATCH v12 0/4] Support SMT control on arm64
Date: Fri, 14 Mar 2025 18:37:59 +0000
Message-Id: <174197746840.735682.9575626401918508908.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311075143.61078-1-yangyicong@huawei.com>
References: <20250311075143.61078-1-yangyicong@huawei.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 15:51:39 +0800, Yicong Yang wrote:
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:
> 
> - better single CPU performance in some cases
> - saving overall power consumption
> 
> [...]

Applied to arm64 (for-next/smt-control), thanks!

[1/4] cpu/SMT: Provide a default topology_is_primary_thread()
      https://git.kernel.org/arm64/c/4b455f59945a
[2/4] arch_topology: Support SMT control for OF based system
      https://git.kernel.org/arm64/c/5deb9c789ae4
[3/4] arm64: topology: Support SMT control on ACPI based system
      https://git.kernel.org/arm64/c/e6b18ebfaf63
[4/4] arm64: Kconfig: Enable HOTPLUG_SMT
      https://git.kernel.org/arm64/c/eed4583bcf9a

-- 
Catalin


