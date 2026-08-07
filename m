Return-Path: <linuxppc-dev+bounces-25619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501C7C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 18:20:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGsrm5Y34z3c88;
	Sat, 08 Aug 2026 04:20:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786126824;
	cv=none; b=eIjGjxH+3h3uHvw3YJbfS/j+2BpZNw/wZ7doN/Oh768aMDaqxgu/tZcSZItVoU9gGui8qr2QRAPABODDiLbBleqTs61vZk1LdDM97KF78xNCoR2rU+w7ApKeRmwPX1Doo7s2s1KUGjb2nBNlnA9QkkKjTYngMZSRdUagrbSwFA0sBu27SDZWQ1NS06pH+Hp7aeusmuYqmnQhcN+za+R17lw8YVvWjynmdrSXp3xxo6iPiOqWy6QQAo1vYbDzQ6E+Yd7Tet3kN9jR81BSMJ0h9zuBEElGR62TW+RwS9K4ezKRW/MVLwn82/1GbXTUQR9CdtNYcGD9CvNT2dwyy37h0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786126824; c=relaxed/relaxed;
	bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4bybheW6ITx/LfgDn2hWV8YJQMnpz8wx/kE6ShpwBBYYtRwAIzhFsXAtl2Qx2JbTeAt2HYxvTmB5xX/5LYP8ruFbv/v6w9YDHSViNU8G7QKWGUuDOyFkzN3NFB3NOOs6K7HFtFcgOYdgDat5MQNiVEgOJ9aerLEbqOAQEdh61nhwdl7p5o/OyCed3TwIdJX8c3EYmg6lLnQRUE13IvOjHRvyNZuo+0vNRcc4H9t69rH12wwzPefMhwZZ1OCg/XfHuN2V8qvSkSCfTj+lCTUb7UE38Cbtk4cZ5wnZ6wIB5iAPJXc//zvi1D7oJ7ghZPq4vyUUVUVfvLLiSvwOI2WRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RaLkAVlC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RaLkAVlC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGsrk53MZz3c58
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 04:20:21 +1000 (AEST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-92e533aacf2so207604185a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786126819; x=1786731619; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
        b=RaLkAVlC9xDnAzN+aKbz8ZoZiBH57M0SCX7UimRtaL6tCCaCx+gjXKpLMULRm2sM7n
         KTTOSWoFtyLQYDiaCL199/uBYYgkPwAj9mlnizpZ4CuWlHIe2nE3lCLvcqo3sNqaqMCU
         zU59sNkGYYT3RCHGXOu6ex8nGqXNBBplWgJN0Kj4+ALfWCKgS+LvGw2P8sCKMes5Ud4Y
         WtIgaa/kzrcN9iV8U5wtNzTD0ossaz1wrXpy7YIwoWTvrdwb021U9/jOYmOYO523tn3r
         1C4Ap089mU0WGJFs9RwCXxbRpnTVeXrhMSKrIwFgttykCzl1m1p7Lkdw8OwX6m8UQy24
         mbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126819; x=1786731619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
        b=jeyOspcs3ZR1c3w8SynJ3aWZWdHDalWkVkY9+L5RxTWfka5dA+ytkY2Nz0oyW2jclP
         SrwMQ4p5UucZ5XWV131pD900IQ+3R8kFQsrcVwbSLGVgxCDpkYX+vfHr8UwPl0fOl4nv
         GkWc5fbRlQ2dsh7+S9YXoscC30RCb4chYeeQMmQ3iGrcw8QV2CilB90ZXKoqtnd7NUUs
         VL1FsHjuwTbFmQqQeG0bQrqWNeLJMNdmLqA0pHl1Wls7tXkK/kYAQO93l++PE8yTJsjv
         gvlTOY/tQK3boTcDYMU9ASTeMAbCNOtpHN/iNbD0/e8somKTdUM8fSOsO443PHkHplp2
         sxQg==
X-Forwarded-Encrypted: i=1; AHgh+RoKDIPBZH0IYl1ZH0SrEv3gcU+7G+KlRFQpT0lBE6YC5u+5nHRx128cEyIgOjZvGcPEeovwFe+vtQ2HmpM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwopTDpD20zH6/9rgeSr8SzVxOPuUG2LDi6eGwhUJMItQ9+Bya2
	O0YxQ/fnA9b00+cL2fZGmZqJCkplwh/46Q0Fm7PYRjnylKTD3a2Z1Yny55KekeyLKlQ=
X-Gm-Gg: AR+sD11VLiXchHNp9Z9fBNoVDUprml4XT+eQlmJB7o7qdgOiedv9pr/DS7T1f1ajVCm
	UMlROCkKTyp3+9VG6jobWeVwb6uHKLSfOVooyre4gM2N8SJonqOKW7zYpBtd/I/1YopKxJvJbYs
	/0I/Q7FHR+gQd7YjfnagmNYe1c8aHjnJWAJ67v+P0j+ln15csCQtDlChWfCUnQLghRAxdIwJuKG
	ssdnjIyFwsQdvLlwF0DFTLdNeWYc6Kk8F7Zmnrl+GxQF4A9AXWQK4l3rpMDUvi5YwFmibWAhOu7
	WQA9dFmQWoAMglXIT0NfXvgKCTZ2nH6fv1ynVmnx24sZ0fbp4ays4HbckE7mJ8mAn/fbAnSwqXK
	j+f34oO3EVBQhY0AzoqMPd5irpe2iuwDOp6PYkXIwqSPn9sX6C4e5neA0z+P71BN6L7H2pUVBOP
	nF9G1KQrYqloHUvBoQTo5yh8ZsxB565afcBeJ5kJjsBAIZ3La+45cxhkwywufQ
X-Received: by 2002:a05:620a:628e:b0:930:a38d:4030 with SMTP id af79cd13be357-93671eae149mr628522585a.29.1786126818655;
        Fri, 07 Aug 2026 11:20:18 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e02d54esm204051085a.6.2026.08.07.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:20:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsPB3-00000001Bmx-1xNi;
	Fri, 07 Aug 2026 15:20:17 -0300
Date: Fri, 7 Aug 2026 15:20:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <20260807182017.GH200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
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
In-Reply-To: <anYgXSR4VAi3TpOj@google.com>

On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:

> But the whole thing is best effort anyway, the kernel picks
> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> how many devices or how much DMA they do.
> SWIOTLB memory is wasted if unused so we should be careful around
> that as it would be the other way around and users would have to
> decrease it manually.

Yeah, it is why the arch code shouldn't really be sizing it directly,
it should be done in common code and, yes, we are probably going to
have to do something alot smarter to have the common code better
auto-tune this for the CC case..

Jason

