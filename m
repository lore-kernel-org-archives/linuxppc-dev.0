Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B38C433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 12:12:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD1E60EBB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 12:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFD1E60EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSd333gfyz30Bl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 23:12:31 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HScxr4YqNz302N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2021 23:08:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScxq0KxHz4xqd;
 Mon, 11 Oct 2021 23:07:59 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: paul.gortmaker@windriver.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Xiaoming Ni <nixiaoming@huawei.com>,
 stable@vger.kernel.org, oss@buserror.net, benh@kernel.crashing.org,
 chenhui.zhao@freescale.com, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, paulus@samba.org, Yuantian.Tang@feescale.com
In-Reply-To: <20210929033646.39630-1-nixiaoming@huawei.com>
References: <021a5ee3-25ef-1de4-0111-d4c3281e0f45@huawei.com>
 <20210929033646.39630-1-nixiaoming@huawei.com>
Subject: Re: [PATCH v2 0/2] powerpc:85xx: fix timebase sync issue when
 CONFIG_HOTPLUG_CPU=n
Message-Id: <163395399480.4094789.15095321874781475669.b4-ty@ellerman.id.au>
Date: Mon, 11 Oct 2021 23:06:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: liuwenliang@huawei.com, wangle6@huawei.com, chenjianguo3@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 29 Sep 2021 11:36:44 +0800, Xiaoming Ni wrote:
> When CONFIG_SMP=y, timebase synchronization is required for mpc8572 when
>  the second kernel is started
> 	arch/powerpc/kernel/smp.c:
> 	int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> 	{
> 		...
> 		if (smp_ops->give_timebase)
> 			smp_ops->give_timebase();
> 		...
> 	}
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc:85xx:Fix oops when mpc85xx_smp_guts_ids node cannot be found
      https://git.kernel.org/powerpc/c/3c2172c1c47b4079c29f0e6637d764a99355ebcd
[2/2] powerpc:85xx: fix timebase sync issue when CONFIG_HOTPLUG_CPU=n
      https://git.kernel.org/powerpc/c/c45361abb9185b1e172bd75eff51ad5f601ccae4

cheers
