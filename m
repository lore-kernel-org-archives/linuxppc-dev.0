Return-Path: <linuxppc-dev+bounces-22425-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FC1CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 16:41:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbBPW0Dqrz2yv2;
	Thu, 11 Jun 2026 02:41:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781109694;
	cv=pass; b=Hz2aV6bjbADqSo6ACRZhcGFAOubgjCjlYjvNZGsmRnc00Pyn8Qj4Wpgi2PWhAkuQOd6InjpERfMGPBPI8+/hSGFSEhwz2RkICjt/1KBPjufKfGKlHi7Y1CID+j4hG5W8zfcfkcE6kBUcULsvbQZTNHeg+opN5EL/EKpepQMP6/x+xpm8BHBD1pCUEp65unk9un/Xffchwm9yY2rnPVVE7jxtjT8clWXYzWLwWuXNlSKY9kNQ1bjNtNfNspkTibwHseocLI3BGEQcjOOro2RP2Ty1G7NU5Ki8akKn6Cd08Har9N2Tt8FUvTiCqlqY2a4OzaYn9VhoJOjlyXSSj8yFjA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781109694; c=relaxed/relaxed;
	bh=PT+PY78KXxofjyRxno52RBKQ5jXbpc7xwPRRoOZh6d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGvkMKwSSe8RM2MXW88LpbtfLImBb87V1+pkoSa7ExV4svUQtcKFQsAKxEOox96QcaYCZM2FbZfx+1eivXQf7FB8I8ykx6ZypIWNH0+FFITrI4MYBzsAAcojB6WMzZslM6Bl8OWn2dfofel8/dIC/EaCLet/jX9ugjiE/LdQIeENh+iuClVSOViP+1yi3Vi+8SmBg5qWVYC30/NfT+dIdLq4llCXGmwKkz9y+2becxbKwWU2zDXFuQAlnZ36VZFPHqINnAaxdG+uvucAuElaCBsBZhFaJAY1k1CIxb8WkMyExdqVI9Qr5eozzm1HINHUbQc2sYhLvLr0LGS+QyqCQA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IeLgGi9v; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=nphamcs@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IeLgGi9v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=nphamcs@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbBPT6g4Gz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 02:41:33 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-45eedc94d37so3626028f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 09:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781109690; cv=none;
        d=google.com; s=arc-20240605;
        b=Op948lgiPUNkl34OtxaZP54Zd7J2PEPPyXJoaNbe3Zs0T0Q68HMO1RT4S3NikMDD4i
         aOfjVHCSaJp1uBTHlf/vDQTvbie57GMGvW1QSU4lXBqhfJ24bec+8Rj2HIlELxvnaCbD
         QB7tPqT65arymCDDu0ABDFRno4gSNNZnTBYqXswvCgxnnBWUpztdJlEzPQUs9t01ZNC3
         4melwKOzIHN5YJRspCN5QtRY+rjfKdbpf/HvFNrx0DzhVkTi/rJCoHXmA5/LALGgttsG
         ljBKkjMHcbRj85+cmcjW16Mo6IsE8ATDxOI6uWg12xDdN6Eh2fO+awhCFLYDIc6tByOj
         AdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PT+PY78KXxofjyRxno52RBKQ5jXbpc7xwPRRoOZh6d8=;
        fh=BHjbAZ5TcI/WGP6eAqOqbm28t9Th/PxI5PunpnkKybk=;
        b=Xl82tPqosVkuPpYOS7Oj4CUZmK7KT6F0Ook5CT7E9HcGCL2kPpemUx6OuolMv8Th7I
         lJACqXsZ6q26vbkP7p8Xq2OwEIKrB0vjMym71xCsVQlvSRcFY4Bqx94iWbJfqvAKQaLR
         EvDDubF5YD7xFRHwzevfbP/6Vdo0/16dViJbEjNiVrpoBXjy1q4mmlW6kGJzv42/SA/L
         iYg094wfFljl9Iy48fb31yIE2EsEVjLsl19dkZVRxmbkZzg1K99e88Jv+FZrptX/tbwe
         /whEYMw9WwqiytAiwuq6WJ7pvIbAlOqKpZk6Sct1ZgNCZIAp29ec2O5C0lkjIF+6zFAK
         5WIA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781109690; x=1781714490; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT+PY78KXxofjyRxno52RBKQ5jXbpc7xwPRRoOZh6d8=;
        b=IeLgGi9vImpPAwUxE07BwA+0PYMcJ9zyg18X1ZPZEjjSV/CQt9lLuaZ7G44nSHFVU4
         wpNBaYFTuDB4tq2c6jFnmaIHnq8A3fNS8r/5kHeJjn/TAflzgp49+dgAgKx8H97TuNRi
         JU2g7EGGAek5O58pFfLioGZLLTI12tpWWVmncoYDpNbLcJTddrwPvaX+eBX7tyHluxWN
         4YjQRtx0yDJDSw3hsvkHNgiIffp0H+LODg1vI52Z+b1UFUXc6LwHb2LBv5Egbz/qY3rA
         x14rYoB340KSEvLk+hRHpkrBJKpIVZkeymBOLRaP/NeqIou1Dc/eWpI0Y8T/N61pvrEK
         PgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109690; x=1781714490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PT+PY78KXxofjyRxno52RBKQ5jXbpc7xwPRRoOZh6d8=;
        b=iewHHMT8WtYmxGYqkU151J1A+nhnAghcyOLEa3/MEuTB+o0n/tT+vqWZzWBETP20YU
         8g5SWSzI+jOby87RCPjdLYK5i5sIYzbNfiU80IvqRdUZsmR3McT2r3837ICwWM0Vjq2W
         stjZWYc8v9DJUsEP4EZpoAcOxNVZUCwuBrclM5ndiVVn8fDLOCh9dPiRhPbQ2+tniXR7
         4QjharMWFeRwY6HAcW2Sw/tdMAWZFOAcdo1XMj4nEBkW6WhmrJcTSMSMuFS9GaDF3YJ3
         QOmkC7IAzYaosnI01dzkybgglnWfGE3Q9yR0WdcsmPkQc/1kMKNJuqyDDxJr33jGG1rE
         vEpg==
