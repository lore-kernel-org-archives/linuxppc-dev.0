Return-Path: <linuxppc-dev+bounces-21522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D7CCD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 15:39:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPxlJ47W1z2xtC;
	Wed, 27 May 2026 01:39:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779809996;
	cv=none; b=h6fZZD5WShV/QN7rZ9VUPQMbcJaHPQacHocbjL4/qDaa2D/0D7DszfJoryUrBYm/u+zHV5YXerefziwxkwN0hNAJEqA3giLk1S664p1Z3Xzb1Mg47zlIq0CJ9OWHBprCsMKDygyG2vLrjo7r6bGx6KQKDU0Rr7k7bcGKTxgL+jTgFJOwyiS5cYb7JmFOc9IfanZQ1gu04swLYSFrjXnU6685EwElfa8cCR77bgrHyZoRxBDCcZzIMP2jRP1ClGNM+gfc0JlZCJBKB6UoIj+Kl+upvMZr+o+x4fr6XLDZdq3a0xtDgb82nirW5Ar6eX79Rm95mCXzlKQa72AH4jFLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779809996; c=relaxed/relaxed;
	bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7k4aCGzQWwPQGCRL7zadk5oR6qYJT+w0ahdXV1CWZmy5eOOX6MyhZ8JBoImQwzx/lhh1OVexBeIBHBDkNzeTFLcaItDKOEAnqNZ8r8czkv8ew0K3ZrifPP0hD4m03MXm59jlfY0WwNMdS6Eb/f0H7Q3qMRB75eukz3Lu7edQvabuqeUQKwYDu6373Hc3uNZ8ivD5515TFfhHkIx2thwGrJpMxvzMNg8bNMIUMuzTFe5Ia9/R7diBvVvZCh1CqyUPIIxBatZWraYxC31MBDX8DWVketsqfVgsNKDyZUi1NMg+YoExfG8Ux3448No5cxTlAwvvaycDT7cfcg6YbNapw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=k/mjpMun; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=k/mjpMun;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPxlG2bxTz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 01:39:53 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-516d0db9372so41984941cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779809990; x=1780414790; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
        b=k/mjpMun7g2xiUXSzx8xG5hC39YSMODL1ctQhXZ0M+kX6T28ykAQqQ0/RKxpcsAFgv
         lKN2nYqnIwL5g5H+77707kc2s5/t53xbwy882t1UWQlR1fw32pxdPyWWAhmndhtZPl9K
         5f/WUY/tv1pSDM3rmAorIixOwhTQ9LKFGRyL/XI5CVpD2U8JH3koO0nolyEYho6Gy5IZ
         h2tcI7tl5LYcHRX3wnDvmgoNZuhYxkX0XpdRNEwqActWxRZsoA84o/dJ+A8aYuimgSjG
         oSeB1/hQnmDRXGpuYBl8fwTMMWlSvV3/rH/PiZkveOhxjUeBDd/6Pp6VlhqMVx7PQRJ+
         nS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809990; x=1780414790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItPd3iMhIb7X3YkSIy7+Cw4n/7vOFcAzSgB6r5JqsAg=;
        b=IpfMD2lpu889SiLVE3oXKC1TWAeGhTTp9RYRRlc4WWgxgWpRQe+U9vaFvYb+8zmqqL
         L6H6f4S4cGzSI0SogSIVb2B+7hdQYx3/vclLsnmcrttLc3vYHDmu9oLCgLqW45lxHPoP
         o2WJJHXPgHgWu4yNkxTdS0vf2eNzCrOxKLU7JQ3ODqsu/cmWQ1HlnV1k/wEj0ZihqcWx
         Kf6F4UX37mArWLPV9XVoR9lSgQCHYgLReWkzZKj0EimRy7ldAs0sDywxKjOFOd2V++Nh
         iFwpt6K4YQptNXXFPYoiJo7Pqjpb71whRILuK2ec7pe1J/Ie/eD7Thfcm3qrtolOxheH
         QbVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uT7VGJqa/udqKIOBaa5HEnL3dRi2MTZuK6KrZBz94ftTDycHw6MG/c055zZFUyTiH7ezSZM7C2vj0isI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLSBMpgPF30/R3IhCRBn4HM180ceEd5a6aVDiKPbGZoWlwnFrY
	rh5oShiv3d9RyglgQJ2AJ3hqM52gpq6hQp1Ny93W9jvwndOTvRno/r939sMOZsEUxuM=
X-Gm-Gg: Acq92OEEddBbYFw0Vi70b/I7csJGGNYlzZIOluTx3iX24E/VMzVgvuTJ7a23+wXgcqR
	UFj0Uy3AYOW9ZA5M4dPC9hD9sqcUuJpJgd79WalcWFByy3Q+0UHoPVEJabHf+BkhEaG8CG3Z5jy
	t3WTJexAiCgJ9dwjUd+652/ZHzFDkm/VxQ42UfcwfIj6BbGLD6n9QkM65NDR7OBGNoZB/1ZTGK4
	hQartxAWTviKHalPTCUPrlxCN3IyyfnwQeS6jdbgp45Bog+3Vn9aRfNb51jaE9Ym8AeFYJYxjEd
	paE16MkyhH4WHlzA4+Mj8UHGcjBBTsnwMpmawN6nXS2/3OG2VABvKZ0rTsljc74k6YxcdBOf9Y6
	4+381uf3z/WFTfA9+pEk71+7lLW5fyFJ1j59xVf1DtfBAuNqIj2+a6MnnLvVfB84D2bgVKY9OP8
	+ukB5BneA88iQstClfR/TB5VYlwpE08pUK0dp5gopW1oQUdIfwDUw+fXXu49wsdTE2n5cgsXTFj
	vasVg==
X-Received: by 2002:a05:622a:1452:b0:50e:5cc3:6f3a with SMTP id d75a77b69052e-516d45eaf62mr265877421cf.26.1779809990039;
        Tue, 26 May 2026 08:39:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5170c403529sm7414661cf.10.2026.05.26.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:39:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRtsi-0000000DiUf-2t1G;
	Tue, 26 May 2026 12:39:48 -0300
Date: Tue, 26 May 2026 12:39:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260526153948.GH2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-11-aneesh.kumar@kernel.org>
 <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
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
In-Reply-To: <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, May 26, 2026 at 02:56:57AM +0000, Michael Kelley wrote:

> With this patch removing SWIOTLB_FORCE from four places in
> kernel code, there are no remaining places where it is set.
> The test of SWIOTLB_FORCE could be removed from
> swiotlb_init_remap(), and its definition could be deleted
> from include/linux/swiotlb.h.

That's great! I think it shows this is the right approach!

Jason

