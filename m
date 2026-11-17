Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0A606A8A1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Amp/AGl4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRS868cLz2xnZ;
	Wed, 18 Nov 2026 01:09:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794924568;
	cv=none; b=fBW0qhczDukdyVkd2Bk1a2rim+pBCeDLIxqYXTT7ZP3dc7UIFLDXC2zhd/wirVS+RuU5yeh8PEYz256Iwsp4CClAosCo6KYk/1vN+XKDPrF2TMQQFGlnHG+5wuYUnftv5iO3YK10AYL1g1oIbOyUlnUxo/Kr++ni0FmteMRXfIFtgJ8gHlqGadJ8AeBDutkwoIYHzAD+DuztdGTTj684v0UpD/cZoMOiIKXzNppL+ERE5pVVYR0s2OgBKs8Nk/4MzEU0FkhbuYEPGvfYx71KBMYym1xQYv2Pl63M52dXKE95DLp2sBVxQovJYJDG3U5f3Io9/tsogTja+pOY6m/vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794924568; c=relaxed/relaxed;
	bh=SoFgxcXLFI5DRM3s4vlmxAtiDyLu72vPJYKzMNWuQhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4uoDg15DB2zqoTk5LrjWmjPPjBdM4Nc7SHiZhdk+cHpjvC1All11AI2BkxVtZqpHBJLAlkDJqMpb6gSzjcgfTteQ5+S3ZWtlFO2kdNRo32PO7x9xy5yWVP230QAZK3lPryWjvkN1XuxFqNJmNqp3cZqk3iBUh+YtchDNsnWl+Kc5rZwlKjwc4FLpK91ZeUdesk3adGHP0AL13FJfdxD0vBdu2ozKnU8ZSKD/iBovmEFXLtHQzjuiVPDEaWCgflsKrulhL57t1N9EK18/jLrHsfIti3RfT+n6Ip62/MjnWh6YyWsa1H/yrlh00RBIrvIqBuuyKcB61QCKAFXYDmMbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Amp/AGl4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Amp/AGl4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRS823vtz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:09:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C579D4341D;
	Tue, 17 Nov 2026 14:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87071F000C7;
	Tue, 17 Nov 2026 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924566;
	bh=SoFgxcXLFI5DRM3s4vlmxAtiDyLu72vPJYKzMNWuQhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Amp/AGl4Ts+6YMeV2WyiFOK231Nm5VwYtzOyOkZYm7FAgXLY4QdgfRnLlDXjS4uE7
	 N5bYD88Tc6/cwU/h/TtuImvZUtD1p7P9nAbBJiNKeJX5zbXDKhtlUbwn2+wkoOIF0/
	 nm7/t4kapPpJRWeW6VoSjfB5iYgOzYt/YM5hWLL89S25CFk3ezdNfrIJDlERZxxNon
	 0q3LHpvAN0e8B/e8Q52GEQR5MTOwGlz9p1wVWXVTgYoK1F3uwQX9Jzz0casBKWiaIs
	 Ea2WBxbd0FVmetNqYfkp62cWe9MRNaRI+uIAgHWYU9bEa614zuWuJLMKMJhYk6JWaG
	 T7HAN1kkBiTTQ==
Message-ID: <57c8caad-31d0-40f7-945b-f53908b811e3@kernel.org>
Date: Tue, 17 Nov 2026 15:09:21 +0100
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
Subject: Re: [PATCHv2 3/3] powerpc/ptdump: Show the exec flag of kernel
 mappings on e500
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <cover.1794572365.git.ritesh.list@gmail.com>
 <074831f06e18d1b8cff91e7588aa7985077dd538.1794572365.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <074831f06e18d1b8cff91e7588aa7985077dd538.1794572365.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 13/11/2026 à 13:31, Ritesh Harjani (IBM) a écrit :
> On e500, _PAGE_EXEC is made of two bits, _PAGE_BAP_SX and _PAGE_BAP_UX,
> and a kernel mapping only has _PAGE_BAP_SX (supervisor bit). The flag
> table requires all the bits of the mask to be set to print "X", so
> kernel_page_tables never shows a kernel mapping as executable:
> 
> w/o this patch:
>    0xf1015000-0xf1015fff  0x00000000         4K PTE   r          present  coherent                  accessed
> 
> Print "X" when any of the bits is set the same way it is done for
> _PAGE_READ and _PAGE_WRITE:
> 
> with this patch:
>    0xf1015000-0xf1015fff  0x00000000         4K PTE   r      X   present  coherent                  accessed
> 
> This only changes what is displayed. ptdump_check_wx() uses pte_exec()
> which already tests for either of the bits.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   arch/powerpc/mm/ptdump/shared.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
> index edc69da19b85..e28a41a8b1ac 100644
> --- a/arch/powerpc/mm/ptdump/shared.c
> +++ b/arch/powerpc/mm/ptdump/shared.c
> @@ -22,9 +22,9 @@ static const struct flag_info flag_array[] = {
>   		.clear	= "w",
>   	}, {
>   		.mask	= _PAGE_EXEC,
> -		.val	= _PAGE_EXEC,
> -		.set	= " X ",
> -		.clear	= "   ",
> +		.val	= 0,
> +		.set	= "   ",
> +		.clear	= " X ",
>   	}, {
>   		.mask	= _PAGE_PRESENT,
>   		.val	= _PAGE_PRESENT,
> --
> 2.39.5
> 


