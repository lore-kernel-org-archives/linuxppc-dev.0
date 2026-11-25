Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3793606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dsg0lUmt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZHpx2pSQz2yCr;
	Wed, 25 Nov 2026 22:42:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795586315;
	cv=none; b=Hg76W0Gc9v5+lZqxSuCplJJz3ZOI4cVxce8rLWG6B8vrJbaDAQHBrLNz0jwpoZ9HcVRn/sCXWm3R3oWIQXlL2IbwBvorEwnl9G8U104/wkYDgzKZ2KNJ4Ycf23gB7nNGHTRA79tQc8B0XzgyEBdxynyruQauBaM4TNNFj1gSUZwQP5TR3wV7m3S8ifxSlUtc3eNA6lAobEbsM+qlV8nW13GMVVKng8N4beS3MfJrdwMUpGT4fdxxV7YKygciFQOW+jqNWtlgcZkR55VsOYyGvW6AadXPlwMMgkDW9W1nmstxQCvfQ8h992bxkLTRxJnlrQfx8JalVQbF4IJFyBY0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795586315; c=relaxed/relaxed;
	bh=xFMuh8nwFoEFZnPvdlHZ2jAd51FcFwkpbhkwnf+oNII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYKY6y9U8aCRqZQBiIQB6F6Tuvkbvo8XOmQbcSznPSKVnUSjKzBrLEbEslifysFNND5Xcxli46RIwl+1a/Fet72I3vSQkCbbYFu3RKm6FNWJTzdJKvJa/pMCffFNYuO1LBsja0C5AcauX30V6H0+KTKcyntrqyv5ToLTfoQIuZg9YJv7CgKkZExaS8wyNADTnBCtcQ7PilcFN7nAWWXCQNyRyJeGeL+himVFlrXAFSuJsX2VQS9T2LatzI08KKsa0+DEhyBXg5+hbxZJe2AzKddBsdUOqCeYIHfFve9wLuURGXkKbLlavSkKRphdQ8Xzj0Y/LI4g5gviEiQ1ZBst7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dsg0lUmt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dsg0lUmt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZ8B26mr9z2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 16:58:34 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2f03f3631b2so29265225ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 21:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586312; x=1796191112; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFMuh8nwFoEFZnPvdlHZ2jAd51FcFwkpbhkwnf+oNII=;
        b=Dsg0lUmt3q91dKbEHy6lAwvkc4f8IARykklvv6tb+wnspfltW4gJ6CzM24Hktvuor5
         NdDoqWTezVyvgI7QRc6QNunmsgurt6T8zGvgxqQLAUlg2uZwEKkaX68b+r9B98Q4CT0Y
         xXCZ6mUggMruZv7mPlVFTJ8YmmFkTjm13W5xGyxphhbT7Z084BsQeMUf4sp31vH5hA05
         kGOFM0cPjMlrktza0KcKRDOpsqGh8VV3UuR/t55TKHGV18TAnv1gULrJpYSwvcFBQQB6
         ArWOWLCLmkuAtLDNPSrJ4Kjjr1P3wBarfgFnzz7nxLXm2guVrT9Qy16uvm3FUrscCVQ8
         dp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586312; x=1796191112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFMuh8nwFoEFZnPvdlHZ2jAd51FcFwkpbhkwnf+oNII=;
        b=1hAGs7UkVP29tyQLRbVqfdaYmATEOnsJeXbhzwu6fojDYelLavwA1fnP93zSKYeKe1
         RnsIKPI6q0jlFz3CXkHzHnHYyoiI7nEIoustKYWJO7PDbVTcZZvg8Gmteha2WliSHcM0
         Xah+xYIupJBdg+qeZlQ1nrUqeHSIO6Xj6EDMbdFvY9VABZncRMy2mgmVR+hKmkfUemAN
         Z6oL9mxZnBUl99jZNgSN/GPVry9tSAfymH6488c4gGBKtUb5EIfXejokbk7NGeDCRfTQ
         UUiVZ23DzVkpkajT/DU/EWERpMz0yupSZIZSV3AoZBdjs/jDxQrlNr6W9xapZ/NPftZd
         iSZg==
X-Gm-Message-State: APuU4Z8zkfq4oEEiabs+vKXZy1rLBqgTRxsZ0ljgXnRXs3OzHyCwl0g9
	fYUaqC1/22hnFx4ndUDfg7wDCafNH1lNPQ5nTP8VIWG7VnwzdzzYZhvN
X-Gm-Gg: AZFdTZfy/YReITh3MNllzbUIcPiUVV+B9/35MxW6O0aVJuFeW9AcsPMWuC8iXnd3ZG5
	GgKEnSjOEppirc8PZcRLHyp7Tas3w9Y999KX1FmA5weAXOWbI/CoQwj6DbEbKj1eH5QiO20+Qbh
	lgrNeXUtCOV35w2a4tgrCoC2gKJ3h/THUYxVjrg/1aqAuDK7IqtrF5HZV/iLDGODgm/RfnkODUd
	bKQtbUeVoRraiAtUayqdcpyMsT0oUlR4vQM2BEhF5g9xKzzpYHm0gWlROf+0WApvhHRCVGP54xq
	r8JHvrLC02OFN48yLtgKg+6Vke+FFuPhSb7PQjY618oPFgfTqK+9RUUy6hcgedYzkqW4Rkf5maZ
	nNn1DF0pqDqOtCsAZnN1GqZwyej4ArVYT0ZPztgbxOnIy57i302NBAQmJDbzHKU7DQT3lF9bKJz
	nzXdJl1RcbWsFHu7JMUgk4HFkNjRxCqMNAN7tWYIBf5o9khSKEb7BX3pyvpuGx3nayebInBVFZN
	b9pZ+R8cRKU81XDlUnvGNbPNVJbe+W95NB8lTep61mQ824USUh/LXWa+qBaS4c43ECjGnBOpq0R
	Mcx3I3+RsY5NGq641fLE14ihTv0EEfzAZqlowP8n8MDgha4gBV25PFJxhTRyPE6ilzdWD/mtz43
	Vz2eNVPcuWMFHfLTLGnNAIw==
X-Received: by 2002:a17:902:da8e:b0:2f0:3647:6224 with SMTP id d9443c01a7336-2f03f261825mr147681875ad.61.1795586312275;
        Tue, 24 Nov 2026 21:58:32 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84294sm78212685ad.9.2026.11.24.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:58:31 -0800 (PST)
Date: Wed, 25 Nov 2026 11:28:26 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if
 perf_pmu_register() fails
Message-ID: <awZ4ZhK1GFHKi9Tr@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:21:53PM +0530, Ritesh Harjani (IBM) wrote:
> kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
> gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
> perf_pmu_register() fails we return without freeing them.
> 
> Call kvmppc_cleanup_hostwide() on that error path.
> 
> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
> index a58634f656e9..ec05b4855736 100644
> --- a/arch/powerpc/perf/kvm-hv-pmu.c
> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
> @@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)
> 
>  		/* Register the pmu */
>  		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
> -		if (rc)
> +		if (rc) {
> +			kvmppc_cleanup_hostwide();
Just a question.
Inside this function, should we also take lock just to set the pointers
NULL rather than putting the whole logic(free also) inside the lock like
we did in previous patch?

Apart from this, all looks good.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>  			goto out;
> +		}
> 
>  		pr_info("Registered kvm-hv pmu");
>  	}
> --
> 2.39.5
> 


