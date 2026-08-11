Return-Path: <linuxppc-dev+bounces-25738-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09229C5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 10:55:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK7p11g1jz2yyJ;
	Tue, 11 Aug 2026 20:55:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786445753;
	cv=none; b=BKeUfBaFVCw5TzJ/zv+QwUimYUKjTwu0RwghEE2JFGeQnuyW/KyC0NXkNMk4/XOK96bpQEkd572nf7z1azVnaCsl1e45cQiDhN4OUPspHK0y3WWQwaCV+UayoPFCRRBTr3VwQymQcecQqgNRLoOavwYJ/CrQvjYvo1Rn4YW8xCGqbMQUc9ILxQ/p+wNe1bdpGqTnEhCzHP5Js6MwbcyA00O0kWdEKMmLFAdSH8cKWE1Hu3o/aydAcKzvRRPU/YR7A196tYMO7lRNXbv+6imHayXMeTzViPgv0K1UmVeUumeC3VTn1cfv0kNp9wnyYsWbq/RI6qJBM10OfvWBdCx78A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786445753; c=relaxed/relaxed;
	bh=La4waMT4rs7aXnTV66yZwYLc3c+bIPKvhMi8gMs4mD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw7/IFlsVSMKz6l5w95/dyP2P7JL2kG5Eb2fXhQISvihyJmVMnvudZjfZcV24pcXjN2eiATv8Kg4zIK9VSu3oTCJFDwn4AWnVlgPjY1EFuCZl5Q9o8zdtxNwUyN6XOR17rx4oed8Z8wmn2qxHD7MvGmdkJpq/EKovQkNe2J+s/nJk5cm6KKdPxdM4zJI+d+CdI5/xXtwlcn0m4zhRaze+kyNktIUhCjsSv54V0IBGidRQomUGBzIIP8nVizMiqf/WVYX4gsi0IL2ze9ucwGXhVHR0hyjMh+e/kucmpp+rbCbfBTaydrziD0hC34O5FSj6gjmNNkNQizreVyovrO+ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B1a0pCwG; dkim-atps=neutral; spf=pass (client-ip=95.215.58.184; helo=out-184.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B1a0pCwG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.184; helo=out-184.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK7nw2jcsz2yvM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 20:55:47 +1000 (AEST)
Date: Tue, 11 Aug 2026 12:55:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786445722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=La4waMT4rs7aXnTV66yZwYLc3c+bIPKvhMi8gMs4mD8=;
	b=B1a0pCwGMiObe8FUyVrFx3+csoClXuKOjOWE3GC90OUdZiZIp6DmyhBfUdR4rmNxclN9nG
	GJe9hUtMII6cBeZF9W0soUALxhFXOqBheu8BN6rvc0uI9vAZvqU6EKFSrkw3U2HkwljDIK
	a762D6zdoDrpP8JR1bOQLgpYCtY3TWQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Thiago Jung Bauermann <bauerman@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec_file: Use inclusive range checks in
 add_usable_mem()
Message-ID: <anr_k9jzc2QYjsJz@linux.dev>
References: <20260809162403.18142-2-thorsten.blum@linux.dev>
 <ee531113-5a56-4e6e-bc16-95941aa5bbfd@linux.ibm.com>
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
In-Reply-To: <ee531113-5a56-4e6e-bc16-95941aa5bbfd@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 11, 2026 at 11:51:46AM +0530, Sourabh Jain wrote:
> On 09/08/26 21:54, Thorsten Blum wrote:
> > add_usable_mem() adds usable memory ranges for the kdump kernel.
> > 
> > The ranges are inclusive, but the partial overlap check uses exclusive
> > comparisons. This skips ranges with base == loc_end or end == loc_base.
> > Use inclusive comparisons instead.
> > 
> > Fixes: 7c64e21a1c5a ("powerpc/kexec_file: Restrict memory usage of kdump kernel")
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/powerpc/kexec/file_load_64.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> > index 8c72e12ea44e..f9e872693ca7 100644
> > --- a/arch/powerpc/kexec/file_load_64.c
> > +++ b/arch/powerpc/kexec/file_load_64.c
> > @@ -113,7 +113,7 @@ static int add_usable_mem(struct umem_info *um_info, u64 base, u64 end)
> >   		loc_end = um_info->ranges[i].end;
> >   		if (loc_base >= base && loc_end <= end)
> >   			add = true;
> > -		else if (base < loc_end && end > loc_base) {
> > +		else if (base <= loc_end && end >= loc_base) {
> 
> This is interesting. The updated condition basically handles exactly a
> one-byte overlap on either side of the usable memory ranges. In practice,
> it is very unlikely that we would have such usable memory and LMB ranges.
> 
> Thorsten, have you encountered any problem that led you to propose this fix?

Found by inspection only and I agree that this is unlikely in practice,
which is why I didn't cc stable. Same for the other patch [1].

Thanks for the review.

[1] https://lore.kernel.org/r/20260810145827.157972-3-thorsten.blum@linux.dev/

