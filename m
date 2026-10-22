Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B863606A319
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dniXRB4Z
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9Sz71L8jz2y7W;
	Fri, 23 Oct 2026 01:22:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792678947;
	cv=none; b=cBpnmdzc8cnGtFxHwyb9XMSBO8aOB2NB0C5oYE7XMj2OIkjrzRsstvFKQdtIb4R5WpVXq7K9LdaGDKwRAN79OeLU+9Zjr+McsVsUPaeHsbJz7sFG6jL3ERw33DfCCI6EawjIKDuQfyYJeCDO+jkUWKCtztVLyiZL8QfykUHTAIb5OIr6viFODCXJ07Ukt6mx67TGHB3R6995xuu636Ip+JVZJOocNVwaZES8FpeNEgkg4KUVTOZJVd6ZwiElsZReXtQzDNuI/ZT6hcH6WZcuR2i34spEf/iHTsaUSu/I0y+UbDDX4dwpmai+VI5+ZNJ28zllHxng7r+lMw55FnwlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792678947; c=relaxed/relaxed;
	bh=UgVlXRgVv5/x1DXWmVGKmIRruqBZ1ifqROjMLIcwpQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5pWFW7lUnzPGZmAwaXQ+CVt0SnfpSMWbaHRqjLdriif8gFL56plD/BUhNuvEf0xPT8hN3I5k4LhgVGmT+IvTBN2ksknsa1l/5q9AkGjo6RaGUH4dUdcUN2hjlnbZtQrMFTHnXPbaw69U+3uyQsmyIQr9rSp636LxTF+F0XKtjm4k9yjJhaujkydkDUACN64I37tnTVafLpJ/aWs4zh+5fvWcfyCjdVhrxSetwSeMG83JayaonUSpDyUnzTErXKaz1bUcuwQVl4oBwMENOd8e31N8rcBR9jbtuVkd9yB9Su8fIbkVQF78gCVrMsKRjm6xu8CvQzpZsPEhING7XtcPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dniXRB4Z; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dniXRB4Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9Sz46S19z2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 01:22:23 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBCFC2C34;
	Thu, 22 Oct 2026 07:21:46 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3BA83F7B4;
	Thu, 22 Oct 2026 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792678910; bh=AjDgKxtJPU0cDSM8jjetpkKUyPIl0mcA2sgghiP/fy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dniXRB4ZD77Kv5qxyizSr8v8KtL/ukXit7rt6xFRKUWRWqRwmE6iH72fHbbiOthgT
	 t8pkLhHcMrKIjkL9hOIAKcTHcKAD8dALDouiCVdrInxKtCYCKPKtoN/P52CBgRrqBV
	 0dUXbOk3kfv9WFL09chD0AKAzIdjKVCTHS+KjbMo=
Date: Thu, 22 Oct 2026 15:21:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org,
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	zohar@linux.ibm.com, noodles@fb.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
Message-ID: <atob9ulCwxZgyWyL@arm.com>
References: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 10:37:27AM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> On x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the device tree
> implementation of ima_get/free_kexec_buffer(). However, x86 passes the IMA
> buffer location through setup_data, not through the device tree, so the
> buffer is never found and the IMA measurement list is not carried over
> across kexec.
> 
> Introduce CONFIG_HAVE_IMA_KEXEC_OF (which selects CONFIG_HAVE_IMA_KEXEC)
> and select it for the architectures that pass the IMA buffer location
> through the device tree, via of_kexec_alloc_and_setup_fdt() (arm64,
> powerpc and riscv). Build the device tree implementation of
> ima_get/free_kexec_buffer() only if the new option is enabled.
> 
> Select the new option also on LoongArch, to preserve the current behavior
> and avoid a link failure. LoongArch does not pass the buffer location to
> the next kernel yet; this will be addressed separately.
> 
> Finally, don't select it for x86, and use x86's own setup_data-based
> implementation regardless of CONFIG_OF_FLATTREE.
> 
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

