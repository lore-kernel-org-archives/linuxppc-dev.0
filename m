Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE73606A323
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcs+Y9EP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZFW52B1Xz2xJT;
	Wed, 25 Nov 2026 20:58:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795600721;
	cv=none; b=onEYiG65drsVBo+j3m+/3xRpA50uIhMbbCLey3sHOxEskwwIU8ma5aaxsBGuP3QxA+8z8ytDzQ5rxoDQB22S59VTGqopCKtJ84p1zQ9nJupxcU0efNC2VpKL4w8J6b97BfyCdATsolakbT3+bj6og+G4JCAyLZ50evk7vuRFOYPdrWbNchZu3VA89qDrTrO+FTqgLMVytF1BDcRrEloIylvxrRY6FKMoK574Tu0yrkyWLp4dWQQBuCTJj/8sab7SfpJn4+Kd6DnI46tOHGLjJMr7Co1bdYaCV3uZYJprf/rrdWhIBlovirQnauUyLX0NEkKjcgNQGDMk8TEodklN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795600721; c=relaxed/relaxed;
	bh=1UD/fxzUT0tjfssdFOdd5M1pCrEUV3tIjK+qrLIpIpw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=JXdJ+bBQc/opr1QWZ9SQibyxIIyerUlN9prnYt9O8w8xWoHWjBVUnO3DHkG9JHT8B3ZCwVq60Yb5tD23J8PB4FEHHFPMmMZJSwCVQ5TTBvWZcS1c87QkuRD4pUnT3MzvJbS1iOJoLDLKyiwGDCwPWE7dMzlcJfVO9ZUutrt/Gb9u5RvH/6w9uTy/CLvT8GVdgLzo2Eq/8NaIsco3xbAGuE6esM3bux2dryZzvCJNQD4gS89VzTmuBWE1gI3MMw2bRqZWyS7kBLN0amZ4JsPSZdu/b2Qd87B5pZ/jQ4X0+Onp6zqRzifjlnZysWYtGIyZVQD4GLnytk/g+0TFdyQ4dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcs+Y9EP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcs+Y9EP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZFW41dKCz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:58:39 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-386c71feeeaso1831972eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 01:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600717; x=1796205517; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1UD/fxzUT0tjfssdFOdd5M1pCrEUV3tIjK+qrLIpIpw=;
        b=qcs+Y9EPt53wn0QNEESWbBx1zggxnf4W3qwiWPTSFcsK/MkcnB7Q/cXy7GbWcsNnjH
         sdoOE/BJUgRwoIm32SEfESMdlbXwkkmkAaMgY5aNkWrOr1EjPDHPNsOYZGFB9wQDcuCP
         WYRhz6T87RuPX1xCSkYxEqhtUurVFajYnhg8Q+KxBA+VGUghuXrMZI3YXhTBw547FawB
         1q1CqRbVqeSAjlSOjkh0LOSv+WptsiVRoOyyrKBp9neyEkVg5Nt4k/xttea4IuOQPLKO
         cP0MY3Et6alMybACvKyikVKSR9xadQTetqeuNyDg/rKeGUR4bf8iG4pFB436xKs352uF
         r+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600717; x=1796205517;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UD/fxzUT0tjfssdFOdd5M1pCrEUV3tIjK+qrLIpIpw=;
        b=SaEEjcOnX7S7DOStuM84TJ0rbSubFS1BzIpyu60PPgEfXy/yT6ycqU8ooQ9VnsXwUu
         t1jy/ccYn8aQnT83S28bX6r3WP4vjAlS59zzLgkByiqZRU2O7ohVkZjzmW6tYba9O35p
         qGTmF9o5onZU9HtFXU0Hh1C2WccrS8p79sC9XnpA/K1H5TsJvXzPdL2KzwGYwdjafRH4
         WRVilS6uRVjQS3rlg8Z5CVrrzLrY2eWUYcU+pIHw5iOUfeNrB2bbJ6eYjvndEnAOMcCx
         mBTTWgz4uzhodaUMni9P9SYF/OUyFik0DRVZELc2p7dCVrfJhFQD67x2rW/+snTSeVaK
         gjow==
