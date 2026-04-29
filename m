Return-Path: <linuxppc-dev+bounces-20300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB5EFF8873
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 20:53:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5V034kCDz2yZc;
	Thu, 30 Apr 2026 06:53:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777496035;
	cv=none; b=MttcTUB1zG42Q2wQveeT7J9OL1VQzq4BcdUf+WIkPC/7TSOfQhHcnrVevhNbOD57assPFkJp+G1CP5plUS0KB0Cd2be4lcdtusuPn+B1sw7IIFT4jsQlJpRbe7nXgotoq/+KlwHU6R2sBvU+jcccRrT0fpT7qwJQH82YtacYH0Cf3uQALO4F+xRtSwvbYUXKDzzN9pAu3n/DnSU7Dkzp3B9ql2k01LzG0D4NyotPSLlFlabU8399t0KuRRTKDjy8YtBXknrd98jWm54BXbUou639oAZfl0nQK1AF7nPVxNbq9xsU4USJJnOJ+DRTmJ7XMJtCb5xeavpoOMXf0fWE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777496035; c=relaxed/relaxed;
	bh=8mcKw+kLlbwESBI1VJ+v5iDRe8hKc5GtNkrLjTHkwIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iqb6wyJ4GYMkt7NUfBAELJGRkuaa0Qf2pHHdFFd8rdnBDl+X4Nd7Q8cnT73c5vTPAwQmrqILNTC8ECcW1ZSAYWM9hKLS+5CX+R78ZAienrk9eaJvsLmfn/XPreSsbugJhY/Q0DDNGwH/KOBdSOTrbynte7z0j2nHuxbDB9sVqfQr3V3PDklXwZxzHWok4mVBio5CuL2eRbGW+N5jJMmTs/bEpFnVNoOc1GWWGtRlCN7c3DZz6/952iTTIIxue/+2WBf7lmcwgDSiZVgXzCE0mMYf4Vc4gmM/lVkSjtq5U8I0jXQHdIDRA7FwWwkpGCNnYPtnLyPJAI1sceYVZxusWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DkeE2Q5P; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DkeE2Q5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5V024WZWz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 06:53:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5B0896015B;
	Wed, 29 Apr 2026 20:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB2C19425;
	Wed, 29 Apr 2026 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777496031;
	bh=ySSBeMm1fA1RqiRnJDthA9J3oUOKBjzNQoryOMt06sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkeE2Q5PhSo1fLSwyOU6Rr7oJ1LJJ07F7M8zpbaloBd1Fns+uvPnbZqXbnI6B64yd
	 geGahp3c3jNFI7tNH4Y3a+vlogeM02AF1B8DYyp160evSx4JLFlRM9ckCGys/vq8Cb
	 ZQz8ED+SBqW4kMFcwKs29vunitwRU+sP3ZYSDGi2YCokCrjkqDhzgMvIIYZo7pQFju
	 Zs0RMd/siKPi8ncNePAxh4GA2xJqMOeoVBxdw7DegLWJbgf3Iiomi5cVJWv3RmULbv
	 9YmJrAu7h1McIEZlu/kUUCAjF6AnyxZMWfLVXHJG3hhZmOFimv2Lf5s1oacHm84ceC
	 lLMiNDI6Wp6xg==
Date: Thu, 30 Apr 2026 05:53:49 +0900
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
Message-ID: <20260429203625.GA3724801@rocinante>
References: <20260422161407.118748-5-kwilczynski@kernel.org>
 <20260429195055.GA312811@bhelgaas>
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
In-Reply-To: <20260429195055.GA312811@bhelgaas>

Hello,

> > @@ -909,11 +909,21 @@ static const struct attribute_group pci_dev_config_attr_group = {
> >   */
> >  static __maybe_unused loff_t
> >  pci_llseek_resource(struct file *filep,
> > -		    struct kobject *kobj __always_unused,
> > +		    struct kobject *kobj,
> >  		    const struct bin_attribute *attr,
> >  		    loff_t offset, int whence)
> >  {
> > -	return fixed_size_llseek(filep, offset, whence, attr->size);
> > +	struct pci_dev *pdev;
> > +	int bar;
> > +
> > +	if (attr->size)
> > +		return fixed_size_llseek(filep, offset, whence, attr->size);
> > +
> > +	pdev = to_pci_dev(kobj_to_dev(kobj));
> > +	bar = (unsigned long)attr->private;
> > +
> > +	return fixed_size_llseek(filep, offset, whence,
> > +				 pci_resource_len(pdev, bar));
>
> Is there a case where using "attr->size" is better than using
> "pci_resource_len(pdev, bar)"?
>
> In other words, would the following be equivalent?
>
>   pci_llseek_resource(...)
>   {
>     ...
>     pdev = to_pci_dev(kobj_to_dev(kobj));
>     bar = (unsigned long)attr->private;
>
>     return fixed_size_llseek(filep, offset, whence,
>                              pci_resource_len(pdev, bar));
>   }

Sadly, the simplified version would break legacy attributes.

pci_llseek_resource() is shared between device-level resource
attributes and bus-level legacy attributes, both have different
semantics:

  - Resource attributes (resource0, resource0_wc, ...) are per-device,
    carry a BAR index in attr->private, and will have .size == 0 with
    the static conversion.
  
  - Legacy attributes (legacy_io, legacy_mem, ...) are per-bus, have
    no BAR index in attr->private, and carry a fixed .size
    (PCI_LEGACY_IO_SIZE, PCI_LEGACY_MEM_SIZE, etc.).

The if (attr->size) check distinguishes the two cases, where legacy
attributes have size set at compile time (no BAR index), and the
resource attributes derive it from the BAR at runtime.

For legacy attributes, the kobj belongs to a struct pci_bus, not a
struct pci_dev, so to_pci_dev(kobj_to_dev(kobj)) would be a wrong
type for container_of().  Also, the pci_resource_len() helper would
not work there either.

Thus, dropping the attr->size check and always using pci_resource_len()
would break the legacy attributes case.

The alternative would be separate llseek callbacks for both the legacy
and resource attributes, which we can add if this would be the preference
here.

I hope this clears this up a little bit.

Thank you!

	Krzysztof

