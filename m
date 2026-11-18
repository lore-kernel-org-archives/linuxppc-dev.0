Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B99606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=demZj214
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVByb3Z20z2xSl;
	Thu, 19 Nov 2026 06:49:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795031399;
	cv=none; b=L4hV+lK5WMG9pGrRa3KsPYcLEtv82Yxs4V1+NaW2lpkWu2sE9gNC778hWTpoN2uthZ5EbuB/k01FWgnfwPpPF/FBZy7xEERL5zXMiAzmLZT87QlWlUYs/tbPv7ds1jeZ//+T83gL/RsC6oNoobdGT4lF9hDuQ+4GUtnrvQnu3vW4BbIYx/HtS6Vsn8wSk8gdpAJcn0y4OAEm5RtAiMmy49lneRu4GtFBDmHOMYmK4mC/HIhQM9kGY+o+FdLnZOnytnYNMag32x3XELsZ63OX8tUw8JVOUzsurUnFgyC2kCiWAXzatF2y7UNGWqAUswxESV6D57zLMUBUQcyP7LQ51g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795031399; c=relaxed/relaxed;
	bh=XpUTJKSNd3BKZMuNsk4G3FLRtdV7s45kYttRU4gqcas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmOwclD2w7aJAUOocyDclCPOYaWiKH0Cb1pdTQm1YjAW+6++nj7RNwQG/l+FRf7ofOngYBm2zdVipYntTUBrxwOiNBUIIqp3y6nEew4tgcJlNHSYTelkibljJU+YExh2tuGytOel4SibYkf+YjtEBj8wkiHEVNr6qxLxKRH+zVxJjP/O8fyu514oaGZy3JajomiEjFpKXouPjgMfT0u/Ch34eUjvXGHt8RqXtRMXO9NVMLKrnV+NQvxkIO/p8L1GrUs9k/BForinh7uPwSJannS7vY6AsL4AtlB357IND5BxjOpcfIsD9mdRh/Sju/KUxgorkSBAp9k8K0PO+x99pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=demZj214; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=demZj214;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVByZ5zZFz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:49:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 95AE66399A;
	Wed, 18 Nov 2026 19:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D01F000C4;
	Wed, 18 Nov 2026 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031396;
	bh=XpUTJKSNd3BKZMuNsk4G3FLRtdV7s45kYttRU4gqcas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=demZj214Okph6xJpa/01zUcpC44TH2tWspl3ewP38RpUZK/Usoqx9e1ixsVubSSXO
	 JCIiOBOUQb0dwTOGZBIKsU3wri/J8Jqcl//pGCJG0chd0j3HciCxzN158i8tpa1v2E
	 gr1wLsOY7D3E/bGcsfBtKk7iBRZSzmG9+EFVX//i503bzxYB96Q/HD8PnYTdBpp19K
	 F48hTsAvMkiq1LAsN+DsXwYpr8IPXP6ea4uScDktTGCzULUGOHu4kZ4qkHX/VF/pDw
	 KPM2CLvpEMNAC56U+xbRc5sWFNb+YDGckQ1+LcmREDLdtiq5ir9oUxJjCPo1apthpD
	 24lLCWhDkBbVA==
Date: Wed, 18 Nov 2026 19:49:48 +0000
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
 Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik <avadhut.naik@amd.com>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 11/19] RAS: Remove unused ras_userspace_consumers()
Message-ID: <20261118194948.45293a26@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-12-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-12-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:21 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Remove the unused ras_userspace_consumers() and atomic
> trace_count as the previous patch made extlog select
> CPER console output by severity.
wrap longer.

Otherwise, if the rest goes forwards this is obviously fine.
However, more to do.. See below.
Given it's trivial I'll just assume you'll do that.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/ras/debugfs.c | 10 ----------
>  include/linux/ras.h   |  2 --
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
> index 42afd3de68b22..838cc689b9989 100644
> --- a/drivers/ras/debugfs.c
> +++ b/drivers/ras/debugfs.c

>  
>  static int trace_release(struct inode *inode, struct file *file)
>  {
> -	atomic_dec(&trace_count);
>  	return single_release(inode, file);

Use that as the callback. No need for the wrapper.

>  }
>  


