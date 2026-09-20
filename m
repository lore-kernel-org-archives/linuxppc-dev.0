Return-Path: <linuxppc-dev+bounces-27791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF9EC982DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2026 03:14:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hnWfq4W2Hz2y8G;
	Sun, 20 Sep 2026 13:14:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789874051;
	cv=none; b=LO2GbApB9OwPLmsPScWXoGFeVaVZS/t2UinKZ09+rYt84WdNf3GKzGFQfDaoOojvbmdURiZCVt3U9CzbZ8S292GXpHHxb93ihVP6jEtj5WNsa1AhJgg+EZVJct5qZtzI4I5FKcd8gddCBC8nc52V49gb/bvDuytV+6JiRzPM5bQyzk5aMzJ5MHkWVcDNK5XF2lNOofd6Z0AVKLoZbs5fu9ZklZIkEzhI2I1Jwebl+m4b7ZrFyqyKycp+BP5mlAe+wP8r+5MynO04FfAjKLaGFBNG6Hp/9yO6K2wPOSh4Mj+Lijh6pWXEN9U5TqHKJSuq2gzEG5HTMkdcoqVI6tPr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789874051; c=relaxed/relaxed;
	bh=Y6VD7DCnH5Wvn+wLxKkGYY5QQQQVDg52h78IKUBAQi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MdIY1WCckus+BQF4y/NAsXJNJGdHMmF9jgFyb/csBAPncUH/R1xhgex39J/78bncDGh/OHE3wJnpa6v/aY9v0+qvqIdKcTVrVUw+RvADp2SdnDxzxp2WDYxCZDIlnfuu9LCBVzC45bzDfp7nTaEf5g+bx5LSJsaFofRiwuBQMQi8yW3i+PsQJkh56QmrqxzLPN7FEbag4afyf6k3yVRJ/cStOflnqlfasDIUhmvgEMQ7tGZAu0Pok5UZp/eTEtXIp8tMotGgcCSFfo+/EXicaGbdgUGrRG16+V62YjQadC20G5tvy5SEwQIOTVJrdsF1IwvhycqU3nlYYpSpwJfHMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vdnPyXL/; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vdnPyXL/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hnWfm2pNCz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2026 13:14:05 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y6VD7DCnH5Wvn+wLxKkGYY5QQQQVDg52h78IKUBAQi8=;
	b=vdnPyXL/sZl6KsrVijZZPPrCyCxRV/tFodClDTuKzGvY6Af9QA/vmT7WI7iRz+JtR0iJaghc9
	rWMdPn+sthbDccaL/g5uqlDOWi+EKPS9b8rocHseUe3ni4l7EY17RAxGh2/pEBTk4sDiwv9WLI3
	CaDH9HqNKl1QubrRmWw4cks=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hnWPr3jKKz1prQs;
	Sun, 20 Sep 2026 11:02:56 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id C57E740537;
	Sun, 20 Sep 2026 11:13:58 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 20 Sep 2026 11:13:55 +0800
Message-ID: <97dce1c2-827a-437f-bff0-9c7057cc2923@huawei.com>
Date: Sun, 20 Sep 2026 11:13:54 +0800
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
Subject: Re: [PATCH v5 00/17] crash: Rework and add arm64 crash hotplug
 support
To: Breno Leitao <leitao@debian.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <ardb@kernel.org>, <james.morse@arm.com>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <robh@kernel.org>,
	<coxu@redhat.com>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<guodongtai@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <blum@kernel.org>, <adityag@linux.ibm.com>,
	<chao.gao@intel.com>, <kas@kernel.org>, <vishal.l.verma@intel.com>,
	<seanjc@google.com>, <piliu@redhat.com>, <jbouron@amazon.com>,
	<me@linux.beauty>, <mclapinski@google.com>, <graf@amazon.com>,
	<bgwin@google.com>, <eric.devolder@oracle.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <lizhengyu3@huawei.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <aq0UR62q6gGJUQ49@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aq0UR62q6gGJUQ49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/18 18:41, Breno Leitao 写道:
> On Fri, Sep 18, 2026 at 06:04:25PM +0800, Jinjie Ruan wrote:
>> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
>> image becomes stale, potentially leading to incomplete crash dumps.
> 
> Looking through the series, it seems to mix bug fixes with new
> feature work. Would it make sense to split out the fixes so they
> can land independently, and keep the new features as a separate
> patchset?

Hi, Breno,

Thanks for the review. I agree with splitting the series. I will
separate the bug fixes into an independent patchset so you can pick them
up more easily. Please note that the arm64 crash hotplug feature depends
on these fixes, so they need to land first. I will send out the split
patches soon.

> 
> I'm currently rolling out crashdump CMA across the Meta fleet, so
> right now I care mostly about picking up isolated bug fixes. As it
> stands, it's difficult to tell which patches are fixes and which
> are features.

Only the last three patches are related to the feature, and all the
preceding patches are bug fixes. I will separate them out.


-- 
Best regards,
Jinjie


