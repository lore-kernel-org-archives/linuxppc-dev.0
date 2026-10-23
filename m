Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4546606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EItz6hEu;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=C64gwSyJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9y043Fc6z2xjh;
	Fri, 23 Oct 2026 20:09:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.53 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792746596;
	cv=pass; b=XPOxumzPd9uiVr2NHbW3vjFS/aO/t2WYWPHKO5RDTBcGcdFeU/vmP3kjysCIUa+wrHftAW3dl8RMzOf72KZNg7ofIpeUTi+RO++NuS7VBQf4bpxLA9HQJH7IRiRJyDUWq78mNaQniiSZobTy5iqWlJYz4vVuOAK+UdbRWBODz6LbddR0TRP9zLe3pHPh0I3ZQhYRzbtLg5I8MvYJONDJnloXwfZge+yxTJPubXLlixRmj8WfCvLFsM0oNwy6mBCXKPn0RCarBV9mD2apwNz89E8PBtUU3l97mQiSRpBNAgRVsredTEzPQaxAhqolUdxG2Z+7cq11L2y2gaXwFqKgCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792746596; c=relaxed/relaxed;
	bh=/YMpiyHb/oOoVAqYaniKbsFsgRAlHMfRbUn7Sd2BORY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GPyStAxMq3dNpSbLtk6TgsPxhsyN56dJb8ae0rnty/QlxmD9G0KoiDLi8Br2tDrDqo0Ov7gz04bnt1w4k44q4kakD8j8D3RVg9C6XAcZC0d7xfrAAX1ibE+WRozsu/1Xkyv6BsgbKwdIH58rLYTuyVS1aV/BoVnw/12tpGziS2bjRYjXgeGws0YDCLsG9BsxxESuCpTUIOvIgjjIQCSJMjDSQQwErqMoZJgbZytg05oUYuOjeCgD1L/Yxcq+xYm31TW6ePcpkG3sCVekrB5BH5MYaP1YmVj1JmkIFYQkiqD+k/UhKs1u0l60xtjNWcnkzr7i0v9vnB8T2EPmtx4KHA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EItz6hEu; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=C64gwSyJ; dkim-atps=neutral; spf=pass (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EItz6hEu;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=C64gwSyJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9xzz16DZz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 20:09:47 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792746577; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LCLkUGG2bI9r5dSw2cyB4v57wJat8ND+fHrm9Z/iA9RQ5lDCZ5HUno0MvEyIOpcL0V
    AkePAAK4zSwb42UpkRkzB9d1yPHj6y0aQaUFDMoOivJQplF2vjQiY1+49ErTzTa21Fhr
    Tpfkba0Bw/lIEw9OSXzxCgQ3sTs++I1ZHjesgW+/V8FSGSjt5wio38FOUwQ64pk3R2bv
    IgLSZRC40oX0duePLzdfHHHbQKHgZCKp+FPU30mYLkTLzGfHXZLz5iIIueaqWtrW8l8f
    9lHb1nO/Xy9SL2EvscdhvbMRNekJ5hJvJcOoi6FcT9ZPN0XPu7OIjYvhrZjjMV7Y2ivd
    7pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792746577;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=/YMpiyHb/oOoVAqYaniKbsFsgRAlHMfRbUn7Sd2BORY=;
    b=BToN0AXvGKzaaTc9M+Yc0lhrIOXD49X0Bwa4+9FfMHsW+1ZnIg0AfIdJnDiaZ+mVas
    VTcu5T28xMOBvW1Qp1VTlMFWHA6OpB00GGcNoT/1HiHtN1TV/yOutRVa/onq7kaDpSRg
    k1VsMVT2qQit77gJ2beD4xgbOntAoxAQJZuMBc1nD04o+U9srBXVk1PJZEStWm6m+szV
    9v/382uejNNdJnFZXvU6JFIzAxi0xc28eCxCITVDIiVcVQTBgcnmTDhAfJ9KwGe1jcZH
    B9Mp6+HdLpOMYwSdu41/jaWFwrs5hHvn57JK4VXvnlCxk3TT4Qhhj6ZqnetQ43hSnepM
    WfDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792746577;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=/YMpiyHb/oOoVAqYaniKbsFsgRAlHMfRbUn7Sd2BORY=;
    b=EItz6hEuI/LDAPJvLWeasBlJVMkDyFS63irOauhUYRb4BoLE+tulerRJhEJ/UKWEwH
    nhffManP8L8+m7Q6Sau++Hd7m6kBC/jcxLCenYZ1PwQzAFkryclksaSDqAFBi0qfqXmb
    OeZVSFYY3wjBLn7IKkWC85iGMQzmidACpaThPDB2a/LFwT9VoCgjd1LJhQ9YSExANktw
    SQIFsYXxAVM03W3eViIt7MOpqDceB5769/U6x04BNwrlv9rW8pr1PJCq8VZrDQe7Vnju
    P5N3NAzzQ6ob11GpdBQP62kSSHi4199K1EnujZYxth4stj5MbKWHoIlh88uuyHnftBT2
    0QGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792746577;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=/YMpiyHb/oOoVAqYaniKbsFsgRAlHMfRbUn7Sd2BORY=;
    b=C64gwSyJHeO6P/nykKZpgCvhbOw2GziBTdD0Xk5d2Bnn+ZvUTv/s4Kni5ITz2AWPcz
    Y+KmN6He9IC5szLvilDw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5q1sy7MWioscGEbW2z9QYPf5P1ugQGy1cNYzA=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d929N99aZHN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 23 Oct 2026 11:09:36 +0200 (CEST)
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
Date: Fri, 23 Oct 2026 11:09:26 +0200
Message-Id: <B4E8FA8C-86CC-45A2-8A61-8A265BF02114@xenosoft.de>
References: <d14e954f-d7ed-493e-bbbd-8a4bd780332d@kernel.org>
Cc: Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Darren Stevens <darren@stevens-zone.net>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <d14e954f-d7ed-493e-bbbd-8a4bd780332d@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: iPhone Mail (24A446)
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNWANTED_DEVICE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 23 October 2026 at 08:48 am, Krzysztof Kozlowski <krzk@kernel.org> wrote:=


This patch received reports which basically rejected the patch for
inclusion and we wait for proper, fixed version, as explained in
submitting patches document.

Patch also did not follow standard naming rules of commits, so again,
please read the docs (submitting patches) how to properly describe and
send your contribution.

Best regards,
Krzysztof

- - -=20

Hi Krzysztof,

But the patch has been ready for a long time; it has also been tested and is=
 already in the right place: https://patchwork.ozlabs.org/project/linuxppc-d=
ev/patch/20260801043458.12500-1-chzigotzky@xenosoft.de/

Thanks,
Christian=


