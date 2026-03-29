Return-Path: <linuxppc-dev+bounces-18980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B29F3D60E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 18:27:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkNCM68Kpz2ySS;
	Mon, 30 Mar 2026 05:27:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c206::4" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774808847;
	cv=pass; b=Hb5hd84IQ4JrwiCiGDmE1vCDcgpKhqGBnMefC8XmxzvE0VDnzu/f1SEBM5qlUu9vVxFXg6Fr0b1+NnmlTRGFl8S8ll9537V2K7ip3hcnppxkViW3ev3v2i4HVPb+c9jt394YCHDmum038tLSx/akKLrZAy2xxpPswavoNP6pn2SM0gwDCMEnbZ/enHrdsvQIInv9DOBDHUmQkjJopq+Ss8F4+9Wp+em+/THFIO08YHrb5eYVc8rGkAi4tPcNTPluDG7oFffQNq6b6irD9mBL9p5dXhWRIDV5fTTA8khvSXqAo4RxaDCXcHdWfIIIYDda5OJIK8/GZXr0yX32t6N/Ug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774808847; c=relaxed/relaxed;
	bh=LpROU6M76Dm08BIkifw4PgH1ldUk0DGr1WrRYnx5rvI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QmEAj6ESEDaW1CQ+SaweFUK1JYHIgaTIR7uoDe+pOGa+TaQCKkdr77lqcog42A26JJq74HxtlujaAj2LcM/OLMQymgrdI4DByPIFotfuGqrL99KSwp7mNYnXdLe1S9kmHUObWsYjS/b3WtL4Of7Z+nu+dYz40l3DqgAWsJsiuRWLGFYBM9pcR/NG+GvuqxrTz78/DG7XivcU6faRKfDyOJrY6lz6NR//Q+ZgsWovqu1fVKIyY9x1BwdW7HYw8PsMdkREbTL3oJp5qKh0RW0O0uveAUyhBVHWUpuDAW0dCffF7/yOsdsfze31bgIMg6x5j8XIEYJS2EAvPw0/nF+PnA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=M6AveoTa; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c206::4; helo=cwxp265cu010.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=M6AveoTa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c206::4; helo=cwxp265cu010.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazlp170120004.outbound.protection.outlook.com [IPv6:2a01:111:f403:c206::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkNCL2Zvjz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 05:27:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue0cUEqSGIbrEm6cEOGose4/wY8JdWvgEiOuZxw8hkZkjM0Q6z8oVM2mhdKAWr9xT5zdP3KDVGE5izHEtEagrSc5AzjxhRI8i+l4D/eNAEtjSvSUmg76klgAm2MCwwTYR6GHMb54/YJ36q+w8BQxtKwi2xp/U4wmXu3aNGHOoVjoajR7BZUJSqN6TPN5XT8TLtQhBP6sVm7xZkHmmPGURVdbu7omonXmjpZRddnO5F8x/t2uOUvhFC/Y3iqlPJ1ZzxHKu/R8+54yfhctyJ9qu44VDHOmydP6b6RP8lyJNnR4vtmRmWsCBR5rzFwBZvpvBWo6dzYXpLRmidpoYEy+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpROU6M76Dm08BIkifw4PgH1ldUk0DGr1WrRYnx5rvI=;
 b=b3OPovNtbRmC8A7Xk5XLnAxKWPzjJczS91zLg9TadpuGRXmnzjbXcisU8JPtPFtaPLsZGKqPjIcQiwVr0UP4XL/pI8/wCc5cVGXL5D++HvxAWd9HqcUK5JMXQN4l7laQZy1gAxZyA4kWoPPxF/2j0Qgzx03gAU4tkMiHjXTBMykWcYNeeMMVAuyGJvMIDNyBViqOfoU1XQXzIiHK6lDXJov/YHPYX9qRrHZI4zjlzWXxnYnq3ufGDb5Zo0P4zZl5jQbFTEQb3ZzxRUQekaBUWhMCYtyowawJj0amFClhJOfp3heVq0AdLARoUVXFEGqyWeDSWehghtJrvy0f1r0FCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpROU6M76Dm08BIkifw4PgH1ldUk0DGr1WrRYnx5rvI=;
 b=M6AveoTahKXPqOgiVeBILgx3AsS35+LJvSYifeWfjytM375yleGhTH+A3ny4CR97H6TGQxRf54rS/EuchSf7iSI/xQxEAUWFwpFDUFZRQBq8wUWrTDIoch5W1gwxpnvbvvgXpyGvJC3+Y2p8lrfdAcx5c8YCdk7zcLhzis3226w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:46c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Sun, 29 Mar
 2026 18:26:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9745.027; Sun, 29 Mar 2026
 18:26:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 29 Mar 2026 19:26:55 +0100
