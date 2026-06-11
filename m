Return-Path: <linuxppc-dev+bounces-22435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF91FCD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 01:31:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbQ8Y1SQTz2ysW;
	Thu, 11 Jun 2026 11:31:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781141469;
	cv=none; b=Ji5olsIs40JwvG/dmLa1BWqwpR18yGq6JBNSZSnpz866yhDa5twbQftQP180gKlJEfLf9zxXJvNw8xIgu8VXXMVFe7FNaxvxnByy1zM8oeEilzQ398fnWuLudvC45loAa+rzirunNWIdgtcIu5ExOab7Ovq/NfAH9jW6udSFKkdT3Q7t2m8tZjcldI6b14u23TL8AQZvqEGDCJ3g5ZIzaNR4xytgA9XwFNkNHyVt8B2VwhPFtZpINtCyKPFPPImDzLvXd/Hr2VMvDtBO0hUYUuPzyis5N4gZXPw6ytYlBkaCxf3zQLlpo8C3xSUg4vdVejtj4Blm4yLRRQVXuetnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781141469; c=relaxed/relaxed;
	bh=RBlgvudl+cGjprXWFObeeRS2MUnS8N5YzsCKOc0pnqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fpSI1h1FSZ3lVWhH6Quc1TPA6rWMQYKptyWMhjmmhdk3eJfv2N7z7uCqkyq1yoZGSOc6eBM5Zp4DjTHCX1s7L5trXinVfdTYmBXrVqh8K3j3BQFiFNlnjAIznVF+hiNk1oN9n0aLp+DA1dVIKLN0W3MgWqFykEwQimlKf1MsPP4ndjUxvVnnYxDRNfkX9Nu/T9abJHZOxy/+cVyBzwLzJIfm1QE4o9NYnALshVUXG5PWoUhdBvHo67DtwHi1BiXBqwOSCYzirBcQZtkwKI3IdqJmNM7EBGyd9vqz9YQWmyluuyHI9ognQZq5Ja9Px+fZwHXw/Jzxjhbo4hOEg2+MsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3gZH/hNn; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3gZH/hNn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbQ8V441rz2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 11:31:04 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RBlgvudl+cGjprXWFObeeRS2MUnS8N5YzsCKOc0pnqk=;
	b=3gZH/hNn+g7QWrpLfYH3VIVhOi+KC+luwjGIe9WtEed6xfgF9PTswIocwyjpaWEgUrlrl483x
	xRsRvhaB6WhwMvFr8+me5PjwErrqXqd54SKqfYa3Ow2i+D3OOZmZcCexoeWlyy5YNsYoV0Xjm9e
	xyc3UBr9eQflKVxitdNqgYY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gbPys18dZzcb1Y;
	Thu, 11 Jun 2026 09:22:45 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E7252025F;
	Thu, 11 Jun 2026 09:30:58 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Jun 2026 09:30:55 +0800
Message-ID: <37f31716-095b-477c-9b0b-946a15275c2e@huawei.com>
Date: Thu, 11 Jun 2026 09:30:54 +0800
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
Subject: Re: [PATCH v16 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
To: Andrew Morton <akpm@linux-foundation.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>, <bhe@redhat.com>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<lirongqing@baidu.com>, <ebiggers@kernel.org>, <paulmck@kernel.org>,
	<leitao@debian.org>, <coxu@redhat.com>, <Liam.Howlett@oracle.com>,
	<ryan.roberts@arm.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <guoren@kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
 <20260608091000.d88d7f5cc1bc4fa17f5774fe@linux-foundation.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260608091000.d88d7f5cc1bc4fa17f5774fe@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 6/9/2026 12:10 AM, Andrew Morton wrote:
> On Mon, 8 Jun 2026 15:34:49 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>> and crashk_cma memory are almost identical across different architectures,
>> This patch set handle them in crash core in a general way, which eliminate
>> a lot of duplication code.
>>
>> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> fyi, AI review might have found a bunch of issues in arch-specific
> code, all of them pre-existing.

Hi, Andrew，

As Mike conveyed, Baoquan proposed splitting out the unrelated bug fixes
into a separate patch set, in order to keep v16 from growing excessively.

Link: https://lore.kernel.org/all/ah2Lx7KHI60tzd0v@MiWiFi-R3L-srv/

Best Regards,
Jinjie

> 
> 	https://sashiko.dev/#/patchset/20260608073459.3119290-1-ruanjinjie@huawei.com
> 


