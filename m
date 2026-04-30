Return-Path: <linuxppc-dev+bounces-20349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DB9FF886F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 23:32:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g69Sl0vxqz2xwH;
	Fri, 01 May 2026 09:32:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777591958;
	cv=none; b=izyHLwrHyzS2WXHDoNuyQ3068fN3LX3SUoEADKZ63y7yExlqYXkU3D76gLyRjuk3eacwWJAFQUDesGkHASYWVzSa09rwFBVlkkMx/iZyb12+3ytOHDr3IeygORZXyB8G+hZcYkTe3a9vrbDskId2UBGUTbG2Mw3vomfHZGBqH4IvXNgK7/DtRUweuoahTDmvS7JVEb9FzPOpCJVecikrLSxFZwKas8SLKi6hFcQ8I+5A1DYJsSuazobGamj3MOgFvdaxxPKZ+0ZRsb2WA9qBZtI1W78+hwm/XA9kpSeROIIXFjYkvqe+opWaXE7az6P9mVhGgMpq127s2PDtAvFvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777591958; c=relaxed/relaxed;
	bh=ZU87gMhr3nFkuGkZK1XRL4Y04R3GqmvDpjoP/EfyajY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyQptO6akupuCdKDBlo+J3ldHMuHHCXCnYKiMxXSsKapy0h/3LI+zPWsAdMlcsbTm2wBvocVAeJY3AJb9dL98nbImhVKh8EHyNZ+vCWqWjdXN5U5wxCs8TEMcuEdRMr+xUvuP54OzLq97niZXsKz6Ide8+M1oeBIwNoft6ZyUY01f743aBfSA6A8xHpqb4bD9pQOrcC7HACh7fs5jbkR0hqyA/iFGGmzy1uhBOXJufLHEFZbcYzLMa2FqrFgcLeYSpurrDMBYSMgMyX9Ix4jcQ1xtLB+GdIWtTmcznA6ZUdbUdHIl5dcmiaC68nZULn6CnYRVRFF1AM4m/myCIsBbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j41sztTr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j41sztTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g69Sh2xk0z2xvH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 09:32:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D539940327;
	Thu, 30 Apr 2026 23:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6B5C2BCB3;
	Thu, 30 Apr 2026 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777591953;
	bh=vnBYxUC+9YLt4GbugUxdFgg5DUIjNo5beM9TG7+8oZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j41sztTrnonOcGk4i7hFsn1OZj3ZVxBy22IOCYM1FPKjwTEchsNZvGR98gfhppo7Z
	 bhMXUaF1QclCYPFnZLBEwnmgWNs9TNJKsNh62PUD+1RlrE+aVZtcf1tAnhKN0pHP0O
	 yAe89bCvd/XV8/o1niZkrvGAznRCvRcDTVwe9cRO5lqAcR0ymTWO5snVbBDEV6j9RQ
	 buECZri1HuzCD2UhkhlPV7LZ9sIYFvScZrLTA8roeUusZ/5dftl1JFhLO1UQIUVtyQ
	 CkNJcOdJYDcuiZpOOCg3OdUweENzWAF3hk1OP9FMM9xgnyLYbjwTBh0HUfjqVpvKvX
	 icZ1gke5AIg8w==
Date: Fri, 1 May 2026 08:32:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 04/24] PCI/sysfs: Use BAR length in
 pci_llseek_resource() when attr->size is zero
Message-ID: <20260430232202.GA3577346@rocinante>
References: <20260422161407.118748-5-kwilczynski@kernel.org>
 <20260429195055.GA312811@bhelgaas>
 <20260429203625.GA3724801@rocinante>
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
In-Reply-To: <20260429203625.GA3724801@rocinante>

Hello,

> The alternative would be separate llseek callbacks for both the legacy
> and resource attributes, which we can add if this would be the preference
> here.

If we were to do this, then it would be as follows:

  static loff_t pci_llseek_resource(struct file *filep,
                                    struct kobject *kobj,
                                    const struct bin_attribute *attr,
                                    loff_t offset, int whence)
  {
        struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
        int bar = (unsigned long)attr->private;

        return fixed_size_llseek(filep, offset, whence,
                                 pci_resource_len(pdev, bar));
  }

  static loff_t pci_llseek_resource_legacy(struct file *filep,
					   struct kobject *kobj __always_unused,
                                           const struct bin_attribute *attr,
                                           loff_t offset, int whence)
  {
        return fixed_size_llseek(filep, offset, whence, attr->size);
  }

Each callback would be placed within the corresponding #ifdef block, so one
for HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE, and the other for the
legacy attributes, so behind the HAVE_PCI_LEGACY guard.

Note, the names need to be different, as some architectures offer both
type of resource files, like PowerPC, which defines both the HAVE_PCI_LEGACY
and HAVE_PCI_MMAP.

With this split, we can also drop the __maybe_unused annotation.

While I wanted to keep the changes to only what was needed for the
pci_llseek_resource() to cover both type of resources, it would be
also fine to have two distinct callbacks, too.

Thank you!

	Krzysztof

