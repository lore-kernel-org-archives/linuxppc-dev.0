Return-Path: <linuxppc-dev+bounces-16669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786FEEE20A3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 13:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6w3t5cFqz2xqk;
	Sat, 07 Feb 2026 00:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770376509;
	cv=none; b=PXfywRB8qZ9R0L5fO/z9jzR2jH0CW1vX7QXADfhjivSQc5AEYPOiLN64lOMC39d9GvWFraxrtpbTDSWwtscCR/kGPqV3liCuBxNstD9gywi4jxwRfoin98qu9WpEz3CG27qz+v7OEgH1AltVt9bwrJRlJYBFbktB4woB34iRk7SrJQBS8qu7Uvy3vhYRVSA/+GN+xtv0RpWA3X1B/4Gxt6oOXMouxRclGCY/FvCs+ee6ORAnpHJZSVX8nYn8RFgFbZeQOEURh+54OduhFP/iucjrltq2rM/FTJsO5brFCABCez/X2xfxSfxQjzfRHUnBY17dL7FAUxivMDsUS4DC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770376509; c=relaxed/relaxed;
	bh=tDEI/GWRahi2pE07GC/9TD0gUS6wvtKdDT3TaBlKGLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TM9zm11alkfNPvPkkBRR5gTORmJf2tFnMyucQ1MX8+yvorpBWJur+i/bDa4uS3oYQyJ0+YOTyLG1ueRs0u3pxGaHRB6NCW/TGH5IKvcoFjhEYvCuj0Q3+PJVq/jj2nHsQmUsTT+wDV681ZMuehEH0gFnQBjEe6nW35ENHjbbbnSkizN5dfuP2fUV6DXgtJX/dPShHz/bA8OGS1a5rG8DXNZj8pDnT9n24i3wyclBQx7PcpS2e+eTmM9e1qGt7fWRHUMA0EVhec+sg/uwK0QRzMdLtxvWOdfKW4nTje7T12sZ8FSF6iwJzaGUxSbEk31SLl7TVtzv93/Cf/3lxskD+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=lezxuHGx; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=lezxuHGx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=xieyuanbin1@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 90572 seconds by postgrey-1.37 at boromir; Fri, 06 Feb 2026 22:15:05 AEDT
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6s2156tlz2xRv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 22:15:02 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tDEI/GWRahi2pE07GC/9TD0gUS6wvtKdDT3TaBlKGLY=;
	b=lezxuHGxlUbsrVX5E0KPypi3S3tpedzQjpSz0VpySP5gZ2fRyQyVc1KcqNT4guABEZKJ/NQS/
	Fbo+bmAJxyoY6YmAGI9iGq9i1p1o20j3scjByeiMXWjcRPA5Dcl2NiDa3J5ypaFqUd6CVaY4jmr
	MFibONHmoaFlDfxHojq8Vms=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f6rwx5CW1zpSx0;
	Fri,  6 Feb 2026 19:10:41 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 13E0F40538;
	Fri,  6 Feb 2026 19:14:56 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Feb 2026 19:14:55 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread compilation error
Date: Fri, 6 Feb 2026 19:14:17 +0800
Message-ID: <20260206111417.69177-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aYTH6A2rZQ4Ky-PL@smile.fi.intel.com>
References: <aYTH6A2rZQ4Ky-PL@smile.fi.intel.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.109.17]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Thu, 5 Feb 2026 18:40:08 +0200, Andy Shevchenko wrote:
>> For strnlen(), if the compiler detects that the maxlen argument exceeds
>> the valid memory size of the input string object, a compilation error may
>> occur.
>> 
>> For lastest linux-next source, changing ppc_kallsyms_lookup_name() to
>> __always_inline,
>
> So, there is no issue in upstream without the mentioned change, right?

Yes. However, before the commit 889b3c1245de48ed0cac ("compiler: remove
CONFIG_OPTIMIZE_INLINING entirely") is merged, inline will be changed to
__always_inline, and this error will be directly triggered.

