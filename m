Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4D606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UBYNtf2f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJjXL0cHbz2xMQ;
	Tue, 03 Nov 2026 20:12:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793697169;
	cv=none; b=CqwIRj1S/p8XOarBvE8FcPD+JvnyAJu/cKoBaoAnp0gLKv9+ZmXR9vPvmqI2JXLR7aZQOaMarQ+OnHVc9jJSCIjagYjJh6XwybjtHIo6spnsfvX2nWFJGeZ5Oa1vHgc7MZISMxddo4Ec4ilJmOfBlDgDJ7dTzV3+/A1XElXj83PMjO1uv+yLmlkBaQO0hAq0eFc6rUePmCFnAndt2k7PxltPbrXN4QyY3faabGgKJtGSwIkTB2Zb7Ro7/2knpkW3ccq0MbsgItBQgIZCtSMEvyqMymHidOfwD3W7cTfEcpaXaw3OzBUVaQI3CKDbR7MdW54afW9qKhUhXawj7ABA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793697169; c=relaxed/relaxed;
	bh=OYP/jrCpbZUv5s67bKRUA8Uq8znYrrO3Cdq0yWmKstk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NZvu0zwDUENWknqPT6duvEL5gaeU1F0sMuqB/C3o49P2DCiHIiShtKhr2x41wmwT9rTTpDdbBX5DX+8mhK7UmdDV3S2h6mXWXwcjD/c95ZhZXZ5SfNh5ORwAGfmfE0Ri7+kmZ2tZGvIQPTMScCegyoFQNG0GtQli3EqXgNs2uH0f4fdR3K6ld9I0qtSt5UPR5nZf7g7BSlp9lnFVJMpoOVqi5JHQtbyv7BCEivOl9R8y/DW5K3Nb9SX8V/8/2we5zMPC3gOLEJi2rX3MICrQ1Bwetc4dJDg+vxRFv/VBChPhDzqAX5983oDJA8bdUJh0vs5W4RY6aqel0H6ICTJY9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UBYNtf2f; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UBYNtf2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJjXG5qscz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:12:43 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OYP/jrCpbZUv5s67bKRUA8Uq8znYrrO3Cdq0yWmKstk=;
	b=UBYNtf2f67DlaOnb9IoYrGANta2eJfmSw/mIKFkMaKnEeyTFIzSpzB2ud3NkTLfmMnvj18r+d
	jXlWHO/J3axedY3/y8VSnPPtF0ekjTEJ2H+t05qN6hJub+uZ3jxVLweYCmMkVJ0tlQPL68jEgOW
	FZpbzTyoeBFsV8vryL5DQZ4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jJjWs0hd0zLlSW;
	Tue,  3 Nov 2026 17:12:25 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B46F40586;
	Tue,  3 Nov 2026 17:12:35 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 17:12:34 +0800
Message-ID: <7b68ea3f-23ba-42d1-b719-70c0fabf26cd@huawei.com>
Date: Tue, 3 Nov 2026 17:12:33 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/crash: update fdt on cpu hotplug remove
To: Shivang Upadhyay <shivangu@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <ritesh.list@gmail.com>, <sshegde@linux.ibm.com>,
	<sourabhjain@linux.ibm.com>, <rppt@kernel.org>, <baoquan.he@linux.dev>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>
References: <20261103085319.51480-1-shivangu@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103085319.51480-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/3 16:53, Shivang Upadhyay 写道:
> Currently fdt for crash kernel is not updated on cpu hotplug remove,
> which can lead to the following XIVE warnings on the crash kernel
> bringup.
> 
> [    0.630795][    T1] xive: H_INT_GET_QUEUE_INFO cpu=16 prio=6 failed -55
> [    0.630912][    T1] xive: Error -55 getting queue info CPU 16 prio 6
> [    0.680899][    T1] xive: H_INT_GET_QUEUE_INFO cpu=17 prio=6 failed -55
> [    0.681000][    T1] xive: Error -55 getting queue info CPU 17 prio 6
> 
> Fixing this by updating crash fdt on cpu hotplug remove path also.
> 
> Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  arch/powerpc/kexec/crash.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index 775895f31037..0ef10e39ae49 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -639,8 +639,6 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  
>  	switch (image->hp_action) {
>  	case KEXEC_CRASH_HP_REMOVE_CPU:
> -		return;
> -

LGTM
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  	case KEXEC_CRASH_HP_ADD_CPU:
>  		update_crash_fdt(image);
>  		break;

-- 
Best regards,
Jinjie


