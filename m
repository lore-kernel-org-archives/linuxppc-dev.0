Return-Path: <linuxppc-dev+bounces-25256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6876AC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:59:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDBwt63s6z308X;
	Mon, 03 Aug 2026 19:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d40e::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785751182;
	cv=pass; b=WsokIuI15X/8ucD7WSBiV6SxkG5oyM2TtYAzE+5bXtAwTEVjfjdVIiG3nw3uTlv5/sMO+fgM6/wafiMLbXzQGS3wNXEKjrJlJVSwy843Hnat0KHoJrfDMXVpknV4AOKsaNmq3Eas+B31s8KiUVrftc8nXKeDV0Z7qAU/IHF3A5eUdD3R9nMw6e0YU/+L3xBuxmqLeNy2mvWPpTwuNEc0pntvzBxyqt6GYnofTvXS/eFHJijaTgKxJdb4zDHzXJ867IIOAl0/Hpw0OoA5y+klAlx4l6ynNYcNxRWM5nSsXJmWXCNViJFAHDJ99QsLu2PL6ej94656xVw+xGtdW27TmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785751182; c=relaxed/relaxed;
	bh=5VVtcaR+K4fTZCq/g5VBt4yON14I2zoyDJVnhlwL2eA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDeHvhJdhyW22GIWyHMNXo6ea40Q76oD5AcNrnnAqI5gH3wckqlBAl5/cIkd0IYLyfi1JLc88Yg7v5rn3raPILRbuwzpwmqFuiM0B73Nn0lQVA5GAIhgH5FTKo/Td60KRQiuVm3qpZ4OnB/I/71kYB71PAeumcPMmOtQtHkwsNuJS3R/HhxRgpTXm2Fkvy6bNHmlDfmimDjYQdIg5WQgww26v1KWi7TfO+n8u77swuC/s6IfwRko7naHZtVuJhhE/7gSjxjhY9xAOX98ZIRsC8eKwYI8RjY1VPqf55Rlff+LHVmRths2cNrE0l4qtq4+Qc7g53QWiYUjOhD2Oqzi0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RBGwA4Fy; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d40e::; helo=meupr01cu001.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RBGwA4Fy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d40e::; helo=meupr01cu001.outbound.protection.outlook.com; envelope-from=moonafterrain@outlook.com; receiver=lists.ozlabs.org)
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d40e::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDBwt1G4Sz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 19:59:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6fd1LdmJsimjbzUttnEtWg7cx7bIgoJPpUTsi3qc3Xb876w3t04ltmQp+G4DhD4HM3XYA9KHghys4v6kcXkO5oAQFUdyFrc1FVJTPJar1mrYr/bztmOHdZTIMiYH5EaHpxZQNXmZBzfLlJ6z5fJ7dwlGGzhilOm2edHTuM+umuSZ7Y9Miz5kaOQ49CoLQRncC3ug518xWVRj5X1/3eF0FuwJ/R6aVHVeno6whFc6AFWcC0l/3m4TOkwXH5QBTJNP7s1Giq8NWOUqZC+4MQMrIHYNBEgPU9VKlaYdiDpsG5BB43PiRlNMUSAtKIRnSHKMyrr/NaJ2mBGkFrlHYUKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VVtcaR+K4fTZCq/g5VBt4yON14I2zoyDJVnhlwL2eA=;
 b=WzZpYgREeeFyqiOL26MU/JhNG8sng7z7/cl3Ftgynl6G8FsaYzoouQusT15NiPvczmyDSFbpJIYne3V4hCutoqZdN3UH5pr+6PeRkA4r5qkwJKEX7We1FkXk2ZOZZt5cRKRxSabY3ievISY1VHDugtVPPMBXOdt7M9wUYZmipDvsZSc/xC8hkSaoJz67R+eZPjOdfriilGQue4qjYy7vOPP0Wnprg+6Ho0w6B2m4sNcsbdR4ZpVwIIXTnQF/NBniPnKsn9U3bdao41Pq9KqH0e5KaJSbn7WB55q3onDvT8qyjBbbc35aMEQudOGNuD4dqCsTiXo33QuaJlKX3gcJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VVtcaR+K4fTZCq/g5VBt4yON14I2zoyDJVnhlwL2eA=;
 b=RBGwA4FyjcoF40csy4p6FtCcBtqlXRvrTkvKqpmb6jPQan4fMdfc72Cy08ZoA6VVKjk1w1ViFp/3yThzpBWUXk7K8dFfCR9EYHp3Hw2L/2/etkHDeggrKRE54fIx1NG7PFIotBBJKi0AaGlvgO3bXKEWbwhoIBpqVuGayuNXkrpVeU4FT/FgshPVKZM9TMKYSjpncW7qZHUxP1lV11KYKyr9Byw75Ljb7wl2oN8QGlSWtkueyjO5Tzz+g04wfgsTdibH+429+H2UI6QqGkDCNKuIp7Be2THQYliVQ+4gEMMQkPtiLcBSURX9xxmvMmgSnsQUCnBTu680XMHhifeTPQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB11484.ausprd01.prod.outlook.com (2603:10c6:10:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 09:59:17 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 09:59:17 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<chleroy@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 0/6] powerpc/spufs: assorted fixes
