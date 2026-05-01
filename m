Return-Path: <linuxppc-dev+bounces-20364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EC2CCFA13
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 13:06:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6WXB1zn8z2xnZ;
	Fri, 01 May 2026 23:06:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777639466;
	cv=none; b=XLG6pgyDuQzrf7KOaEZb4gxeYZCnljZ9PJH8O4jafkkDFjlAQ57WVsuEgeqGgLYbUueniyXk+++LwVRYSGBmNNV6uHF2PO6EgznbD9bYhudqRCAyn4Er90pQnIShvdrGD0Tw/VDPbJmi5j+C79NCRo3bIgdCCs7znoekXYThbtk7AJpeE1oZCGC9oURrqv5wnqss8twcdSB1pefTx+zEHpgwooTQCgyehQ9eY/UjzGpPFQokdvjqLnRp7i8oFYsvAjsZ6CkwAQlbCzh/DZXnJBFLdn4yyqSdXd8ykH1SXfgBndNd3Lbo+7ysFSZGG4DukqdOr1JmQlXJX7aZyf16FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777639466; c=relaxed/relaxed;
	bh=WDJ5agURbFUqib/Y5f6nEczqKk4PcA/SMngvEMv0JI8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TdAGgc7AZA0P47MDCfn639VOnEYn12+ePYHa0jiobgBI7xIIpXQ3xyjbRb8Y+BerTOncdWqZKC0Kqt/lYcYVjtOMLZgHjLvwEKi2Cmlnk4dfiNA1fCVo/YH4qp87ue1p32FEGATFd/Sy5bxnauOT5fcvm3z0SLmfHIjxfpe7r0fUUlbszxZqvNmTImm/9jEa+J6kfCDu3rQj9HkBkTgLZSr91BHE3tA+rol7EimmTAXc7epiZD4q/tU9JhRZuqPhsA3iXDWE79hyA/OLZOWkn6JuyGA09kbrYoHXlU0AANo8LMthRerqcp93tQttm6XjZ4OMTMTxNhWokHLE6lQftQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LBPygiff; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LBPygiff;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6W2K6bL7z2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 22:44:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B7BF060142;
	Fri,  1 May 2026 12:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32744C2BCC4;
	Fri,  1 May 2026 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777639463;
	bh=tOQURC2lOBxx2B37R+W14tFAK4b6ua+v1BIBDO25iGY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LBPygiffx0JtHpCrM7wj7xR3bXkb7oJzWnSiONJHFvDtsXFeuKu6AeJtS6/bAsxFl
	 Ijx465GWMs8sVlmOVatb++6ZEpw3R8RKPpTAhSCsm608dnf+dLm+P6bu+44LmRifBj
	 qSs6vUAC991+/ilaCCgEZRFfgUemE70qsiRgsuSh91z85yXBS7Klz5YEDMwutgNGZ6
	 Urn2uDW/X6v/x3VkcjYO4xfGmKmOd23ladCqxES8o8Xtk3NgcuqSYzuwhPLjbi9L1s
	 kFgfyDvVj0YGbigk8RUf9WXeDNo0wKdhwJB/GcEBeZZf3y3FfIIV2Muipl87r1g73Y
	 DRSKBEZKIVjpA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 262F8F4006D;
	Fri,  1 May 2026 08:44:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 01 May 2026 08:44:22 -0400
