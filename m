Return-Path: <linuxppc-dev+bounces-18274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92C9F53D7E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:39:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZMmJ0vxFz2yh4;
	Tue, 17 Mar 2026 04:39:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d409::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773682784;
	cv=pass; b=GUn/Nhqj0DGO1Sn/nkpYaXJr03l85PE2/Ef53n0JjwQP6l8gt9Le4xcastrSZuhfAtUgqApQiIX3z2GvSrWEnkaz5OhsO62e3bFvUq9NXPLfctEOcdwAtLn9GTBwEKKJ8OCD7cQnUODoIPbH9GUzf6b8uZ9Vyx7Dh5Xu1aza3r8/A6zgAGaU45mLwHf4ngzK7Big0zAW2xwH/u12VDliI+BJF3MRImQ+b1JdCZIUKdK5M4Z09EeYd8hvrW/ohNS8IKczdWnNecWiNCpvrzsjX9+6Jr4puehA77ZMYmVF1BCxSEFFPMzJBRI53Tq/DpxTam0ywZekJHaAspSAfln1eg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773682784; c=relaxed/relaxed;
	bh=8Sxv3CS2SJlti6XTML4hHXgChxt3ZIaJm/l+sB3ac00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EGvloJmiKQFy+o6fx015m2MWrMbjOmk9hzJLJxxVX0TIT97KKycCocRSI/tUyTz5pp9vwP6YquzWMgHjQcNVLsQblEGv6w1e1S8AsSuxvZ3t78JHq+r2jhbBexnevakuwIj6oz3PqohTlGBCbDbiGh10im7Pp+TEfskc8FGevMvnAqaYlUTzB3x36T9EQGNK/x2CSIhBfRewCCV1KuUfj0A8476Ix8ucGs3AH1Y/JzMevInHiJ6yIIHtJWgLt0lENKCoV7T/nWfwmRjlNkU0TfNJ1rJximAEoCPb+bug5pOiJyGLWbhdnsANxe/LdsWfB+177xBN5xiR7EUPE0jsyQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=live.com; dkim=pass (2048-bit key; unprotected) header.d=live.com header.i=@live.com header.a=rsa-sha256 header.s=selector1 header.b=AhS06jsQ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d409::; helo=pnypr01cu001.outbound.protection.outlook.com; envelope-from=gargaditya08@live.com; receiver=lists.ozlabs.org) smtp.mailfrom=live.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=live.com header.i=@live.com header.a=rsa-sha256 header.s=selector1 header.b=AhS06jsQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=live.com (client-ip=2a01:111:f403:d409::; helo=pnypr01cu001.outbound.protection.outlook.com; envelope-from=gargaditya08@live.com; receiver=lists.ozlabs.org)
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d409::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZMmG5kVbz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 04:39:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac4v+uVpyzJfiuT2U7UYQ/v4PxCh2x552ERCLevktGctf45jrgfhgfO0SGjFD9inakk++fFSO31Fcn/HN3ojnpHtNI/OeBhai68vvB2tLev8DrSYVqwtKlK3oW8pXx00rnm2kqYct+Z5UUxSCsYu0q95hghlshSl8ffWMZnLRtx9D3Ez4Z+CCF3t00EaYp+bHYYbITQDQ6JIlJhn6QDjk4y8YbpzUykv3uXrRpGJPf0og45hSaSK/upClqlYrNPZE8PXAiG3F8xQTGPJZUzUf6yudBLQxKHhe4WF6G8tM7cezEYESlhjQbg7HJRv5ZjWQyiv10S1RcfTArKvQ91Srw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sxv3CS2SJlti6XTML4hHXgChxt3ZIaJm/l+sB3ac00=;
 b=oF9rVLCDa6EfWm5fa/HOWWsRIgbq53Q7FcRi3aCRJXBxts0/Ow6IB5E8iCfEQMUjgqwNICPwxruzb3e4QIvEjYaBRJJ+GvmrviXBUihGYqSdMLmBJjjxEvpxakryB9D9YPHvjDPvpdJHejrO/j0WTIQRK2uQa7V2FMKgwzi7qeFU86vpphhQXvj4FiCVuNegBzFJVqHfX1Ow+HLgn8Af8pzth4MIBYP9Nfni6cfM0iLCD/5uowmeT2/LaOfInMpwOONAo/4sEdWDbUZkywGpjK8DRcjXGUu7xxr3CdqIvBeVDSKYBN2f9oZv2Civsq7wtCjjoPZ1qJiM1XO3AfXhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sxv3CS2SJlti6XTML4hHXgChxt3ZIaJm/l+sB3ac00=;
 b=AhS06jsQNh/Fi319Zsx1mdk90pVB2iiEphryfwMfDjWjTelxwK2W3RGcOg1UIm+aLkuYEUBp6OA8HftI4YC6doWnvE1AywBskyscOCrSzXoG6EAbpP6oYmQMA885uNFW4GpCwz+gmZIQfKNIE4kI0+bxjgQAv1XrqC6BDZV8fJGjrrDB+4M2MSmC+p99b7EQ4HHMGYHFC2YH6UjB81Wc7HZEejrxan0LBHi6LJDvc+KA8w7+mzpbExn/5Vyy8WVEpuv2o0CzNt74x9fsVzitzqeYY6n/hyYUtRdYjRYzy8bXkrFkXn2bu7U79trL0dbtO8YNm5Xin5Q0nHO2QvIkjw==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA0PR01MB8900.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 17:39:00 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 17:39:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 O'Halloran <oohall@gmail.com>, Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
	<YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, Dave Jiang
	<dave.jiang@intel.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Feng
 Tang <feng.tang@linux.alibaba.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: Re: [PATCH RESEND v6] PCI/portdev: Disable AER for Titan Ridge 4C
 2018