X-Gm-Message-State: APuU4Z9nuxT4q4qAwICXHZ9IcId19ECU+RCAzo7a1R+4K09r17Edvoxe
	4FhmY8ApkBZozp70Bn8sVjzLocBjrJbdlJ0XGqNaggASCxToV6HavHDlDHrmTw==
X-Gm-Gg: AZFdTZfDxNqFoFOQDF/+CuMid6hMfc+p315zxUlX7htlqK+0NTrK2bMskAzJwkTac9p
	+bhJJs4qhuHtC1j7B8uOp2JzC/7HEBHNYTwnbaK5tUBQQ1pXftFHfJ+qLigKWIBrzaiSaJhS5OX
	LsQrluLobjQdba998DqaF2NVk17EJyDXG5hsRFtVBSxLyDzsE29U5YRgCTajEdIfxn8TG60co4G
	jWSoOfUgIEJoHBZXBFc1YmqFlqVCMPIXxjq1jA71JKeW5LEN00Chx65fCxOp/Ed5mb2AMY2ylKx
	VxIQzf88QMR+yab0ZtVnhZ478UPi7VKOfNWsLr8VT9GYVaQuX1BoJosQ4ueJhzEiXpecXxe1cLY
	vCTG5FbsutLCLPMiAMMF1Gi2bq2xgPu4C1ex1lTTHigJhC+J1CHZs01NfoHAjBt1LAe8WIPkae7
	rn027Jn5OY5kmpquu490QbBLtY7ncI6hp3sKXWknBAUTLhk6H0vRPiEx5rUcv4FpQxQg0aM9kAD
	5KzC2pD2ThqlZMg/WlIXeSFwxtZJjNlpJnEe6yF6+BIXeaQg4oH/RwqaU6AYuj0S0bhrvUqQXlq
	/z2QZkuWT3ZQJnUkKpdLfZQa9FsA
X-Received: by 2002:a05:7301:e103:b0:385:496e:80ac with SMTP id 5a478bee46e88-3856fe59334mr19973566eec.8.1795600716629;
        Wed, 25 Nov 2026 01:58:36 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm26470301eec.18.2026.11.25.01.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:58:35 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
In-Reply-To: <awZ4ZhK1GFHKi9Tr@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Date: Wed, 25 Nov 2026 15:18:30 +0530
Message-ID: <pkvtjl75.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com> <awZ4ZhK1GFHKi9Tr@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:

> On Mon, Nov 23, 2026 at 07:21:53PM +0530, Ritesh Harjani (IBM) wrote:
>> kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
>> gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
>> perf_pmu_register() fails we return without freeing them.
>> 
>> Call kvmppc_cleanup_hostwide() on that error path.
>> 
>> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
>> index a58634f656e9..ec05b4855736 100644
>> --- a/arch/powerpc/perf/kvm-hv-pmu.c
>> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
>> @@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)
>> 
>>  		/* Register the pmu */
>>  		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
>> -		if (rc)
>> +		if (rc) {
>> +			kvmppc_cleanup_hostwide();
> Just a question.
> Inside this function, should we also take lock just to set the pointers
> NULL rather than putting the whole logic(free also) inside the lock like
> we did in previous patch?
>

In the previous patch, we brought GFP_KERNEL (sleepable) allocation
outside of atomic context. However, in here, there is no harm in keeping
the lock to assign the null values to pointers. But I guess what you are
suggesting is - Do we need to keep the lock around in the cleanup? Looks
like no, we don't, since if the perf pmu register failed then we won't
get a perf pmu update event for this - which is the only other user of
this lock which can race.

However, this patch is mostly an error handling fix (reported as a bug
by Sashiko). One can pickup the cleanup of that path as a separate
patch.  There is also a powerpc wide clang's context analysis work that
is going on, so as part of that - we could maybe optimize away taking of
the lock in kvmppc_cleanup_hostwide() as well. As for this patch series,
I think let's go with this, as most of the patches in the series are
with Fixes tag to be backported.


> Apart from this, all looks good.
>
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Thanks for the review!


