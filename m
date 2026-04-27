Return-Path: <linuxppc-dev+bounces-20200-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1512FFF8864
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 23:34:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4Kds5R3Xz2xYw;
	Tue, 28 Apr 2026 09:34:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777332849;
	cv=none; b=jj1dc4f7wXqbFdkLyIE9GQ+RNMfMlK+KT/yyDOnKNRY7xY5gNVYaGGEXRQzLc2otvL/QlgS6PkrqALCimDIo8L2hARKkGsow+lm98PJNesn8nyd22R7z+p/hHZROv0mD7QEzXcD8DEN+zm8/ocvj7ofZZYGrcRP/1tp6bwpEYXX7hCypxm48RySVHAewFTQOwvBjR/9tOHqwWw61CgnkTO4dBXgiLSKYyHO7yptCCJh1T8ug1Nsupts75lixXGs7oPFpSoHm217/nPvsIWHWPpuBdLtUJ9Ua0tISa0LpvVBgerp5zwNqkmr7TtvBYAOrWWe+dBuDId8Vzc002UZ3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777332849; c=relaxed/relaxed;
	bh=Qc21ffeD0b/b0ueR4bBCJ3K7ckNgRBBbvBSrQ7TNgWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqxE+wX1FBDBzpKqJOdF85wrm4J9sptbITMd7KdSutPldH2HiRLhti06yUypn95l5949tBWSlR2f8V20+ZHaos1QYEXhjMkluiFHUSZVNCQprAqKypVXeCQ5muaEyUrmE4URva4jI0N/Mep5eHbGCYM05NomZL1tdJ4hXvrJbhOHSjyFG2U2MLsob367c0wMcQl1KrRcMhHa807YVypqn8Tb1huCSgygh2nkjtL5cHu0OlyeTciJHaYRVTMbIkYJRJsZJOZNZBYRtip/5h77LjIPHtDWcq6TOAp9wyWMQjtiYB1jb8Ro5Z2wVPcdWviXeH6Nl1TQonTrMe/oiSjalQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K+mRV2AS; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K+mRV2AS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4Kdr6d31z2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 09:34:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2262860052;
	Mon, 27 Apr 2026 23:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7C5C19425;
	Mon, 27 Apr 2026 23:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332843;
	bh=+Mz+K9V9xVnzkN7jC1vFBVIkFBsNppLIc/gwkfZtBgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+mRV2ASzEe1cwMUzJcq40wHQOH8FRWxflpZrmvVnBTQ1fOl8fCWS6FHJqKhQO5Pg
	 UYYsiK58BIxOWwjZLHEjS7P0xRfZKXtMg7FfR7yMSLIEWGkd46SMd8IGxx58zp3cPB
	 OKvnPDfWDpkdFMQ/z40YvvQRhhV2LzOM1KgWYeWYfK280OO7pML+nPcHQ2ovjtElkY
	 IF12LfpwalDJkDrtZPhkdW+jy7RBVGjuIgQqtlUasppV9J2EFUUokyspv4WhKFYM9d
	 iqJjIvqMHQ8tv+vynUPHqhBSHs4iIG/KUffr+xlzxliv9VshLYpjaEI9dmBtZcOrMt
	 YdPINto2m8qfw==
Date: Tue, 28 Apr 2026 08:34:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Christophe Leroy <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Dexuan Cui <decui@microsoft.com>, Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, 
	Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, Shuan He <heshuan@bytedance.com>, 
	Srivatsa Bhat <srivatsabhat@microsoft.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260427232320.GA865293@rocinante>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
 <20260423172200.GA2271460@rocinante>
 <56ce57ca-b5ce-415c-b17e-bdcddf93770e@linux.ibm.com>
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
In-Reply-To: <56ce57ca-b5ce-415c-b17e-bdcddf93770e@linux.ibm.com>

Hello,

> > I sadly do not own any Alpha or PowerPC hardware, so when I was testing
> > these architectures while working on the series, it would be only under
> > QEMU.
> 
> I tested the patches on PPC64 machines running as pSeries(on PowerVM and
> KVM) also PowerNV.
> 
> The sysfs attributes looks normal on boot, and on hotplug/unplug of devices
> and SRIOV use cases.
> 
> I see no warnings/errors in dmesg during PCI scans, initialization.

I appreciate that you took the time to test this on a real hardware.
 
> Tested-By: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Thank you!

	Krzysztof

