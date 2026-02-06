Return-Path: <linuxppc-dev+bounces-16716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA174EF06FA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 01:01:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8RH42cYPz2yFm;
	Mon, 09 Feb 2026 12:01:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.0.225.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770598912;
	cv=none; b=hu+y+M5RMPfAr/0bzGjaWMAv6FrVUneIfC42mTDRpi7i43MMzfOgX9qBaBDCqShbmzBrNEIVGOd60kOyY9GynBL1M2hG5NLIBK9XgZh4FSJGtz2o3zTaHzquvxBg2DACdC6j4bLm0wzbsHz2NUBiXyqvzFilM7vF5GZDoGUT8RH+vOxT1MpTvE1TIeGZI8BwQi6t1Hjy8pgC8MkuREgYXIaqf/T6nVPEQulH4rKC5bB9JuWIpUznN4lzY2Vl0jnaEJJNYGdCCISXsUj5hQst7ha016SmaJpXNgaFvskSADq+4kXLxlnaYgv99Vd3UtxDRbV+VB4/2NHxm0fBqDMxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770598912; c=relaxed/relaxed;
	bh=69SVmH080kQ0s9pD6WHGHZSpprX+aHodu42uF0Ih4nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m8ICPmd3AO+y9KopQ7STR0bFOC6gYY7Nq/lTzcppKQtrD7Zc/EtQGolxYpOaIRcqsjlWnQwQFkaWAvvnv+x74k9ml//z0DSb5P1xbLd+DC8Q2NHzOax0XK6sjlFtxocs2P2M771t7P7jyA8G7siGO6zw6GZK4TojtVEqQNtPcY3SKFC0UTcfnZN0FW/RTqgIthk0mDSvByau6Uo98j+1F5DQdQCR4NiQKFz1wFUcYKJREiMyaKRHKYq6fR7ie74mqXLJ8hvvaOJr2A3w0T4+pHYC9ZH0kNT8d8aXcgp1mcqFC3vB/Ou8kqZIxQbKbtblmiFo+DyCWLHdFCOd14bNTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass (client-ip=210.0.225.12; helo=mx1.zhaoxin.com; envelope-from=leoliu-oc@zhaoxin.com; receiver=lists.ozlabs.org) smtp.mailfrom=zhaoxin.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zhaoxin.com (client-ip=210.0.225.12; helo=mx1.zhaoxin.com; envelope-from=leoliu-oc@zhaoxin.com; receiver=lists.ozlabs.org)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8RH30ks4z2xLv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 12:01:49 +1100 (AEDT)
X-ASG-Debug-ID: 1770598818-086e230ac70afc0001-v7v7hK
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id uaI0d5gmSMmYU5Mr (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 09 Feb 2026 09:00:18 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 9 Feb
 2026 09:00:18 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Mon, 9 Feb 2026 09:00:18 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [10.32.64.12] (10.32.64.12) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 6 Feb
 2026 19:07:52 +0800
Message-ID: <c1c24812-37aa-48af-922f-2e43c659703c@zhaoxin.com>
Date: Fri, 6 Feb 2026 19:07:50 +0800
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
Subject: Re: [PATCH v2] PCI: dpc: Increase pciehp waiting time for DPC
 recovery
To: Lukas Wunner <lukas@wunner.de>
X-ASG-Orig-Subj: Re: [PATCH v2] PCI: dpc: Increase pciehp waiting time for DPC
 recovery
CC: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Oliver O'Halloran <oohall@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<CobeChen@zhaoxin.com>, <ErosZhang@zhaoxin.com>, <TonyWWang@zhaoxin.com>
References: <20260204035542.53232-1-LeoLiu-oc@zhaoxin.com>
 <aYRatwSvUG0yQkHd@wunner.de>
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <aYRatwSvUG0yQkHd@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.32.64.12]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 2/9/2026 9:00:17 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1770598818
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1170
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.154248
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



=E5=9C=A8 2026/2/5 16:54, Lukas Wunner =E5=86=99=E9=81=93:
>=20
>=20
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>=20
> On Wed, Feb 04, 2026 at 11:55:42AM +0800, LeoLiu-oc wrote:
>> For example, The execution of the ice_pci_err_detected() in the ice netw=
ork
>> card driver exceeded the maximum waiting time for DPC recovery, causing =
the
>> pciehp_disable_slot() to be executed which is not needed. From the user'=
s
>> point of view, you will see that the ice network card may not be usable =
and
>> could even cause more serious errors, such as a kernel panic. kernel pan=
ic
>> is caused by a race between pciehp_disable_slot() and pcie_do_recovery()=
.
>> In practice, we would observe that the ice network card is in an
>> unavailable state and a kernel panic.
>=20
> Unfortunately v2 was submitted without answering all of the questions
> and testing all of the things asked for during review:
>=20
> https://lore.kernel.org/all/aYBoP-B2E9fp_4YZ@wunner.de/

I have already replied to your concern in the following email. Please
pay attention to check it

https://lore.kernel.org/all/018007dd-68d9-4e16-b605-15d9c77ea13f@zhaoxin.co=
m/

Yours sincerely,
LeoLiu-oc


