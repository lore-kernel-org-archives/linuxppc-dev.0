Return-Path: <linuxppc-dev+bounces-25270-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F6BC55179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 14:43:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDKCk2Zv9z30F0;
	Tue, 04 Aug 2026 00:42:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:ee2:a80:100::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785768178;
	cv=none; b=LzIwVDwyeEQthUiaUz5ptxKtugKNvCEKE8eHof4PyW7gPVyFlwG3xn9ZV2CrDVhSEgsxLA7lGQd91tWYaYevVb8CB/Coawf/y6sEOcuz67ILQVaDZmH1pp0pdsPlYLLru8O7exfrUEq08ILptQAjPHPq+IsTKY4uORPqTfQSA3AAdzYH85Hv25jqQGa5NnyZ0nlBVgOouZnM7RPfWwQReACK12XAsvgioIyLAaL70Czj2K5UryAX+2yg84uBae807AxL5Z+o7Mmosc6OX4Wk/1mfNiP1zQwwWkmYeXprJ3HiVvOxKCkEeyBjpZKOJngGnBpNpVAbPSdwKz2lzfcLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785768178; c=relaxed/relaxed;
	bh=H2Vt4IlI3KMxVE8qBCDtjC+d1qIw883LCHhrBpB3u3E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=loqecCMyTamUL8pSmS/wkuWiRxxiO8qeVOwr6qhP6Pm/PnxWpmCkp1eaNarHzeaBSbHQNMmSPrr5QU8sdwmrd/x5Xb1I/ozOVlG8lnxpSvWUaVTESMdA/6RNGcUukahhNVNGD5qu/qAL15fjQUURUXqkPiWcvbJWIyqEUzlYz1ZkspRNtoUlecW1AFWU3eKbgAaxfwB8KD0lXB0qYoRJtyXNVzhk+H/nOUC7H1o0JpoASSds+FpwrS1PmlfnbvEltNyzehCS0S0iLSG7soGueCvI5O6C/qsnsqHw17SjrLTzMVYEFkkTH3KDjx7sTkznEfQjj04PD+LTyHpOfp8Smw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=borea.si; dkim=pass (1024-bit key; unprotected) header.d=borea.si header.i=@borea.si header.a=rsa-sha256 header.s=dkim header.b=rlK9T1qx; dkim-atps=neutral; spf=pass (client-ip=2a00:ee2:a80:100::2; helo=ris.borea.si; envelope-from=matevz.langus@borea.si; receiver=lists.ozlabs.org) smtp.mailfrom=borea.si
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=borea.si
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=borea.si header.i=@borea.si header.a=rsa-sha256 header.s=dkim header.b=rlK9T1qx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=borea.si (client-ip=2a00:ee2:a80:100::2; helo=ris.borea.si; envelope-from=matevz.langus@borea.si; receiver=lists.ozlabs.org)
Received: from ris.borea.si (ris.borea.si [IPv6:2a00:ee2:a80:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDKCj3BLbz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 00:42:56 +1000 (AEST)
Received: from ris.borea.si (ris.borea.si [127.0.0.1])
	by ris.borea.si (Postfix) with ESMTP id 4hDKCb1rNfz1px
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 16:42:51 +0200 (CEST)
Authentication-Results: ris.borea.si (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=borea.si
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=borea.si; h=
	x-mailer:to:references:message-id:content-transfer-encoding:date
	:date:in-reply-to:from:from:subject:subject:mime-version
	:content-type:content-type; s=dkim; t=1785768168; x=1788360169;
	 bh=H2Vt4IlI3KMxVE8qBCDtjC+d1qIw883LCHhrBpB3u3E=; b=rlK9T1qxSQ+H
	n0oWcp1Tt8EGjV7bKrSp+jCPwLif9NN5Ht9AEzt9ipsLE015h1Gun0MsRyeP6DA/
	W/xwWNMvziJeLdVRSdsB49artUbHOWzmUhTf56/x6RIlaB7RWzTPcOrlGh1L0z2j
	j0ArBH8KEinZEq9H3KItT4nfSLyFkOc=
X-Virus-Scanned: Debian amavisd-new at ris.borea.si
Received: from ris.borea.si ([127.0.0.1])
	by ris.borea.si (ris.borea.si [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SbDBe8TphyNa for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2026 16:42:48 +0200 (CEST)
Received: from smtpclient.apple (unknown [IPv6:2a00:ee2:a80:0:880f:f393:d837:b93f])
	by ris.borea.si (Postfix) with ESMTPSA id 4hDKCW6rqKzNQ;
	Mon,  3 Aug 2026 16:42:47 +0200 (CEST)
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC
 PRAM
From: Matevz Langus <matevz.langus@borea.si>
In-Reply-To: <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
Date: Mon, 3 Aug 2026 16:42:37 +0200
Cc: Zhao Qiang <qiang.zhao@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <066899BE-9B23-4FCC-BBE1-6CB3BC8CD196@borea.si>
References: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
 <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Yes, this patch is for all devices with QE / QuiccEngine.
In reality also for CPM based devices like MPC8260 even MPC860 on all =
cases 256 Bytes should be reserved for PRAM.


> On 3 Aug 2026, at 16:18, Christophe Leroy (CS GROUP) =
<chleroy@kernel.org> wrote:
>=20
>=20
>=20
> Le 03/08/2026 =C3=A0 14:58, Matevz Langus a =C3=A9crit :
>> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. =
D?couvrez pourquoi ceci est important ? =
https://aka.ms/LearnAboutSenderIdentification ]
>> More MURAM needs to be allocated than just sizeof(struct =
ucc_hdlc_param).
>> We have noticed MURAM corruption outside of struct ucc_hdlc_param. It =
was
>> caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
>> 14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
>> Even looking into QE UCC HDLC microcode source code reveals it =
actually
>> stores data beyond 0x6c.
>> Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode =
on kernel 6.12.
>> Signed-off-by: Matevz Langus <matevz.langus@borea.si>
>=20
> Same in MPC8323 reference manual, it is marked "reserved" until offset =
0x100
>=20
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>=20
>=20
>=20
>> ---
>>  drivers/net/wan/fsl_ucc_hdlc.h | 1 +
>>  1 file changed, 1 insertion(+)
>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h =
b/drivers/net/wan/fsl_ucc_hdlc.h
>> index 71d5ad0a7b98..e170d3ac9116 100644
>> --- a/drivers/net/wan/fsl_ucc_hdlc.h
>> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
>> @@ -60,6 +60,7 @@ struct ucc_hdlc_param {
>>   __be16 haddr4;
>>   __be16 ts_tmp;
>>   __be16 tmp_mb;
>> + __u8 reserved[148];
>>  };
>>    struct ucc_hdlc_private {
>> --  2.34.1
>=20


