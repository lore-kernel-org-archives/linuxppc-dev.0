Return-Path: <linuxppc-dev+bounces-18868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC9D10BA421
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:56:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhldl1HBVz2xmX;
	Fri, 27 Mar 2026 13:56:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774580171;
	cv=none; b=eoyZPAzY08nzJ8/XWFDFHPpAi+fIRd9VM4L2aifiyLvatDuxmUWZtrWIVKuVFKIouESyz3EmLxKk0FYiO0sKHWoEffrJA/MAZsFUccVBSomW6qah8fU5pICQilzFQgSfy0v6lCKSpXlYA/yb/XfNWxOGgVEXI4gnT8fGLrCO88hAlzfMqhnGQIaZdk/36L2JfMGzD55T9Q2fnPy2S91UAmJ/cwCDoPUe/dfawER0SlB0/2A3OwWdBSQAnKBGPgG94onBlIqdEYEdItmOfH5+51q682uTJCEC9nCY/XgEzWLf3kP6IsboUPO9iBWoxOUZQBLuDPQZ0zHOemNaS9KOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774580171; c=relaxed/relaxed;
	bh=/x34Ij2kuXzsnJRKdh7n98HuULH2/zRsLD1v43nFDFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hP7gJbf0zUG1n9j2YUzmRJAU5E2fAf1h+WKPJH15kOxfyII6D2FG5uLbTVaNVk+3KPBaaFj30/XnPNH1PsSW71B2Y2+uv8AnSDKI6uOMSgGtuHYlgYxJ9vvcgDDABTsY20mM+/+7XQ7Tg/rcQkvo/NIWcA7hOyTv9Z9gq5wncHmeSZbE//IXv8pyIk6/+bXbasQ95bhl34/Q1N/B8Dgcn6ilL71DePU8rSwu7LAvqFhp8ZoO+WpXQZ/04QMjQstyOg3LWOCBOywCal+pYNZ0nnzkubZ2RX9L0+1FoctDGYoXkKq2Ue95UvHR7afdcLcxr9h93SG18lpJ+g/3hVBXlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=nmqu=b3=linux-m68k.org=gerg@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=nmqu=b3=linux-m68k.org=gerg@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhldj5xcqz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:56:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3B0DC60054;
	Fri, 27 Mar 2026 02:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62989C116C6;
	Fri, 27 Mar 2026 02:55:59 +0000 (UTC)
Message-ID: <b89ac970-7990-4a12-9769-82efc945c950@linux-m68k.org>
Date: Fri, 27 Mar 2026 12:55:55 +1000
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application of
 align
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
 <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/3/26 02:56, Ilpo Järvinen wrote:
> Aligning res->start by align inside pcibios_align_resource() is
> unnecessary because caller of pcibios_align_resource() is
> __find_resource_space() that aligns res->start with align before
> calling pcibios_align_resource().
> 
> Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> result in changing start either because 0x300 bits would have not
> survived the earlier alignment if align was large enough to have an
> impact.
> 
> Thus, remove the duplicated aligning from pcibios_align_resource().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

LGTM.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>


> ---
>   arch/m68k/kernel/pcibios.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 1415f6e4e5ce..7e286ee1976b 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>   	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>   		start = (start + 0x3ff) & ~0x3ff;
>   
> -	start = (start + align - 1) & ~(align - 1);
> -
>   	return start;
>   }
>   