Thread-Topic: [PATCH 0/6] powerpc/spufs: assorted fixes
Thread-Index: AQHdIpbafWrFzrsOd0a44iIFf4B2oraMD8kAgAAH4IA=
Date: Mon, 3 Aug 2026 09:59:17 +0000
Message-ID: <9E49BF8D-34E4-449A-A24A-AACCF6215DAF@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <a1c11e04-a3df-4beb-84c8-f0e0443bb828@app.fastmail.com>
In-Reply-To: <a1c11e04-a3df-4beb-84c8-f0e0443bb828@app.fastmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY7PR01MB11484:EE_
x-ms-office365-filtering-correlation-id: 1d92a396-3ac2-4434-d88e-08def145e1c4
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|22091999003|39105399006|24021099003|15080799012|24121999003|31061999003|4140399003|8060799015|19110799012|8062599012|25010399006|40105399003|18071099003|2607281247196008|102099032|440099028|19061999003|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZNdWX9JsUe5Nadksj3MWIoaVQ4nDaZIobOyWDWpjdRql1zV4df/iUNOqg/1O?=
 =?us-ascii?Q?GcatqicOEGzBz8BXXIm7CLCEqIJdtsGtu0B9a0XAc/SCzjTm0Np0bRzbB6h4?=
 =?us-ascii?Q?Fg1r9ti5YBRbWqJfJwtJH42vEvO59oi5VHKhv126F8ZEJjcX3FIAv7FMhkTZ?=
 =?us-ascii?Q?cN8kkv0jmm45AzsEmvbgzmup9gnORKSt2Jn3RsMZ3rr0LIRyZHYcsVY4yAOW?=
 =?us-ascii?Q?G82MGzcqB9DMBL5jJIEZay/vV9EFID9abcC7Geun58Z/5nluYTdYyHd/Dy/m?=
 =?us-ascii?Q?Uk1wZLgLolWw5VeqJUTi4+2Pg+ccfEYso1M+lCcUVZqR2PJWOF0NxWZTix6l?=
 =?us-ascii?Q?LOJnN5MqD/Qpx0bnN16bBa2fflWQIJ7LjL7G2ogTup6u8CkhuHxcdOIwCnxQ?=
 =?us-ascii?Q?EjQejE4d8FgvaAXVahKX8S4L8cdYdNkc4So+uzrCNcQ6M04LhynZiMoJQzNO?=
 =?us-ascii?Q?CwnfIoPO8V+tTjk8RFpImdOKP1d6IP1LLf8T6jNNp9fIrawWtYKh6z3aiB4q?=
 =?us-ascii?Q?UxpMLhwJCOqZ3jqovYWcyFIGzOlmrTMWvmYtbrzQHjQNyXKwjiL/+XnZ5dxO?=
 =?us-ascii?Q?TSE8mdF7lSH82y3rPXdEj9H3C92a5gJcTWJxagnK4YuDqyJAAmv8+oEET762?=
 =?us-ascii?Q?lRRnJa9L+gcHR3CZFUdYmu2sz9dL00MhzeFsmNB3m7aGacWDII4qEeBNoxo/?=
 =?us-ascii?Q?5lx5mS2rjf8lGOABDstg8xu8eywB5WltX+OFd3/dfvP8xBUO/h/MCmDyMLkZ?=
 =?us-ascii?Q?dEMqD1bmbgbLKGPNAhqzEOwYWJpOZXqAvB3PtVWvT54x+EAEDBc7iXnw8k1z?=
 =?us-ascii?Q?U66gPLTM9HwvVR4ST9TfhcK1BPKcviFwa075mtE1ju9Xlztoc3hHOZMn28YB?=
 =?us-ascii?Q?WC3ak6sNmrG2vFt7Hcff2JoVeeWn0KRbmxOa2e9OBJ488AfCLu6f9K5fkf8g?=
 =?us-ascii?Q?lUx+Rfce4ufFQEe+DrZONK1n9kqEvoRLNRCG/e+VZs7kIZhh3HRMshXGbDGi?=
 =?us-ascii?Q?+t0v/UvNCXT0fSOZl2kralwJbbwNV9z1XkpH2/Ae/A8WhwGmMjXz7nfV/fHM?=
 =?us-ascii?Q?sBIhvC8GAvGSejjh+iG+CwdEJawlhA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0PhxrbdAs5ICCs8d0wYCR0o6k8Y2be99iBpW1CAVcWg4OJRElvnvcTyOKgr/?=
 =?us-ascii?Q?tIcCSxJ8UB5Qz5ZuDLS/xq7VcL+fqaOH8A/ogWB4ruwf5/8AKVwpSl33aZi8?=
 =?us-ascii?Q?M5IwuGTAPE31Iw25wzbSvVPt1AhnWegFnsw/L3M2Eq40f+jEutsSgpd+ai95?=
 =?us-ascii?Q?AIgU3nc+t0mIMnh+UA0nEpl0siI2W4Y4dIjAcfXmXzyGloyrt4PSm0UJISQa?=
 =?us-ascii?Q?ouZ4xmjuyR9mFXj6WpngLt7sIjA0Mk6YfOanPEzOmMFDDaYjUtbIcKP90QbO?=
 =?us-ascii?Q?dmVWvyRFT7BebwasU/Q5ZYswM0nqEAlsagb6gVmmPmBhzXzSBYfbSqA+Rb3k?=
 =?us-ascii?Q?kPHtgLoU0HIKKbC7mQUlzeNGeQy9yjdw3wqvkPQ4Io3i0evM8XVuRI7pTeIK?=
 =?us-ascii?Q?HuXblNRfTKxICYViV9IHiPhCz5HKIup3EaFkl2e5G66IVzG1yNQgLlG5wlN3?=
 =?us-ascii?Q?/nDXnia7dAXKqe72bB4+Bf6x1kHf2ot12U/vSL51dLAgZE7X30gOzn7XvnVH?=
 =?us-ascii?Q?rWdAhrsieHTElgxKvh17vC2LJkNVkHb8C9Nn0CyIbihozimqtgIs1XGiqoFX?=
 =?us-ascii?Q?McTfDjOBBZA9A2rrYbyDa7wSJsn8jIarell4/lzB2ZaiYv4468JOvaaqok9x?=
 =?us-ascii?Q?ZKCYIiom1H2fHe/7xX/z2RLYQVTLSKgV9PIV03FDfwx8VxBlexrLuvkBNOro?=
 =?us-ascii?Q?o5+5QhrhxdvdVzievbVvXsS2HgAIvPxoQTP2xWiYsuvYzY3pRgWOK4eyUllE?=
 =?us-ascii?Q?1PKPJLjlsfc8ZZ82GLWCfRxGvOs1QHLPpV2/5hi3xGqxTL8dFslUDGtod2Nn?=
 =?us-ascii?Q?GW+hIywoVOsGzivvP8blsjUGIpsUAj42cGASMt96VlCCy12liyrcTvxxfhWc?=
 =?us-ascii?Q?cPnbmSC0GfrX6P50Cz7nzVlHOtaYI7Zo+DKXuCxklXdwNhf76BdR5DtEIjwg?=
 =?us-ascii?Q?DXVyi3sA1yYO2A6b/HhkszAqaEgeOyKQIQPtACM5skH7RRvWuzQnek8CSh1o?=
 =?us-ascii?Q?cCSAJoViIEhaywXfv4J0ScRuUcGOw+/DcJlQHLlGZj7d0xxjcUq7ukDLvz3W?=
 =?us-ascii?Q?7E4N8drCWLzpXtnM2lnEQMM7tu9KZG2/MeutPgWTLIN2lQ1VLulg/7PVxGHL?=
 =?us-ascii?Q?5ZC/OouQrWIzPn4S7UKNwF2iroDk3UbTk2dedR1sKIWeBKvsvEPL0oBFLeZS?=
 =?us-ascii?Q?d+KZNFHPTIVCMgdeudKkLa9+rOMjas89jIRRvBJmY3kYRwofvOug2UPujCY2?=
 =?us-ascii?Q?qK5Qi10lANbRj0yqF/Mw4Mi4MlOgQnoAWoOQgXee2s6NmUGP0JmDKS3zXGG/?=
 =?us-ascii?Q?0iTg/jLM4a5LZD8Je36mpOo1MXIHxsHat2tLNSIBq1B/78l2G+YPyOHSpQn8?=
 =?us-ascii?Q?UtmVD4awY+Odn3xgwMJr/uwOyuBq85yGPcic2J9slcelqVuErQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8452DF422F792E498EE5A043ED656361@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d92a396-3ac2-4434-d88e-08def145e1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 09:59:17.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB11484

On Mon, Aug 03, 2026 at 11:28:46AM +0200, Arnd Bergmann wrote:
> On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
> >
> > Patches 1-5 are tagged for stable. 6/6 is deliberately not: it changes =
the
> > atomicity of multi-element mailbox transfers rather than just adding a
> > check, so it seems better to let it soak in mainline first.
> >
> > Build-tested only. I have no Cell or PS3 hardware, so none of this has
> > been exercised at runtime.
>=20
> These are all reasonable fixes as far as I can tell, but I'm missing
> information about why you care about spufs. If you used some atomated
> tooling, please add some reference to what you used.
>=20
>        Arnd

Hi Arnd,

We're working on a paper on LLM-assisted vulnerability research. spufs
was just picked at random as one of the modules to look at. The tooling
is an agent we developed ourselves. Should we add an Assisted-by tag in
v2?

Thanks,
Junrui Luo=

