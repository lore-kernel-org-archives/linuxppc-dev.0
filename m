Return-Path: <linuxppc-dev+bounces-22039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD1ACD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:57:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWR2k626Qz2y1Y;
	Thu, 04 Jun 2026 23:57:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780581438;
	cv=none; b=RfTAVaO1EzqF+51V2c+EIvjDeQrhvdEwrHPzHVKZvYfKcbwxFV+odiavmerysJX2BQTbOg9PjC6JZzRhVhRrMlONygfyntjAIyF2XMPz0v9HXIXx5tVbTX0VOP0vm2kQ69WKoE7ghNo8JOG7qz1nNfh6fbcSDp3NPQuVROWMlnOBgLNJaBVQEa9bPhrng33GYrikH/rwWXUx5fCDgb9V8GxXtcqRbzkH327lH7LxsSDg3j2hoLnGReB5tn2NDY2VbdtFKWdBcx9B7ogibZrlueXPCaBOkHpBPiG+coiU6f8SYXS2NNxrwlxyf+vIOiwa5mjwNcssgJohO+EHKs0ntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780581438; c=relaxed/relaxed;
	bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGiGVdriV2AukrQgBGnO6tgfmdH4pya1C75UsUZ/mOZyl2LxmNLdQooAnl3zO+txYlh5tSlLawlRcTvlQAM9tCYfhMlKjfT28m1oQATj5sCHapHybUmbSI6Ld7yVTGSQMsu4KumRktD1tGrIFGh5eqYmfj0zSv/iem41v61D4Te6H03HOVRP4my4YsRnGOkRiat2lbNNcRfqxNiVvhUIVc0W9TCxeYyRqOT0OB8DFuesJrdJfpfNHx6yGgwQKEl1C2R8X8HFPAsXQ8ZLFLdeSzIXDM78/MeVEOzLC9EsoLiIHJdGQUxppU11er6snL3+k9G6t+uCPY0k9FiEMjPP3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aMLQs2sN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aMLQs2sN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWR2j2fDcz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:57:16 +1000 (AEST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-8ccea53f35cso8256156d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780581434; x=1781186234; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=aMLQs2sNHy7NRbJmqxXkr5zEJ97NSCYnwX69mfbaRynd0j9lFDt1tM7byuf2rrpmuO
         nESzfE3cS8Dnh7xigO2Hs056GP4wh9LXBCTed7tP1s8AxrUUo49OJbymmBX4hEriIIBx
         ar/v46U+BuVtp1J4aPWhoD638zljtspM7X4rIFZtyV5yERPXZhQRyqOrmdYNK8bOzT5R
         pMhwKEY/82q0VXiNV9+g1MoaFN9aCVYReUndUN5HScMz1kcWEWLvbdci+g92X87/WMeo
         gKZ70HIEurcKEwmsQQc8wJBm/QYb2Z9OODKLAefCXoQILdYZC7krtfc5OfDRiQuQvlwu
         DAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581434; x=1781186234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=BYF8L1WOwBaUTX2QahXmcqWnSgpPOVHsEw30eMQaM8dOn3WSK6E91Q+6p8h2hcyb1+
         oYt/3b5ext3he2UE5y6HSXPcr2pplyoPHYpAvxF2pBxh1UZKMcD0dNPXEmcQTNRQhadT
         smswCp4+sNw4oCUVfnmVpNTx57oBsfIJH7vWDhWOmUUWLJ3lDXEqsgnK4BocEPWLevYH
         /ap4xwVuzoAWH8239hjB6kHwX1rq3fOrJfgbQZRSJsC845WqrPyj1XbMi7VXDvz9UZZA
         wnlkkUehMFCRiWkR2zzjdpzD53d8oSwq7BflSvaNgEFF5+vVcwQqg/em70aN+pbu4iBs
         xzcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vb4jeQeAzWZsBNnYVc6hBnQ+awBgobydDGeyX0k2n6vKExfeg/GWbsqi8Fi4lWZl0ukz7o+q5f7Z7urk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylHbbheBqcRKpvi4C4lI6RgDgQ8H5Z0Q1LvwRSU6E4m2Bo0gJS
	Tphq1x4tfc0d6NZwbpDu9MLridzVkweDxmOjW7coBbQMOvUz12xGywaFsFy0UdELqdU=
X-Gm-Gg: Acq92OHs8Twmz4xnATAR2nU+bHsyw7wc4Wal7jU1Ieyz+iaQVoBldXkYy4w4+L6AIVv
	1OZrUgelr4PMt3xYsgffnYZB+021ouQwYzy4US/2fVeGcO9KbxOZ8+3V0ZddqM2gKXjuC07KniF
	kYL3oQN6EIyAOBC5IcbFviD7j6Hu4uuQKdndQl9Ek7u3geRvDsh1lrHy90+nzCMxIlK1lzuGp5g
	MXI1yJXpOvE7MekGbPOXZ56G2tYCxy7v5SkukdX5nScfsg7jxCjUTE9Ifsv/LtSpVs0S965fEy0
	nSF4uHhc/jnFlCLcVqK58Zc6VScW01yUQamGt70iTELafO2B27IKvKrkoWVRCPBMH4Khg6Lf84C
	Q+eLjktKdF0X5VSu0lTnM+yOlEgQMxSn/VcFbRh+l2OhorTK57GUFV2OH2ulfic6P9GQfAXbZ9W
	srHXM4U4lWYOOKdhZoJhkDiMFTLDuCMmrFYRQY0Fn1cg7hLJeE+BdU/UCPxRD0w0mqzE1w4bbmg
	ktUVlxeRpFw2dBJlo88h1vCD5U=
X-Received: by 2002:a05:6214:800c:b0:8ce:e098:d974 with SMTP id 6a1803df08f44-8cee098dc5emr22722786d6.6.1780581433691;
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd07629dsm53598296d6.39.2026.06.04.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8ZM-00000008FiY-2nrt;
	Thu, 04 Jun 2026 10:57:12 -0300
Date: Thu, 4 Jun 2026 10:57:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260604135712.GV2487554@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
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
In-Reply-To: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>

On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:

> Given that Christoph's objection is not really about the modules part,
> but that the set_memory_{encrypted,decrypted} should not be used here,
> one option is to revert 78b30c50a7ac until that issue is sorted out?

Please no, we have stuff already using this so it would be a
functional regression. Revert making heaps into a module since that
doesn't have a functional regression.

Jason

