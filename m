Return-Path: <linuxppc-dev+bounces-26541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B49CC79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:35:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbrt14Z0Gz2yr2;
	Fri, 04 Sep 2026 19:35:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.80 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788514521;
	cv=pass; b=Bgr4n+9vV+vMe0y4wDXQr5vjBHfasbcGJycrYQ6Almf8PPcpeKy6iclCPAbR1f8kQyJNlfOQ492+3Iz5F/IcQP3E27jBndfJWawtl8SgLXl/mMZi3tzh70WrVy54R+q4SBwzqyALKpGPX1BuyaBwlBpVwuBZGF990sPthUnGyWvgKaSsb/o+7KUkQQK5tZ/NdS4rhiYuZaExnDMfhjncfnK3Hl+4/+2w+KKbDXTiSdVyOao5oBmcXRl9VHPfoyUCnmkAgd6/OnJj1vK4qBXgAEFwHlmX5tsgFNEWuAxnKtrRRtPV2gmGDPdiKaSBxYrIqvmB9/8ACLn1jyZgK4NrOA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788514521; c=relaxed/relaxed;
	bh=EiDPjcBnm/FrJdlo+ABtXJZ6TIb5cAbzdVR8GzrsJ7A=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=T0jDmBmu0q28UfNG1ONdq+ud2RCn7qrnWDfOifPimlYkZI2i8W3bGYIo5R5D+/c1VVww/iTBy4u7kVXPOgS/vihB8zkjHzmO9IFtDVU1S+DR3lOXQo7DDIduuEEH/dSFqZHX7fTT1h01FkMxywJtu6X6T2kI1U4P4o9HDiJJYYWbfi6HjJdnU0RSpIK1EZt+yW5+2L/sIYyH0I/Jj67UBNhJpVCfgMSoOLJ+CGMtMDQCR8bonQZBuGgvsFJZ1QcC5k/R/uQHI57gBM66LqTsW5gaIc+EU2O6SndraqSTTO4M/6OY+BKMbG2KvXq4uYliQWJuCaKfoVCO7PnMGhguXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=HpCi1rVr; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9N2RCOg+; dkim-atps=neutral; spf=pass (client-ip=85.215.255.80; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=HpCi1rVr;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9N2RCOg+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=85.215.255.80; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrsx5cjBz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 19:35:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1788514508; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O6PuBSbXTKy4vi5CDwWDjauVRUCd6pTA/4RV3lrj8ggfM/WX/GHQ4JF4ZwTST97HzW
    T/Me1o3EXXBfYFwszHoee+xIG+82qKshrRxoBfQb106n6PHyc+eghjkDxJXoww7E+DDM
    ucDnx/VYYa0EpgEStWZ/yh5RyrzCh4hNRTrDTHxIKjqqx4cB3Md3FWqrt/ESMr9vJUoq
    Pk9YyS8Wg6SfF+HbgjbxaedpDbvMGgglHfvI2kAsIkTpolbr7i31nlbzB7tcjIoikjPn
    JBJdZOlUZCJTAoGgaSxZ2wrkKh6mDip+2MrQT7Sn6WLVuln2YMRMgJeNIKQ8AGYRvzII
    oftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788514508;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=EiDPjcBnm/FrJdlo+ABtXJZ6TIb5cAbzdVR8GzrsJ7A=;
    b=pCC+qBCZSx8dJnqPVDwYpRBWpzFqYGicsWIQHRIO3KVF8qM73+2ZzOKHN75ayFsmNE
    jGUh1PA9XzlMIXaWfimSwZnNoOcFTyhiK3oO1+hu2R3LZBa51XlhwhdJ7foYJ4xX5zc7
    Qoh78K6fAGRHp4NayK0mA2xCGhwlW+Rh4MwPoiVW+liGlmQMAdtO54UlSf4c5U52SWJy
    4jWeiQcxb8EUiwDEot2veHEIx+0btYxMm6nSaIWkrg7ZHd4eX3Ta+bmyV4qj0v7X3k4H
    gaYShEJRtA00Vj5VdBuGrW4j2iBXphTVlkYRlbWzu9MTkQogtdXDOIojqRaGezrU8iUs
    XWmQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788514508;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=EiDPjcBnm/FrJdlo+ABtXJZ6TIb5cAbzdVR8GzrsJ7A=;
    b=HpCi1rVrWB5UnEuRrv/MiZvnv3EPejqSnfTBOZw7sqYpw4+aeWKvODl9CaGdAUDp9d
    tcLbRiGcB65D53Kas8zvdQH2Pf7ogGZXcz1sqr/kEA22QkitSuSRSMpP9Hy+L5VSa0JA
    d8RwORBZNCJfTOChlvKbti8dGgVKqoSv2LzaxLfp0YEomhfoM5DqqteCUzkX6zssfpHs
    yOPEankSG580v18YEDsEWhvDL4p95c0VR2d+QIGhq64uSm6DnpNP0/LESVhfWtSo8Tbd
    oyn/lS2BqvHzCDR7is3JHKnK4cxssZiul+MX7iBOPbItCzAJOop7ug6e1PmeM/rkr3Od
    tAvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788514508;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=EiDPjcBnm/FrJdlo+ABtXJZ6TIb5cAbzdVR8GzrsJ7A=;
    b=9N2RCOg+OsuJ9tPdlkxdLh68OquOaszQ131sXBw+SF6G0NBbc5C62kqOTphw8ej3q6
    moTDNxuGrML8qM0V5lBQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7BZqwsy/CXnbxcSyMRGT1qrNiz7sLFQXRefpK"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ee2bee2849Z85lw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 4 Sep 2026 11:35:08 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [Linux PPC] Disable PREEMPT
Date: Fri, 4 Sep 2026 11:34:57 +0200
Message-Id: <0B5355D7-4FE4-4B16-8ADE-CBB05A1D6C16@xenosoft.de>
References: <af7a8fa3-8ac8-4b97-bff7-5257867e7209@linux.ibm.com>
Cc: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Christophe Leroy <chleroy@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 hypexed@yahoo.com.au, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <af7a8fa3-8ac8-4b97-bff7-5257867e7209@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: iPhone Mail (23G83)


> On 04 September 2026 at 11:24 Shrikanth Hegde <sshegde@linux.ibm.com> wrot=
e:
>=20
> =EF=BB=BFcan you try with latest code? maybe 7.2? there is usage
> of generic api to handle the work now which renders the patch shared long b=
ack
> which you tried irrelevant.

Thanks. I will test the RC1 of kernel 7.3 with PREEMPT enabled.

- Christian=


