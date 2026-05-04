Return-Path: <linuxppc-dev+bounces-20398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4631ACD3423
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 05:59:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g89vB5B6Bz2yZ3;
	Mon, 04 May 2026 15:59:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777874342;
	cv=pass; b=GUvW5aD0QuFT4yz1QD5eGXJtl7cRR2vr5Fo3t5QGiC44aN/UbBLsy5gpJEhkdxgnwHFtGt9/tM1JCkbteTtzhZhtQh9CDy2JzA6PWTfqjnhnD0nZNakPI+4MZGPDF2TjRej2fo+Rnp2IHkmpGmnJHQ1f5riohpoxjDugJ4XRJnyEwoY4Py91CsJR5umk+fHF6RPVFJn0vZ0fzC6g52w2AlrEJQc5/w8y5Vix+cWu2uebbeceMgg34A/QZFTpbWVyi+QJA2ZbZG7gVgl9pIZ7Siqa7eeAocTKL0h3dpjGVg8t1eufKBouwbH65I/y3Mk8z25e2ifVnnJ6hoU0FM2afg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777874342; c=relaxed/relaxed;
	bh=goS/RWqTYCu+aSndrQeOOU2qMmF5HP0unuX6icaaVbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oySzlUnFhv+L8a+4ukU7P32qHzDgV6s8CiDkVjP02m5aLNIIFnytdfcblYkPL+YEfRlY04cx3Hv8tSwnfYMd5hfHImJELc2Pf/oZVclhf1lJA7IlZYpwcoPHCZj+uP5gOl2Hbs31Ukp0eLPYjP6EEB1W4iEvW9O0TrEMwBVwpskFOaN3/YOCAtvQOQtb49imTICz5+/OJVeaYau94xzJ/XjELUY1rSsRYFx2LfwJSeXBpsvdnqqEPuLYxi4lf5AZP3a31joEPxjMolY6EFkoksb9o3ngiVUYCLsplcFiy5eAhWQHjk10NYiWZmTJvmAzm6ZuMsRxL91oub2SCd8wbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=FL/eEEfO; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=FL/eEEfO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g89v9094Vz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 15:59:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO2v6XbQJHyd0r6tzCYFo/4Zh81nzyknI/5WLphX68Wipw0qRB5dkHbW1lJr9S5b/t4kbWP2dR7iTQ02FWbH6OA5n1uXq3LH2JNSgixCmlJGvU6F75W69XIBck0K6y24sST0w7/pfkD32p3kcsBP9cICGjAmrs2wpWASSYww10gu7NM9AU9pPatlBu/pdKkMeLhc0l/e/vHDCDiOp1Hol4faX/JON7BLeCRsE2bL3wewDgQQy4d1WBNbsmQN+1zSN2Kn3elIWnbESXGItVkARsQPeigi5OZjQRTtqhMiRO4pyu/pXGAHLSPmzKtx9tu7XQ1juTqsH0wsZESBF53SqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goS/RWqTYCu+aSndrQeOOU2qMmF5HP0unuX6icaaVbQ=;
 b=MeGEY2katqWHvHoonP7JLz5Lazi3cHNgu4OMWE88hubR6ZE9UuElpx/mLIC+JhqJGPwC+/SaBMl0EL/Ap2V6XQGU0zAzlLfa50Zpz2cI3Z7W1gov7mcwQeBySG99ZddsjKfJy9vpPA55AGTioKzGiMZ/E/HINMILFPwgqv4I8XdWRZGRW25SlsJGdUivCZ6vI77wJh/agLgr71gW/6LIYabs0x2y1Oh5ozxFq6v/R22C0SPsQ/o7mcbZhNLoqRBTn3DleOjvFYkEwwesCYZ5U/6WVrMVUAxUwyo92K4NWIP3KEUd1+OnDWxmedc4WYZNLhg/MezwlFmCzlfpI4B7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goS/RWqTYCu+aSndrQeOOU2qMmF5HP0unuX6icaaVbQ=;
 b=FL/eEEfOsY1VrgDQTwalWACxBhBwM4vq6EZYGHdTMN/CtSr14Aydogwq4x924StAIi0LvKK8OXMzsrykqtHq3PPtdnCckCQ5Mp/oWlFIs1Nvd16k7M6CuT0MX7WLIVNppPeMq82z58HophGcH7mU0V3smMAZM+9ucK0d8OpLuS5Ab0SkT/INq43mVGlXeuiLmgo9T+M/5OCOICiv2wfNGp5xtWqMoIuIzmgsCCHDkEIIMTqHnn7tE44Jdz5H4tOEnff/R3UJ84drHaU3DxvckR1K9eGEPXFGpabMTUAF85TYV1BrHw21Auk4GhZIgiLfjQCb1cFO0ayZWh+Lqwi3ag==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by GV2PR06MB11048.eurprd06.prod.outlook.com (2603:10a6:150:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 05:58:33 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 05:58:33 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
	<chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>
Subject: RE: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Thread-Topic: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Thread-Index: AQHc181CUlbpXlMAkUeEM17nC2/SEbX5HEUAgARIxcA=
Date: Mon, 4 May 2026 05:58:33 +0000
Message-ID:
 <AM0PR06MB10396EA1DB3F5A3DD966704D5F7312@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
 <20260501122756.GB15617@horms.kernel.org>
In-Reply-To: <20260501122756.GB15617@horms.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|GV2PR06MB11048:EE_
x-ms-office365-filtering-correlation-id: 612c9450-7b6b-433e-2d17-08dea9a22cca
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 be+eak+D5pOXe8ojbyIE57FSvdbbSTQMrap7F1CFewjYMsIbv0KGNnIQIglurGefK90Ao45T3xCv9LWCmNf6iFThDQVVDN3XaebsvpRIQCqFzCsXHlHMoVt8BNe9Yqq2DDx57c4W+2RWbYt6yhe1DgTG30Zy345Ri13/1KyRJ/HA2OZ0iYkwMVbxcYB4F1mlFY1ftX9DkaAYpWZNrNmcx66a93nsHHcbC+hmkz5lI0bP1bXmiXk39HgV+CN6XZrZdRjLRqtk02oHbdKnHMO+3KJ6wYH29nnj1oAkEKD/YV0DofSm4SOuw2e+/t67HsE0QPQGNBNtIbqAc3sZYsggXqPsw9TE8asrBZVwDD33SqS1APL0oRYjr7eMipKfN8vFHyMH21kIpbugY8zVMDJwrDmE+r8iCzB1cUTJhVa/qozHFlCv2zYoXQThjqvi5t6C777Zi5jRDOpJm1rhtMitYIdQDrMqMu4e/g4li4NYx40SmjYIxXIESF4zyJfvoeEHtDJf7FqDFVCSWzDESFgEQlmKPMnckCmdPrG+COmnf//xdz2NkhsknVNXMyClgKS4nhVw0SQdnRLrRXtJnuHsQS/P3DHEwyiUO1Nf8PadcTheb77xwGy0hxqDWsgHIlG6q4xPnmcFrtw0I0CsexaVrrJI/BwxIfD778ZKY65vnIeKwOQ6Q0EX8IEpxQLFrD8dN6Lve0LqVXM+h7rsWGBqf8SJK+LXQlXJ4OMfGm7prxSzWfPaSiV/1fX5QKGOUkDn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ggyXwVxrY/dARRcDPxgt5KaMe+/2P58iuUe1RggaRB3z84b1zkBOOMqDBsT5?=
 =?us-ascii?Q?Ifos8qkOu4ojfOvwZHethekE6bQnEIT05eYup4Uc4YkrPKPm+sCLVCPZTZ/5?=
 =?us-ascii?Q?p3iUiuJ9SYkqiOcqc5s9NR2B2Sg/95x3X1hS40uw9BgGzrkZP+JJTfrk2lRN?=
 =?us-ascii?Q?c9HtO7hvQ6BZQChjRgQAuN6Ck2DXsS/ve8VRrUoZ3UaX2yRb974oFoqurRCc?=
 =?us-ascii?Q?XANrkk0LOgRuv18d/YsJS2mF7Q16Tso1p+CzPPDharg+DR+ZpefGYpfdw5FO?=
 =?us-ascii?Q?dtrDkOdvK8/meW3YXys0k2zR2+hkEb0CD8pjBGnM5vmiT6xAF9W2U6Q8ZXlp?=
 =?us-ascii?Q?1qOEOd6Y/Y5Wq3Fs3QfgJzQxry1Vcmy+cFfEEvVpxOqP9aejhmNQXL1mnhw3?=
 =?us-ascii?Q?9z/ZAzQdg8W3AXAPtKjNafoTRDNICdGPzR3gAqXRnKGUKA4EXGBOAkAt45cl?=
 =?us-ascii?Q?/L44gfGVf3PHymt4SGivWfkLje/4OI0qcoi/AxVrUr/fUDBLQEq95W0cSy21?=
 =?us-ascii?Q?w75E+DqwmmcNhqIPuNbaDjG8pKQOPJRpYWJmuz8yIpnFPQaOl1qwhVD3Yq1f?=
 =?us-ascii?Q?owprCtzT5GSw5xQyrG1nY+G0lNsDq9Uiepkw2Z88C47l0P/AqtDOvnU89+OC?=
 =?us-ascii?Q?ad4nK24D2dxlXPIaf+wF+EgNRjIRxCUazzZ5AsH9Qglbi1jkdlqqkA6Ad2VS?=
 =?us-ascii?Q?kZJNs1zSWwpyxn0ozL3zKZ2e+hFNGA3etX5KInJihQPChNPlVLegXumRWI3P?=
 =?us-ascii?Q?ZBOTLFy9Rxl1H32vEciLmOAeEYkv7EnuF0/ITCesvc5yZcLEmQ1JEjFPXf+A?=
 =?us-ascii?Q?kkUD3hWzGqttavf6hSI6o76Sv1j0zl/ZwzyMePHESnXa/8wr4PSFKAEd9nLt?=
 =?us-ascii?Q?K9hEMS7X0d81ctYiVkqIzZ0zhvQPQcer0q852asn7ut/vAMdVH7R/F88nhLy?=
 =?us-ascii?Q?xiNS1lAQWaCfJDXTkEJKCeLHcY4ZPHIy6IK7tDu1TQ11mA6NG6YEKDaYNdJS?=
 =?us-ascii?Q?6qCGIAhKQ9iCQXZsytbfjElFP7Izyrnzb8P3AG42auGq5fIIgJfRXzNx7zdP?=
 =?us-ascii?Q?t2UwyYo3X1vrM13G5K6ZACbx8RUZc8o+Jc+hgSh5A35PGrDz8Gy8DEMMPB60?=
 =?us-ascii?Q?tk6Tvmp/UYQK4Ya2ceZJVhBWjNpYr6+xWy0KBfK3cC0yd7CXvcRnghXnkea7?=
 =?us-ascii?Q?vJ66gGa5N9TEEDbb6CJkW8auuRXQ9ykaLkwJu2WoUnxNAOUccc/JpEPE7UFM?=
 =?us-ascii?Q?NFDPHt9lTj3+ROceiBqYjpJDJSynGLsKYe1nQ4vnNwwQQxnaG9QiAR+HwK/9?=
 =?us-ascii?Q?I2j64cP2mx/dErMBq9PyxP79m4e5KAhRzupparQiBGUMemOh84arIoMJwbIe?=
 =?us-ascii?Q?jBDLpGBYKCah8rSEjkq9Gkb/ORv7rNHlz2lnbL34d6GiePwGGRs5FkVbQKe8?=
 =?us-ascii?Q?Lw+Ie4ptzTFILNLqC75HDmPOqefUTi5shEnnDOnuF9v0NqpMgHit18n4CgYT?=
 =?us-ascii?Q?5+n2mGpaR5aT9wvHvdJT2pE1IqEH5VMtZs/Xi7IWUUYHE6IR9jol1aFNcUlP?=
 =?us-ascii?Q?cDvZDacnYPqHtE5fOWUyIikaLoGX1ebS4SfbZyNO/xDzvZ7G6zFv9VMFdsrb?=
 =?us-ascii?Q?3pFyjmcDYfe2Itri49WTgZ9dPXwsUx/c7W8VYlNjLX/zatkqkntG7ijqeNyH?=
 =?us-ascii?Q?1DcpV9WVttRLc2j0QDXNjMe2e9PhxbELAvqqVqi8ywdSAMqZfBqDICABJzmT?=
 =?us-ascii?Q?OLCr6KRVVJelqcVrxtC86iSokF/lDrE=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612c9450-7b6b-433e-2d17-08dea9a22cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 05:58:33.4036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAdVORKISYmfwpVyVK8ueKG8T6m4LBArpxSvgvcE2wMDcGjQhFYxzODgcv+p7b2yrnb1qZ57h+0Pq3ZEv4iGwM3kw0bxCrpCEYT2puCH+Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB11048

>=20
> On Wed, Apr 29, 2026 at 01:42:07PM +0200, Holger Brunck wrote:
> > Unmapping of uf_regs is done from ucc_fast_free and doesn't need to be
> > done explicitly. If already unmapped ucc_fast_free will crash.
> >
> > Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
>=20
> As a fix for code present in net, this warrants a fixes tag that cites th=
e commit
> that introduced this bug.
> Perhaps this one is appropriate.
>=20
> Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")
>=20
> Also, as a fix for net it would be best to explicitly target that branch,=
 like this:
>=20
> Subject: [PATCH net 1/2] ...
>=20
> I don't think it's necessary to repost to just to address either of the a=
bove.  But for
> reference more information on the Netdev development process can be found
> here:
>=20

ok I will take care of this next time.

>=20
> The above not withstanding, this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> FTR, an AI generated review of this patch is available on sashiko.dev.
> All the issues flagged there seem to be pre-existing and I do not believe=
 they
> should block progress of this patch. But you may want to look into then i=
n the
> context of follow-up.
>

Thanks, I will have a look at this.

Best regards
Holger


