Return-Path: <linuxppc-dev+bounces-19991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A288FAD3F7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 04:09:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1Mzm3jfnz2yjs;
	Thu, 23 Apr 2026 14:09:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=50.20.195.61
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776912737;
	cv=none; b=OCHaLh5lLVSvk5YCCiD1Lsk7VUT7YJtFV/cI2t6A3H2Q8tosV7FxqcrXzNsnUI/Inxayhh/ZYHE5hdtv3WXnFEpK1Qd04r7GIGKjzqDAnvvp4+uLZrs9naUVBT+DwIpRYBxh4Udbltu9+GelkISIGpUH0Oma1QywFnuNnkdpuynxxkFOWXkxKC29OAC+tlpk3KFiQdQHV/qAuxCrPuTLRWMgAgAQjZ5ysfW9oY2HgCV1WkIIH9s0qZ1cStpThEmko1V42j2ktVeFytEvOuxHjPY2ApQxAQ5+RxE9G7JkQDrriXY9l7C5TmQDgPx/juOL9Vmw3NMaCvb3vks7jszzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776912737; c=relaxed/relaxed;
	bh=11u2xA1Se/7hYF7NN3SQw5j6EKJasneG214Bc6KfxZQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IurQ0TmkA+IbhSgyviwyBtmz3lFp/dDI8wnpewxs0VMmMT9q/oVINDr98tAg2Pj2ra8bwQkypdIu0H8UNO+nJ+SmKvYyXeUHcSfz5SlLDSE8Hb+jLBlu2vAzoub5ZORcLepEOawcrmOjxOYUnc+pAo4AkmNvNIMaTA6WnbrY6ioUh9KofYaOr7WOSybl4z42ymXndpEpOaUTdaWXFoAhrMa5m/nRu6zCqdA0ZXKVz1AO6QH9MABsjAUrWlEQipE97D/wrdJaOwngG7MULNZgNRQsr5BzXdiaEn8B2vJ22tftNI/Rg0tWcl5F8OAEomndHaQzEZ+gWTiLUkBDcb0Rsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com; spf=pass (client-ip=50.20.195.61; helo=mail.redfish-solutions.com; envelope-from=philipp_subx@redfish-solutions.com; receiver=lists.ozlabs.org) smtp.mailfrom=redfish-solutions.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redfish-solutions.com (client-ip=50.20.195.61; helo=mail.redfish-solutions.com; envelope-from=philipp_subx@redfish-solutions.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 435 seconds by postgrey-1.37 at boromir; Thu, 23 Apr 2026 12:52:16 AEST
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [50.20.195.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1LGm2PPzz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 12:52:15 +1000 (AEST)
Received: from smtpclient.apple (macbook4.redfish-solutions.com [192.168.3.6])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.18.1/8.18.1) with ESMTPSA id 63N2fckv405223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 20:41:38 -0600
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
Date: Wed, 22 Apr 2026 20:41:27 -0600
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        openwrt-devel <openwrt-devel@lists.openwrt.org>,
        Guy Ellis <guy@traverse.com.au>, netdev@vger.kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        linux@armlinux.org.uk, tsbogend@alpha.franken.de, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        3chas3@gmail.com, razor@blackwall.org, idosch@nvidia.com,
        jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu,
        herbert@gondor.apana.org.au, geert@linux-m68k.org, ebiggers@kernel.org,
        johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org,
        kuniyu@google.com, fourier.thomas@gmail.com,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bridge@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <68316F0B-2442-4492-A041-E57EFC58AC08@redfish-solutions.com>
References: <20260422041846.2035118-1-kuba@kernel.org>
 <accbbcdf0ec14ae4d3f21ef5da7091bdcbd6574f.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Scanned-By: MIMEDefang 3.6 on 192.168.4.49



> On Apr 22, 2026, at 7:05=E2=80=AFAM, David Woodhouse =
<dwmw2@infradead.org> wrote:
>=20
> On Tue, 2026-04-21 at 21:18 -0700, Jakub Kicinski wrote:
>>=20
>>    I'm still deleting the solos driver, chances are nobody uses it.
>>    Easy enough to revert back in since core is still around.
>>    The guiding principle is to keep USB modems and delete
>>    the rest as USB ADSL2+ CPEs were most popular historically.
>=20
> Still not entirely convinced; I worked on both USB ATM modems and on
> Solos, and the Solos is both the most modern and the only one I still
> actually have. And the only one we have native support for that could
> ever do full 24Mb/s ADSL2+, I believe.
>=20
> If we drop it, OpenWrt will need to drop support for these, which I
> think were quite popular at the time; there were a few UK resellers:
> https://openwrt.org/toh/traverse/geos1_1
>=20
> I still don't actually care *enough* to try to find an ADSL line I
> could plug one into for testing though... :)


I have 3 boards lying around if anyone wants them.




