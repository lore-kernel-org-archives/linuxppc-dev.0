Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5D606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtbhcMcf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9M803l9Lz2y7W;
	Thu, 22 Oct 2026 20:59:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792663184;
	cv=none; b=PTTSiGSzkGF4Dq4/B6AWwBATEM6MPd8PWX0CR+fGP2SXn3EeQFe9fyD+0X8S9MZ0Egmt4GW8dAvYj9ghpmbkh+LkwJe3+1rzBvns5Uh6bA2bDZPeeOmhMMz2wLfcrZ5gHVk4sr9ZHN65+AfavlBaQK4Z3kl8ZPqwLq+a1etDzyfiiixV6RnAQo5D7wW/ZVUly96QqmtjIAciB8ZWRDhJtsPlSPdvIAwk8ZwcCBQD3FtJzW/LvEKduzYx8SMSHPUZVmtMZEcn1RAGKLXH9xWYtcSzYmL9C0k8mbSyNd+yMydCEJ2bAZWwVwASjRfZJDs+00Qx7Du505teKHiRDb2iww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792663184; c=relaxed/relaxed;
	bh=IoH7ekxN//XilbjyHr/WJ7HKfImuR7n5++a/wt+yFvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgANZST3QvZF1YPN9+lYUnnPPsrSfi6WBKQnZKxrFmU8X4DKbhWBAL9oAV11DIDopkl+QC0U4+wRhnvqzK6YayhLxvfqyU7aLMKK8P084Q56CtOmhRleVt73beUM5Rs25qcqpHB3T0+P0wrBcrBsKaIElxFnEEAtvZdzllRVB4cr6uf15iSHn4xxn323YNVI30o286BPfGMA0hOnB0mS4kY1K5a81VAn2cqAQoGahtHuGZ2kP3s1BmY5gA48Uql/hWwmi8hQ8Qm4/orRpQhuSwWZRFNESMGQ07vG/pwUOY4DXeJsksZm4Evm6cqcGnld8AwbscgPQU+N8D7WfiFgqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtbhcMcf; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtbhcMcf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9M7z0DpFz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 20:59:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F316E42DD6;
	Thu, 22 Oct 2026 09:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69681F000C8;
	Thu, 22 Oct 2026 09:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663178;
	bh=IoH7ekxN//XilbjyHr/WJ7HKfImuR7n5++a/wt+yFvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BtbhcMcf1IpwvLJwfCFCO2HbnnTWGh+2wjxLooRbBwVXv6jZq1Dq9RrWOXuZlIcIM
	 0LjgiRYGO6PyvlsRCAtx6KbdXCx3zJHLHbZWsna5F5Qlu7BHz5EYT/HnkoiHwhXckG
	 ppXGvymm1kR7ds29QEyI4saH1fOOf8oGEYY44SEqiyH7iTJtVtouLT0dHKI3WPG4//
	 eT1jDI3z9J77BNGfxUMRnm2t9IaEu7yvoaWoauZ24H1JbhgfTLTPq989SFFb0ZIxjZ
	 k1dbIsP0spq+nfDB1TNkmEUIFTbwJk1PKPjfX62FlFRVAQagxtSglL6ZuNVbMcA4qg
	 ltQ+F82tjDzBw==
Date: Thu, 22 Oct 2026 11:59:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, zohar@linux.ibm.com, noodles@fb.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
Message-ID: <20261022-whispering-cerise-malamute-94d7db@quoll>
References: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
 <ath534EEbFntir8j@earth.li>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ath534EEbFntir8j@earth.li>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:37:51AM +0100, Jonathan McDowell wrote:
> On Tue, Oct 20, 2026 at 10:37:27AM +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > On x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the device tree
> > implementation of ima_get/free_kexec_buffer(). However, x86 passes the IMA
> > buffer location through setup_data, not through the device tree, so the
> > buffer is never found and the IMA measurement list is not carried over
> > across kexec.
> > 
> > Introduce CONFIG_HAVE_IMA_KEXEC_OF (which selects CONFIG_HAVE_IMA_KEXEC)
> > and select it for the architectures that pass the IMA buffer location
> > through the device tree, via of_kexec_alloc_and_setup_fdt() (arm64,
> > powerpc and riscv). Build the device tree implementation of
> > ima_get/free_kexec_buffer() only if the new option is enabled.
> > 
> > Select the new option also on LoongArch, to preserve the current behavior
> > and avoid a link failure. LoongArch does not pass the buffer location to
> > the next kernel yet; this will be addressed separately.
> > 
> > Finally, don't select it for x86, and use x86's own setup_data-based
> > implementation regardless of CONFIG_OF_FLATTREE.
> > 
> > Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Reviewed-By: Jonathan McDowell <noodles@meta.com>

Please use kernel style tags, so Reviewed-by.

Best regards,
Krzysztof


