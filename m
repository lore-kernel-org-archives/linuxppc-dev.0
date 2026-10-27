Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB960A2622
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=az4lEek2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDYNq5MNjz2ySl;
	Wed, 28 Oct 2026 01:51:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793112715;
	cv=none; b=K5bRiUIlGLM+BKen3VSLvuX22itNbr8T3vEWVb5i7gyakaF96bt3HZ7R0kVl979OMJdcxFxVli/qEw7n0FsPi+EIRftA2df5WaG//Wv8N/xZO2ylIK2a/Y33FPJh2UXzvUURD9sjBQ2iOG2BGt/uWOwkW7NFVF8XGLjV8KktMgNygH9Bd2P34PhjVhFZKx881YRJHLW14VGd0OuwNguPJZBomEtxJqVmUOU/OhMQCxRwLBbIsNVn7mQ373KcOlbbsCHcKZrmvDLstUsC9jej/NuVreWX3w688FYWIIIUTrQuiIvXcMj4XsGXNDxvBWqawS/8SA8FeX86m3iCdo2SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793112715; c=relaxed/relaxed;
	bh=JoOqvyAj0+Jgjt+c2q64ZVpxp84DiEqBDr/qWbcE/6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En6RfuRb4VrpHroZKnZINc258VKz66u3Rt+4m6L9KGApQExNglE3TnYDUKn27K21cUu8f+5P6cipJFdSzgjRTmZ94b/8c7bTZEgc1In5KkoSopxtXeH0weXvD/Wlr4Dth0nLeFGxalS0V5eaz3zSe2osry4IDkGgcuIa1eOI1t3mrWa5nw60xkoKx0Y8B9Qs5aP9uXMWJ739dDgWrg/wvUo9RKz0AbMiILRRhvt8MctIikBHM9CmWkeDP+c3ni6p/8nhtzGNJon65p8GYG1Sp75hQ764b8XbNadSZDfLuDzqQTX819zXvdRk+IS+PCils2blDJwBBKbSxa+hUBsuPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=az4lEek2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=az4lEek2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDYNp4yThz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 01:51:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EAED141FF3;
	Tue, 27 Oct 2026 14:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F541F031E5;
	Tue, 27 Oct 2026 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112711;
	bh=JoOqvyAj0+Jgjt+c2q64ZVpxp84DiEqBDr/qWbcE/6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=az4lEek2XZaQvbtwT/js8IRwBNgkl2479NPzwhFVN//obZR3z3zbbiUTdI83cibmn
	 lhlHU/NMSDCWNPKVwHA2RhwSm5NU19g1rT89n/pVplKXWBYvrKHRjTIfFJqK23Obw8
	 0Q0fpMzlY7hmAefyfeXKPrZwojDSGOdQq62pdlJlVIYxXiHxS1MPJyBO8wTZFgmXCB
	 HB/K00P4XAt8ZJND776NrElFPSpcFa2Xq7SyCn5MUK0yZ65yBVGtalX+BEt6uS4eBB
	 /t1nZMo7C7FQj6EdWsUZbtd1vM4z5ff5OHId/0Z+p4o4I9fam+WF4FPEcrbnq80Ytq
	 vAXX+WDtn8GUA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5D75A198004A;
	Tue, 27 Oct 2026 10:51:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 10:51:49 -0400
X-ME-Sender: <xms:gLrgavLAlgkrAhj-6GVk5yLjUj1kyaDiq3PHRAuB8g5hZtL3adnBMA>
    <xme:gLrgahq9Ns9x_c8FHLAL2iQ29lp-hr92Bw2cw2gpp6xFzPUbsAt_MgBkpxcEL9Qso
    VTCqJC2qCdFPNYFJk1IFe7oQ3ugipZgsgosd87cO1r_YL9q7BICvRYm>
