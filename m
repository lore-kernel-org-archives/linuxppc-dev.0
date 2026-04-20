Return-Path: <linuxppc-dev+bounces-19844-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3C6F36C3A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 07:26:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzcW20PNKz2ynn;
	Mon, 20 Apr 2026 17:26:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776670013;
	cv=none; b=bHfa6d+69ltQ+GPkkRmBKJaHnDOrgJovW/axGGhSqAWDWuhtuuZ9vTY0uMOygKbJyeGW6bxw69MiGisAFhJkjC1A0jEVxgjS4AHjuBqpM/3EN/CZuNhSGqxXKUoJ/KuoMniZ7aKvA67w5SdGKYQhGiTep6Q8J6T935fC2ZSOAMzPicUZbqgUCaT354bqzx2SEzos0YDSszaIgQ1wd88mm8plncHp29C+VFD075QLVF77Ik/anwf49vOGv6gMUkyejY6zCu1m3272CP6AR15bc5n780buQp4355H/i2nH6Jd4cOn6WkQY2GO/T3OVq3XRg6jKhHXt+J7yIX5ZOZGV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776670013; c=relaxed/relaxed;
	bh=hkO6Nc68R7AMJu+lA9Su51P8nuTpDZ4kPudBZi+bg+8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jC04pcPytS9HaYH8zkEyq0b9Uf5Jek2+yiS7+7BS4cP0vbjpdIQzwisjsbLCwrZaQxR/gbBTzTg82Id7arEckNJvROBcz7kv0rQg7cadH5EGoEO+cEU0bAylukSBZpBCwCjXUxwXtnm37nn22Ei+tkmHuIbVHZXaw3pJRSLGzAo94dqbypYTe75er6oPNHXWJYPEl/+v2ueH3Siz/xF/j4OrakVnL0J7QpssTZ0OTwAQAsRm78O1gbN1w08JdMCsBbQ7O6t0jzGNXenqHCUJdIDM0vKDS3FjTeGq8EeFpQniioVSlI1LiEjHxHFhV2AqPK49KF9YFUxhLuow7SWRTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FIuFuYZx; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FIuFuYZx; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linmiaohe@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FIuFuYZx;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FIuFuYZx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linmiaohe@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzcVz2wfxz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 17:26:50 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hkO6Nc68R7AMJu+lA9Su51P8nuTpDZ4kPudBZi+bg+8=;
	b=FIuFuYZx6PMxQ3fAVUZLYpHeiTSRPTIcJ20Ubhiz5fQF+InL/Iuja4kC8IcH3zRZ83hzoqqXY
	7j+swclZ2tWYU+DN9STn+/NZ1ogv85AdvFPfR14qbKswsVaeXuEnFwkeF5BL40b4q2Rw4U00Ui3
	zhpcdX1FjCecB0RuFlyEJDQ=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fzcTx5fNHz1BG5p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 15:25:57 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hkO6Nc68R7AMJu+lA9Su51P8nuTpDZ4kPudBZi+bg+8=;
	b=FIuFuYZx6PMxQ3fAVUZLYpHeiTSRPTIcJ20Ubhiz5fQF+InL/Iuja4kC8IcH3zRZ83hzoqqXY
	7j+swclZ2tWYU+DN9STn+/NZ1ogv85AdvFPfR14qbKswsVaeXuEnFwkeF5BL40b4q2Rw4U00Ui3
	zhpcdX1FjCecB0RuFlyEJDQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fzcML0ljLz1prN0;
	Mon, 20 Apr 2026 15:20:14 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E84040569;
	Mon, 20 Apr 2026 15:26:38 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 15:26:38 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 15:26:36 +0800
Subject: Re: [PATCH v5 13/14] selftests/mm: move hwpoison setup into
 run_test() and silence modprobe output for memory-failure category
To: Sayali Patil <sayalip@linux.ibm.com>
CC: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, "Michal
 Hocko" <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
	<Liam.Howlett@oracle.com>, <linuxppc-dev@lists.ozlabs.org>, "Venkat Rao
 Bagalkote" <venkat88@linux.ibm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>
References: <cover.1776150071.git.sayalip@linux.ibm.com>
 <ec5a0e5e98c4fe55b8571c408ca891bd02208cc3.1776150071.git.sayalip@linux.ibm.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bdcb1965-d59d-4cf8-d79b-a7997012aac6@huawei.com>
Date: Mon, 20 Apr 2026 15:26:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
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
In-Reply-To: <ec5a0e5e98c4fe55b8571c408ca891bd02208cc3.1776150071.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.124.160]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/4/14 16:22, Sayali Patil wrote:
> run_vmtests.sh contains special handling to ensure the hwpoison_inject
> module is available for the memory-failure tests. This logic was
> implemented outside of run_test(), making the setup category-specific
> but managed globally.
> 
> Move the hwpoison_inject handling into run_test() and restrict it
> to the memory-failure category so that:
> 1. the module is checked and loaded only when memory-failure tests run,
> 2. the test is skipped if the module or the debugfs interface
> (/sys/kernel/debug/hwpoison/) is not available.
> 3. the module is unloaded after the test if it was loaded by the script.
> 
> This localizes category-specific setup and makes the test flow
> consistent with other per-category preparations.
> 
> While updating this logic, fix the module availability check.
> The script previously used:
> 
> 	modprobe -R hwpoison_inject
> 
> The -R option prints the resolved module name to stdout, causing every
> run to print:
> 
> 	hwpoison_inject
> 
> in the test output, even when no action is required, introducing
> unnecessary noise.
> 
> Replace this with:
> 
> 	modprobe -n hwpoison_inject
> 
> which verifies that the module is loadable without producing output,
> keeping the selftest logs clean and consistent.
> 
> Also, ensure that skipped tests do not override a previously recorded
> failure. A skipped test currently sets exitcode to ksft_skip even if a
> prior test has failed, which can mask failures in the final exit status.
> Update the logic to only set exitcode to ksft_skip when no failure has
> been recorded.
> 
> Fixes: ff4ef2fbd101 ("selftests/mm: add memory failure anonymous page test")
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

