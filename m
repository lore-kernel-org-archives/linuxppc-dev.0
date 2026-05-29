Return-Path: <linuxppc-dev+bounces-21705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D09FCD6E4C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 09:52:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRdtl6d6vz2yQH;
	Fri, 29 May 2026 19:52:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780048335;
	cv=none; b=c6rbu1Nifma91qCEibXVuq+EGovEne1p9JEljbCkbs6tsBKi44i5eMNpYy8HxBatjG1sTAv0WGNoUDlMItoL26uUm6xboP3uWEGFUxKVXJJ7VQDzdKX1X2PAjXpSKP/OKed6OLoPg7AYuQQdNMg1DWm/eDboYNFb/MgZb6nn+qLFkuuTdfcNEFT9I60PTTqi9J7BYKPzuJTAdCBI7iGOZ8Kdz5RQfCR03NTSFDI50Y5y/4R9bUCKd75AbrtBoX1m45hyKOEvlVpy0w3vTGRX46VxvmMwVFDrpxHhAyZI37E+z0WT+QowFAtRux3mBUjThSorqAMVI3l6QVruFHf6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780048335; c=relaxed/relaxed;
	bh=cyHVyrPLnPbjHalgaeAqgxSN+UvK2IlCWIiCjhI7Wfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXHrXBm+dcNFQztYR6neDdMUqq4vhPjKGDOADlowyfQKBREV66489xrxRflXKlbQu3ihdhcbTCw7lUgeAPaxzKqU1Nb8pv3BcaWGedfvy2+8ci3KhQH6qMUrJ63zJwbgOBBGh7toBcmmkBL3MJW3/5cllfLWeKAXUzDszqHU+Ap9fw8Ve64Pg/pcxMHkR1gfgBXnVCRuEC3nf0vgIQq+5LWhBSAdmxDDDT2avc+wbkecxA/gfQ/fQC2G6W5rp7vFrlolohKUvqObozZgfu6QD0LBmBiueOsDbQhUmC+nyGFNtg3ReqlDqNNDk7fn5GmgbvkaiEEg14gKo/aw81gaCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaRrrk0p; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaRrrk0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRdtk4sgjz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 19:52:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DAE3840A27;
	Fri, 29 May 2026 09:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1964C1F00893;
	Fri, 29 May 2026 09:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780048331;
	bh=cyHVyrPLnPbjHalgaeAqgxSN+UvK2IlCWIiCjhI7Wfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kaRrrk0pfe80aqSLzGkDgozvYQmy4j1rZwrQGhoJod62SsclJywf9x87D6vFYImYJ
	 hw5lgf4YYiI5N3Z23+QH8ievAoEa4+rs8mmrX/EGlfVaLbQIXPj/+cEkhbxUGyr2t0
	 avCMzfaviqlG085QTL2SU2BquV7BQYNHzLpam52f/DzivKANcn5hZbM5/79DvNANaY
	 AqKkxPg9NyEe5aKcN0u6VxDvu4Mbpc+9tpzVpt+yVzImBTRQlnfENdQzTnrAA6BSlX
	 nXLp98OYE5eZk+0fTJScebrYxKlRS0eLvlpOlvs9joTbODGrHrzv0d+h1McwrSxxoA
	 2mbQ4y7vr7a7g==
Message-ID: <b00339e7-ff69-4679-9d7c-56768b784db2@kernel.org>
Date: Fri, 29 May 2026 11:52:08 +0200
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
Subject: Re: [PATCH] powerpc/boot: remove unused min_t/max_t macros
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260525091839.817778-3-thorsten.blum@linux.dev>
 <7c1a04f3-caa8-4200-a4ee-55cd2cc28461@kernel.org>
 <ahlgQZW7z7Ht4qpS@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <ahlgQZW7z7Ht4qpS@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/05/2026 à 11:45, Thorsten Blum a écrit :
> Hi Christophe,
> 
> On Fri, May 29, 2026 at 11:10:20AM +0200, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 25/05/2026 à 11:18, Thorsten Blum a écrit :
>>> The min_t() and max_t() macros are no longer used by the boot wrapper,
>>> remove them.
>>
>> Did you test your change ?
> 
> Yes, but with Gzip and not with XZ, and by grepping for min_t/max_t in
> arch/powerpc/boot/. I (wrongly) assumed that arch/powerpc/boot/ is
> self-contained.

You could have figured out with 'git blame arch/powerpc/boot/types.h' 
that those lines were added by commit c762c69e106f ("powerpc/boot: Add 
support for XZ compression")

> 
> Thanks for catching this, and please drop this patch for now as I wasn't
> aware of the dependency to lib/xz/.


