Return-Path: <linuxppc-dev+bounces-26608-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E86C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 13:08:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcYYL1MYcz2yv6;
	Sat, 05 Sep 2026 23:08:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.169 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788613702;
	cv=pass; b=Zo18dQbun7h0ZDhXLYr5PX+D67v2pipQF73zLXg5CTPl/ZXfVwxkklsBdDcjmsFLuxdSczKsgk0YnzK9niowXflIsvnvjHq8dNnHmQLHCp6JuIiuoKwIscn6LyPShigYOm4MNjedPlJvNyj7QTgJbbYuAPwZ97hhqMe6JNgXCoYs7yHGqZfPmUen3kbwebiZ73UWD+336EwclOeNFJmoDQu10VEhMMD8hQ2A3dkD2eDSJ5U6wuOQx/SJfBeIP7YY/q5HzCK3LlhcNSQ+sSoKK3rBvBu73S5I+Vk1Gzo5byYw4fqclq5gSdGvss+QJVE+lAD5qPqyR9U6zva+7yyeIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788613702; c=relaxed/relaxed;
	bh=SHK3JGx8nDPodJFCEjuJ2vzLkxuVZe5qvUUhwhpjugE=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P8cKtk3QkbT70ggProyuTAHv/E/veeyjZt9jJ1VsE9tJPNDZbkufJIvyVkOU0ml0fW3FfOAQjhT6R6OKYHN5BT0om9jO6qm9S4cvau0VZWkytH2g5hIljJ1QkkUuHyMuHSR/j+GHldfDLGnVT18MiaGmXDYUpOITk06w9ibzzLWZSxBB8BhIAjCbusy+aaGD3sb/vltLPufGGL/UnukItKOaXJ5QqOcqcPsWjwFhhXvCuSjhYSYnwYyD8B1S57CaEANPMQneXRTDBZIfakBpuNfOi5aimmtIbNTZmbuzAFxICMbYJCytPez0L0JBltLReia0f3qxSQf680p+31R4CQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=n7GeONDX; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3HKwXrM5; dkim-atps=neutral; spf=pass (client-ip=81.169.146.169; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=n7GeONDX;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3HKwXrM5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=81.169.146.169; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcYYC1s75z2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 23:08:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1788613662; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZmjsFKyc6iADtsCILwpsfYA4hwbCaHBojFfYZ8Tk7uHZldhaA/nNNiRAZSqmMV6mbx
    +33k3pGJxPDirpO4JmpJdK2yYqx36XU4cLSQakPRYfwL4iFVMk68y99eIIjpNI7IecQ/
    0/ZLzOBbMdbc8x8NGekqfPJWMkxxWdBGqVtyS8Pr/pqNE335EJ66BmbZVlI46c8CGoT7
    gVKMTPxgBBhSIH6stwJ3m0a+Wrl9CTnPmnYBMtT0WYWyOCNd0x8I3FiOYm6eDaG6mPuw
    hVqxgYv4cBCPzhhvEtLZyrpAwMQITOsSVjiZgf0OK9b0xmJizrQIMW4fQrbiQXpki1Zj
    lbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788613662;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=SHK3JGx8nDPodJFCEjuJ2vzLkxuVZe5qvUUhwhpjugE=;
    b=HHcebYzDD+z5Pr63nVeSXq29JUHJ7XPcLG0GmEw4D3t2qIfUCxp3kvhmA8xJNaaWm9
    7qtsclvNsTYaS1V7n/tAVqqVp2ebZvQdNXRQl80r0z7NgnMapJxrARTuHjFFkqFELLnj
    V1uuqxqAqKOKXHiY+ZHk/m+ooCtN2jDkPcGZXzYsFful+yVQmrUWB7FbdN6Pe2MbdPy8
    Ndwotvmu63bcO9ObzIYgDI0P10RvcavrrOCPogzlfu7dvS/dCM1y+1ZUkT0kymUrjlXU
    620I9Z6cXB94O7TFS94f83Fj3yl/MjrVqaabpnacYtWJwHomoUVFvZNu4t5DXPCKkyT0
    DFKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788613662;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=SHK3JGx8nDPodJFCEjuJ2vzLkxuVZe5qvUUhwhpjugE=;
    b=n7GeONDXMeVqtXsXnVXhPp087rx6Ux1N7BXEWVzGVPwMtEeB+qDKW1SySh4271iUpH
    FtP4H0FQZSuxi7UGTkJPK3dEzIvQhDg1LzEnnaeoz1nQT9EcKThNDOy8XIWOTv4eKOMW
    HpJXj2/04XODN5XognIpidLbi2W16FWEhbBZgDMdhAh73FTXnN1FjLk2CnImukJofRD6
    GAOqif8e8VTRH702+x34CaW1+NCyMThjCSpbJZvtWNx7qCByY4HjFIMP1NnHvr89zfil
    KUrx69iO/NMmNoL+vm98HftPe5D5Zpq5jZzAcH74chE5NjisyxI67X9Bv16szFONuegw
    UQ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788613662;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=SHK3JGx8nDPodJFCEjuJ2vzLkxuVZe5qvUUhwhpjugE=;
    b=3HKwXrM5ZN0Dg4ZQSdmC97LraV9NGk/nL6MGhknk7pUzyTLtwJ6z3LJ8YB1Z2Yldil
    hBaaEPdWVWGtsIHS+UDQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+m6Xc="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee285D7fAez
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 5 Sep 2026 15:07:41 +0200 (CEST)
Subject: Re: [Linux PPC] Disable PREEMPT
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Christophe Leroy <chleroy@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 hypexed@yahoo.com.au, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
References: <af7a8fa3-8ac8-4b97-bff7-5257867e7209@linux.ibm.com>
 <0B5355D7-4FE4-4B16-8ADE-CBB05A1D6C16@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <25834fb4-ac52-01f3-11c1-c277af5a4c8d@xenosoft.de>
Date: Sat, 5 Sep 2026 15:07:40 +0200
X-Mailer: BrassMonkey/34.3.2.1
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
In-Reply-To: <0B5355D7-4FE4-4B16-8ADE-CBB05A1D6C16@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/26 11:34, Christian Zigotzky wrote:
>> On 04 September 2026 at 11:24 Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>> ﻿can you try with latest code? maybe 7.2? there is usage
>> of generic api to handle the work now which renders the patch shared long back
>> which you tried irrelevant.
> Thanks. I will test the RC1 of kernel 7.3 with PREEMPT enabled.
>
> - Christian

I compiled and tested the RC1 of kernel 7.3 with PREEMPT support today 
[1]. Unfortunately the issue [2] still exists.

The entire FSL Cyrus+ board freezes when using KVM HV with PREEMPT.

I will disable PREEMPT with the Kconfig.preempt.patch [3] for the RC2.

- Christian

[1] https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc1-preempt
[2] https://github.com/chzigotzky/kernels/issues/19
[3] 
https://github.com/chzigotzky/kernels/blob/main/patches/e5500/Kconfig.preempt.patch

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