X-ME-Sender: <xms:JqD0af-dsW1UXIKGFbOiCBlshGCGBxMKKb8ZI1eFeMCLu8-KIhW2mA>
    <xme:JqD0aWgzNu3SCDqvf3k8TeYQ0VFCxA_vAaYloCaVB9vT4R_v6GpW0O3MgV0xQd1OG
    hyMiZim3ssy4qSwox82eF9xw3VNMB-CqtH7cZNOkRcAYxb3mz4q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgeehudeiieevveehleehleeugefhhfdttdehlefhuddttdehieelteekleevtdejnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpe
    epkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhhishgrnhhjuhhmsehlihhnuhigrdhisghmrdgtohhm
    pdhrtghpthhtohepvhgvnhhkrghtkeeksehlihhnuhigrdhisghmrdgtohhmpdhrtghpth
    htoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgt
    phhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhnvgigthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JqD0aZ-eFMMT6v1KtExUvT6w0MVa-AGRyUautOMYlbZSFZ0vq-U--Q>
    <xmx:JqD0aaRKqirODqnZgL7zXQSn6YLEL_7TT0RNqFCBqv0tkomx4eub6g>
    <xmx:JqD0abdYZ6RoWS_8dTiAOa_bbY3m5TEekj0vAk_5nCGaxIaN29ghQg>
    <xmx:JqD0aUQx3oRrUvGvAwS3Q2FbkCtlv152yBi0Idd0V3HWPH92UpL-LQ>
    <xmx:JqD0afLpq_HMJjX5wXeWl1zdOxy6ewWTpmc6m8NihfDAjXM2FdbzBk2u>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3F34780070; Fri,  1 May 2026 08:44:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
Date: Fri, 01 May 2026 08:44:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Misbah Anjum N" <misanjum@linux.ibm.com>,
 "Linux Kernel" <linux-kernel@vger.kernel.org>,
 "Linux Nfs" <linux-nfs@vger.kernel.org>
Cc: "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, venkat88@linux.ibm.com,
 "Linux Next" <linux-next@vger.kernel.org>
Message-Id: <8e8847fb-0eff-46b0-97dc-fe683c706db3@app.fastmail.com>
In-Reply-To: <d6701b40b8b7c143f87ecec0afb08af8a2867358.camel@kernel.org>
References: <dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com>
 <8cf80f450085ac17164e8fa1391e9635@linux.ibm.com>
 <d6701b40b8b7c143f87ecec0afb08af8a2867358.camel@kernel.org>
Subject: Re: [BUG] [powerpc] [next-20260216/17] nfsd: use-after-free in
 cache_check_rcu() triggered by sosreport on ppc64le
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, May 1, 2026, at 3:06 AM, Jeff Layton wrote:
> On Fri, 2026-05-01 at 02:15 +0530, Misbah Anjum N wrote:
>> Hi,
>>=20
>> Following up on my bug report, I have completed a git bisect and have=20
>> critical new findings to report.
>> Ref:=20
>> https://lore.kernel.org/linux-next/dcd371d3a95815a84ba7de52cef447b8@l=
inux.ibm.com/T/#u
>>=20
>> Current Status: Bug Has Propagated from linux-next to Mainline.
>> First Bad commit identified: da6b5aae84beb0917ecb0c9fbc71169d145397ff
>>=20
>> The use-after-free bug in cache_check_rcu() that I originally reporte=
d=20
>> in linux-next (6.19.0-next-20260216/17) has now propagated into mainl=
ine=20
>> and is confirmed present in:
>> - mainline (Tested on Latest kernel as of 2026-04-30 - commit=20
>> 08d0d3466664)
>> - linux-next (Tested on Latest kernel as of 2026-04-30)
>>=20
>> This bug is causing failures on ppc64le systems:
>> 1. Kernel panics: 100% reproducible crashes when sosreport runs
>> 2. CI/Testing failures: All automated Avocado-vt KVM testing on ppc64=
le=20
>> is failing
>> 3. Use-after-free corruption: Memory corruption with corrupted pointe=
rs=20
>> containing
>>     ASCII strings ("libz.so.", "export_cap") or poison patterns=20
>> (0xcccccccccccccccc)
>>=20
>
> Thanks for the bug report. I must have missed your earlier email.

You didn=E2=80=99t miss it. We responded to that report in February with
a fix that you and Neil both reviewed and it is in v7.0 now.

That fix addressed one instance of this problem; there are actually
several more, all in the same UAF class. I have a patch series nearly
complete to address these issues.

The issue Misbah reports here is not the same as the February issue,
though it is very similar.


> The commit you landed on is a merge commit and is not likely to be the
> cause, particularly since that merge was for x86 drivers and you're
> seeing this on PPC. Is this reproducible on other architectures?

We have an internal bug reporting the same stack trace on ARM64. Now
that we have both a reproducer and a platform that is easily accessible
it will be straightforward to confirm these issues are fully addressed
before we merge the new fixes.


--=20
Chuck Lever

