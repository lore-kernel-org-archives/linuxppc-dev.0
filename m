Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47A606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T4ljeoz/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKXnL15fhz2xfX;
	Thu, 05 Nov 2026 04:41:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793814118;
	cv=none; b=dG66nX5s7kJoypOoL+aZmeKqZ7ovNInf+2rGx6bughv0py73q+XHzD2W06Ul5QDDglx0p37ILqadpfCA5XI8EcgFwcbAuQAZFAFuydFYdkOGQB5dOjthX/yeNEGvKliVNh85100kw3Zu1PsK91BHE/Qe/OkdsfYP7GghZkRUWgNeE230gcIObuit81BI1ZMoJRp8kIYwUG4qbOJBbSOJrUIJqefVLkO+YKlmCUvFu2jpZwWYI9TwYOuLQlorBFMhyu1yKEgj+JIEavcN66fnoA5+WNRiJsbzztaAVP9/1HLbGRnQkkg2az/1qSUQVcIln2vy1bA32KQL3EvBis3UoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793814118; c=relaxed/relaxed;
	bh=xOu/sgCdG8GJBVBdqmibrQhOxMTtv5+ZKSbTCSJow3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzvtUficmMP/9a0dUN4tnHnAZ2j1GsVlsxn4wDAf9z5CvK0hX03YEKpJtO9tddilzYyt5Cm18gcClbkWxHLh3G+ZEW37lInddee2VMrBLBOBemCAmGXIywfA8H6erenInn43QwmReJ2gvHt5ATnjhLtLkK7CImu0TN63xxGiwwGxISwvMTDwffRynYaP4EI3+S+Tzqg2SWNk14ZHpXI7wNWAu/C0j4PGjIfsyMmP/l4jgapEFlmkZdNg/uDDpUD3bo/8aoPQRL7lj2+y05ReMLHXHnEQErfy3ZvaSg12Btdz7iBSceF7XyOBBvHC13Z4YCIinjumW8nKj+Wu4qFMhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T4ljeoz/; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T4ljeoz/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKXnJ3CLcz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 04:41:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xOu/sgCdG8GJBVBdqmibrQhOxMTtv5+ZKSbTCSJow3s=; b=T4ljeoz/vbynY1KNTJMhGtVIZ5
	gVX22skzq0HsqK1L8qH47K1ch1kCXb9n1REqGhGypW4ndngkMYobFUOrMiWzK8bTQ0UdEbaTDYgvl
	r3BumxWs8aKmz1IXTHzJUsuD2hCz22HIX+pgvDMMKlkGksS1dME4OvqhYNgKMwdmQDP48H9tmN0qk
	liUP2cUcm9NJPCg+P+KS11FKnkiMAfM7iAUPqg5A/QNf4Ucst2S8tdowoMEPysKmNybi58bqUWasw
	v/dX4Ru5g8mrr1k1JrlJ7xv8j/FY1Nv6zHR4KiwFGcxGU+nARPZjbxKJ8RdCQqVZatrv8dOb8t28+
	qNaqavpw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOezh-00000006FxM-2y8y;
	Wed, 04 Nov 2026 17:41:53 +0000
Message-ID: <07bd7095-b8de-472a-9ffb-2c3f62c51080@infradead.org>
Date: Wed, 4 Nov 2026 09:41:52 -0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/sysdev/tsi108: Remove redundant 0x prefix in
 tsi108_setup_pci()
To: Thorsten Blum <blum@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261104165857.174285-2-blum@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261104165857.174285-2-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 8:58 AM, Thorsten Blum wrote:
> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefix to avoid printing 0x0x.
> 
> Fixes: 55d8bd02cc1b ("powerpc/sysdev/tsi108: fix resource printk format warnings")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  arch/powerpc/sysdev/tsi108_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
> index 07d0f6a83879..dcc5e3e85dbd 100644
> --- a/arch/powerpc/sysdev/tsi108_pci.c
> +++ b/arch/powerpc/sysdev/tsi108_pci.c
> @@ -217,7 +217,7 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
>  
>  	(hose)->ops = &tsi108_direct_pci_ops;
>  
> -	pr_info("Found tsi108 PCI host bridge at 0x%pa. Firmware bus number: %d->%d\n",
> +	pr_info("Found tsi108 PCI host bridge at %pa. Firmware bus number: %d->%d\n",
>  		&rsrc.start, hose->first_busno, hose->last_busno);
>  
>  	/* Interpret the "ranges" property */

-- 
~Randy

