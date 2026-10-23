Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B999606C936
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AgZuoWkd;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eoDTpKVd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9ySr2Fy5z2ySl;
	Fri, 23 Oct 2026 20:31:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.170 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792747884;
	cv=pass; b=fXRxoYgfN2mO8R8QBjrAITTTFKfEQAVMRZaHnnwRroZvuSHmcOcljBDr6PtiMa8Uo05OSohPdnh9w1G9BsFjLuxmL1p3STZ4Egp5XwXCmtLrq3G6XslHRnhqpD30UocraJnLNOz87pM2zdDaDNCYrIHzxnXnHCeiIJFSUbdWh1Ub1711gAgSq8dvDmSVQPLg5BrlLcFmlSkWmmwoXeAQtO2ooHG5w+FizaoncmiSPYdtsMDT+PoOgtwp3XvdlZQFYSCwlcATUrZi5hqqKjR2NuLT6B0qsD6RQ5Cwho+Zd99xpnM4lWbKY4uZGj6j5ePxaXkPpmow8zJiaBBma4NPtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792747884; c=relaxed/relaxed;
	bh=4/JtPZxwY0peCYqrhbe/GP2Ebv+7Kymqi3t9iz/6G8w=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ktwySUD/dnVWdDe4OmsgR3nVx7Gz0w+WDiQU04T4CabjAyHqJdrjX8NtbDPMhF9LtkGuDUNiMMUvoEeybiptEXIM90cV9SqJJ2DBFsQSbGmKhXZfwc+Wy/WplKSy7cAYHZ+iGT0huosXG4fSTPTzRVNnwmgEHdWTFOAaCyEvfyG0ZDlmycnxRA6FGKLQv5ZqtSj1tUShuEX4huPc/VDulrh51cqKatfyBgBfNb7ZGu48/yiHYE5XRJMbTmtkKgRZYl3XZl/hIoXYvqh8jUYgH3DS38HzUHEU7MaUWcN/LLF3pJbrPcvbXoVOLOmwGqdAHCMdpzm6hX8OQ2PUIqwFgQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AgZuoWkd; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eoDTpKVd; dkim-atps=neutral; spf=pass (client-ip=81.169.146.170; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AgZuoWkd;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eoDTpKVd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=81.169.146.170; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9ySm4m9gz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 20:31:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792747868; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fXeXrPJYKiuSw1hm3b30uNLko62Rs3Mow6QbRxTkmfsfe6jSGCiNv7UmxeMSe7y+MJ
    mHgyJQPuYNdSdw9WsV7W9NTIbsOBe5No9JN4DwtTdW95yKAorhP/+vGq6K1/dCEEgR/j
    ccxG8R9DPnmCb1J+YY+Iye4Aa1xjFumBlA5jQ6wAsdviLNUD+Q17WG9LORodvnUxQ1V1
    sS1fPSTPfn14lMQjRK/FL//Q2CCazlqD2JsF3SkxsuNKELdsKvcsOxJ0kJvqLrDFFiaD
    qNFbHFOqfApyWs1GmYKSSAM20OE4/kX7PqpLkHxSA56PM4EAWnweRYgvA7qHs/+JTf5N
    86TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792747868;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=4/JtPZxwY0peCYqrhbe/GP2Ebv+7Kymqi3t9iz/6G8w=;
    b=QffDn1YTEbNg7SnRJku8p4HCoxduZnyv71ThNMYvkAfRwUGMPBLFR80xB3X/b9KQNf
    JEULUlbkoqzkbekCStiDkl6LMGZS/fYcNLN1QkFa02mOWKw3zubb4xVKXnkSbvEUfucA
    RugXGVBf9PHBapRNKsxbICTiHLi9y1ZZrYFlxb0QoSRKu3qBGi/9Iw+xDEIh5ROc2wql
    d5+/xFwWOQp8gKWPRPITt1wjsFnNPYgbEfPKqWovsHduY7m35nXSV+pZ4HGGxPsmirpz
    eLDcfVnHuf6Xj9drUbWOyAvv1B6W5CO4PaUtZdAX9K0ZOAtQ0cxDS3O9WE2W41VhdAP1
    E/3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792747868;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=4/JtPZxwY0peCYqrhbe/GP2Ebv+7Kymqi3t9iz/6G8w=;
    b=AgZuoWkd6mfiyPn8N80BIxTtkPKYKBSV27z6Z28aqM5QOEkKNa2hbvfJVd73Jb5iOQ
    +htQhToZvhhsMWtCo+eqa8Bf7i3/vamiT70bTAuBqwq85fIMBcGZJh4KMYGiMVhwrsYy
    eBrrJ+l2FA9YI59Ne2/rq4vxH8S4p1nuvSwxVo5wrOqwAoZn5ZVHdX3BTekojF8+wCfH
    8/VInynblFdmVzcmDc6IAv8BQbQZDwfsYHZPofoaucumRpOTETNwfNkmshOjaB+/HVae
    9E138FoLKyTXYn6yRmYA8W4KkpRn+TCsyiaUpu1zKRWLtxqdBESe86QHnAg0fyaH0iXX
    RE/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792747868;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=4/JtPZxwY0peCYqrhbe/GP2Ebv+7Kymqi3t9iz/6G8w=;
    b=eoDTpKVdXHDOQZS8bgHTc5i+sb4pLXyPvJhWOKtjimL5hcPwO+miCSQxPVNv9qeAsQ
    yu4AO8GX98LlOw1b3+Dg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5q1sy7MWioscGEbW2z9QYPf5P1ugQGy1cNYzA=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d929N9V8ZO3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 11:31:08 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Connecting the SB600's i8259 controller rather in pasemi's pci.c than in pasemi's setup.c.
Date: Fri, 23 Oct 2026 11:30:57 +0200
Message-Id: <7C0659AC-D012-4E98-BC4C-C3BC2ABF6A4F@xenosoft.de>
References: <ce442cc1-5820-40fa-beab-e9c0d6a0df3b@kernel.org>
Cc: Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Darren Stevens <darren@stevens-zone.net>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <ce442cc1-5820-40fa-beab-e9c0d6a0df3b@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: iPhone Mail (24A446)
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNWANTED_DEVICE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23 October 2026 at 11:12 am Krzysztof Kozlowski <krzk@kernel.org> wrote:

You are referring to some other patch but replied about this one.

Best regards,
Krzysztof

- - -

Is the following patch OK or not?

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260801043458.12500=
-1-chzigotzky@xenosoft.de/

Sorry to bother you.=


