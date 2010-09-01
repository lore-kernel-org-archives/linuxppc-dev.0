Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by ozlabs.org (Postfix) with ESMTP id 66D53B7145
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 23:06:10 +1000 (EST)
Received: from mail156-tx2 (localhost.localdomain [127.0.0.1])	by
	mail156-tx2-R.bigfish.com (Postfix) with ESMTP id 4F4833306ED	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Sep 2010 13:05:58 +0000 (UTC)
Received: from TX2EHSMHS013.bigfish.com (unknown [10.9.14.238])	by
	mail156-tx2.bigfish.com (Postfix) with ESMTP id C62936A805D	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Sep 2010 13:05:56 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o81D5foG020544	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 1 Sep 2010 06:05:51 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o81DJPeu019485	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 1 Sep 2010 08:19:25 -0500 (CDT)
Message-ID: <4C7E4FA4.60909@freescale.com>
Date: Wed, 1 Sep 2010 08:05:40 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 1/2] powerpc/mm: Assume first cpu is
	boot_cpuid not 0
References: <1283297085-3455-1-git-send-email-msm@freescale.com>
In-Reply-To: <1283297085-3455-1-git-send-email-msm@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matthew McClintock wrote:
> +#ifndef CONFIG_SMP
>  	stale_map[0] = alloc_bootmem(CTX_MAP_SIZE);
> +#else
> +	stale_map[boot_cpuid] = alloc_bootmem(CTX_MAP_SIZE);

So you're saying that even on a non-SMP kernel, boot_cpuid might not be zero?
