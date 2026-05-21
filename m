Return-Path: <linuxppc-dev+bounces-21339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53526CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 17:06:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLvvV5TJrz2xS2;
	Fri, 22 May 2026 03:06:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779383190;
	cv=pass; b=QH9s9hCeP/CGKtiZGqAgae50u3vO5ib9fpbXxDcjMsPA0U6qyXrgoITQ+tMafk+5IFvzlRGDcbV+XnNTMpd2dKAfWhOEduRHfRWfrKh900lv3sojfM6KELSsDMNO1O+dJ19sKRYv4WgAwx4S+ZWCS+zxyy6EnPB5h/Qi2hd73I/J3Q7takiLdoh+w05/IBNWMzo8HKuc1igFHWurzlteiUJ9k9w9nqGcinHcGt3V8QDJuv+fHniYieufXO/B/I/Baqz9u2jkQ2ZUwu0PbbClN24WoC0J8s4ooSZDLnkz98xdXcJ7Lf+MLAbBgTg2hjgzMI+Mx5KvsJzgnpikmztERQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779383190; c=relaxed/relaxed;
	bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHwyI+IOZrU141Sv5CWKI5YCqkdQHbzBqLOx9Dl7HdbBc22N6ARcdlMufA0PWtuQOmefQAHj2VuY9oPTUKwlnTwUKOIcgeSQ2TdWH4nDQEaNH+qfKf4ts1EH75fsHBMZ/aFBzsWBlyDUTwdeFz8q5eWoq9KMhzdFo8+6zv/4uWAnEZSlwfxRehproxOu2l9Z+uR+vA6fTE72l6CxXYDS8g5ec33NYLPqIwXmeoGrKjbCdqEXOrfJquKOdRwVWjadTPX+TdJrFOz9lJ5+gTF3OjQn/nnZuaJV5psqsykHDHFcBBw5CInlRoMbDz515SmBcZLQnN2zN3b6bmeDuLcAFA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Dm84n+OH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Dm84n+OH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLvvT1HwJz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 03:06:28 +1000 (AEST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-516d1ddcdf4so2391cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 10:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779383185; cv=none;
        d=google.com; s=arc-20240605;
        b=AFiAcxk88buqIjXRtRmxeC2Qsv4+IQZuol9EhtyFbovMME+IigNqgJjEvwqKjJu9zZ
         D78Hka3S+ZhsmDAwA44puwTZ7VcCG8dXyVivatcBFK2evuZjn6qqPuVWfCa3MhCeh/eb
         LhAgMi4ELdxfYjsSlSsn5MbKjeg92vczF+kw87qvH1e/aOx5/RIJ1ub+5zkypEapX+6v
         +YluRTHwW6bgcu0OJT21QKbi5ftDERz1Gxkj51cvISrWvUYW1VGGW7DHVKWGg0r1kjMH
         jO5JykzbeBZQBDzquCTZc/XYiy7CAjND4kFU8ny0Q7pXCa7qp5gYO/W8HeI+tYKo8BEX
         JviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        fh=UiVGrtkgTQU2Y0c2gH6zVZs3vpq/mWQ6UCono+T55BQ=;
        b=ATh0hpOTAFPiwvMhG5ow8aKiulpWsSS1v9EQxO6YqY1hPnTZufIFjHaI9sdxdz1I6+
         WNmrBT8GmQQz8YU4kV9Gu1m9C9fIwpN1n+rTL1LuTlLTPOTovpc2Wzg45iYpJ+7KOUEL
         rcFIsbvf22V3AUlIh6fhjHxkSutOuAdY84FqwpT8Lea3MYjGNUovOytPW+sH1i31IMAa
         eRZAdqNqRIpiNe4eUI61USAsbtRTmqcqfEGuTmffwFrJZ7Xew57M6dmoO7QP48C8mzfa
         uFyHlYQ0famO+c4s2tSzhOW+H1YXZobZk6cHNS7Qftk/3Y3Fec5VZtDcf5cNfcz0mVuh
         wYVQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779383185; x=1779987985; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        b=Dm84n+OH8WfmBoqks6Rz9OngVVdYCqOwlKzm7g/KyIszlOV/BfiI6t4jkdQQGIb51N
         HYvY6p4WyOogQuCI6x+wOQSMtBRO3p5hlv9g0+kh7TX4R+pkNnn2Gp7gtga0GKxWhvhW
         s6xs5VgiZUjnN930nXA/H8XDPwK+hhhAqWWe34GXowq4PJEja8OwYHw8b/Opu4MXQkpn
         CL1ABx/VlTHibPfcH1BqtlbEERvHe5WjH7/0cyiXNQI3yTas58tUgfP2HiOJSWsNRt3M
         jOULQ8JXZvyWV/LD6BEzlFWusv4IsX5qXLybVT78XWKcK9yhPV0EJoxdH0GgKWBjmStA
         xE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383185; x=1779987985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        b=JKjYe/79aqvdzJcPX9uLG5kiM1skifZKX+O/gjDasAD2GuuDmOMWRIoojUJwFh0GuC
         Q3fkuu28Yd+3mund1pqQHddPFsAb02KMMmdaxONHK4SzBx9pkTxc6AuydD+ErgtX54gm
         AglCiqyhi6auNt2oQ4sVw8dqYKy6QA1x09p0hBWJ9PxFEbub26pz6kvNHJ4UOWt+S6B+
         BJ9DhGD+6vOVmxwFUNPO2TC7C6r3kyEEXAEHtaVBY0MIZ6eeitxzdMoyMyoP0tyLSzz9
         CJTEq54Df94up9DAF2kht76TatftBFi1REkWyMWVZpm32MjKNli2WGIlB9c7M/wxOq/M
         mO6w==
X-Forwarded-Encrypted: i=1; AFNElJ96gPKYfI0XfeWuR/HF2KGfcNewawlEaQkPMDrfZ82SnQjApYlXc0WMbIxj291JBo/rVNL64b64pm2hlLw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6faFp6J/HeFvwhd5xSa9AIBR7jG+B+sJKUmZZNiTbPUdcd5vo
	QWWiSjuJwaCLlOTuz581D+6PFgzZVKv2YwEPQpep8al7ezoOEJON256avocBIa+tcT8xgx0uTNU
	/IBrXtVMm1OHSxPNDBi/FMreLhjx/YXxO3U/LChgd
X-Gm-Gg: Acq92OFLefwAW0IeeVEi+W08JFVTXTAxZQblA5Qb3yi+A2Zj3H0TRmkvDveiHcZNQ56
	mYiyhiaQBSca0lVaWMVig6nIvMyzuAD7w4ZVm6fI8OWuYCknFhjgP6iKRzC2y3pDK3l/oJWBdgQ
	KXQwRObFU5JDchvZAtS1nmrwB2r1BrdzTiJl2nQsFoswGJThLfQZBlBgeWwkK7apUm4rnuhY/2n
	6yBsn+BmSYeAHsOY20Eh49FaEzVZbuvqi4AvfluMkg9IE5G48x41ejas1h7RoUuRFfCLCEXMgJR
	KmVUm+bC1ElNBhIr/S2BGU4mzcRTUZ3j9P4YYZcEk30r0l1Tc/1n
X-Received: by 2002:a05:622a:130d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-516c52f91damr11257861cf.1.1779383184387; Thu, 21 May 2026
 10:06:24 -0700 (PDT)
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
References: <20260512090408.794195-1-aneesh.kumar@kernel.org> <20260512090408.794195-5-aneesh.kumar@kernel.org>
In-Reply-To: <20260512090408.794195-5-aneesh.kumar@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 21 May 2026 18:06:09 +0100
X-Gm-Features: AVHnY4ISudxxSxVvcLPDn4R1NI9d_Ojyz-0XSa_zA0I3j6uTkfH8ncuvoLHXOtc
Message-ID: <CAFgf54o4ZnvnJ3369bHb10tvJJVP+5YWq=ec4Jh5K6S6U9uNEA@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:05=E2=80=AFAM Aneesh Kumar K.V (Arm)
<aneesh.kumar@kernel.org> wrote:
> @@ -1411,6 +1436,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>         if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>                 pr_warn_once("Memory encryption is active and system is u=
sing DMA bounce buffers\n");
>
> +       /*
> +        * if we are trying to swiotlb map a decrypted paddr or the paddr=
 is encrypted
> +        * but the device is forcing decryption, use decrypted io_tlb_mem
> +        */
> +       if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))

I don't think swiotlb needs to know about force_dma_unencrypted(), the
dma/direct caller should have all the information to pass the
appropriate flags.

Thanks.
Mostafa

> +               require_decrypted =3D true;
> +
> +       if (require_decrypted !=3D mem->unencrypted)
> +               return (phys_addr_t)DMA_MAPPING_ERROR;
> +

