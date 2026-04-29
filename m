Return-Path: <linuxppc-dev+bounces-20297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F0FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 19:51:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5SbS6FRsz2yjp;
	Thu, 30 Apr 2026 05:51:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777492260;
	cv=none; b=TIwRtBkF9xApSU32pJj2PNgmJ7OQkQovAk1p8h9OAkuX4+0p1E60XMipWWkDZweZ+zHBt4EelKRnAiZhw2fqGItS6WAgEjyYQoVRXrZgm+5InaVWMR/gnJAIcfvWHRHXlYKFSZY+BeJLNjTjChtizRzRQ/ExgTXXdgmHCt95qqBu4WhDmYy6E0bPwBtVE2KiZ0wX9G5J6aYgh25Dz5ePvX6KUdwxq0GwLKU3F0WVnTirVQY6jprOkzsbhO4h8NxCaDdPDNCQA2QW3cAxYy1EaUd9WMrq4lUbAzg0TVGUz5OUM67YSLfi8YjdJQYBtvvwqhQfettRG0JU/1snDLvJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777492260; c=relaxed/relaxed;
	bh=gVV+9mFFowQNz8CKA6uyUrx6Sw5oyJ0Eq+FIZeCNlSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lf+YnczF6dEmChVH+bujZ7TLEUz4+BGr9kKUM3IOpI7OTDxf7nFwCd15etzWm9x2v3KWqEF3XKwVrwb45HFrrzs8g0yy/7D2ooJCLsFWPHUo8usI4yz8mQiESg063riyC1E95bQMXP/HuVp16rbZNVqzFAlftQCd2ThkWtRpMg0uI4HDIqrj2p/RjPDQ72TP6fzHVFX2rRnvWvIV1nkmCcqWKL7GH6CVpyuTsuzyFHshI07b3MFC9LDHFr0rwFGFUf210XfP+JyygwvokIwRqprH2Ii1qNhwqrA+vMMxGvEZC6viAk2uCM/4a9SqOVsfhkIUA1WZnXJ1O66c35bhSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NEwvBJq7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NEwvBJq7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5SbR4Dl4z2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 05:50:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA8DB43785;
	Wed, 29 Apr 2026 19:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F602C19425;
	Wed, 29 Apr 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777492256;
	bh=KV0jOqo91Nc5X7Pf3+Y8ZL1SPzxDfjq7fwMURhV0piM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NEwvBJq7WK44M3W5Zehz9jff7Syq93gIaLa34rIEJ7kqJgreQpIc/bigVkpENOlov
	 f9U7oGNP9EVqK5hok1xeIwscY0arcT+jqEPyVKDDdbfoAKEdUlunICYRCNFxhtJRvq
	 HAaSrXYtgB11Hhix5he+GW0cB3lS7oMpNJdcm/t2LTGeL4t7+otLTbxUpGr7FJCAt7
	 Iz2bhvjeKsj6Tx0fPPh2grltl4vPcYLHHm+hecuJ84O2oDI30VaXgfdVM/OnhcJQt+
	 /3Z7K8IBXmGIHP3Wlr0Cuw0gLXdJdihkesJx3urvU8wKPCLiIT0+tlfmqfn3uyO9Gf
	 4jQDfKAfRS8gw==
Date: Wed, 29 Apr 2026 14:50:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 04/24] PCI/sysfs: Use BAR length in
 pci_llseek_resource() when attr->size is zero
Message-ID: <20260429195055.GA312811@bhelgaas>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422161407.118748-5-kwilczynski@kernel.org>

On Wed, Apr 22, 2026 at 04:13:47PM +0000, Krzysztof Wilczyński wrote:
> Both legacy and resource attributes set .f_mapping = iomem_get_mapping,
> so the default generic_file_llseek() would consult iomem_inode for the
> file size, which knows nothing about the attribute.  That is why this
> custom llseek callback exists.
> 
> Currently, the legacy and resource attributes have .size set at creation
> time, as such, using the attr->size is sufficient.  However, the upcoming
> static resource attributes will have .size == 0 set, since they are const,
> and the .bin_size callback will be used to provide the real size to kernfs
> instead.
> 
> Thus, update pci_llseek_resource() to derive the file size from the
> BAR using pci_resource_len() instead of reading the attr->size directly.
> 
> The custom pci_llseek_resource() helper has been added in commit
> 24de09c16f97 ("PCI: Implement custom llseek for sysfs resource
> entries").
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6783c6168445..73a9ae9d289b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -909,11 +909,21 @@ static const struct attribute_group pci_dev_config_attr_group = {
>   */
>  static __maybe_unused loff_t
>  pci_llseek_resource(struct file *filep,
> -		    struct kobject *kobj __always_unused,
> +		    struct kobject *kobj,
>  		    const struct bin_attribute *attr,
>  		    loff_t offset, int whence)
>  {
> -	return fixed_size_llseek(filep, offset, whence, attr->size);
> +	struct pci_dev *pdev;
> +	int bar;
> +
> +	if (attr->size)
> +		return fixed_size_llseek(filep, offset, whence, attr->size);
> +
> +	pdev = to_pci_dev(kobj_to_dev(kobj));
> +	bar = (unsigned long)attr->private;
> +
> +	return fixed_size_llseek(filep, offset, whence,
> +				 pci_resource_len(pdev, bar));

Is there a case where using "attr->size" is better than using
"pci_resource_len(pdev, bar)"?

In other words, would the following be equivalent?

  pci_llseek_resource(...)
  {
    ...
    pdev = to_pci_dev(kobj_to_dev(kobj));
    bar = (unsigned long)attr->private;

    return fixed_size_llseek(filep, offset, whence,
                             pci_resource_len(pdev, bar));
  }

