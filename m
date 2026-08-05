Return-Path: <linuxppc-dev+bounces-25414-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C038C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 07:08:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFM1v2Bj7z2xqM;
	Wed, 05 Aug 2026 17:08:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785913683;
	cv=none; b=H1KoYH8AusjuVikwG2txclQEmJPg852S+mgLLkOZneuOQZJ3EoFZ6xMUTyHakYh2ktRYc9xNYmcWxGR2nANdW9tmmtIq0At4c8RcEYbOSYBTEP5T6nw5K6+dNBNmUaGc24Je3fPcv7wzHy0PWc+5lF2I0zhWSQcOrIwAMEBDmgs94CO5K2joWBIZ+a4mIqK9z1i4lT+p3nmjKsaqKEkEHv7OqtaXmJAhXilr9Pxz4mZ6EiW5d6ZW6Q8/strScIV+FHcNUm2kXfbO2FWC7/c3VPog3NXP1C0e3j96tbMzhvQ+DXlew+JrBYSSy7z36x8Uya0M3Dg4avV+kvGujztA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785913683; c=relaxed/relaxed;
	bh=UGMpfuT8snJ0tfEwGHyplWLK/i+F2oymMko+Mu78Kgc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=el18G/a/j9F8hqF+cjvZDZRRHXlsujytpcvoB1D1HICXVHilvQMqtPJjJKKAu2HfyvKpkaoPpf4qj21rr+/VaurBXmO8umbGvh66D8KeO8MCUYKt+rsVK6k5bnqduNaywgl8OFPUe03+5Pl6u05CsbFe6vyoI7pzSPpMH9PxejN78R9dLc4dz0e46oUlWMTux0WkIj6wqU7BO2DgROn16RG2FAdgnQ+fJUV7wLwGFTR0FyUNLK/YGNsqGZQQ/f0KOSvp3/Vp3+87ryhGfPYd9YarYg9h0GAk5Iu7n1whC+zCGfl0HdM6rOQC+l4TR9LYDxKYMf+XxBDROhrzwxBEdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8gTQU9Z; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8gTQU9Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFM1t1LClz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 17:08:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 651E04059A;
	Wed,  5 Aug 2026 07:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6444D1F000E9;
	Wed,  5 Aug 2026 07:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913679;
	bh=UGMpfuT8snJ0tfEwGHyplWLK/i+F2oymMko+Mu78Kgc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m8gTQU9ZFMy92/rC16QxOHZfJw/kMrRJPhdx7cuc13a+8XkfbClmetnJiDjGw7kxo
	 alS0UTHx7Zct0mAfLYRN21R8sg8rsHliQJK+cqUNYdNGvdLNSqdG4BpJNi0AhAYa3+
	 uJJFTepTFDX1X6x0KlhKPBl/hXQ/SGkNAfL4euPAxrmTuerAXggUiBeuzn28O1J3Mg
	 wS8yQfmuqqIzrJ10TNlckzEIqCHt4qCYRsE5yT7oBdqNs9H5U6/linqwet6BEyEsmR
	 cByYnCYyCxjDPVrRhC906M1dHJ1/n07jkxltxBXLRcjgBpdiJbRxLKOZ14UT+0GoW5
	 Z8Ih6G8q7+1Qg==
Content-Type: multipart/mixed; boundary="===============7106082230189184574=="
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
MIME-Version: 1.0
Message-Id: <5ef8aa40184d48efe9c1fb0def756263a654c22e4908bc803d0d92426e07ef52@mail.kernel.org>
In-Reply-To: <84353363810b8d63e7933391f5c6a2ea46f348e3.1785906979.git.skb99@linux.ibm.com>
References: <84353363810b8d63e7933391f5c6a2ea46f348e3.1785906979.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v10 4/8] selftest/bpf: Enable verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 07:07:58 +0000 (UTC)

--===============7106082230189184574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftest/bpf: Enable verifier selftest for powerpc64
>
> This patch enables arch specifier "__powerpc64" in verifier
> selftest for ppc64. Power 32-bit would require separate
> handling. Changes tested for 64-bit only.

This isn't a bug, but would it read more precisely to name the new tag
as __arch_powerpc64 (matching the macro added in bpf_misc.h) rather
than "__powerpc64"?  The actual macro expands to __arch("POWERPC64"),
and "__powerpc64__" is the compiler predefine used in test_loader.c,
but there's no __powerpc64 tag itself.

Also, would phrasing it imperatively match the series style better?
For example, "Add __arch_powerpc64 so verifier tests can gate on ppc64"
instead of "This patch enables..."?

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 5eacf1b432521..c35359c97e44b 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -159,6 +159,7 @@
>  #define __arch_riscv64		__arch("RISCV64")
>  #define __arch_s390x		__arch("s390x")
>  #define __arch_loongarch	__arch("LOONGARCH")
> +#define __arch_powerpc64	__arch("POWERPC64")
>  #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
>  #define __load_if_JITed()	__test_tag("load_mode=jited")
>  #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 07807757b518d..221393f2a8ef4 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -378,6 +378,7 @@ enum arch {
>  	ARCH_RISCV64	= 0x8,
>  	ARCH_S390X	= 0x10,
>  	ARCH_LOONGARCH	= 0x20,
> +	ARCH_POWERPC64	= 0x40,
>  };
>
>  static int get_current_arch(void)
> @@ -392,6 +393,8 @@ static int get_current_arch(void)
>  	return ARCH_S390X;
>  #elif defined(__loongarch__)
>  	return ARCH_LOONGARCH;
> +#elif defined(__powerpc64__)
> +	return ARCH_POWERPC64;
>  #endif
>  	return ARCH_UNKNOWN;
>  }
> @@ -585,6 +588,8 @@ static int parse_test_spec(struct test_loader *tester,
>  				arch = ARCH_S390X;
>  			} else if (strcmp(val, "LOONGARCH") == 0) {
>  				arch = ARCH_LOONGARCH;
> +			} else if (strcmp(val, "POWERPC64") == 0) {
> +				arch = ARCH_POWERPC64;
>  			} else {
>  				PRINT_FAIL("bad arch spec: '%s'\n", val);
>  				err = -EINVAL;



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30981212698
--===============7106082230189184574==--