X-Forwarded-Encrypted: i=1; AFNElJ8FgxEfzQnNODruJuLlaGX5CVl530EOUh/b/rElojXa+XXRhXNBDoqX9MJSZtZ9Xj3UX223bM3wPEPbQ1g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQfjpaEMl/taS8XiLSLuG+fWLkBPzABUGrIlFOx8PUUcfHzt/P
	JImPSJ+SUGd1x7S8xSK1uJ84WKNtWp/SfqZMijaMvHQXkk185MDyDyheTOpbePf2psYQsOh0Dg7
	Enru0NpRAZ9SSQ4Gpybk8PBa0+2oekMU=
X-Gm-Gg: Acq92OFAoCqHtq/B2t+qqRjQR7lRTCkz+MxAVAU2S1fWSw1vXSIVFVZ2/e1S+FB1uf0
	kmYQ8Klsvzrjp4SCbJaVhQGuXQXSDAAFEUJkPMlcSLhI3qLpWJV9+DXrZcaEkBVCkwyP+4t5xNm
	ors7i1IYoKBxYdSmyaEBz7s+W8Z0Un3SWznHwESR439hF9HGynKAmWykh9b6ljrvGbentWHNPqU
	DFCsXOZ/ZEUk9huvvGz5KnKa2M+t700qm/J1zSLu4y11YMnwzhOeQ+bGkxIfDv8FRq0Bo1Vxg7w
	aA3hEiR+J7SN8wYUOEduEdIyO0sctWygZ4m9+bEozkje+pLHj9wFiwKo54Hs38D9YQ==
X-Received: by 2002:a05:6000:178e:b0:45e:f52b:f4b7 with SMTP id
 ffacd0b85a97d-4605668e61cmr11443793f8f.17.1781109690091; Wed, 10 Jun 2026
 09:41:30 -0700 (PDT)
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
References: <cover.1781000840.git.ritesh.list@gmail.com> <68591daf0d679e5a0072d63751f187d14613e2b0.1781000840.git.ritesh.list@gmail.com>
In-Reply-To: <68591daf0d679e5a0072d63751f187d14613e2b0.1781000840.git.ritesh.list@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 10 Jun 2026 09:41:18 -0700
X-Gm-Features: AVVi8Cd2j8ucYOyrC_mYn3R-SWWpqfSCH5PoEKv3S1kL1-SjdJ4cmU7YlrR2bZw
Message-ID: <CAKEwX=NCB6yrf4Dc0yU_CwZWi0Kk3tBup7yvP7EUz2k7_CR2RA@mail.gmail.com>
Subject: Re: [RFC 1/4] include/linux/swap.h: Remove unused leftovers
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:20=E2=80=AFAM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
>
> This removed unused leftovers most of them are forward structure
> declarations. Also removes SWAP_BATCH macro which isn't used any
> where in the code.
>
> Found these during manual code review.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  include/linux/swap.h | 7 -------
>  1 file changed, 7 deletions(-)

Seems like this can be submitted independently of this patch series right?

