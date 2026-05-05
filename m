Return-Path: <linuxppc-dev+bounces-20475-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553E0CD342F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 10:12:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8vSr6Dlkz2xfB;
	Tue, 05 May 2026 20:12:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777975932;
	cv=pass; b=QCguYpLGpIa9HycBOykqiVpL4O5XWu2mFy5HXrV3JrV5GIqM4jQYA/jf5RKQWKSEqtXQi4AlTuFAnwIuFEM+gQLClbUwzQ8jS0BSPX1FcbA4z6KptWtJ1zUHoRFB3722TDtZdD9fNou78i4hI0YobDwuMTFpFNv/eTCXHnxB/iivVfTBYFZDTHKCNaIUn5oAV+A6ROce2K4f3Q0y69ojpwM+tw5QAVgO6lUE96RnugT6o86IwPtQOkS0egz85UtzBWJvA3yl5l7N5m5zqLlJkOklDgx39mVdZfx423i55Ifwx5trSEKftcAtnL6w+VQcTxpY0Ze/DsuUQgECE6j5KA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777975932; c=relaxed/relaxed;
	bh=eidSOQEut/hjXIAW+CuKkytdy+WCoRJ9uMOqHiV9Ays=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mYAjohvtoNb8Zz12CKDQaZLnNsDBHA4hMqeoAqb/XeutQ5RUGOroswZYIQwsDdFl04UKanNy+3F25MWQnflEC/21vKqRR78PsUyD9e115X2FCgK+QIKChzYAXxiSeNcvqno8z1cuqgM+qDuCaO+LEMxEqkFNiGN5AQDHboyae+Ku8l0FMIpSRrbUlvyJdvkRI81EUmMBnV9boqq4wcMgBRWI9VGQUWD971NGBUcLn16Jxq5562BrAw4ZyIbel3uc8w97MFThCZ4CgX+rUsrl3Ae3QBVnn6VYuOOmGa46cn0YwA+h8qi+JnveHDJmjRcOtP2+DAjcdZbgibr1fzMveA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=rceZgSXk; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=rceZgSXk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8vSq209fz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 20:12:10 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWniJ9hKD/gfeRkDFriTSo+icOc7jtlQ94i3fn9BkWorSSprzjrgLq225cRYlX2v3EZ8BJBBzUa+YBfI3oR4jY3bxYNMCHIWTjdnUzAcHyN+4C0YE2hN5kNPUzcm5XR+TN/xAPO9b9Bm355IjKJ/r4fo3YQZRucEmCmfNsGM4v7BWeMlnMS0WiA7R3keyySLC+1LA1L5osIeCnM0pDxUNUWyOMQ3Zry+OS1dKdhmlNdiY/nI1QIugKjAYqrOr89cEM3pphWj1MiTUT27vikk3xHs5E6RWZm7OLKwZ2JC/Y4OIoY0eozRgh1qHigh9ClxlpTJ/9b4rRXTExunoUaEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eidSOQEut/hjXIAW+CuKkytdy+WCoRJ9uMOqHiV9Ays=;
 b=GVnDFGqkIBGB4BC1+LlHr05au8sVSGIk96J+L5aU/NNXC4t7idMu7w4frQZDWRoN738yWqi8oUqtGYQ5Q4XnQePSHawaunhITjYvr0Xg/JyZiieHWWobVmY6hiLO3YpnoTGUxK4qcvwc4aP5iPyX6o1KnOR8MwFyHg8RLwvHCmS0ujbouVgUdRyQhM8klekZHUcpAEzJw5XYj9OCSIc/gev+xb+Z1/ztsAd41Mn1RlSOqQ6BusRkvue3liZRHBBQGyc+aiSR+llh75GnbJt7N8aTZx3vhHEIsQHAnvgdp6fyYtCYv2h93OteJBA1AArNNNURNgCw7QqElyRVH11m5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eidSOQEut/hjXIAW+CuKkytdy+WCoRJ9uMOqHiV9Ays=;
 b=rceZgSXk1h/ik3uXM8VTp+bwqW0Rb3Gbf5HT4K++QZHwdKw0mOU7MC5r7H/KnFVRJX/nRTA+WpefY+7NfRnSJRBqXLhB7e9pZT7FnU7VBL77reuBXTyAeHDPv6pQw2NqeoApt9iaeNyggqHwN/Tan8+Ji82uu7WhmhvqoDGhMtJKQrjHmVoYIAc2zfQff68iOhtDYhmOfuJi27HHZqzlaNDNQPO9r9LjUO2i+6D9sk7vxL98+T5s32g8aDkPlO/kaIa+qj6EW2wKGU51zWVsdaQetcn4wk02bGz29G17BrvLEZqxn5HiVLvx04eW7ApUMgI8tSJlLWmBO5EQWpkhZA==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by VI1PR06MB8902.eurprd06.prod.outlook.com (2603:10a6:800:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:11:45 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:11:45 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
	<qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
Thread-Topic: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
Thread-Index: AQHc2960xmhVPMAKekKnNexcW8lvMrX+6IyAgAAqBeCAAAqDAIAAB8Tw
Date: Tue, 5 May 2026 10:11:45 +0000
Message-ID:
 <AM0PR06MB10396A396796DD5F09809B301F73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
 <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
 <AM0PR06MB10396920527D0B69CC9D9BDFEF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
 <07fc37e5-7815-48ed-8632-62e896f8f6ad@kernel.org>
In-Reply-To: <07fc37e5-7815-48ed-8632-62e896f8f6ad@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|VI1PR06MB8902:EE_
x-ms-office365-filtering-correlation-id: 43d4698e-a9ae-4e3b-c255-08deaa8eb617
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 otuHD1qd0wXphnM6w9lwuT9p8TaRiBclmQeVTsFKTr2+5K2b8FgKu75KUu8TZSIDUiuf35sXhc24Vg1QAFJuxueou8YfiRxspNOPVsBFvwaoI81AnUaBMOkjHiEWXqEdd9+/7iqELhbkYUAE+8OPfNqfsLjqMbyz/fmLxTwiJKzkWhkr9JSMf4cMVpkOq5+NuoV2q2SUqhIlbyosiHYNthfof2HVV/wROvdB7S4UX46s80DZdrN3RfTWylDuhHN4xuG3An4z4uzNllzZjlhfoK7fppuUFvA78aKb3JehR2+dpcBxuB76WvK+A3J4JV/Rnh9f4T93x8+44HXVy32JwcinJDKc27EXBU8kHgMFNXggNIIDTNQOyk2SatS4QuqPAmrt1l+ip+xySRmjCq2n3RYgMaXNMLekOs0cmQ0cm46zQcCszBp7m5Rx7SEkLFPanGqnfNWaJdu0PzHyN7KBwwZdo7m97RnTksR1laOFDxNON0hw0b/xm3SOwVrDay0usiSymlOrdHBaf2XgoDrhv5n7sgYgLZqdnE86ifM3m7hVpyBFBmwZUOySOVZlNrOEigrtGEdEeASuR++sOjoRY8pFKqJN7soeHypw7pW4UBB36P9JVMeEWaC5okkLQqDQ8R5PkhjFGjNDQ3dOdZMDQ0uKq/VA8x3mwCCin5LfQUupwGvilgR/V23kXUwuqakkHF7ln3FPJ5aRSZDMz1QG26A0vpGtoWLXRyAEGs8XcDbIDsdF4lgiMnIuOXqdkaYq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWV5R2hEZmI4c1ozSXFFejlud1pPdHJVR3V1d29CRjFvQkdUR1NqQWMxcnVv?=
 =?utf-8?B?UVA1ZGdvUzdBZng3ZzBJWlcvWmlVejZHNmozR3VwaU9uaTVSdEk4cVV3UWRo?=
 =?utf-8?B?MzlJY05JdkZwcG8wWTNFc3JSWTUrYmFmdm1Rd3QrTjZjWDl4cHVMZkR0ZFJX?=
 =?utf-8?B?TER6S3BGa29LTUxINEFJWURZT2o3OHpFK2o4ZUtVNS9YZWIrL21Na0Y1SnVo?=
 =?utf-8?B?cVlQejZzclllY0FlYzNWMndPSXZUNnNmTG12b1dlRm5jM0Vwc2YvRVc5VVRn?=
 =?utf-8?B?RFd3RDlQeU5iZlFKK08yVFJjMzlsSDE2S1B2Y1lqVm1RQ3dBc2JZMG1tVkRm?=
 =?utf-8?B?SVNIQjhzV3BFZnZnTkVtSkRkK21tNWwrYWJrV2V3cFNUU1hSZFZ3VTl2UWc0?=
 =?utf-8?B?R1NLWkd0M3I4S2p4MDlsWEhYWUozWm5rS0krWG9Xc1ppcG5kaEpWeDEzTGxy?=
 =?utf-8?B?bTVQL3kvU0cwRnYzaElGSzBrUHhPdVRTb0pucko3MlRocjF2WG1BQWo3Q1VE?=
 =?utf-8?B?V0N5N2R4ZjFucXJQTEZ2SjNKam5LbzZBdUFLd0RlUXdsNFFuOHJzUkI0R090?=
 =?utf-8?B?eEl6M3h5dThERzZZMFlJakgvV05ZU0Z4N2tGYnlLOFFtbkxNaFVSczBlWmVh?=
 =?utf-8?B?L0RTMFZPUHBpMFBSWjZEK0dCU1NEWWs1ZThKRTVWQUlmeHg1Q1NqVklXQ1ZL?=
 =?utf-8?B?MW1NRVhqZmZEZFdRd0dtQlBKNUYxaFoxczd2ZWVtZzFoZDI1VWc0ejFoZG1v?=
 =?utf-8?B?ZWhUS25BN2lvaktPd1BtZmdhU1FIZHY0OHNFMVdLU3AzaU9BaHJkcC9WQm5Y?=
 =?utf-8?B?YlVnMWhvS3NaU2MzZlJ5d2h0TDhzRkRDQmluRWx1UXZtaUk0c3VaeENxYnpB?=
 =?utf-8?B?RkNxS0RRMWpDUXFwTlhSMGl3d2t4YzYxRHlzRE9BVlA4SXVia2h4WjFqYnF2?=
 =?utf-8?B?ZUt6RFpoNlBXSnhvZFduUStFM0c5RDJkK01pUGlYNE1WUUE3VmhFWjFVMlZC?=
 =?utf-8?B?cXFFNWxUY3RvZjA3MXN1VHp2c0d4bThuRXNBanRDL2pRTTFRamJSSlpFUlhK?=
 =?utf-8?B?aElUSm1kN2ZoelBQN1lneUZ2K1pTSzJYVmtYaVlPQ2RoZEt5UXBaT2lxbDdM?=
 =?utf-8?B?QTMwaE4zUmRDOGdWNlNqNGlUZ3NrVzFtZzMxcS9PeFg5Q1JzNWFCWDVucTVu?=
 =?utf-8?B?S1VxMXcyNWJuNThLU0NBSXpndzE0V1MxSWl0ZnFlYkdlN2JvOE9WZjkxNmJt?=
 =?utf-8?B?dThQOXF2Z3pDNTBGbDJ3MmtSYllJSVhxdFhTb01LVng0NGRWajBUOGltZU0x?=
 =?utf-8?B?bVFvSmVvUmdWL1FZaHlwM0dndmpzeUdPcFFQelloQkNpamU4dHRGL1k0R21V?=
 =?utf-8?B?ZXR4eHZlQ1NLQW5xL0ZGbDJjR0tRT0lqdU44Yy9IdnZnQld1dTdDOHVUSzFP?=
 =?utf-8?B?WURlZzUrVVVlVmtSaHBtb1hmTFQ3T2NmS2c0STNFYUs4cjBwUXhMSjRBRWNO?=
 =?utf-8?B?R3IrT3FrdmRwb0lyNlAzcE9mdHhvc1FLZGhjUkRXOWJ0cnBpS2diL21VOHN4?=
 =?utf-8?B?TnZIUmFNSThabFBGczd1T09VSTVRZEo3bXYyanBvOXd6cUYxZUlhMnh4NTBF?=
 =?utf-8?B?Qi9Oa0ljV3BTTG1HcWozbFQ0YVJoUXFyeTFod0xLWC91ZGlzV3p2SkU0VWpy?=
 =?utf-8?B?OFFsMUF6bklrS2Nxd3JwKzhYdGVLUS9kTitwdm1TZGJHUCt0UUJyUFZNMmdm?=
 =?utf-8?B?Rmg4cE5WMTFsTWIvYkk4Tm45eE15YmNManRDM0dYbDljTmR1bHJuTkU2R0hC?=
 =?utf-8?B?UWJSUXRmV1ZXcGhxYlliWFg3dDV5NXFhaTRXeGhmZHBaMDdHdm9rU3lsYlNs?=
 =?utf-8?B?QjdKakZ1c3FLYnJnYmZab0lQZGNtT0h1T0theWxjYTNYS3JLTWJzUzc1dXVh?=
 =?utf-8?B?ajZhVmg5aUNDeVhsb1NERjZQZGxrdG9SOVVhY1ovSkRGc3hrSHpMNG9yRHpX?=
 =?utf-8?B?cGVJQWZWLytJcjRNU2FyU05TQkRSaS8wWUduKzBXajFxZGFuT2N3WnZjYWNX?=
 =?utf-8?B?dEVGeGU0eFJjbEZTblowRGEzSGlCT0NNa3ZZNlFIWXY5dHR6bEE2RGQvVGpk?=
 =?utf-8?B?UEsxcjlSNmFzMDZvejA1c01VTmErVnZCWHhHbkVDWlpPdUJub3Eza0lDR0dS?=
 =?utf-8?B?R0J3OHQycHBIZlozcGFKUFhsY1J1c29nZVBSZmJEVXE5NVJYNWMrM0NnZ0NK?=
 =?utf-8?B?WHE4V2RJaGpQbk55UFVpdmllcmN6OHRpd0pGTElnUUlyd2E0LytOcHRBZzVk?=
 =?utf-8?B?cU95bUNzU0dWL012WXoza2JuREVaby85Mlp6T1JiaU5VaTJaVmZoVlNSc01N?=
 =?utf-8?Q?/5zz7D63y+ENxyFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d4698e-a9ae-4e3b-c255-08deaa8eb617
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 10:11:45.0212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xenSct/+v/4Ovq43TER+/qE3PxQD2z+/pdJ8kZEnPTM4Mlbac5ZRWTFKz4FBLeisOuLFNpOneYXnzhPke+dxHInNdJa5n0zS9su1Rhv3fSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8902

PiANCj4gTGUgMDUvMDUvMjAyNiDDoCAxMDoxNCwgSG9sZ2VyIEJydW5jayBhIMOpY3JpdCA6DQo+
ID4+DQo+ID4+IExlIDA0LzA1LzIwMjYgw6AgMTc6NTYsIEhvbGdlciBCcnVuY2sgYSDDqWNyaXQg
Og0KPiA+Pj4gSWYgZG1hX3JtYiBpcyB1c2VkIGl0IGhhcyB0byBiZSBkb25lIGFmdGVyIHJlYWRp
bmcgYmRfc3RhdHVzIGFuZA0KPiA+Pj4gY2hlY2tpbmcgaWYgUl9FX1MgaXMgemVyby4gVGhlcmVm
b3JlIHdlIG5lZWQgdG8gbW92ZSBpdCBpbnRvIHRoZSB3aGlsZSBsb29wLg0KPiA+Pg0KPiA+PiBD
YW4geW91IGdpdmUgbW9yZSBkZXRhaWxzID8gV2h5IGRvZXMgZG1hX3JtYigpIGhhcyB0byBiZSBk
b25lIGFmdGVyDQo+ID4+IHJlYWRpbmcgYmRfc3RhdHVzIGFuZCBjaGVja2luZyBpZiBSX0VfUyBp
cyB6ZXJvID8NCj4gPj4NCj4gPg0KPiA+IHdoZW4gUl9FX1MgaXMgemVybyBpbiB0aGUgc3RhdHVz
IG9mIHRoZSBidWZmZXIgZGVzY3JpcHRvciBpdCBtZWFucyB0aGUNCj4gPiBidWZmZXIgaXMgZmls
bGVkIHdpdGggZGF0YSBmcm9tIHRoZSBkZXZpY2UuICBOb3cgdGhlIENQVSBvd25zIHRoZQ0KPiA+
IGRlc2NyaXB0b3IuIE5vdyB3ZSBzaG91bGQgZXhlY3V0ZSB0aGUgZG1hX3JtYiB0byBiZSBzdXJl
IHRoYXQgd2UgcmVhZCB0aGUNCj4gZGF0YSBjb3JyZWN0bHkuDQo+ID4gQW5kIHRoaXMgd2UgbmVl
ZCB0byByZWRvIGZvciBlYWNoIGJ1ZmZlciBkZXNjcmlwdG9yIHdoaWNoIGlzIGZpbGxlZA0KPiA+
IHdpdGggZGF0YSwgdGhhdOKAmXMgd2h5IGl0IG11c3QgYmUgZG9uZSB3aXRoaW4gdGhlIGZvciBs
b29wIGFuZCBub3QgYmVmb3JlIGFuZA0KPiBhZnRlci4NCj4gDQo+IFdlIGVudGVyIGhkbGNfcnhf
ZG9uZSgpIGFmdGVyIGFuIGludGVycnVwdCB3aGljaCB0cmlnZ2VycyBzY2hlZHVsaW5nIG9mDQo+
IHVjY19oZGxjX3BvbGwoKS4gSSB0aGluayBkbWFfcm1iKCkgaXMgbmVlZGVkIF9iZWZvcmVfIHJl
YWRpbmcgdGhlIGZpcnN0IHN0YXR1cywNCj4gb3RoZXJ3aXNlIGl0IG1pZ2h0IHJlYWQgYW4gZXJy
b25lb3VzIHN0YXR1cy4NCj4gDQoNCndlIGVuZCB1cCBpbiBoZGxjX3J4X2RvbmUgYWxzbyBpZiBh
IFRYIGludGVycnVwdCB3YXMgdHJpZ2dlcmVkIGR1ZSB0byB0aGUgTkFQSSBsYXllci4NCklmIFJY
IGJkX3N0YXR1cyBpcyBzdGlsbCAxIHdlIHdvdWxkIHJlYWQgYSBwZW5kaW5nIFJYIHBhY2tldCBu
ZXh0IHRpbWUuICBTbyB0aGUgZG1hX3JtYigpDQpiZWZvcmUgaXMgbm90IG5lY2Vzc2FyeS4gQnV0
IGlmIHdlIGhhdmUgcmVhZCBhIHplcm8gaW4gYmRfc3RhdHVzIHdlIG5lZWQgdG8gYmUgc3VyZSB0
aGF0DQp0aGUgZGF0YSB3cml0dGVuIGZyb20gdGhlIFFFIHRvIFJBTSBpcyBmdWxseSBhdmFpbGFi
bGUuIFRoYXQgaXMgd2h5IEkgdGhpbmsgZG9pbmcgaXQgYWZ0ZXINCnJlYWRpbmcgdGhlIHN0YXR1
cyBpcyBjb3JyZWN0IGhlcmUuDQogDQo+IE9uY2Ugd2UgYXJlIGhlcmUgdGhlIGludGVycnVwdCBo
YXMgYmVlbiBjbGVhcmVkIHNvIGFueSBuZXcgYnVmZmVyIHdpbGwgdHJpZ2dlciBhDQo+IG5ldyBp
bnRlcnJ1cHQgYW5kIGNhbGwgYWdhaW4gdGhpcyBmdW5jdGlvbi4gVGhlcmVmb3JlIEkgZG9uJ3Qg
dGhpbmsgaXQgaXMgd29ydGggdGhlDQo+IGNvc3Qgb2YgYSBkbWFfcm1iKCkgaW5zaWRlIHRoZSBs
b29wLg0KPiANCg0KWWVzLCBidXQgd2hpbGUgd2UgYXJlIGluIHRoZSBmb3IgbG9vcCB0aGUgUUUg
bWlnaHQgaGF2ZSB3cml0dGVuIHRoZSBuZXh0IHBhY2tldCB0bw0KdGhlIG1lbW9yeSBpbiBiYWNr
Z3JvdW5kIGFuZCBzZXRzIHRoZSBiZF9zdGF0dXMgdG8gemVyby4gQW5kIGlmIHRoaXMgaXMgdGhl
DQpjYXNlIHdlIG5lZWQgYWdhaW4gbWFrZSBzdXJlIHRoYXQgdGhlIG1lbW9yeSB3ZSByZWFkIGlz
IGNvcnJlY3QuDQoNCkZvciBleGFtcGxlIHRoZSBmb2xsb3dpbmcgZHJpdmVyIGRvZXMgdGhlIHNh
bWUgQUZBSVUuDQpkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvbmV0ZGV2LmMgIA0K
ZnJvbSBsaW5lIDE1MjQgZmYNCg0KSXQgZmlyc3QgcmVhZHMgdGhlIHN0YXR1cyBmb3IgdGhlIFJY
IHBhY2tldCB0aGVuIGRvZXMgZG1hX3JtYigpIGFuZCB0aGVuIHJlYWRzDQp0aGUgZGF0YSBpdHNl
bGYuIEFuZCBpdCBpcyBkb25lIHdpdGhpbiB0aGUgd2hpbGUgbG9vcCBhcyBhbnkgZnVydGhlciBh
dmFpbGFibGUgcGFja2V0DQptYXkgaGF2ZSBhcnJpdmVkIGp1c3Qgbm93IGFuZCB3ZSBuZWVkIHRv
IGJlIHN1cmUgdGhhdCB0aGUgZGF0YSBpcyB2YWxpZC4gDQoNCkJlc3QgcmVnYXJkcw0KSG9sZ2Vy
DQoNCg==

