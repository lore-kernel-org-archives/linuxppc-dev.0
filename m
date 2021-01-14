Return-Path: <SRS0=IYgH=GR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 19:56:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E2521D46
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 19:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E2521D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGw6z5D5nzDrQb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 06:56:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jHfHFDrk; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGw4k43VczDr5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 06:54:30 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10D7523B2F;
 Thu, 14 Jan 2021 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610642959;
 bh=65pHwfEnxIO+KB+8lFvkgezdzPtnmMUdO//94olI6vI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jHfHFDrkdgJpDwQVRHeWH7b30XpaXrfdc82v4IFN913LRBw0YvDm28IVCZClxBv0L
 l7LUzN1ljXzazxofxAQZ5MJYb00sqpIAvYqGSdQbkHXVwUM25k+1TkkzhD66+oIAY+
 95aMx6p1Opg1xcRBLduZ/ST/jTvH2066akpcZvnzYPm8FxfNSe0uH9gWrKL13G8vgI
 d7nurpcITHiVvedCfSIF0ox6wSYRJxF8q+88fj5bLADaXXFgcjAz89kAGc5FB9TlQy
 IAFlMGOvUHhEKGTzSywqhiqlF/UlcFaM9oQKdBDF+I2un/Iqrg4UelvIF9VHwtX8v2
 QcnNQGduZPXSg==
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sven Van Asbroeck <thesven73@gmail.com>
In-Reply-To: <6b51cc2bfbca70d3e9b9da7b7aa4c7a9d793ca0e.1610629002.git.christophe.leroy@csgroup.eu>
References: <6b51cc2bfbca70d3e9b9da7b7aa4c7a9d793ca0e.1610629002.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] spi: fsl: Fix driver breakage when SPI_CS_HIGH is not set
 in spi->mode
Message-Id: <161064292109.43781.3127571598832303421.b4-ty@kernel.org>
Date: Thu, 14 Jan 2021 16:48:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Jan 2021 13:09:37 +0000 (UTC), Christophe Leroy wrote:
> Commit 766c6b63aa04 ("spi: fix client driver breakages when using GPIO
> descriptors") broke fsl spi driver.
> 
> As now we fully rely on gpiolib for handling the polarity of
> chip selects, the driver shall not alter the GPIO value anymore
> when SPI_CS_HIGH is not set in spi->mode.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl: Fix driver breakage when SPI_CS_HIGH is not set in spi->mode
      commit: 7a2da5d7960a64ee923fe3e31f01a1101052c66f

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
