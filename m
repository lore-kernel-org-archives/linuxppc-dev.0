Return-Path: <linuxppc-dev+bounces-24870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BB7C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:18:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7vgt1S5wz2yhv;
	Mon, 27 Jul 2026 20:18:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785147514;
	cv=none; b=i/ofkhOcH1WKcC/1/hJiQAyuytySzZnpaMd7ha6+EuXfGGy0uB2VjLNNDMwsKbyo83foSbe1lp5QN17VsL5/Dwn2dSyIsGo9nsy/FJwtkXW3qPsBCAwMg/ZjmjxOewgBWiwkWWEwKeEDH+Ix0aUT6cMS02BtrxpSJXaqL8sXcmMk84DsA50kbgS7nMxWaI3yq1lQqKlBXE6ZUTsyDhasNaKfSNBuQ7z5w3CJNbkqe9xtFF3wRME9YL/lh/6z3MDjKxWY8AtdZ9yGy2rSkF/dMGGeF38uJIHNGH4ZI+aCO+DcZLexUjwGrR02tsMFxKvLDtDwuvM9EiC3+Lrp0RkxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785147514; c=relaxed/relaxed;
	bh=tm4bX5EaMEcOm+KUpSmElRPonEmmie0f+X4ECTvvYHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tno0uqgyHe9T/RseuzML3A0M2kD3gWAamlR0MdyTQ6Jjc+T5FVOI8M1GIrFzA3aBZj51yJNOeKzCtC9JvPWSxvS2rAUN3q9nilfPQibve3IjS8VrwdIlpp2g0oyD/y7agze/dHFqIPC3gVfC35Ljmi6pNO28YuxGFvM+GsYIeB7Zl4Hlc+pIdujUjwuolSL5jZ/ssguczAnX6rTvBxAfvnxKYR0zcMA1tdpv2ekUH8ft0XOB1kYbGUR3K3vW2LudIwJjj+mdxJCVxbQrfwBS3F5hs3GC0XH8ayWyvpL3OMU5W2J1ojKlC6DE0y+mv2bnaErZBw66OCZw6jfpeg6JhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYxixka0; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYxixka0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7vgs2czLz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:18:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EAB60601DE;
	Mon, 27 Jul 2026 10:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE4C1F000E9;
	Mon, 27 Jul 2026 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147509;
	bh=tm4bX5EaMEcOm+KUpSmElRPonEmmie0f+X4ECTvvYHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYxixka0FlhauT4YJqj3Jfq5JgaoHCfQuUzMJ940VOmDeZ2ucrFT10LpKaeOY5aX9
	 Fsb5w94VOsRF+1E04eufzieRAL9zebAV/UEr9GkHBO93efzHnJQ0DngR2pSHa6LKJd
	 +FuvAr+gmMUSr8aqIKFMZVwWd/D1qTTjLq6RMR/bpST2nvoUyDmXhooRO5Z5g/2RcK
	 NlpFszwwKZ/FueD8GbXIeoQcouRlVvm5i7djRDiB9Os99FONj7gH9LS2Y62GBq+0Q5
	 TImTyF+igaEB/3WT6ZThTL/BNkADmgUkG+2hUrLnXUqRwzxJpHcuJXjd8lRGb7jDxI
	 jd7HvIhSy/8Ew==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: Move CONFIG_QE_GPIO to SoC
Date: Mon, 27 Jul 2026 12:17:59 +0200
Message-ID: <178514745088.65524.3935355950831235390.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9a7131d15a94e2017877e628f0e97f9aa2e0aae9.1785140877.git.chleroy@kernel.org>
References: <9a7131d15a94e2017877e628f0e97f9aa2e0aae9.1785140877.git.chleroy@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=chleroy@kernel.org; h=from:subject:message-id; bh=uN4DlDlGUY5Xyerk30O+tWmKQX/egw2gDnpOL+pthDo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSlG0Qz821INK3tnj4tvcWuuDhDnvHzm75w1sots+dsm 1Bb3Xeqo5SFQYyLQVZMkeX4f+5dM7q+pOZP3aUPM4eVCWQIAxenAEzkqxHD/1IbnygBmyABewNf k6W31CSKzc/dcb2nKKO6Tz9s7i8RPoY/3MtW8bV8UmjQ67UI2mC3Y8XEf2kvrvlkTPB+8N3404R aFgA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Mon, 27 Jul 2026 10:45:37 +0200, Christophe Leroy (CS GROUP) wrote:
> Commit 7aa1aa6ecec2 ("QE: Move QE from arch/powerpc to drivers/soc")
> moved QE into drivers/soc including gpio.c but left CONFIG_QE_GPIO
> in powerpc's Kconfig.
> 
> Move it to SoC as well as it is the only place it is used:
> 
>   drivers/soc/fsl/qe/Makefile:obj-$(CONFIG_QE_GPIO)       += gpio.o qe_ports_ic.o
>   include/soc/fsl/qe/qe.h:#ifdef CONFIG_QE_GPIO
>   include/soc/fsl/qe/qe.h:#endif /* CONFIG_QE_GPIO */
> 
> [...]

Applied, thanks!

[1/1] powerpc: Move CONFIG_QE_GPIO to SoC
      commit: 6599935a1e4be0354326086ea6c73dcb8f43b881

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

