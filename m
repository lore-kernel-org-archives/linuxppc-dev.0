Return-Path: <linuxppc-dev+bounces-18467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3DB1091916
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 20:26:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcHKd2jB6z2ynn;
	Fri, 20 Mar 2026 07:26:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773930486;
	cv=pass; b=hBRA5KMZc34aRb7DSb+YTBXOssarQv+s/5GFjYS2lHlUeqVX+8FJ6QElH1sT3cTxxnCiVk49AHaNSmxbSWvfwhSEmvO+xZ/m9V7c+8H604ZsT0bPVDxP5YBHAcNWIAlHhghoWwqTBYU1AxUd4YGqrS3m124mHJyxyY/wAajvf/ppdFZC2M91sbhxaK0TMNIgR2AOYq2h5wOxm6pE6Gp81jMxnASf9i99aWn80SOvEAJxfByRIoimYBJYET0gTYdFJ8Dy0N034jNKjboBAwujp/WttQSaH2yMcgJu0eRZT19JiSDVFRJyrOgPXkIW0+LQHC3qY2WSTHiJPhNR1BUiNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773930486; c=relaxed/relaxed;
	bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI8jzTfjERpHdPy3F7bDfFvVvukAPL4siBcdVpr3iFaI1xadK5TK4u0JoGLN7Fct7CstDZgfGZxnLd0CqY9phDTBtAI7dxUbXsbj4xVwrZlk3Dl0M4DSevRNsmRyxVL2yw2MaWilY0bpSrG7hy4jCAVHdwQ0XPnwYtXwIRYvYt2cukjXn6fTgs6elYO7aPO8bQE03Qvq5Yn3v5Y4agzMvoe5AjOBj30rW/oEoOy/FErpVWuN6n5HRsAeCoCXlS570aKVoldgveIYfQw4/zXhb8ha+dQl6sb7LVExc0hT9sHpyDUV1tJVJZ79W8ugMSVKKOnnrzNSbAPFkSa8mIk96A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bmrVuT2a; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=andybnac@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bmrVuT2a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=andybnac@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc7Ml6kBJz2ygT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 01:28:02 +1100 (AEDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-662b5bf4b10so2003307a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 07:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773930479; cv=none;
        d=google.com; s=arc-20240605;
        b=SEmjf/zYBbFc1qNqdE8TlYSORDLPjtv7FmqYeSvhuzOJoxIPxuiKyB7WPV1gHpuB8T
         UXkQnrmgagrI3fws1fecckJ0Adjqnesx0W7x7SPmWeA8F0uC6bEvxmOTv1tvPMMV2Imu
         rRyOFJ0+DZKuwLa52k1a59WUNDRkFJbv3uY6wODAPltmnD7W3YVgMAEMCJPzAzLLfxqz
         0XWw/7PHrMxb19RK91cldcLBNUWIb+SictT4gE/cnC1PtdnLH7qi9AtnaLTuIzTh7nmv
         1XFy0gv/E3vJR1gubuFDQrDGJbadRWHBvH/q4tfKGJVPVza7eIjmNKhKB39ZY3MNGLKn
         65YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        fh=/j0MvYsfX6rzct+zxQ6Qav9elU4uDDxD7GqSTD0sz88=;
        b=i/D02+QdLTj0lGUvcP4rp5qSq7nRcwzGagmyIzWu6zZWj8FQBGB/E2ZZ9Ca/e39iln
         lvghPp711CbKvk+1bwU0orFWbzme3IeqzT2Fy9za+XKA2e6twNljGDDz1Cu+SAXzkRiL
         hCQgnAsHSdoPGdsa47Sgdg/c7gbGPIAIixc3Udt3xZGbRXrLfz8rcCBp1vHjv41OdHkv
         jPhxer7hmUm6n5PCHZSmOV/WxkY/0iFzi8GqOich/pVBUXJuTk13Hbqun8/AURGpdyDq
         ctVmdUO5KpBmshGAaF8yUVpW2axZT7vaW+KzAGOrABxUIBjW6JizgNmbZTlyePiClJoE
         tkHw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773930479; x=1774535279; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=bmrVuT2agVlO+XnVnwkPNLEHNsA3v7YbnAaBpun/QrC6g6FFssJxfSEpCwHNMyxgBB
         WmZnFWljqzmj9AK7Oi7nJItEX9+6Vyv5zZQWbsu53UTFO7MPIsHmhn9SosvctpXN3yHY
         +hDP7PEOH2JjWQCrCSeQcC1NtusLePud1aGMCjSlBI1zdlxGVwTnKriW9UM+4KkyurCU
         4/xAUTagwkHnZGtB1WEXUVFTtn472XyZtcrXORUeujgd83/gUpcMED1MolHjVqWQoz4z
         dmpxbI0xCE6qUw5CDAUhuGX7Jqeg7+GNvg1ZevmdjnadwHJzTqmCKglOcz4GYf+GkoIo
         +shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930479; x=1774535279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=a0HIbs3V7UqDF6GmNgo/DVlbaeCV5pkTgm6BRle1bSyGGECCqW1VUx6sSDGCKOxk9k
         P20PN/G7B0SvtzGQMV2/3JsgAo/3xb25sLwtVBEZRHDZjpqFKt+tx9wbEYWgD+uC+ls0
         LhnKMjTvpmAe6GoegI6DQRuhZBKhUGQBX/ueTC8szbfdRyIM1NQXjXZj0A9szBgoMrw/
         hSWp6QXgxEhxnB9eAV2tFLvKjChsgSUfurBp4sihzvnnzAaZaxnQbwXM8G/zsP21ZwJB
         Ir1cpqTRYhRK4Kn0NNXIUCJ8spHkINrmO7mP8pIaxU8c3EjXiLb2ia+iry33WpJ9lfTB
         EpNw==
X-Forwarded-Encrypted: i=1; AJvYcCUra5mBOxtHghQz3TrsfNtUUl4yb4bmTU1CgjWnF3UtgffRDUHBkpgYT+wu9jNCbcJeDN3Lwozs0rqaRZI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6yBU1QT9ZpUDP1v/7fk4obHnvLTALn2SzgeGo9Zay9p9hdOh+
	Y3Wa1tlu9kB+raVPSOrvMxDlibJxGRbp7x/yl3zvDHD6dOTbJ7vRBpzyaeZaNlVDR/Tq2rnIXJd
	rwV7UIlnsheeX66XnW/GzF0H3KUx+JSw=
X-Gm-Gg: ATEYQzwlizjIBOmIqJST31dz8L6lEKa5WWV+t3nVtm4crvFM7GwbD8PJtC8TJ8ZZ1Jq
	YlKzS7OX6/yTBM6JyoVBm6iAKcFvEkA18wRlG2MpRMRPQnRmrobtTOvFrmTfeXrcE5tY4DuGP0Y
	8zzkt6Ql7+6RqV0ctikqDQJd+AkfyQWd3coC0NkaCp9ULVMcoYG5w8nKzPtE3Z7gPdV0otF9k0z
	ryqbtvud1Aaqg1c1RXzGrU83+rjJn3t07AVkU101avTuxAo3Ep1aC4H1vkTuHsr/0EFffYw7VHm
	QB1rgDZCbQ==
X-Received: by 2002:a17:906:ee83:b0:b96:db93:5d0e with SMTP id
 a640c23a62f3a-b97f4ab7799mr545864466b.41.1773930478856; Thu, 19 Mar 2026
 07:27:58 -0700 (PDT)
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
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 19 Mar 2026 09:27:47 -0500
X-Gm-Features: AaiRm52wQD6uRKulnt1Y_ioaRFL-b1bqEKDLHZMA0LYwV13CAWHAV79Bf5laR-o
Message-ID: <CAFTtA3O74BTJz8d87CJFQpa8Sub_ouKyyAB8cTXUxd=BnUzS7Q@mail.gmail.com>
Subject: Re: [PATCH 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:27=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/include/asm/auxvec.h      | 13 +++++++++++++
>  arch/riscv/include/uapi/asm/auxvec.h |  2 --
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/aux=
vec.h
> new file mode 100644
> index 000000000000..fb4233445276
> --- /dev/null
> +++ b/arch/riscv/include/asm/auxvec.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Regents of the University of California
> + */
> +
> +#ifndef _ASM_RISCV_AUXVEC_H
> +#define _ASM_RISCV_AUXVEC_H
> +
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH    10
> +
> +#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/ua=
pi/asm/auxvec.h
> index 95050ebe9ad0..0a725f2aa2e7 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -33,8 +33,6 @@
>  #define AT_L3_CACHESIZE                46
>  #define AT_L3_CACHEGEOMETRY    47
>
> -/* entries in ARCH_DLINFO */
> -#define AT_VECTOR_SIZE_ARCH    10
>  #define AT_MINSIGSTKSZ         51
>
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
>
> --
> 2.53.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

