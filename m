Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DAAC61DA3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Feb 2023 10:52:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PLbhH5LRfz3cBq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Feb 2023 21:51:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=qxwzVNlO;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PLbgC5mn0z3bT1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2023 21:51:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=qxwzVNlO;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLbg953Jmz4x84;
	Tue, 21 Feb 2023 21:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1676976661;
	bh=xxgisTBsLq1Il2r7exlEIFfuUgeu19ZFyGDQMu1Uymo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qxwzVNlOLonPby8HMI4Uk4h2fbdciIoGSLYXWvO8ezp2YwZzclmuFVIwLigdj//i4
	 kRzj09bqOzSiYkymEBlsHyFJFdVtUwhkBHfDNRDZQ30y2Ddjf0i4UeNutMRKwIBdck
	 LBREbVgzrmKQaaSZj0kk+w6AijCfcmRZqAc3WNyN5zJu+yZ/H63xwHNJchJrwECr/F
	 Mu36YLLS47u51Pn387IjiYZNSpIncZTJWlwIHEyoIB4fkS4/Zb/yrumtN+AURsCiab
	 7qzR25TfrivvhqUALNfv0aUWIC5OiqLRJHi1GqLbe7WAwa+ejsnwIOxe/xetZOl+l1
	 jE9uil3dxfyXQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, broonie@kernel.org
Subject: Re: [PATCH v4 07/15] powerpc/83xx/mpc832x_rdb: Replace all
 spi->chip_select references with function call
In-Reply-To: <20230210193647.4159467-8-amit.kumar-mahapatra@amd.com>
References: <20230210193647.4159467-1-amit.kumar-mahapatra@amd.com>
 <20230210193647.4159467-8-amit.kumar-mahapatra@amd.com>
Date: Tue, 21 Feb 2023 21:50:58 +1100
Message-ID: <87ilfvb8bx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com> writes:
> Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
> members of struct spi_device to be an array. But changing the type of these
> members to array would break the spi driver functionality. To make the
> transition smoother introduced four new APIs to get/set the
> spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
> spi->cs_gpiod references with get or set API calls.
> While adding multi-cs support in further patches the chip_select & cs_gpiod
> members of the spi_device structure would be converted to arrays & the
> "idx" parameter of the APIs would be used as array index i.e.,
> spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.
>
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> index caa96edf0e72..4ab1d48cd229 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> @@ -144,7 +144,7 @@ static int __init fsl_spi_init(struct spi_board_info *board_infos,
>  
>  static void mpc83xx_spi_cs_control(struct spi_device *spi, bool on)
>  {
> -	pr_debug("%s %d %d\n", __func__, spi->chip_select, on);
> +	pr_debug("%s %d %d\n", __func__, spi_get_chipselect(spi, 0), on);
>  	par_io_data_set(3, 13, on);
>  }
  
Better to just delete the pr_debug(), it's disabled by default and I
doubt anyone will ever enable it again in code that old.

cheers
