Return-Path: <linuxppc-dev+bounces-17659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77236EDEC01
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 03:35:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQdbM03dTz2yLH;
	Wed, 04 Mar 2026 14:35:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772595310;
	cv=none; b=MVXweU1szXzzhtqplf8NHCgvDWs8VgFxOTyMZNu+I2sKq6jStONClqp+1/k3hmS3qi39zYbmIxPX7MsKjEMJ00fKiVn4vtReWCrbNRzUM2GZ9tx7Vu1Ee4XzUMZGxmky6++KG2yWq34+LP+ZLQIUVvJ8HcJLXRgvoTSmmCUCwT9yyQdm0Uvhr1zslPZhTO8VsuBn1dlv0853iB4PKDrSMoGfmE0UXW5itkseTKfh0Ve/Dbl1nghEJa4bXlDz9AUmEN1daVRie8JCCRure6mFEscCG+9yyRBa7nIp4KtEi9s2iv8cG9faZU38gViiyyFmFztwNSe2KKhRT5RmGoxoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772595310; c=relaxed/relaxed;
	bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MikOcZ+6SSMGaSB03uGpdfDoa7FDFYV7ATSv9EzW1LmrWFEMnx/VCN0D+/VyD3R7nW7e+ujG+ToPZu2qpL/9FkQFbcUhJ3WobMHTG+bP/WGHRvGOf3tcTDzSbSwlS31KtKeS2sybQWiInaOMaVjebBwSNxWFyBNe4IFtHWLGtjCPdelYjwj01VJcnPz80xaak5GE9hetPQCCWLeDzm5FzYyhSDQaJJsEXQKQNZ9ezfaarX3AI7eR56MZG2tkUke1/FSM/jX5t0IA4zqIsj0ssRmMVj9inOzv3dSx4p1owouo91xeUtn+XchA33mRJ4A7E0gYgXiFVsCQfDWqRmTFog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.dk; dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=V/zknwwT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=axboe@kernel.dk; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.dk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=V/zknwwT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=axboe@kernel.dk; receiver=lists.ozlabs.org)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQdbK1qmlz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 14:35:09 +1100 (AEDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-7d4c383f2fcso4377070a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 19:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772595307; x=1773200107; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=V/zknwwTwpjWGs8pmSSWOfp4ocC5SUkbMuM6a7TtVeMzBw/hRyqoRTzUvTarmYx7wP
         Tcd2Ag6kbhrdQLi2n0bNaW8oA9tDimEhe1ZqSlbYX0NnPeEzVYNrcOp6EBAuLGP8ZKUZ
         UrhMb/jr+sflcWB6YXInq3x0OFz1NTBjvloHG5Lwml5J2chGDfjpghxIGhrRApmiDXDI
         basPBC0dSUvqkTB8A+XI/jSxsZDMPdaunBrvvNmijws20AnQjAc/YdlvBLdDsaTZJ4fl
         Lfmbz2rQnKrpK7PV9Bb4IlRRNxVULXzYT+L25yEZCdPOIiZ/OMaEhSZZLVOJkfK2Q7iF
         zBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595307; x=1773200107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=ZkcuwCNogba8WeJWWyM2NcFTfNQv9tEMCNGhFFfOQP9Mdq7tYpUXpoMsi8iz1sCk0V
         s/fxi1qTChxAtD8hSc5YIGuzP/msylhoDaoIza4lSOAfuwRADhXvjRL4gqS1oNXGzs2Z
         gTLPEc/OUamyFLdQpBBfvEVW886Og90VMC5yjsPWf5AUFa1f+q+Tf0jLPNhDrHefP1V2
         eDgkLRxxgYySS5wl8WYOqex8XFS1Tf66Lfl3T3DQK3/p0Kc58aHk7Juy4f2WcXRRRtlz
         dgxW5wQVpCInOHm4nh77aUUB3Q2ocZh/lp0mVammnfP09wTKMC0ij8KhV5xX1j/kRQ5q
         SX5g==
X-Forwarded-Encrypted: i=1; AJvYcCXw23X+a/9k+GEcNGpZ74fOE7Kbs86YOFiWBoXklTstI8qlcnzo5xg4etLv5BsLhruEH0cw7w8aBwMVzSo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9tkIipE/E0iZtBl9VIx3H74pQXEpqbWYnW95xNscQ+B2675cs
	BkLC1yjTTrUL+0+yxktzPfNOznjmDqGkTsmNKp0tAz9wUHRmm2LInFkXr7WXkOqzZ8ylwSprhKa
	AmvhwWd3EdQ==
X-Gm-Gg: ATEYQzxGAbbdU9voawkoKRgQFfsCgDs+SH2Km7YqYhXf5stFJflkeOA+UlyxuZab2PQ
	MURe2rNavpDcylWAV0J4BzWyfTawkGdnhfTj5WmYoObIWrfI8CbFm+SFQXlS7gz73n2EfnFm6IO
	0hRmQODGYSL2n56shlHBW/APsApbBfKFFdmSetx+VVdt7VEhb/71Hpk6RDQS1Oc3l4w19Yvmh5i
	LpbOqwNXMk0O2wSwtSp1/dvFHdn9zCmotgZKxi5YskXqWq6U0VO1IzlFjLOyLHCItAzUeTKRDBj
	0hIYrEuFZmO5lwPtrRQLcTiI4lnwENuXx5mMta3zpu6mqAEim8BPTMX2YXvAP4slPxaTu1sjSFB
	8bqwB28zfVe6xgk/e3jHSugnY67fF/4HhoBGcOJW9JicOazFndW04d5Snf3iu0XMZUKX17pPyDT
	1UT3KxE8TUpN3bcki53ZMc6+BRjP/DPtsg0NKWIf9bk+gWEgE8zIzpsjNUNRWk31mGwIirIdqcJ
	3MWnsqn4g==
X-Received: by 2002:a05:6830:6185:b0:7c7:6977:17cb with SMTP id 46e09a7af769-7d6d139f788mr450044a34.21.1772595307034;
        Tue, 03 Mar 2026 19:35:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653f6asm15202012a34.19.2026.03.03.19.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 19:35:06 -0800 (PST)
Message-ID: <e96e851a-9050-4d8c-b1e5-bc3b5d91a84c@kernel.dk>
Date: Tue, 3 Mar 2026 20:35:01 -0700
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
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
To: Yury Norov <ynorov@nvidia.com>, Sean Christopherson <seanjc@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>,
 Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
 <aaedwFwXh9QXS3Ju@google.com> <aaen2pGs0UeiJqz1@yury>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aaen2pGs0UeiJqz1@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 8:32 PM, Yury Norov wrote:
> My motivation is that it helps to simplify constructions like this:
> 
> -               loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
> -                                    PAGE_SIZE - offset_in_page(dstoff));
> +               loff_t cmp_len = min(rest_of_page(srcoff), rest_of_page(dstoff));
> 
> Or this:
> 
> -               if (folio_test_highmem(dst_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(dst_off))
> -                       chunk = PAGE_SIZE - offset_in_page(dst_off);
> -               if (folio_test_highmem(src_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(src_off))
> -                       chunk = PAGE_SIZE - offset_in_page(src_off);
> +               if (folio_test_highmem(dst_folio) && chunk > rest_of_page(dst_off))
> +                       chunk = rest_of_page(dst_off);
> +               if (folio_test_highmem(src_folio) && chunk > rest_of_page(src_off))
> +                       chunk = rest_of_page(src_off);
> 
> To a point where I don't have to use my brains to decode them. I agree
> it's an easy math. It's just too bulky to my (and 9p guys too) taste.

The thing is, now I have to go lookup what on earth rest_of_page() does,
whereas PAGE_SIZE - offset_in_page(page) is immediately obvious. It's a
classic case of "oh let's add this helper to simplify things" which
really just makes it worse, because now you have to jump to the
definition of rest_of_page().

IOW, just no.

-- 
Jens Axboe

