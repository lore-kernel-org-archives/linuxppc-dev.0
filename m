Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD8606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxoeVWsw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVB9V6pGwz2xdX;
	Thu, 19 Nov 2026 06:14:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795029262;
	cv=none; b=lkvq9Qxam2LigR3pOAy1C3We6yrtL2X896kwaQIwmNX4GP2z9oys7quj9r9eUhjYvxkkR4yMqUCuuKhzG7/KPKCqnW9F6aXcWNT+wsuh42wE1XP76HGgZlOIea6G6M8nzyYUlp6YWD5GXUwvOwT8KAHc1UmnIUm7uVfefJZ+zfHqf948ILwOOfXgbNt7hWH0BJ525E3LIjyQfxT8GzYl2EyB7Na0UCXBF+k3Xa81T+Nk7icsSoT1C6obWmbXL6rIsQnXPBfhPZER6fOXw6cfJpidRx+vo+h6w8ZoUMo5PpsN01KcTgXtJFyg6IJD15k9KP8pFldFsXh/dLXbz161mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795029262; c=relaxed/relaxed;
	bh=d9SMOsxwAFQZaUBngPgxh+BWRFva5JtsprMZmImAyMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VF1ycBqzQQ3ZY1RzF7UXjp+o24oLWhSs2X4iieqKDg++ZizaIQfFeJzVy09iaNsU0/pCkulVxl/z+pPbCz+q+nGhYRVX3VVn8+CoXEITfILPLC6FUQgf/iLHfChcjCNu2HGXmDijITAF+Vm7ezRHPgl7B0MbbPdtk5Hzcnuhg5RDAURWM/BX5wtGOYo+/ABsrTJpjJN4J5bRTD38bdM28A7nMimEYXHEuC/i243INd0+jIkp9AiAg+EY1IFpcZII0xEL2aR/wlo4FVW6YXrtTYwnO8X3NPCp4zIdSFuWGZuCttMZISIKZCIVPQRlWbDCxnj9iLX8crd9PWbXDcS3WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxoeVWsw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxoeVWsw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVB9V08mvz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:14:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5121C4634F;
	Wed, 18 Nov 2026 19:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AF51F000C4;
	Wed, 18 Nov 2026 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029259;
	bh=d9SMOsxwAFQZaUBngPgxh+BWRFva5JtsprMZmImAyMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VxoeVWswVKJ9uEK5QYTOLpSc/fG1ejiOdRS9ttIaxvwDjkbx+fjATQoIvZarZK5Cr
	 30BaMKHJoZpLs0TqJQ4KjckA9GnwiI96q2cSEqA85pWEgY/3QBJhLZb0Hn1X1vicLX
	 aDOcOvlF6cn6ceiorWrs31apZUXj7aELEInkTtjYkp3l6ZtIzCZqJJ82TM9yllYjg2
	 KGokbS+cmhTz2BxpxZj5B1KPuHCJi74n908Uz8seXJfpXOOR+67Rtimd+mBJzJZZnv
	 uzXK52FpqEtPGxEmJEKo5kD9xygQ852Tw0g8oaUipdAbx8Y3bJ5AqunBoOvaLt3xe4
	 MkCUysXXoCmAw==
Date: Wed, 18 Nov 2026 19:14:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Radu Rendec <radu@rendec.net>, Avadhut Naik
 <avadhut.naik@amd.com>, Dave Jiang <dave.jiang@intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>,
 Dan Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 06/19] ACPI: APEI: Remove aer allocation in
 ghes_handle_aer()
Message-ID: <20261118191408.2005b091@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-7-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-7-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:10:16 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> aer_recover_queue() now copies the input aer_regs instead of
> storing a pointer to the struct. Use a local variable to pass
> aer_regs in ghes_handle_aer() and remove the memory allocation
> introduced by:
> commit e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error
> status data has multiple sections")
> 
> No functional change intended.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Just one trivial thing.

I didn't bother figuring out impact of the change discussed on previous
patch on this one, so no tags for this version.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 57406494ec1f7..d7ef84e3b988e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -32,7 +32,6 @@
>  #include <linux/slab.h>
>  #include <linux/vmcore_info.h>
>  #include <acpi/apei.h>
> -#include <acpi/ghes.h>
>  #include <ras/ras_event.h>
>  
>  #include "../pci.h"
> @@ -1413,18 +1412,15 @@ static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
>   * @severity: AER_CORRECTABLE, AER_NONFATAL or AER_FATAL
>   * @aer_regs: snapshot of the device's AER Capability registers
>   *
> - * Queue an error record received from firmware through APEI GHES.  The
> - * record is processed later from a workqueue, which logs the error and,
> + * Queue an error record received from firmware. The record is processed
> + * later from a workqueue, which logs the error and,
>   * for uncorrectable errors, attempts recovery of the device.

Whilst noisier, you should probably still rewrap that last line.

>   *


