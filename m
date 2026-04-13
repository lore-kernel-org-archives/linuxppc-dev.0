Return-Path: <linuxppc-dev+bounces-19682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB2EBFD37
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:35:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQM33Ktgz2yhv;
	Mon, 13 Apr 2026 21:35:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776080127;
	cv=none; b=dWOR8CeaggWkYDxxNMy3AMl9Te06A6a7jyEF+PoCrE+8hd0ji/MA9Lw4+bjUfShHznPhxcLdqeCHkbRtyLGo2R7GGSwhBuikCoeFewSsmrcsYSdqyeqtQ7booDfiUemd5T+vXhNkXy6XcyNYMEIRvGcgE3JoVjl2Me1rJlCAPAj5aq/ZUrpi/maM7xREbdODFj6y4UQMz9SyDPmbUaWy3qaqiz8BZX0+sEaos3B3N4bXAliSH17W9lRsPPRDLdZuzRZhFW+z7cRzRYsPBH1QRqUE2w09dpsEztFiZzsjWC1VZSMTNJcxmqN/t4l2EILN3XevhFOn+16ZQ7djsPwTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776080127; c=relaxed/relaxed;
	bh=2Lk//oxuN31geKgB90jytcWQfWsNUhB66hyUVf2MrmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5h6OeQYLth0IGNTyMVVFdAeyW6i3uW75ZRz0J0sWHxwODwgYLXFrH4QLMzHJEIIbkS8P1Sc7PFEt0GDTFbBQeM67F61Ll9NN/HQcQ/k8H+jvW4AyQjjaCEvp3VcjQxuSwZaQkP0S2h7kDTtGtVljsnaUxm8ZMSnKSYPlbtP8k7wt7mG9K/J3GaZ448bcdmwhB1duMK+EXKF6sCcBU/c2koKa1z2lkTXoxogCVAZRaYvNybxSpIMVYut+/ELv54ARhJts3kN2s0iZn2f6JNIfJYiq1MojzrpCu8kqichYAi7SCwHC1lCx78iikvNa9Rwva14+AQLEyLAvrm6RgmHHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ps0GEu+P; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ps0GEu+P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQM24QW1z2yDk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:35:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 98DC760172;
	Mon, 13 Apr 2026 11:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF431C116C6;
	Mon, 13 Apr 2026 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776080124;
	bh=7+wx9A5ChF2RGBChwepHvx3I0eIKpfHK5FSdsSGWHt8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ps0GEu+PYm0ED+w7Hmkawn2VeRh9SYfgT4r6LxY0vRcm5BNc+9aNA9W3TtzrZ/nid
	 g7b79ByhceHI/rPA3lCb2bnnGr2Z3ekvJYNoKEvC0QOA/NQneI8PqpmfNvUZ4sxmKJ
	 F4h84zr2swIultje0WjXIwypXADX9PFgerQn4LxtIiS8W8TqhyMZUn19jq2WCwI5Sj
	 FEgU+OZjWlxa3J+YuoTNU4qJdt27KqNJ+JpCcsmDTNsbvH7U0GTtNqFbOmhqP5jH0t
	 Zlq1A3yma9IxP044+5c2l3WfVi2ZgYr531//knfFIh1/nGHUO1yc2bBttGWHEUF5cc
	 Ge3rA83KWs4Yg==
Message-ID: <29777eec-7032-41a1-867a-19b97b28c26c@kernel.org>
Date: Mon, 13 Apr 2026 13:35:20 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/powerpc: Drop CONFIG_FIRMWARE_EDID from defconfig
 files
To: Thomas Zimmermann <tzimmermann@suse.de>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260401083023.214426-1-tzimmermann@suse.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260401083023.214426-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/04/2026 à 10:30, Thomas Zimmermann a écrit :
> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.