Message-Id: <DHFH7TSMMSLB.355ANAWQS0N7B@garyguo.net>
Cc: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH V7 1/4] rust: Fix a race condition in Makefile
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Mukesh Kumar
 Chaurasiya (IBM)" <mkchauras@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <20260329160254.2592207-2-mkchauras@gmail.com>
 <CANiq72nxgwPUv1AJhRQSFNWtV+w_a-VqK3VWtjaKncRJkNNETw@mail.gmail.com>
In-Reply-To: <CANiq72nxgwPUv1AJhRQSFNWtV+w_a-VqK3VWtjaKncRJkNNETw@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5a4f49-43cd-4aef-e70b-08de8dc0c29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Eo5oMPl7PCB9vz2eH144JqMdwhybu+HHUqyImoww0vHP0gBfcsipukN6tFVuYjJB0cowoYrWEG56NhZ2RO9I4gfGb+NA/5VafLLR951mOEmWihXvaXks8cFAyS6l8M4WMbaqUCqrbHf85xCCD/C6wMjGTykYWOJzCjZp92squnnVrXTFu0L3kXmk2HAmT3F7APVK/jpO7ARKiyOyk2j9opPhpjAvTVR2WnHQokBoKhyhDFryQGrsyI9x5rEGbzhAAe0vAZ44ZiKfx4IGAyaThwqom621obF+UL65End6atM6cJnVwYLsfWoRc2KgddaYgi89cA96XKDqnIHkNCQmnitVPdSXb6Md4j3aRS2ZEFDd0YT8r5fBfYWxt5sHXDOxcfbU6GroMtbZAPqC0ctW7WR7yQdXSKtVKplkADkJo83FuNFesRFBE0HocdlqHZOOUE1HkMcCHMpy1IDg/NI6FODjps4IIz9Ie95N4Jd5Usw7MzMqHPhplEWPgwRFm5X6ywighh1eWUspPbZDGcAKuM1uLWiJ0+H/s1tgQAoEgJjA4HrH9HGnL5B5DqXgD2DFILOxLmtHdTgpxJPLzrm0ok6nIHQmmy+JPeG8dC4drJnJl6M3jt1h0dk+4IBHBjS6c29IbbMXhZymObd7WbEz92wiG1FseR/xu2P4mayfmnmm2OBeK7XsxFER8Xbfrtn0gl3kKPGeZWhPgZUsVEQwD68MIttY+pOPVhkVI5WHinA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJVMG5tQmpqZC9vczZuZ2VaN3h5NUtMY0JqNXJuYnIwMVVTL0ZTQzcrbzVw?=
 =?utf-8?B?SWZpSkJmYngxVU43WTZpOHBZSDdLeWdFRURZN0J4NXE2c29SUFdlSE9LVjlt?=
 =?utf-8?B?OCtJc0ptaXlQYWFLaU1XcjltV2ZTOFFTSlZPZ1NnL00yOUhxZHpCSUtLNW5x?=
 =?utf-8?B?ME9DMVZLWVc4b0xsdHNQMTNqRXJvV0RJeXh2aEYrbUFuMkJkWXJ2VVJuQ0k5?=
 =?utf-8?B?eVJWQmpLbVAxL0F3V3R1YlBpL0hOWnQyT2p5UTN1ei9WVFNsOHRBcGNlUlR5?=
 =?utf-8?B?U0FKNS9KOFpKS3BDQ05aUmp2SzVZNHptQXNQTFJmTk50eXh5ZkhhR0FoZGNV?=
 =?utf-8?B?NDdJRGM0Snc3dW8vbllRQjhHRGsvYTZ4ZmdTMjgxaFNVM0dQeEpJeDF6OW9I?=
 =?utf-8?B?YnRGa2VxcFdRL0xMKy8wWnNJUkZWOHY2c3hwYW1ibnhJYnB3TzlQZUhZVUpC?=
 =?utf-8?B?d215M0tGSHdPZ1dPY3k2ZXpCUTdXMEp6SzNMaTUydVhFVW5yWnh2alRiVTBl?=
 =?utf-8?B?R09RQWdWOXEyMkhrQmg3OCtWRmhTczJ0eGlZOW5lb1djdGxYUUx1T3dlTytH?=
 =?utf-8?B?Tm5seDhuRW5MTXZkOXlmSlFKbS9LVUZoSUk5bEZ2OUhxUnR3cS9MZGNsVmRQ?=
 =?utf-8?B?OXRIR3ZLbVlxWlZNcllWT21ISExCZm9UWVk5UVZsNDAza2RCK2RLbDFJZTBI?=
 =?utf-8?B?M0dNK2MvNzUwUnVKd2p0cTJmaHNqVnlZZUtLMndrb1lURU55eGg0M1dqMmpJ?=
 =?utf-8?B?d21OYVFpUU85ZXRnL3owVkZ0YXkraXlBNTIzTTUyZitJTTZJRzVKMWpHajNI?=
 =?utf-8?B?Q2VMZS9wVzZzdVhnbTdmNnR5M1hZU2FwZ3FvT0dLMGtBQUFKcU9JNFZxUHZJ?=
 =?utf-8?B?TUFnU2hBcFNDZVZQMGxGT0NiekpFeFo5V0t1QmU4Wlg5QzJUN1J1OUZicCty?=
 =?utf-8?B?MC9RczNlcG9hbG5VNmJlUHhmWUxSRC81ckFSQ0pXTGJuQUhsMHkwbGlYeUJW?=
 =?utf-8?B?aktSWGdwU1Q2a1JWaDNFZ1NCOEtEMStQZUZhRDk1SkJ4ZXV5R1Y0aVpqdG5n?=
 =?utf-8?B?T2F3SjVvRlJpYWRIVGlGdWpxUW9RK2puNHJzMEw1RWVrNXpsaS9OaHc5Um1E?=
 =?utf-8?B?OUhoYUliYURGSkxDdnhKcjd1NDc4WTRQWlFCdDhjWU04RE9tWTQ2UStFcUI0?=
 =?utf-8?B?azlLZlZrUHpXaVhPNU5MVVlBNmM4MDhKT3BGdFRINmM1K0tLMmVmK0lRdWp5?=
 =?utf-8?B?dnRXMytzVllBL3AvdHVUME5HTGhoYXRXeFlhRnF5cWpPODNlTUtUWElGV2xs?=
 =?utf-8?B?SG1BUTc2YVdoZmlEUElNSWVaWm0zeFVoMFlMeXFxelBsekZOckhsaUpqWGlZ?=
 =?utf-8?B?ZmRFZ2FuWExFcjNDT1Bva0MwU0pMeUplTVgrNXVGaGZUTXViRDJHK2k3ZjhI?=
 =?utf-8?B?ak5iNVcwSmtwMW5ZdHhDUWFEbytrbit0dS9KNXZUbVM4ZHU5MFE1RCtEZGVa?=
 =?utf-8?B?NDlSTkxDbXFUY1RZVjllS2hPSSs2Vyt5ZzkzU21OanBJQlNqUExWSStiQ2xZ?=
 =?utf-8?B?Y1VDcnZQQWx6OHZyNGIyLzdCakF3WmdFZjRpdlBjbDIxdk9pdUxnbkozMTZD?=
 =?utf-8?B?cnVqL2p1M29ESmxoTG1Scnpic3luMlNCa21vWE82Qzd4WTlrMCtjUVVmOFJP?=
 =?utf-8?B?S0dPRjR6V3BScXdsekh6MlZYMjVSZ3FtampnNHc1UmhVYko3Vld5VUtEajND?=
 =?utf-8?B?akxJZXhvdlNxYTBwK3AvU1BaQ1ErOTkrbEJ2ZkhsSEpPb0NzYS9ESkJFZ05O?=
 =?utf-8?B?OUpzYkpTUjhhT0N2eGdLR3NiOTF6Q0RiRmpPL1VBRWFGUDkvVkhWSHNUMU9k?=
 =?utf-8?B?Z08xd2E5UGZtRE9OKzdScXpBOVhrOEZaRTNiR1c0SVZIeWxVMndMZHZPR1Z2?=
 =?utf-8?B?K0JtNDZyWUF2QlYxQUJEV0pxV282NjZyTkRsdGM5VDh6dXEva2s3UDdraWxG?=
 =?utf-8?B?UTBKcVBwU08rSUVVYjJCTEhtSmxlYkMzNTkwZks1Vkt1RGczWjc2QzlQcmNI?=
 =?utf-8?B?TkhHa0JmWlliUGoyS25NQ25HVisyU1p6Tm5YeUMvUXFIQXozTlFXUXhqeVNj?=
 =?utf-8?B?NHc2V3BWTGdORTA2R21KOUFIaEg3OTZTalpwQkdLTkRWZlVUUWRlN3k5UThH?=
 =?utf-8?B?TFdWWjcwR2RJTmZxQmNVcnVOMXZqcG9xaFNJcHp4alR4YnNySlVHYWZDYWpJ?=
 =?utf-8?B?UjMyVG9abTdqRHhzbGhvWDJHaVRUTFBaV2E0OE1CdzBTZHpxcHJRN2ZkYS9Z?=
 =?utf-8?B?eG9HMWN6clU3U1RRdCtKemlwWmJ4VC9RRC9EaFZYU3dtSDdFY0VoQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5a4f49-43cd-4aef-e70b-08de8dc0c29a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 18:26:57.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzvTrvKmpoXH5A3tOKbPLj8fSLtmD+CeeVnoG0oCK+wmEcAYgpLbwv0A3JwXxMlRpe8cFvzi9K/3wZrSfumfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8493