Thread-Topic: [PATCH RESEND v6] PCI/portdev: Disable AER for Titan Ridge 4C
 2018
Thread-Index: AQHctWvFE8HiDz1LkUmMp75SF+UD3Q==
Date: Mon, 16 Mar 2026 17:39:00 +0000
Message-ID: <EDD57FBF-B2DD-4C79-B8A4-75824F4B8912@live.com>
References: <20260113173351.1417-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260113173351.1417-1-atharvatiwarilinuxdev@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|MA0PR01MB8900:EE_
x-ms-office365-filtering-correlation-id: 77917c18-0de4-48ad-4255-08de8382e870
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8060799015|25031999004|8062599012|19110799012|461199028|15080799012|1602099012|53005399003|41105399003|40105399003|4302099013|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnpnNVBXdkp3NVViY3BGWDkzNUhoemlWZVZXK05NbDZvVVRQR1R0eGp6V3g0?=
 =?utf-8?B?WmNnT09nR2U0VDF2Z3pSanFid1VBeE9ZOC93cWxmNzF5a1VkYU8yN2NOcm50?=
 =?utf-8?B?UTVTeUR6dTRFdEttenpEc1U1aGFSWkxrWktMOFZBQmM3T2ZNNWVQaFMzWGYz?=
 =?utf-8?B?MFJ4dXdVYjNkaWNuWjNPbFI2LzNEU1orZTR0NTA5ZCtYM0NEUnlSM3RwajNE?=
 =?utf-8?B?a3Mvcm5jYzMyUi9jTnd4SFN4MnFwUGU4RWQ1REtERUFqUEZRWmluOHdpdXRX?=
 =?utf-8?B?ZndQUEdxdG1PaUxNd2poZHJ5b0ZsSUVZOTdzQVNoMGtmYmI0T0tMbk40Szl3?=
 =?utf-8?B?WTdBazNZRWFZNTR1eGhtb1NpTHNza2RBS0NnVlZwUmJIMFZLRUIzNDYzLzJw?=
 =?utf-8?B?bE1sRmJJYTFnK3h4VEhIQ1hleHFIY0xlc2RMRksycEhpamhaTG95QTNFNVAy?=
 =?utf-8?B?TTR6U1krekxtaWFkQ1JKdWdmSGNMSGxSYzhEZGR1WU01RTVOODdtS21paU0x?=
 =?utf-8?B?TW5UOUFFVGNTbjlzUEpYSElmbzE2OWRmdWxGbFo1TTdZQUhPaW5IZUdzV2FM?=
 =?utf-8?B?TUFTcjkza05sdG5LQ3V0Wk9ITXVxeVlIcXJpbWVoTkxyWFVmNkVTcmZzQmJ4?=
 =?utf-8?B?RzFJUzRwQ1hCTnM2VldQYjlHMjhHQ1FyZlROMXlzRENWQnd1L0h5VkZsL0tp?=
 =?utf-8?B?UEJ6ZnZIbjM1d0RjNGNjVUlCaFluQjVmbExyTithVEhYbjB4aytWYnU2RGJn?=
 =?utf-8?B?TUIzZzRET3dDaHk5QmZPV0poZUYzYW01SWIrdUpYMWF6VUM2QVpiSWtqd3J3?=
 =?utf-8?B?R2RGdFAxdGhzUlROV1QxUFNrTys5a0RJSFRzTXg3NU9LZUdyRndyRHRCNmcv?=
 =?utf-8?B?RkV2c2FPZUtDMjF3bnZsbFNkdTlhSkQxVFg3aW1iNDlxU0QxZWNPTjUrV0g3?=
 =?utf-8?B?ak9HelB0MCtFTWxGa3Z4YUwrcS9HZmdpTWNTQk42RGI2ZlNCeUlmcW5GR0hF?=
 =?utf-8?B?TjVUMGpoY1ArSnozbUIyMVd6WkFxSUNuMGFSRjZjNUJQTEJPOTA5dzJxYmcz?=
 =?utf-8?B?SDFGZ2EzelQ2YzZ6VGYxaHFOdG9RUG5xK0pjZ1JCdUxKNkswdTg5UzVKUWxv?=
 =?utf-8?B?dExZSVhSOUhKQ2NYOVN5MFpubHVYT0VWUFVzQlZ1VGJhYXVUa3BWS1JtQ2ds?=
 =?utf-8?B?TkVxQjRadkUxcVlYMGVpdTFCZG5EbTZGdFRyNHVKSU1WTTRnaXQ5MFNkZEZm?=
 =?utf-8?B?NTJDdzkrSTAzSGR2bVJ3Q0lvWVVUUWg1czNhVHpKVHhsZW1PeFcxd0ZkR01q?=
 =?utf-8?B?dHdNc0xWc2FGVnFYMzY3ZitiaFlMYlg2cUpsRjR6dzE4S1lQV3RoNXBtRDhL?=
 =?utf-8?B?dGVjTm83NDhZRUQ0Z1Q1TS82cmpoVmluK3JGbnY3U0d5dkovUk5YZ2RvNFdo?=
 =?utf-8?B?Q1pNNjFxN25NU01sMitaR21VQ29sL0g1ZkE2WlZ6bWZpcG05YUZuYUxQWTk2?=
 =?utf-8?Q?xM1j8Y=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emM3ZkZWODBJTG8vM0o5eEpBaDd2anFQVmVkdHI5bUx4NU5QMjVLSG02WmlQ?=
 =?utf-8?B?VUI5aldySGd4cEgrOFdyQWhVTld4L21RdjQ0aUIrbHQxelpveEk2WCtqQkkw?=
 =?utf-8?B?V2FwOCtZZXZHRGw5T1VVRFRrUGhNZWo0VXZEZ1VXWTNnOTV4YlQ3ZXpSVXAv?=
 =?utf-8?B?alJ6RzBtcG5LS1BrVzI4VDIwSDd3djRoQlV4L0hYMTJDMzVtT1hUT290Vzl5?=
 =?utf-8?B?aTZrMXJ0cnFkc21PYWRGOCt3aTRjSHdxTG9lVHRqaVgwMWpyRDdsRkoxZndM?=
 =?utf-8?B?d00zZlFaTTlBYWtucnh6b2ZoNEU5bm1iQ0ttYjN4ckNpaU1BTlBZMng2Z3My?=
 =?utf-8?B?MTNmL1lKR2p2Vnl6djBZd1BZR1ZyYzh0UDFocGVoQVZwaGRRQkdMN3RwNG1D?=
 =?utf-8?B?MXo3dGhUcUFzTjJMQk1QMGs0WHJYNzFaSW42ckJLdURUQ3FHeE5jZ1pFa1Ja?=
 =?utf-8?B?RkQvMjZFZ2EzLzZKR1QzVVdDTDVybzljdVJnUFFoazQrbldrU0RCZ1hKRGkw?=
 =?utf-8?B?WEdKL1VBczlsQTJtbUlPNDkrQWNidUhhUDZNZjZLY0N4UXcvMGMrbUp6WklO?=
 =?utf-8?B?K0lvMytBdEpIUEt1bElQdHJoRkhXWFZrblJnOG0xQzJVV1Q2VGVLNFI2eVFh?=
 =?utf-8?B?aXlLRmQ0ek0yQ3F1S3hoTXkyQWRFK2ZVMWNhRGVaR3ZVcXZtWGpKQkxsWERa?=
 =?utf-8?B?ODdVSVRHck8zTW4zTXc0VVROTmRKQlhvYXkrU1ViMGdPMkttMUEvUkM0dFVw?=
 =?utf-8?B?QXNXaFFaNmdJWTlvempqc0p3ajAzVjhqcjN2VHZHN2RVL2w2Zkg1QzVaaFNv?=
 =?utf-8?B?MVpvMHdvLytwNldKbVE2MUR0RDBlTjhiZ1dCem5hNE96QjUxWFRwRGdCclRp?=
 =?utf-8?B?SzRPQy9kQzFXN3RJMWRzd2xPUmtJQnJFbXB4eUtLZStmcGlsUkQ0UVNVV0tQ?=
 =?utf-8?B?KzdTUm9ST1RrYXBIL2ZHNDdvN0JOYXErVkFRQVlVa2M1THVCK1h3a1dpQVd3?=
 =?utf-8?B?NE5mUzlxcHZOMlQ1OWt0OUU1QXRCbGtUNm9JRTFuUDMvRVVvNW1RTTFialF6?=
 =?utf-8?B?cHJzS1pXUnV0TWw1M011azNLMGNMczlQZzUxWmpOaVJoN1NFbFA5TnlHcnhv?=
 =?utf-8?B?T2ZRNC9iSHpkTHd5UldlZWJjUTJZcFZLWHdmaXZqZGJVVllVcndXTEhDSjFM?=
 =?utf-8?B?VkM0WlZmK1lZTDlrU1MwODFkTUNLUG5ONWF3UDh2d0RPakE4ZUw3cnlBWFpJ?=
 =?utf-8?B?M05zakFweVZBRlFpZEw4OEpQR212QUVuejMzOUtIbnA1RGVFeW5VSzVKc1B3?=
 =?utf-8?B?cG95eWpad3B1dlo5OTBPakRad1BnQXhqb0pZOFlrOGNnc2hOSUJ1V09ZVjRn?=
 =?utf-8?B?YUUxYkRTditZOGpiUTlXb2FvUm8rUjlKNHdEUy9HVkJ6VVU5WGJHRU12Tzlj?=
 =?utf-8?B?M004SWRnNE5UM3VuazM5ZHhIK20wNUx5QkkweWhVMnh2d1JHenVOSTBjOThN?=
 =?utf-8?B?NGRZRkNpU25zT3F1dWNvcHQzbFdFRTF5cGFaRWtyR3g2dUk1RHczZ0VQaFk4?=
 =?utf-8?B?a3FldjNmeGN5R3hoTGpRNFFtZmlIbXJUeFZHOTh0Z3UreDM1ZUlxenNPeDgz?=
 =?utf-8?B?L0c5cDhaVk1CSTEzN201Zm44Mnp3Y3NIZTkzUkRRMGpSVWJWdy9CdVUxUFhu?=
 =?utf-8?B?WVIxQ3VyTUtDZURSTFhheUx1Y05xREtISWE1Z3lYNnRONWhyQ01Rd1FyNVpB?=
 =?utf-8?B?d0kwdTFhSFNjZDdtWHFCdEF1bThlMHl0VmhKNW1mQmdvSEJXSGN3VEVBOERM?=
 =?utf-8?B?RkpWcEhXQnV1UEJ1ZGFwTHYvMTF6Q3FwRTcrVnNaaHFVVEdmcXJNNjgrd0lI?=
 =?utf-8?B?RHlRUzhKb1p4aW9wY2Y4ZTNZbVNzUUpwWTJobkR5QWxuVkhFQ3MzS1lGSjlw?=
 =?utf-8?Q?f9s4Tsn2wdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DC3AD3921A0024994AD1F8A93EB3E21@INDPRD01.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 77917c18-0de4-48ad-4255-08de8382e870
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 17:39:00.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8900

