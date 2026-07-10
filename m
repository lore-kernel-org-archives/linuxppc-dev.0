Return-Path: <linuxppc-dev+bounces-23982-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6E7C44501
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 01:53:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxFGt4BHYz2yXj;
	Fri, 10 Jul 2026 11:53:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783648406;
	cv=none; b=IJ7snkQ+O/iXkXBRpGk8CB1V34XaVIuLvHoicnMqDlDvuz0ZukInbYR1oRtvWH3Qx5xhlU1L8Y/9VHkHzu1ebYGRLhGJUV+cuMgFNd3XF3hDF7R/XCW/X17ZPtQ+pZs0RcKwodVPESxTt7GTQ3X27ZQixgLUSeWuKFjzvM8gQl/KKtYBYuwWiK9HB1lazAxfFO0U9Nqg91tIgmY2m3A4Tcjzr0ERLdxzKtsPlcQkP4y5M5dF1w0WMpvSnSeIgWNC+pi/eo38yjPb7RI+twpVzrZ/bvCa0IR4mzuAyRDz2PX38eis3es+JUKsjQ7tkp6kzyYo+NMNVdMDjFis7PG4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783648406; c=relaxed/relaxed;
	bh=V5WePhdn0vM41AQZAytpqz+CRuhLkoEsVRrLRpGTVLs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dq/XeB/zLbD0ZlU8mPt3jdQLweVxPDOMc7F9IfkMz5KqIH7fOLX2JoNAxfWu98FJRWZV1VrXcGv/NYOMWBNlsJWPq3hvmZcFScFSuzlD9WMMChp247TYJLxMAq1+hyB8S/RMbBTtmQagMrzY16NO7yVYXKfFqwIpb24/t2X+24bqSZyjjcILwd7iyz7n40B0NTaVsQdCtC19pU2/SV9qSa6R5X+S/kW3fE+vgEkSa3kvJSQjE3wGpvtDtEuZUN9MlgBj1O9Mfjdgsw/+A+I/pqcuy6nftonEzL/tkox8GPedXAVG26QCivAZeHnJTuUK2XIB7vV87OSGh5uHXjf4Vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=1b02jHio; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=1b02jHio;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxFGr38YVz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 11:53:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D0C36001A;
	Fri, 10 Jul 2026 01:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9CB1F000E9;
	Fri, 10 Jul 2026 01:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783648400;
	bh=V5WePhdn0vM41AQZAytpqz+CRuhLkoEsVRrLRpGTVLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1b02jHioGv7QDp+jI0I5SMN7EUOkmf64ry1tpnm7kjslq1G5+6Gz1TDKTYLrC6j4T
	 MeIbQIL5Z5sRxDPbsmux03xqN4aybxaWzK47JWq6JiSmGh/7JvD3n1GSm48O6Duzfm
	 LAjyMiPqsIXOMpgUMlUhHRz4Dux9GpLIgLuMYxHg=
Date: Thu, 9 Jul 2026 18:53:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Ritesh
 Harjani <ritesh.list@gmail.com>, David Hildenbrand <david@kernel.org>, Zi
 Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain
 <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org,
 Miaohe Lin <linmiaohe@huawei.com>, Venkat Rao Bagalkote
 <venkat88@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] selftests/mm: avoid false failures in hugetlb
 and KSM tests
Message-Id: <20260709185319.cbf0c39dd47ee3853d212b7b@linux-foundation.org>
In-Reply-To: <cover.1783446924.git.sayalip@linux.ibm.com>
References: <cover.1783446924.git.sayalip@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jul 2026 12:29:04 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> This series fixes issues in the hugetlb and KSM MM selftest categories
> that can report failures when the prerequisites for the tests are not
> satisfied.

Thanks.  AI review asked one question:
	https://sashiko.dev/#/patchset/cover.1783446924.git.sayalip@linux.ibm.com

