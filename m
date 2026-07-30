Return-Path: <linuxppc-dev+bounces-25120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603E5C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 14:46:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9sTH6Jz3z2yDs;
	Fri, 31 Jul 2026 00:46:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785422771;
	cv=none; b=auuQ36F6cXl5SwqFFuSaiFYpG9JunTK3y8Avm/pGIi2Sbh+OhNx+2WlpUjXzK5D12+Z29H1XzS9ysdz5cjTj4yDEcQOfYvg/9JW7Y5QfjZamU7MP+ZgueUUunn5LeCynJZmqBPdVKyWxDUNF+2Ty2s13SaL91sPi19/8qao2R+dsD9sv6fhd7cSeuMTG1M1QhAvimbaVZZEDhaMgBHwLU6vSAS7sXxopaFkAoUP0npqHVQ2SNysFGvIzCSupFPhL+1den/FZu94M0Y1OF3vatxrAWMhLXzbPSiWbppzObfZHFo1GstdePMDTBePBi/ZK9AJrkdr6vMNNB6ZKG7wkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785422771; c=relaxed/relaxed;
	bh=i3evynFgbV7bMOKE00Gd+z/kFZkYvHbchKCORhppOB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABmVjJJc1jaQ+uHQaCgVddIpKZfJbZ6BquSsMVEQR/HHf7FazozFnr//+GQJXvbbtSxreEq8c2x7Pxo+R/fa1oD41o0kz9yXHv/aJbsEHbIBg39X9ZZryZGQY7Qeb511X70UugZz/jU9B0HX2svHFwiATqhib10WSlbDTYmj3j34sRyBSmxPBg2G8YRxAHCT9DjXl3Ny11mgJIuvuNJH8NK6szSOSmK76vG5u53rHO/r+03pIzYa5hBUj3zBDnBFkiQbmx0qPth/5LHRV0Q0OMr9y0UMWiB5F4TRhDtCNsM7uLNFs0R6QllB4CSOtfi48Ph3J65ovuMMmX7FzrZNSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UJYSMRJW; dkim-atps=neutral; spf=pass (client-ip=91.218.175.174; helo=out-174.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UJYSMRJW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.174; helo=out-174.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9sTD1VRCz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:46:07 +1000 (AEST)
Date: Thu, 30 Jul 2026 16:45:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785422742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3evynFgbV7bMOKE00Gd+z/kFZkYvHbchKCORhppOB0=;
	b=UJYSMRJW6tcxIkzfcX3hz3D4FKxoMVt1eHV7uvfryJVmD+XNPe4W1tGzTucYzikFoGPmbo
	+eEqdZyoXbd2cZvjz8ohpQwz8hHpQifRui1hs54xrd9/B5RfLZwf8W04Ifz9KTLsCwgldQ
	Sz98khpi7TupirpfzjeXcjncb7V8vCU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec: Simplify kdump_extra_elfcorehdr_size()
Message-ID: <amtjkfZgkvFACYzE@linux.dev>
References: <20260730131940.597739-2-thorsten.blum@linux.dev>
 <42ab7c21-25cd-4ed1-b43f-b155e82db1a0@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42ab7c21-25cd-4ed1-b43f-b155e82db1a0@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 30, 2026 at 04:33:18PM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 30/07/2026 à 15:19, Thorsten Blum a écrit :
> > Return the size directly and drop the extra_sz variable to simplify
> > kdump_extra_elfcorehdr_size(). The two warning paths now fall through
> > to the existing return 0 at the end of the function.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/powerpc/kexec/file_load_64.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> > index c3503d698428..d0c544079e03 100644
> > --- a/arch/powerpc/kexec/file_load_64.c
> > +++ b/arch/powerpc/kexec/file_load_64.c
> > @@ -377,16 +377,12 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
> >   static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
> >   {
> >   #if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
> > -	unsigned int extra_sz = 0;
> > -
> >   	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
> >   		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
> >   	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
> >   		pr_warn("Configured crash mem ranges may not be enough\n");
> >   	else
> > -		extra_sz = (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
> > -
> > -	return extra_sz;
> > +		return (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
> 
> I don't understand.
> 
> Previously, when cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES you would
> return 0. Now you will return something different. For instance if
> cmem->nr_ranges is (CONFIG_CRASH_MAX_MEMORY_RANGES + 1) you will return
> (unsigned int)(-1 * sizeof(Elf64_Phdr))

It still returns 0.

When cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES, the else if
branch prints the warning and then falls through to the return 0 at the
end of the function. The final else branch is not entered in that case.

No functional changes are intended.

> >   #endif
> >   	return 0;
> >   }
> 