On Sun Mar 29, 2026 at 6:25 PM BST, Miguel Ojeda wrote:
> On Sun, Mar 29, 2026 at 6:03=E2=80=AFPM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
>>
>> When compiling with -j1 flag in powerpc, the libproc_macro finds the
>> libcore.rmeta both in toolchain and local rust directory. libproc_macro
>> should use the toolchain provided libcore.rmeta.
>
> By toolchain, do you mean the sysroot one or something else?
>
> We should make it such that `rustc` does not try to use them to begin
> with, e.g. we added `--sysroot=3D/dev/null` to prevent that in the past,
> please see:
>
>   71479eee9da8 ("rust: Suppress searching builtin sysroot")
>
> In other words, we should try to avoid adding dependencies (even if
> order-only) to workaround the issue, but instead we should get rid of
> the root issue.
>
> Otherwise, after a build, if we rebuild only one of them, wouldn't it
> find again both? i.e. this is not really a "race condition".
>
> From the original message, I see this was happening when building the
> host libraries, because the targets happen to match, i.e. you are
> doing a native build on powerpc, right?
>
> Perhaps we could put the host `.rmeta`s separately, or something like tha=
t.

Yeah, we can either remove `-L$(objtree)/$(obj)` and specify `--extern
dep=3Dpath-to-dep`, or we can store host libraries to something like
`$(objtree)/$(obj)/host` and use that instead.

The latter should be an easier fix. Also, I can see that we're already havi=
ng
`-L$(objtree)/$(obj)/test`.

Best,
Gary


