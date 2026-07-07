Return-Path: <linuxppc-dev+bounces-23671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D196C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 05:38:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvVPf4g0tz3bsX;
	Tue, 07 Jul 2026 15:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783402694;
	cv=none; b=hhhyVs80BZ/+9P9QTKmz8Zto0IbcXeLvxHxUU4eHNu/wgYZlJOyaICos7ahj7RAeJNluHY7j23O82gfFFtEZKocS2MBQBNfKr5tyIruxD9Og5tnvlSr/lAafmLwNFC1vYN6j/M7x3bukH8/aNcp5E7s2/WnPDWU7cIJ5tvqvhvhDg9TsQQxmR2GXwSazkv8/r3k5uDlXyGrcgPsO8D6cBEyl564QfCfkuQ9pTo+H60paIlFUxUrTcW07LXGRFRJCbw/YtvxLZ/fBc4So+akAynJ2lww3QZvf0+jrk5qqHFGn53TlU88q6TQo1nP7VOTzoDkmJff96JT7Kkpqw32ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783402694; c=relaxed/relaxed;
	bh=p1z6ysEkvPhwh7JemQocAndVR5dhrdQsHU5bo95fecw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhZusTaOZ/0xdIgHt2dAyGTxcJfcs6qG5Ay9+CpEQPf01ySIt/ZcDvMbnIti343IoTn/BJLdiXuke5a/qFh/tRhg66FM9RE0hRQeD+tSMhLxVPhA0SNDCudesPIZ1qmy41t/qCYCx7rsoKbUXdyCDYm2xO25DoP3fAelwFP3W/2eg+SZ7HFtMgJV+s9et2kFgsjp69lGZhUwfiQ/lGYZhsZc5+EQE9mwozXSLFz3JtojSWdpOfMpi+waWHKcDmjubaCatLOJwJU5YQA+oIKMK5yuZgiZIntnjAnFNlH7GIA16H5ZNtoIVjs+1nKyMhiXcddLhbu/6mqxcp7igH8k9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E+NZsFI7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E+NZsFI7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvVPc3bMCz3brx
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 15:38:11 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso41306575ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 22:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783402688; x=1784007488; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1z6ysEkvPhwh7JemQocAndVR5dhrdQsHU5bo95fecw=;
        b=E+NZsFI7tl7LaSQoWLaCK3yWUu4uo/b2nbtLZvF8NfjyD3ljnTexLG5TujEB4Kx4ss
         Jesy8hnmeq2Xk9mnknvDdt+7uHgvYiD4kq2pBQo8b7djuKOM3IEYUn5f1WkrxsmXeK1R
         Gn2Y8er6khZRVpXpH+UPZuIIb9rleHbXpif1hf4DhjDEWY4VCuZaJ0vfbBJif3H+zB6V
         C77kfBhncdFz4jw/3N2PNyFhcMxZroxvKi4UT34WJoUi6JmhXuahferlxC7045U1M40d
         2y+f+dFXtr3ib11x7ximIgYNg/IAUg6/8jjFV1paM3Z/m5SXZLJCI1kLxoX9Z8k5/1er
         Hfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402688; x=1784007488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1z6ysEkvPhwh7JemQocAndVR5dhrdQsHU5bo95fecw=;
        b=dnBTaAejZx6e+WYR5jg3uMnrDi+zMCSC0Dnjbc7gF4zdfUVTwpXLIo5ZjohxrDuVGS
         WLSl74dQMwu3+UUAra/AbHtdoC+xh2+80zhdTwtPHxbqVKoPrCKHo4e6G1dKQaiZjUSE
         06NdY6f9Fco/RA6wMkqRraHNNsKc9x9n6r9bU0czzYreFyilsJQsJv4f4z+9F8TQYt8p
         q3yp3DcMhGSPcfKbD281B/Sz3Q17Fr2PxBJ8q3VFteWRoMgEUFnZvvfmAdWPtc0Xh/Oz
         /hqSg1wZhapTmMaedSyWRIxAE7M4Uswe/7NJtqcUvqNP65060+nx61h+e9N1f5lotV7/
         zxzA==