X-ME-Received: <xmr:gLrgaigHnEu2DOyJCpY49eTeuHuI1p8TjWFQcr3g-i1UMc-y-AQAr1B7orc>
X-ME-Proxy-Cause: dmFkZTGhb5CCIEhi8YRVlZWXxywwjLDCiGKJTqYq3TGxohkiie2e7b08prnm6qm3Mgq/Xv
    f8mSL32tsLRpmgHaz6MZN+ZLdDrreydc6PdATZZoDlZZ4l4PoJjiJdhSudk3RV1jcJLsWl
    oGA9pKowkapDelRVuYlxCWlLeI7Z9/5iCynDokopMlVbGp8TOM3/RjSN/h13nNEROePlRY
    T35FzV8bgHo+mgJ1f+5oYNw35uJOWghFaZlb9xVnbDVCacqulVDS82UMGOBzg1yx5ECtZJ
    FuUQ2k/l29twYFlZP1ht6lfqh9RlJqn8qcxxQSBg1/mtGcYkOI8JiYt70URezpQ7kmjRmV
    J0aWJh/2p99Q5+2naRg9TcLhY7jPBYo2JWuKgkFL8E4JXBF2S0D8yAS+GGxhVRrDOgc9BC
    sMOKD8Wl7RYrMPEiZQOpn9PekBFgU7capm2o7nIlInu72F6Xp1aDS5bdkZpG9R5GaJJCR3
    56gL0cSDcpTgU9GBjEaKbu1mje0wR7SzmSZEBZumtk18Yekozk9oGPdB9y5v/ze1OYIaSX
    tF8S/frgaX2ZSwZSJSxf4Jsr8L8G6idJw06leYWdZ26CGTfqBOijN+PT0bh+d3bnyy3g2n
    92jz6sAl2//Fv0Kppx7hFvHhS12BccSJOh2PGA7gOFwihsIfKg8mLHvpsSFg
X-ME-Proxy: <xmx:gLrgaumHM46mCUBbbnYEqXur4opZmpmG4YXo5V15tjjpYM-Mc85uPg>
    <xmx:gLrgah49HVzBmPghZOLcaa4hCoPYdU3q6YoMMqHVA-Q7u2TyKQg52A>
    <xmx:gLrgaim0om9HQc7lD6Tc-7i8r87HAvGK3UN41DOa8xgFZ_UxpPTy2Q>
    <xmx:gLrgajiZQVCrpJT1ZH2Qks2KtrpGxe2s57jSA7H7IlInRy3VksMJAQ>
    <xmx:gLrganlsr6aI5eIKIEcQYttuzXZA1Q_Yq5sz8KY9RTMvBvSmQ70WtJOR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:51:44 -0400 (EDT)
Date: Tue, 27 Oct 2026 14:51:43 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	kvm@vger.kernel.org, =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
Message-ID: <auC4eUEN52PJF1bM@thinkstation>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-4-66f00b7a564c@virtuozzo.com>
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
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-4-66f00b7a564c@virtuozzo.com>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:36:03PM +0200, Konstantin Khorenko wrote:
> +	/* The child's exit took the parent's share off the counter. */
> +	if (*after < own || *before - *after >= own)
> +		return FAIL_COUNTER;
> +	if (*after != *before)
> +		return CHANGED;
> +	if (mem[pmdsize] != (shared ? 'c' : 2) || !data_ok(mem, size, pmdsize) ||
> +	    !check_huge_shmem(mem, size - pmdsize, NR_PMDS - 1, pmdsize))
> +		return FAIL_PARENT;

ShmemPmdMapped is system-wide. A drop of 'own' or more from another
process between the two reads fails the test instead of being retried
as CHANGED.

The parent's THPs can also lose their PMDs during the test: reclaim can
swap one out, and NUMA balancing can migrate one, which leaves the
counter low while the migration entry is in place. That gives
FAIL_COUNTER, or FAIL_PARENT from the exact count in check_huge_shmem().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

