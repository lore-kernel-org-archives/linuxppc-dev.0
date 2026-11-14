Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D06606A882
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP+CwZcV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRVjV5wLjz30P3;
	Sat, 14 Nov 2026 21:29:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794652158;
	cv=none; b=RCXJJvYzfzvL5GTWyWdMGHbyWBSujUZvXalp2MfxfCZi/zn4gs/19/h1Sb1Ilqxv1V0ZuEMGQ3YWKQQSDRiGqnoydZPwnKurj5li3xfrs8VcaI+Or4Eg27xNJS/iU9DaVUME5c2BRs0C4Yrn3A4qIUL3VwUDIclaZBqIQbBuKpsCd1bGQdLygmBY1eiXyDkFxivCeUUFUjB7QzeicAc3Mz7P1w6clOTQlVFE0qlL7GXO6gr/GMooquiFqwE2P2k+M1Me20dQYLrarGkr8JfB9DV4WTYOIcK5XGr+ZdZQQzpJ/ZP5ioV0YU08zHbG4sBDRvrSeMP+MoB0isPhXYKRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794652158; c=relaxed/relaxed;
	bh=dcmfpT9IKALT3AMaYE02cIzt82rWcSY8cPriyi8AD/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL4d/CpMbhSivLBHFYktwJZ70p8ulgFPqx+luLkqalNQNV5lNTCCYUHO8Lv9P8yrLy8GVhpFxUBCKFy55OLGzXHgUQcF7nWMzjoKX3VKEAznIMV6j50o6Se6OzRiydsxij+dAMmjIcrdfHlCUvPfEP6E4iPjh+u81106NtzVCgnpkVfqKlsG9auPBNB9XfpotKioeFSLUR5rMtLhQtBeUR3gWeBQjatwyTlX0eo3sK4WcOGcnUX14lkbbXDJCtPc5SBWj2SJOJlJ68yYBZNkO4VWWH4gaaG7SYpaEkTn+fQxG12ovbGxQNibydtz81zXgwLbqloW7P7+8nQ16XxWUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP+CwZcV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP+CwZcV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRVjT2knVz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 21:29:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B99A5618E7;
	Sat, 14 Nov 2026 10:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18271F000C4;
	Sat, 14 Nov 2026 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794652154;
	bh=dcmfpT9IKALT3AMaYE02cIzt82rWcSY8cPriyi8AD/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oP+CwZcVcFSC3QvevnrIzew+WDs8zC9DmXsnq2G/7H2yeFPN+RyqU+HU4xj5HwjQj
	 vHdMlcxd4eI4x7z75kVK2ljbcLX5dRP+Zo6M3RaTut3u/mSirmLQSvVTq172Nn7bJb
	 9eyl2HFHcPGjBIryaGA2CR++sko1J3Tibq7YUBL6wtT8my3PJ12O4clWPxPHXm54TY
	 61O0Jh2IOAVsjHTJE6DNkMelf4Tg/LTPHJSBlWTmN9ctIQM+muyrA7qMEg8RbcISLw
	 3DoKrxM7nVqnTprQqH5INM54aesKZ5kp8+VXvVyix1hqsAxyiDakU4b7I2z4bbjEZR
	 yLVeoQgcZXtdA==
Message-ID: <39b3b80c-54ca-4fee-9a56-bb2999705e2b@kernel.org>
Date: Sat, 14 Nov 2026 11:29:04 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_YEALINK from
 ppc6xx_defconfig
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henk Vergonet <Henk.Vergonet@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>, Martin Diehl <m-diehl@gmx.de>,
 "Alfred E . Heggestad" <aeh@db.org>, Thomas Reitmayr <treitmayr@devbase.at>,
 Slawomir Stepien <sst@poczta.fm>, Jie Wang <jie.wang@intel.com>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 Randy Dunlap <rdunlap@infradead.org>, usbb2k-api-dev@nongnu.org,
 linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
 <20261111215723.3802209-2-dmitry.torokhov@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261111215723.3802209-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 11/11/2026 à 22:57, Dmitry Torokhov a écrit :
> The yealink driver is obsolete and being removed. Drop its module
> selection from ppc6xx_defconfig.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   arch/powerpc/configs/ppc6xx_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 8aab229fb909..29acc77573d6 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
>   CONFIG_INPUT_ATI_REMOTE2=m
>   CONFIG_INPUT_KEYSPAN_REMOTE=m
>   CONFIG_INPUT_POWERMATE=m
> -CONFIG_INPUT_YEALINK=m
>   CONFIG_INPUT_CM109=m
>   CONFIG_INPUT_UINPUT=m
>   CONFIG_SERIO_RAW=m