Seems like dependency on X86 was added by commit 7e35fc7ab433 ("video: 
Make CONFIG_FIRMWARE_EDID generally available")

Before that commit it was dependent on CONFIG_FB which is available on 
powerpc. Maybe it is worth explaining that in the commit message.


Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   arch/powerpc/configs/amigaone_defconfig | 1 -
>   arch/powerpc/configs/chrp32_defconfig   | 1 -
>   arch/powerpc/configs/g5_defconfig       | 1 -
>   arch/powerpc/configs/pasemi_defconfig   | 1 -
>   arch/powerpc/configs/powernv_defconfig  | 1 -
>   arch/powerpc/configs/ppc64_defconfig    | 1 -
>   arch/powerpc/configs/ppc64e_defconfig   | 1 -
>   arch/powerpc/configs/skiroot_defconfig  | 1 -
>   8 files changed, 8 deletions(-)
> 
> diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
> index 69ef3dc31c4b..7a515390646b 100644
> --- a/arch/powerpc/configs/amigaone_defconfig
> +++ b/arch/powerpc/configs/amigaone_defconfig
> @@ -76,7 +76,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
>   # CONFIG_HW_RANDOM is not set
>   # CONFIG_HWMON is not set
>   CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>   CONFIG_FB_TILEBLITTING=y
>   CONFIG_FB_RADEON=y
>   CONFIG_FB_3DFX=y
> diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
> index b799c95480ae..66eae5b7e16c 100644
> --- a/arch/powerpc/configs/chrp32_defconfig
> +++ b/arch/powerpc/configs/chrp32_defconfig
> @@ -76,7 +76,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
>   CONFIG_NVRAM=y
>   # CONFIG_HWMON is not set
>   CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>   CONFIG_FB_OF=y
>   CONFIG_FB_MATROX=y
>   CONFIG_FB_MATROX_MILLENIUM=y
> diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
> index 428f17b45513..ed051fbc7b69 100644
> --- a/arch/powerpc/configs/g5_defconfig
> +++ b/arch/powerpc/configs/g5_defconfig
> @@ -123,7 +123,6 @@ CONFIG_I2C_CHARDEV=y
>   CONFIG_AGP=m
>   CONFIG_AGP_UNINORTH=m
>   CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>   CONFIG_FB_TILEBLITTING=y
>   CONFIG_FB_OF=y
>   CONFIG_FB_NVIDIA=y
> diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
> index 8bbf51b38480..89bcbeb05067 100644
> --- a/arch/powerpc/configs/pasemi_defconfig
> +++ b/arch/powerpc/configs/pasemi_defconfig
> @@ -98,7 +98,6 @@ CONFIG_SENSORS_LM85=y
>   CONFIG_SENSORS_LM90=y
>   CONFIG_DRM=y
>   CONFIG_DRM_RADEON=y
> -CONFIG_FIRMWARE_EDID=y
>   CONFIG_FB_TILEBLITTING=y
>   CONFIG_FB_VGA16=y
>   CONFIG_FB_NVIDIA=y
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 9ac746cfb4be..fea71d647375 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -198,7 +198,6 @@ CONFIG_I2C_CHARDEV=y
>   # CONFIG_PTP_1588_CLOCK is not set
>   CONFIG_DRM=y
>   CONFIG_DRM_AST=y
> -CONFIG_FIRMWARE_EDID=y
>   CONFIG_FB_OF=y
>   CONFIG_FB_MATROX=m
>   CONFIG_FB_MATROX_MILLENIUM=y
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index 2b0720f2753b..2b358c242123 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -251,7 +251,6 @@ CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_AMD8111=y
>   CONFIG_I2C_PASEMI=y
>   CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>   CONFIG_FB_OF=y
>   CONFIG_FB_MATROX=y
>   CONFIG_FB_MATROX_MILLENIUM=y
> diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
> index 90247b2a0ab0..80606a5e6475 100644
> --- a/arch/powerpc/configs/ppc64e_defconfig
> +++ b/arch/powerpc/configs/ppc64e_defconfig
> @@ -120,7 +120,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
>   CONFIG_I2C_CHARDEV=y
>   CONFIG_I2C_AMD8111=y
>   CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>   CONFIG_FB_OF=y
>   CONFIG_FB_MATROX=y
>   CONFIG_FB_MATROX_MILLENIUM=y
> diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
> index 86c74146824a..879e57629af7 100644
> --- a/arch/powerpc/configs/skiroot_defconfig
> +++ b/arch/powerpc/configs/skiroot_defconfig
> @@ -216,7 +216,6 @@ CONFIG_SENSORS_IBMPOWERNV=m
>   CONFIG_DRM=m
>   CONFIG_DRM_AST=m
>   CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>   # CONFIG_VGA_CONSOLE is not set
>   CONFIG_FRAMEBUFFER_CONSOLE=y
>   CONFIG_LOGO=y


