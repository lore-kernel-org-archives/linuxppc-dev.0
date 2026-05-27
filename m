Return-Path: <linuxppc-dev+bounces-21563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49113CD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 11:11:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQRkZ37YRz2xLs;
	Wed, 27 May 2026 21:11:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779880262;
	cv=none; b=cuYSZD90FaW3mUp+dMtSV3haDof4bFAp/YCsBT+F3YtxYDT5371ydmUf+kaIhACmG801hcCYASS/Ub7WI2wz9m04Zq+wzP/6oYUPhTqW+/Qmue1aaL5Enwb9FZQp2deLya3UgPcmpXoQOfxliYXWVEwat9uQJuOH3agC9b5Szjvdnid3l3YjYnU7rw1MsSPHtVGHjEO35rFJamdTCGcgeg3rNLZnb8TyMNhvGF1wQrHrdc3HG2VodoTDNSGBHrEPz4a1fp5SHxLIvUW1RHonVQnh/sFdY+yZS/UiNg41xMW+l4p2DgxZeNLIUeNfDnZ7uwOY4340XC8Eb21Na0rs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779880262; c=relaxed/relaxed;
	bh=KGqTFvvS9ROJQGSXgijEDECJPV5OA75EyXyQP/46Uas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRifWlQC5sto0Fc/UWnVT6rSJNJq7ZxSDLSyR+4Z4qZlRKmLdn7CO9VUDLdeLNhGWDNRYsTLswHIG5SvhnHLzsW4J5mek8Y6R0YOtJ2rshJ/5UKmqjO5002hrtHHwafmH96PA3Hba+xt6ge12AVzYPR+81dU/QPkvgKb+ZpB3DE8tIgc6nH60SvEfQCCSNPSbQ2iqvt3BZlJHW7lkKxqO7zhDOep2dKTLF5GYlh+ztImn1Aq/P7rBBGvBR6xE+xrRYSEYHcTIfArjt7l9vhqEocjA5Du1Tb3rF6ODqOm4rPfjDY3erFRA5vd7s3XJ4ZKp6pyOufqEtU0aMndyrjM2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMAwibdt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMAwibdt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQRkY3LHkz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 21:11:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 355934381F;
	Wed, 27 May 2026 11:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DBA1F000E9;
	Wed, 27 May 2026 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779880258;
	bh=KGqTFvvS9ROJQGSXgijEDECJPV5OA75EyXyQP/46Uas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lMAwibdtFEPs4M/x9xSDBKS4MJget8jlsBqtXFFoxMhxbrCx6tJ8I5slvO/epSGaP
	 CgZEUlzy0WTIT1ro6EXwGMzVp/gwCjsljH3DvDsutyje5altcgYspjhpHA3NjmZ9sG
	 E8SddKRAxtfkhDizkkUAL3llpi4Y2BK85PZwjjdgQcNenzsksMi+U6l1SsFyF4c92N
	 BSI3rCQoLVCarmkFb4CRo572rtHJan/dKm1uo+C7UnzJlinCxdpMh+YztbWMe5zWvy
	 /0UfJX8KDd7XhzIaEAn5kMTWymDHyxcAgQVLKIWhG5F7mG6ZPj2105Eq3NFKKWJQ9s
	 zccoRlEZOuEIA==
Date: Wed, 27 May 2026 08:10:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
	maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: Re: [PATCH V5 1/2] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
Message-ID: <ahbRPjZwe2NsNQIA@x1>
References: <20260504151321.12346-1-atrajeev@linux.ibm.com>
 <afwtl1zodrSUpK7n@z2>
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
In-Reply-To: <afwtl1zodrSUpK7n@z2>

On Wed, May 06, 2026 at 11:13:43PM -0700, Namhyung Kim wrote:
> On Mon, May 04, 2026 at 08:43:20PM +0530, Athira Rajeev wrote:
> > Fixes: 1dbfaf94cf66 ("perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc")
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> 
> For both patches,
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

