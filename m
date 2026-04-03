Return-Path: <linuxppc-dev+bounces-19282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B80E85381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 16:52:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnPss2LkYz2yjm;
	Sat, 04 Apr 2026 03:52:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775235169;
	cv=none; b=b12E/pIPNFJGdhovX6ztSYgrTZLLq/xgKdYpnh/vN+32gwhuekg1C2dzWrpEy7ev+vo3nnzVZRGzzPgZ470/iRrK4NvGbFOccOM7/jeOf+4nqe3N7tvJdFm9r2cfcMks/wGlD1gJsYGEnqasYY4AXykzRtwgoFby8+Aamw3kQmia/f7x7He2bS64nhaMhvR8FhWX+kbjnWaAIQjPvDckPMyVh1BHYBv4benrc2VYFNm+/kdSexB7ao7JjN2FJAUUT9qcEg1HsgSnIRSHMqsh0tvyejoL+J78lyl7gfHCKhoRrNiF+Huqmg3p7n2c4iIEIVxamsaH4NXRkGeJUlQxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775235169; c=relaxed/relaxed;
	bh=0c2UQi4/OuEbP0FtG8wRx0+kreT637uyGL1E7YXTJiY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WH/5x0d2pa9uvLENreuhWES6qIq9+Kl5C7VvASXkmXmtRodq0+i32JNR4RUTmkV+MFQNNGjyYpShlT0x3H+Qybw5npfDkQeUs4wIGd7NvfKuHdAaDHyzYay3uo/RP5CGHAjlxr/7njvR6XUOt37SNdaI/md9G5E5cPQx9RAakYD06CJfKQg5DUyx2Uf1f2O9X6+ck70WSGhTeSeBHJwaa238Y5Da4cHTn7aHZYQ/1Og+d5gZrphV135YBWeQEdhxsfi2VAzAhyNdrBe0gF7Q4gWFYjioFf+IgDwLafqDL9n91oktBXXlDmCMbwCQT7ybJaCYZRmBB068Fo7qGhwe8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U29NGLna; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U29NGLna;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnPsr3Dlzz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 03:52:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 829034384C;
	Fri,  3 Apr 2026 16:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57C8C4CEF7;
	Fri,  3 Apr 2026 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775235165;
	bh=YRveJVZCu8GDGV3bBJZ/v1pJiWaRn6WEGXVvRMAeJ9I=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=U29NGLna1TugWKaYx1hSqQYPS4LcIP8K7XlUqdSh3E61Lv4CTXYohzIUMSem2MY2S
	 9IrNsow63DN3BAKQbKKkRCy4l1hEe6UxPBuzRyDBjrZRiJCiSb4Oq8zA1SDccry/S2
	 66ysEQ2FRNyOw+ud/hw8JTmnq1LB9Frc2sEgLOZ47bdemzkMo5IJE/NAtHvQHnMfOv
	 suvgN7PW0y6e9y8es+t8OaRXHhDxibFECuKitFRDpzn63c6VfbP9DVWlnjZwlyby2q
	 fKxu6twCXWSCVKuCihudKP8MJl+fyLFGnAcYLaNfeJMAgFIj/inPlGw3OQEIPBy4op
	 AHXO0hVXumvog==
From: Mark Brown <broonie@kernel.org>
To: festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20260326055614.3614104-1-chancel.liu@nxp.com>
References: <20260326055614.3614104-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: imx-rpmsg: Add DSD format support with dynamic
 DAI format switching
Message-Id: <177522560849.52946.6682860027345640594.b4-ty@b4>
Date: Fri, 03 Apr 2026 15:13:28 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-67696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YRveJVZCu8GDGV3bBJZ/v1pJiWaRn6WEGXVvRMAeJ9I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpz/BZjF5/dR+mfS9bVnwsI6rH+fG7++qDr6DB9
 tPVDW3SuEqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCac/wWQAKCRAk1otyXVSH
 0Dj3CACACwFyTyL3B80o6GL+XDzhZs9Js2nU3MCZD6GOxiGo+q2C18nuoN+b483KQ56BH9uAkVu
 SAYCSNd07/9j0DTvcHSMZFQY+2GxbAk7KO6ZX6IdnqmjRCVl0WNT5vjSUbDXEAHyWdv/qaVd2xi
 gTViu52u5ePDcratJ3DcnWWUQiG370nfnVgFTsCzRppH5JdLcLRM9kIlWjq3FSb0VgcND1tFXsH
 3dg+rtbO0nzM+xe4ybjFj9IuToYATdGkNfUq5AWTNbQYMNP9qVVAlACGT/2unUcFEQjrnHAUDFU
 FIlpjlPw/sszdhTFI9ynKQo37UDd1OoJC2eGSnDD5HMfb8xd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 26 Mar 2026 14:56:14 +0900, Chancel Liu wrote:
> ASoC: imx-rpmsg: Add DSD format support with dynamic DAI format switching

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: imx-rpmsg: Add DSD format support with dynamic DAI format switching
      https://git.kernel.org/broonie/sound/c/ccd7e53b7d6f

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


