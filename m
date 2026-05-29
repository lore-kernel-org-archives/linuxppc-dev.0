Return-Path: <linuxppc-dev+bounces-21701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E2CCD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 09:10:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRcyX29NFz2yQH;
	Fri, 29 May 2026 19:10:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780045828;
	cv=none; b=jZ4qRoWn2rmxllXkuWbEFqfxQ9ij82VALiiwuXtIp7sdZllMVmCl7AsCRQ2bjzZFYqiASlZGcLqP3WYzywr2GLZQNelqhgKyy7TtjFtP62nQMlpS4BKz5pjaXe2MsNisJpfF4O1UURRCoOxlqbwHlemndHKCndZbY30BBhuQomcM1YkJyqm9s5/Q5f9/Vd8EanpIJkA62hDxFytS//qD13mE2S+90riX4PcjwdwafxCF4YiM+B7Dv/N3fqKyofv5zb6JTJdD/ziTbzW/IZs6Vl7pQohmZSAeOfuJT3CMep2whvxWgi6NCKw7oefUECUR1VF/05fB60ENHhqN5sL0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780045828; c=relaxed/relaxed;
	bh=S8RgkVBDzDG3YaYzhTa4ISLM+K3g4AZuNYjWiAh67ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQT9HXPWe1njrp4VqgRf4V4sU4TdS/iRFzehIO3bxucUztrLYSXbUeB6G9Ph+FvvNj+aiAqIgUrNSwl4mZrGB800YSyLwC1DgceeJyASn+ElQxwiZIASd+AHKnZbfl1/IMAFEVzCQLFn2frk/F0/+6l2hDjKBxl58Fgtl8mbjNbkVnUInpo5uP9p6kp64cMb30ZIfvH6AQSmaZjOAUp49cexkuxqukO2ymk/vjV4h8DeCAmiOrd0EEw4S5wtTM72MD/DEp9byxesRZwIRmZa4hQHPcdJ95tm5LC/UdrGqyC8ztF+EG2oAo+ziqpIfZL8bCEnsvYhmcF2CvpgoXDdgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npqlHZhf; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npqlHZhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRcyW1F3Hz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 19:10:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BDCE440965;
	Fri, 29 May 2026 09:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0201F00893;
	Fri, 29 May 2026 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780045824;
	bh=S8RgkVBDzDG3YaYzhTa4ISLM+K3g4AZuNYjWiAh67ao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=npqlHZhfv7Tx5WB+QmIVjPtAAEh9WWZ2VppHuNVru6ulksxMr965VBErPcNNlz+eN
	 8ZDAwHiGR9rM0otdBqNZlKrgCk7dpmZ16UkDszKLMwS9lOylRmV/sJMkt+k1VMV9AY
	 pG4vvSe8M4LirIFvLguXN1OkTyDGj61UM99uLqCqgWTJywYC/AAgD+I01eGxVg+izU
	 x4UX/rMw0ZsfZ+5kQpambEzdIKi9zUVEq9tzU73sFs4r0jcv33owHSWNXC7hdhwa1K
	 tCD/Ap15yHyaVxE1GOo+PQU8ZdWQhmLtA5ubviH5g/lvUFXi616tPdMewA5fDBWFGM
	 qRkZqMrm+u4fg==
Message-ID: <7c1a04f3-caa8-4200-a4ee-55cd2cc28461@kernel.org>
Date: Fri, 29 May 2026 11:10:20 +0200
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
Subject: Re: [PATCH] powerpc/boot: remove unused min_t/max_t macros
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260525091839.817778-3-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260525091839.817778-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/05/2026 à 11:18, Thorsten Blum a écrit :
> The min_t() and max_t() macros are no longer used by the boot wrapper,
> remove them.

Did you test your change ?


   BOOTCC  arch/powerpc/boot/decompress.o
In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:241,
                  from arch/powerpc/boot/decompress.c:37:
arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c: In function 'fill_temp':
arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:158:28: error: 
implicit declaration of function 'min_t'; did you mean 'min'? 
[-Wimplicit-function-declaration]
   158 |         size_t copy_size = min_t(size_t,
       |                            ^~~~~
       |                            min
arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:158:34: error: 
expected expression before 'size_t'
   158 |         size_t copy_size = min_t(size_t,
       |                                  ^~~~~~
In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:242:
arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c: In function 'dict_repeat':
arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:357:22: error: expected 
expression before 'size_t'
   357 |         left = min_t(size_t, dict->limit - dict->pos, *len);
       |                      ^~~~~~
arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c: In function 
'xz_dec_lzma2_run':
arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:1101:52: error: 
expected expression before 'size_t'
  1101 |                         dict_limit(&s->dict, min_t(size_t,
       |                                                    ^~~~~~
In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:243:
arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c: In function 'bcj_flush':
arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c:469:27: error: expected 
expression before 'size_t'
   469 |         copy_size = min_t(size_t, s->temp.filtered, b->out_size 
- b->out_pos);
       |                           ^~~~~~
make[2]: *** [arch/powerpc/boot/Makefile:235: 
arch/powerpc/boot/decompress.o] Error 1
make[1]: *** [arch/powerpc/Makefile:236: zImage] Error 2
make: *** [Makefile:248: __sub-make] Error 2



> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/boot/types.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
> index 8a4c418b7260..c5085c2632bf 100644
> --- a/arch/powerpc/boot/types.h
> +++ b/arch/powerpc/boot/types.h
> @@ -37,9 +37,6 @@ typedef s64 int64_t;
>   	(void) (&_x == &_y);	\
>   	_x > _y ? _x : _y; })
>   
> -#define min_t(type, a, b) min(((type) a), ((type) b))
> -#define max_t(type, a, b) max(((type) a), ((type) b))
> -
>   typedef int bool;
>   
>   #ifndef true


