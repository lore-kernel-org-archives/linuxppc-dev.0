Return-Path: <linuxppc-dev+bounces-20571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B37ACD3439
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 15:08:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBFxK2JwSz2xQC;
	Fri, 08 May 2026 01:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778166485;
	cv=pass; b=JwQ/VCg4evxYp1Tv2w9xHjn+d1LaYB2Q09LK6JBx4Hz6707kVlHe5/XyUqMj3RrIdAxnTJLuk7K+z9sSFLzkQ4ToqWT9wcAj2a/lOvBIk+SyJomp3/XyWoQAy3W2vhFFc7qqoWYZla4zaVAxMo5fg3uPPNljIESK/WkMiqxYjiOXXFHrf+0QK/SBZ6FKPmLOht/JRNMMCVDIb1nR7dDUlsZRUXH0rZs8Sq3OAx8fSevDLGwatEufIjR9fQbultbFOURKSuIcZ6VRfqm66guo5+A1xTA9ZPqCj5u3DnQl5JQHORTxMlW2iEGAY2ty9gAIgfSSLMRd4x3ePl494PJGsg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778166485; c=relaxed/relaxed;
	bh=LswTpcupaSdZPPJOs7QBQX8VSwIFYM0YwdGmT7fjYz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ViNsZfa0E9vEaNfkBaRD82+I8NoR2ycbZJ8C0/wfM/OUNbOyGVdYSDTnxT/4dX7EfET2BD2QQKSJ1oF7rjvIjaDPXdhHC6VlvQuKT16HDEslFqSssu10mddp/OXizHOUkqLABv08zaDeH3/vw50Qi8xFY1XYKpH3t/kfrdD/3vd4xS4XQlaMub8TfP8UMG1YoMBS7eLdXeqQFUCs3iExwXWdWPMLayMlqKVnddru0WZJwV3PR2hQFX52IS7Qyh++TVwC3HUNr8bVBAQFGsDEaRhJz+YFRxzJMfKvzP6FhT7YFivcKzxopMojZB8JT7K6L5lRqJIoKzeaD17bjsN28g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=JuCSiuTp; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=JuCSiuTp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBFxD2nHWz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 01:07:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwsEYMKxfC027kG9g4CqSyxE491/d05QiWlcL2oGzJlWDo3/PCNxdsIgqflFylcKflRgvi1QkhdweI+VHP2pu7nng/inTSYu8SlZmsFj3EjAet3iTcdao8xUjG5MTkY0aLYueiuCjRdWC1sNnehysQrui9be2QSXJB3VoY9FBH/89y+5/qhEhI2vkbleM7cJ4nzyB/QMa+vbrjSrEEdJHqRYnLgKYpDppw6IRaeFrqu9lH6KV55vW1rEKhZTqfdPn/NQ2M2obffvxbwXq2LlLnrHQg8bVMTX/SN+rmzLY0gq8KyFi8ezSPeukJonZjbCOrta7zIyYpx2VgapQAl9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LswTpcupaSdZPPJOs7QBQX8VSwIFYM0YwdGmT7fjYz8=;
 b=d3H1HhQI6kPsCHnHzF3RZ36qY2idNkG28L2U4x8xbiYOyKVLimpwswzcwkXk99C89bKfPVuPHPkdRSX1FAj6/3bMul3ayQku2YYCWK5Omq8taFRSBWn4wp1UyfQqxneEd/v6DOJIy89jn/EmsW7V7PBFHVWKm0NiWoPLGJB04YFcFpFSnwKZ6IcGmgWypugTU/F6E1jY1WYriIthoudOgZW7HttFMtcUmkXLSVIz4dMElpfmR9wfBWKuoPM++S7LVwwJ72swjjlas10TijHejNXr6a1IQclNny8KGOkUW7CKWchuD+I4hAw3vnXXW8osZQD8cfxbnZyhphxMKDl/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LswTpcupaSdZPPJOs7QBQX8VSwIFYM0YwdGmT7fjYz8=;
 b=JuCSiuTpD1xOWykmFSfK1s3qRRIugJGnZDvw85GGAazKDyc58XIXutciywKi6SvOGYp204DxsxH4kfHSnTrjCpgo+FMnhmGVqpubkt07nVlnPClFP7p9i3IgY8e2T0KKy2T0c1s/I7N8DloN/mn99bE0vPhR8k+KnQMYi3nvG32d1SIM5/TXK41VxUF7tH9RTStMXml2DGXFla6HgPiprh7lIAxMqvZdzqSLj1P8UesMcS/GKT6rkTh6qxOkVkWKMM3IMqtzDTbZ2oE/lFxyZ0Yxx/2HAeb13i5VCvme7/GhxH39rEcLs2zbz+xhG/3ugm8SWLCW3aBEDWHYLHDo5A==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by PA1PR06MB9379.eurprd06.prod.outlook.com (2603:10a6:102:45f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:07:35 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 15:07:35 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
	<chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Thread-Topic: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Thread-Index: AQHc3Umw1+noMo6hfE2oruIw7o3WBrYBoimAgADKE5A=
Date: Thu, 7 May 2026 15:07:35 +0000
Message-ID:
 <AM0PR06MB1039657EB2FADD7BDAD4159D5F73C2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
 <20260506161629.5488a643@kernel.org>
In-Reply-To: <20260506161629.5488a643@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|PA1PR06MB9379:EE_
x-ms-office365-filtering-correlation-id: c86fc915-47c5-4e24-0481-08deac4a5f18
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 eSiu0Z4WefdYUlNwMXyAPl+kWe4F1vuzTFcY5zdU0QRLij888EkowoV5gPq3sfl5sYPYDGoA/SAUs6iiOmA1jhGMNwIg0p9zdjl5Sjqt2podtMXXWfeKdxFwY8aizQyk4tB+e5OElLDW2sCG5Sul26eALc/PZVJWZQFkirmiDu2Zk0NAGWlcPkrTy6+RRaOEic9BePJW/QSPQvwJyOtBZfdLTP9TCHsexBYqgs5Qm8IlXi7HYAzDylv5JNuluf++6ul9mqn7OejcqV4+FuUw0qTyYJULNXQOuOvlIqPlh1O6Z/yIngqUyAvIYzzT49cfSj2vGr6k7AZQm7rEiV/esqkAtTEVij2mDAldwfcSIHn+wbzER7jCtfw+SAvqhchaAQ8VLpR2/lOmt591Q5Due8ElgIJ9+gTnBThC4PD3WkIy7zNxQdY2kpvJzkinzO/KeoUnN9IXYsxQeSZLI2GRCH8WoftW9T3k6kpllI/SzQ28kvBPUPlM/hEwxloMal+0u3oJS/E3sCqh8IYTwcJCdQKqJVpOEu5Hfz5UiiN9soQp7iePW/hEo1UgsJSV9JyUVyndLVI/rYskskF4UXlfDtrw7jptU1gTO67mePk5MRWEk7hylacB+Ngo06j1kEqoh4kVW6OHEaQm9DBjV2YZU2ZjpsMQH11kHEjdfX4JrxEOwnyDh8Bv0olA+Kokiu393YSRCqzb1z6FiaVPBWdwBD6cH+ReU2Nj4sgNZRCtx7Zs8WtOHqI/1NZW/Q0plrQg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4CyvXtti4zDRaKh/SwgGfftq+b1u+EVoFgYhvJssS2OAFfyQ67wxIJW4pq4D?=
 =?us-ascii?Q?LnPhrGuK6HSfpgUVhHTA94jr5dbikVa7H09cXXOhkLY6O9W7CbaLCr9RogaP?=
 =?us-ascii?Q?HZiDq2n2ftydJ1hOhYd0x78N6KHBF8Li319vq+Ys2B8Dq54i+nebbwkqO7Wi?=
 =?us-ascii?Q?5Q9eqJNafmMyuH0JP5/R912Qe6At9hK9Ffkd3gCioPsYnevrwsoJBpVDfwxP?=
 =?us-ascii?Q?dGZfo3PorF95LaCqrU1MrsVDl3h5RQxX/bZrBlAymbC47u72PMWC6VSbLmoz?=
 =?us-ascii?Q?kU5/dqOWHezOLDtcyWGZ3pJ2nJCCpWk16/ujFvjOBRTS6RiRZOM+THv+V5hX?=
 =?us-ascii?Q?J7BYgKxaUAwxB2J0TZ7xFcf3lnLR1PNW7bu0PrhYOojKn8By3gXsFyj+AHC0?=
 =?us-ascii?Q?IPYecYQVfoR1QIvFkLgi9vTk6aKhQWc1ciSggQ6JxwI5LXkEPg8cXhfFbMGl?=
 =?us-ascii?Q?Ccvbyxg5TFl+t5FBo5YZ8cNvdMxFIKDK0UzDl4K2bMcX8RZfWdBXxNyHt5WF?=
 =?us-ascii?Q?j3aRSdaWsnnMI5RYRprhhno6eV1shwky5pHuI8IY5HSw5y50KdNOaDdyK9oA?=
 =?us-ascii?Q?CvQCAWM2EDQl2FqkMjet0W0vcLTIbwHzPHSVyl2ywLh4XUDQCkDtAj73gt5X?=
 =?us-ascii?Q?g9R3zn/YiqN2jLtX4kD+/bSAD6q/+Q8gkuwzoSsUJkJqMzV8m5HGQggZH5Oo?=
 =?us-ascii?Q?GWevRb9ky3Y/VYI1uBJMj+SIIcrnhdbt1LFtd9laGBWpCTUbQd1jcxKq5ub1?=
 =?us-ascii?Q?hiQS7+33mzZLQ6ssxf2FrAwyFcPWmzWtYw3t/2aFHHV0Tdd/Ig2wm443LVlF?=
 =?us-ascii?Q?r3mEPW2LsIukY78DLYogpqZEa2qoXq3ZK+bHtfWVmOzcCdxWRZXYq3lH3y7u?=
 =?us-ascii?Q?jyNQ0ZTysQ9KFtPryKjBtHNuY1pCuKdGfy3tMLUY7KZAb6znIAFFcIQ80eSQ?=
 =?us-ascii?Q?hN6+NgIb7kOOl3A6NhczoIiAVRifuOQL7wyan5NOkbeDYH5nBzCriI2Gx6sM?=
 =?us-ascii?Q?xf4p92NJTHFNAGS+OCA3Vc7rg0zXwKQ7T9jbU0bR+PmjthaWOFD6wsvPAF1L?=
 =?us-ascii?Q?tmEY2gg2kfRUJ8fwhbHsQGjMmbM2SYFhuVcEtLumTx9fxGXmKsxP8Go8fQnF?=
 =?us-ascii?Q?mAx72YHDXRcpXm+gmwnOBtqKvPglfgWbKfxjbNiUZgk4AXOlTODvEYU7raM1?=
 =?us-ascii?Q?lfAKc6/llwSvf7iphdhDSjtu5g2wqhyCcuXHoAoXDgKq0XMpngiwea0rA/2L?=
 =?us-ascii?Q?qWXO1iwc06IaE2Dm5F9iiCC4cONyRZCLFgTNNWs7gHBY2lJxExk72Y/XuT5R?=
 =?us-ascii?Q?REwg4yhVnHzmnDHqXPNZTciHScCUQlTG/Dftapw7vcJq/KA/12JuDT3aD3ld?=
 =?us-ascii?Q?Vn60kxWmWWsn0Ph3hUu0zifSq8Eec1VFW5uos8JZz+xj4OG+nNRFoI//g8ti?=
 =?us-ascii?Q?S9QFHcHlpgxtGihusuPOtrMUbkC5aHiIerohXLchyMp9waqljesfc7AsVj/Q?=
 =?us-ascii?Q?JWsVUc3Y8OCg5bXVD++waQf4FTQLrgjdrkaQX9b9nixEOY0q0e1g93DDqyk/?=
 =?us-ascii?Q?GgH3ibXwQqxjLC8PIdLSR4L0mhX9nSnxAEhCRXW2k8bd4W7mBKnMeYyBpaU/?=
 =?us-ascii?Q?8BpbtTqEW3ASHF4ORQ/85MCAos3IQ1g5PmyBNnzs82Mgl8YtixqgJf3fIc7o?=
 =?us-ascii?Q?Rr/CutMYFLtgJG+ibpFEp1Nht+BpKykCBgj32gTYLyjQt9ZreBmVrfohwvvX?=
 =?us-ascii?Q?fKaCtMvsAZlomn3xZ7inFqKeRg5oWys=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c86fc915-47c5-4e24-0481-08deac4a5f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 15:07:35.5558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyiDhN1h8yE0H/5s9aDIUyMjhYVxrKh7zTms34DvVbAsHHSZptz2+Y6JvzbATFOpSnCLmqzCYsTa5hcDhYW50b5+mu1MBAiQO1Em8C0sozQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9379

> On Wed,  6 May 2026 13:15:29 +0200 Holger Brunck wrote:
> > When the device is removed all allocated resources should be freed.
> > In uhdlc_memclean the netdev transmit queue was already stopped. But
> > at this point we may have pending skb in the transmit queue which must
> > be freed. Therefore iterate over the tx_skbuff pointers and free all
> > pending skb. The issue was discovered by sashiko.
>=20
> And you tested this how?
>=20
> Given the questionable v1 I'm highly hesitant to accept patches from you =
if you
> can't test them.

I tested the patch on a ls1043a board running HDLC in busmode on kernel 6.1=
2

I was able to queue some packets in the TX part simply in removing the TX c=
lock
for my setup. When I then shutdown the interface and remove the module I ca=
n
see that thel sk_buff pointers stored in the priv->tx_skbuff array, are not=
 freed
 without the patch in question.
I am currently not able to run my setup on latest master, but the changes i=
n the
driver compared to master are minimal.
=20
Best regards
Holger =20