X-Gm-Message-State: AOJu0Ywvp+EF7y+3ffaMElWl20CkbmJuuC5Ajcu4yO5hMRUnCdmeqVzU
	zAPhhUpOY5GAkx5W9OtEdYfO3ZlyAewB1JtwyBnZmh9je/EHfUtbJyWy
X-Gm-Gg: AfdE7cntjLVxUn4zC+e2h/1wWgS7cM5Gt1YphzgN+t9KZJnh3mP1VTplFfPUEMTZJ7L
	/uGtnAHjHpPH7yGgfnN09ky1Yygyc4TR6U38Hc6WmZ5+fO+rO/Fc5JujiWqLJrIp3bRZlEf7EHs
	y6rqRFt667jnnjEGi94V9N9U3juJWapFs+IrnWskIO1wOQjv6csHVTuOackwS7VKsdpaYOKdV/P
	cwIZh0+dJ85f4R5zIn7CA85QJxV2w626loMMvgKx9o9QYzcd87DjgYSHVF8p4Erbg7F1nhI/pe5
	/EjRTmDlS1oLHN0D6ampNmcwS78UgVGnahZ/1EyOYyLk2dqc1Dzimbre9Y+Y31v1v13meTAXd0w
	gHlorMGdoloBBYPhwRZ0m6K0q0/lPeB7wMkFBMP/YdOG6d46+xVxXwa/lu0mmhDY/1DmCp0HQWk
	38B7WNwBipT8Ng6CA4PRDqyWznIBO8h1vDP3aBBXrYvqaeay0LIRpB/v6KxEQW
X-Received: by 2002:a17:903:2b06:b0:2ca:9ab:e723 with SMTP id d9443c01a7336-2ccbf046ca6mr37209635ad.33.1783402688361;
        Mon, 06 Jul 2026 22:38:08 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm5219135ad.18.2026.07.06.22.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:38:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:08:02 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	adityag@linux.ibm.com, mahesh@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
Message-ID: <akyQQAiLHI3sVmTz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706082708.43918-1-nikhilks@linux.ibm.com>

On Mon, Jul 06, 2026 at 01:57:08PM +0530, Nikhil Kumar Singh wrote:
> The value loaded into r0 in copy_and_flush() represents the number of
> 8-byte words processed between cache synchronization operations.
> 
> The existing comment refers to cache line size, which can make it appear
> that the value is a cache line size in bytes rather than a loop count.
> Clarify the comment to explain that the loop processes 8 words (64 bytes)
> per cache synchronization iteration, and that increasing the value would
> skip cache maintenance for intermediate cache lines.
> 
> This is a comment-only change with no functional impact.
> 
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> ---
>  arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 63432a33ec49..a54f6f979173 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
>  _GLOBAL(copy_and_flush)
>  	addi	r5,r5,-8
>  	addi	r6,r6,-8
> -4:	li	r0,8			/* Use the smallest common	*/
> -					/* denominator cache line	*/
> -					/* size.  This results in	*/
> -					/* extra cache line flushes	*/
> -					/* but operation is correct.	*/
> -					/* Can't get cache line size	*/
> -					/* from NACA as it is being	*/
> -					/* moved too.			*/
> +4:	li	r0,8			/* r0 is the number of 8-byte words	*/
> +					/* to copy per cache sync iteration.	*/
> +					/* 8 words * 8 bytes = 64 bytes. 64B is	*/
> +					/* the current default cache line size.	*/
> +					/* This is a loop count, not a byte	*/
> +					/* count. Increasing it may skip	*/
> +					/* dcbst/icbi for lines in between and	*/
> +					/* leave stale instructions in icache.	*/
> +					/* This results in extra cache line	*/
> +					/* flushes but operation is correct.	*/
> +					/* Can't get cache line size from NACA	*/
> +					/* as it is being moved too.		*/
The comment looks fine. But the alignement of the comment is still
different from earlier. Keep the alignment same as earlier, it looks a
little nicer.

Regards,
Mukesh
>  
>  	mtctr	r0			/* put # words/line in ctr	*/
>  3:	addi	r6,r6,8			/* copy a cache line		*/
> -- 
> 2.43.5
> 

