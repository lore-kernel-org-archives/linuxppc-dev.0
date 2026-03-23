Return-Path: <linuxppc-dev+bounces-18566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46937D58CBE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 02:15:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffGx674tFz2ySb;
	Mon, 23 Mar 2026 13:15:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774232154;
	cv=none; b=jxtdlK3z7OPMkUXAuhOo48v6nfvd4fyezCRh836BQP4UsnFFum+pigtLdjnXGTFuDeGpdeCFfGkZIVGoIjKYjDXYoO9p7bHI2yqLuoXzyc/KLDJFeKmJsV3DAmifGyFt6iKPqOurafz2RzvSUNvs/xQHBTiArtwlcT2BKl0YePqQL6V6bQXGQ+RdnnJBwl8VWJt9JVvyUkGLgBTVHv1cVgcvOUyH4/Yg3hA0y8d6GUkIsOQ1Miiemjr/WgkbQuUH8fRLUmsmbGSvnXUlZZK72FIcNefyNdC9KqpP+qH40cHbOCX5ksczXoQWpBaE0Iaiocho8mhMAHgJSBckbAMZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774232154; c=relaxed/relaxed;
	bh=R5jIawgYWsUZf+zva/5Ugy+eZOQoWT60xSBcueOhzu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TtuVtYykAhgP6z0HmAoPxVACMfjUBh094nhONmz5l7EmM/6SQtn0vVbzy30a8fuMpIX7uXzJa0AQ4J90yB1ZCdOBJN3PjNlbIX5+lX9S/6QsfpoGeFKklsyAhzP6Luk/f8BZ3BqiXKSaxTL6dg7OJnaeUdZ7T3/Q9dURUirse9AwUdGgyDQlrLnSRl7uQnZWg3WVSneS8aPAevcsJm48pD4rh5Gsz8NjH2qpnpGnv8YeWrKJURLsG/TekW4a4o9dOMhAa5xjWOtgTYd55Ueb7t1jCLoTQKxSUetzgCl4oGuE2qtiL1NFhxMYVDfP+5GSljmyJIXr6gJS80EOCrQR3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y3Xbkkm3; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y3Xbkkm3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffGx43yWPz2ySB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 13:15:50 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=R5jIawgYWsUZf+zva/5Ugy+eZOQoWT60xSBcueOhzu4=;
	b=y3Xbkkm33OuzIVeOTkvy3KpKEPcdf2aDbqAe3Lg6LRtI41eVGLOzLzEHaXMCw85OESY1/4bI2
	bPphRkVD2M+iRz/lb01qPoNmCTKGtBzHctxQ/gkE4GpAhkYl12sCafXE+ut9iIm15PjCGESUiss
	J6rjzuriAJCkMeqt9jfnwnw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4ffGnw4XfYz1cytY;
	Mon, 23 Mar 2026 10:09:40 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id F0BC0402AB;
	Mon, 23 Mar 2026 10:15:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Mar 2026 10:15:39 +0800
Message-ID: <e666d76c-cd76-306e-a6c2-232c6815271b@huawei.com>
Date: Mon, 23 Mar 2026 10:15:38 +0800
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
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <dapeng1.mi@linux.intel.com>, <kees@kernel.org>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <fvdl@google.com>,
	<rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>,
	<sourabhjain@linux.ibm.com>, <jbohac@suse.cz>, <cfsworks@gmail.com>,
	<osandov@fb.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <brgerst@gmail.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
 <ce99a024-f910-cd83-c60a-28e60db318d3@huawei.com>
 <20260322185853.e8e43c346ed98a0ef0544948@linux-foundation.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260322185853.e8e43c346ed98a0ef0544948@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/23 9:58, Andrew Morton wrote:
> On Mon, 23 Mar 2026 09:44:21 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> If there are no other review comments, I'd like to ask if this is ready
>> to be merged.
> 
> This patchset predates the introduction of the Sashiko AI review, and
> that thing is proving very good at finding issues.

That would be good to use this tool to find the low-level issues.

> 
> So can you please update the changelog footers for thus-far-received
> acks/reviews and then resend?

Sure.

> 
> Thanks.
> 
> 
> 