DQoNCj4gT24gMTMgSmFuIDIwMjYsIGF0IDExOjAz4oCvUE0sIEF0aGFydmEgVGl3YXJpIDxhdGhh
cnZhdGl3YXJpbGludXhkZXZAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IERpc2FibGUgQUVSIGZv
ciBJbnRlbCBUaXRhbiBSaWRnZSA0QyAyMDE4DQo+ICh1c2VkIGluIFQyIGlNYWNzLCB3aGVyZSB0
aGUgd2FybmluZ3MgYXBwZWFyKQ0KPiB0aGF0IGdlbmVyYXRlIGNvbnRpbnVvdXMgcGNpZXBvcnQg
d2FybmluZ3MuIHN1Y2ggYXM6DQo+IA0KPiBwY2llcG9ydCAwMDAwOjAwOjFjLjQ6IEFFUjogQ29y
cmVjdGFibGUgZXJyb3IgbWVzc2FnZSByZWNlaXZlZCBmcm9tIDAwMDA6MDc6MDAuMA0KPiBwY2ll
cG9ydCAwMDAwOjA3OjAwLjA6IFBDSWUgQnVzIEVycm9yOiBzZXZlcml0eT1Db3JyZWN0YWJsZSwg
dHlwZT1EYXRhIExpbmsgTGF5ZXIsIChSZWNlaXZlciBJRCkNCj4gcGNpZXBvcnQgMDAwMDowNzow
MC4wOiAgIGRldmljZSBbODA4NjoxNWVhXSBlcnJvciBzdGF0dXMvbWFzaz0wMDAwMDA4MC8wMDAw
MjAwMA0KPiBwY2llcG9ydCAwMDAwOjA3OjAwLjA6ICAgIFsgN10gQmFkRExMUA0KPiANCj4gbWFj
T1MgYWxzbyBkaXNhYmxlcyBBRVIgZm9yIFRodW5kZXJib2x0IGRldmljZXMgYW5kIGNvbnRyb2xs
ZXJzIGluIHRoZWlyIGRyaXZlcnMuDQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjIwNjUxDQo+IFNpZ25lZC1vZmYtYnk6IEF0aGFydmEg
VGl3YXJpIDxhdGhhcnZhdGl3YXJpbGludXhkZXZAZ21haWwuY29tPg0KDQpMb29raW5nIGF0IHRo
ZSBjb21tZW50OiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIy
MDY1MSNjNCwgSSBhbSBkZWR1Y2luZyAyIHRoaW5nczoNCg0KMS4gWW91IG5lZWQgQUVSIGZvciBh
IGRyaXZlciB5b3UgYXJlIHdyaXRpbmcNCjIuIEFFUiB3YXMgd29ya2luZyBiZWZvcmUgNi4xDQoN
CkkgdGhpbmsgZmluZGluZyB0aGUgY2F1c2Ugb2YgdGhlIHJlZ3Jlc3Npb24gd291bGQgYmUgYmV0
dGVyIHRoYW4gZGlzYWJsaW5nIHRoZSB0aGluZyBpdHNlbGYgcmlnaHQ/DQoNCkFuZCBpZiBkaXNh
YmxpbmcgQUVSIGhhcyBpdHMgYmVuZWZpdHMsIHBsZWFzZSB3cml0ZSBhIHByb3BlciBjb21taXQg
bWVzc2FnZS4NCg0K

