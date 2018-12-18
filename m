Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D424C43612
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 14:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D67A217D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FVaVDrVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D67A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K0Pz2W4PzDqVV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 01:14:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FVaVDrVF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe07::614;
 helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=horia.geanta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="FVaVDrVF"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02on0614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe07::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K0LD21WgzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 01:10:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=750CEJ0D1iJZ6V7P3x7AhmUsvhxKS7D2Z7ET3X5PBRw=;
 b=FVaVDrVFTdfNTe+kjodxzuKlm7QMZ7LfUiMYpAzheSoYvY7VCuPGLm/qhfNnfRZgMePTPwK3MOQIC0dqlsk1CGNvoloLzU64VEgyIywyab2bgSyWQseAmbipnfXtE/L4i0P5k/8WKP+PSzaSsNgM+Bs5nJ8Wu2RjnX1K8YAU4V8=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2911.eurprd04.prod.outlook.com (10.175.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Tue, 18 Dec 2018 14:10:52 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b%3]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 14:10:51 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Thread-Topic: [PATCH v2] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Thread-Index: AQHUkrZRuumNw2oDTEu9A76Zrrromg==
Date: Tue, 18 Dec 2018 14:10:51 +0000
Message-ID: <VI1PR0402MB34859B80160A32A1AF0D959898BD0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <7f27d91e7e78d8aac28e8b6c600fd874b7d5be9f.1544686398.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2911;
 6:XTLhxyxlYzpVDFosmBYTC21ekelmBa7N9CKuLZmHNW7AbMqariMBG/E0KzIDUMD6j7P/zg553QAXmr3U53Vg4WWmJ+RmDkXWdQcXSXesWyvzM+4IUlWdfsPJy4WFx3gpmNqUPLtxsx+lyeDIgRAR7B0dnI4o3XQQn+/Q+Oub+Q0s5PoJifBWs3TxTOiwESUg/NEU4uYg+oLCCFn6fs5nW9aAFaQ6hELBgsdn1X5pwH3Ux65xmhfNGNruLB1d/Dp4VZAVZkgZr20xhe7aP+wDBPzF5+sTgvyRpXdgIW5PNosROcA8uatXm4rae5DaPaBbqvP59EYEX4aBWot2cEywrc2XKNm4fPFjbkepgsDaF1D2TQynIRehuBZdHa19sMGYdpTgNIeoFbD5IBfSY4NxGcnmgq4qG5xA5Fm4eTc9+gSJ5Ur/pbHnTFDuz2phX4oN3z3eEq6NfNhaxL+iNvF6mQ==;
 5:GjZZl/g03Xjr6PqJ1OpCYy23m5YNSINj95nMaVo+sI7n4uSAw2M6cckrkPUk1dnIWes3WEkaoD47LLTySuKmfudfETUzblDbn9uuGvr1ElfZtuxuOJyaHRy/SQUvr07UIoVcPq4qpzMlAMq83cSi3Fv2yGpFJVUT1tyy/FA+UQ4=;
 7:UHDzal+sp0P8eTNApw9l7qPRiRzDiIOfU9d8wKe72qbbVhjtCa77Hka7eyk73lnKdvUd0Y4vNAY0+zvi+2HpOZqt+uwnjXjyzuxmlZ+G3k1ScJziOEb3Bp4NPV0h5Agg/SgZTfrD0t82oj+UN7asKA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 814dbb3d-58c1-4a3a-1491-08d664f29e37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2911; 
x-ms-traffictypediagnostic: VI1PR0402MB2911:
x-microsoft-antispam-prvs: <VI1PR0402MB291110B0C2C18B71FF6FE39498BD0@VI1PR0402MB2911.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB2911; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB2911; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(53936002)(14444005)(4326008)(86362001)(256004)(3846002)(6116002)(476003)(9686003)(305945005)(6246003)(106356001)(74316002)(446003)(97736004)(486006)(44832011)(55016002)(105586002)(229853002)(6436002)(71200400001)(71190400001)(186003)(5660300001)(7696005)(81156014)(81166006)(25786009)(33656002)(8936002)(68736007)(14454004)(66066001)(99286004)(102836004)(53546011)(6506007)(76176011)(26005)(316002)(110136005)(54906003)(7736002)(478600001)(2906002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2911;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nyci3D3cx7MaOWKBveVm5cz2sBHinabAF8j5gOk6bURjD4hyeTMShq/BMViPfSkdGyNQNqn/uYhgy/Oijz1egx8bwwPuhjnFho6DaP5hyeCA3F50Rera0RyjaQ9JSPxl9B3c5VYdWfCirFGYpFPYNYpYQK9CTHn00CoGJi1SDsvew2yYw/9aJbFRENuajUEgvO89jutbh7GOiAivoNFj58NoA+DfZ1YfKYkjmA2QdeBGDF5s+rYq5MOnIJclVIABmkqB66AZNJLrBHjYIxcDWbfjJNs3eNOJFZBz4N1p+PjErJvaT2o1XDQkn6/Ye29O
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814dbb3d-58c1-4a3a-1491-08d664f29e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 14:10:51.7285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2911
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/13/2018 9:34 AM, Christophe Leroy wrote:=0A=
> [    2.364486] WARNING: CPU: 0 PID: 60 at ./arch/powerpc/include/asm/io.h=
:837 dma_nommu_map_page+0x44/0xd4=0A=
> [    2.373579] CPU: 0 PID: 60 Comm: cryptomgr_test Tainted: G        W   =
      4.20.0-rc5-00560-g6bfb52e23a00-dirty #531=0A=
> [    2.384740] NIP:  c000c540 LR: c000c584 CTR: 00000000=0A=
> [    2.389743] REGS: c95abab0 TRAP: 0700   Tainted: G        W          (=
4.20.0-rc5-00560-g6bfb52e23a00-dirty)=0A=
> [    2.400042] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24042204  XER: 000000=
00=0A=
> [    2.406669]=0A=
> [    2.406669] GPR00: c02f2244 c95abb60 c6262990 c95abd80 0000256a 000000=
01 00000001 00000001=0A=
> [    2.406669] GPR08: 00000000 00002000 00000010 00000010 24042202 000000=
00 00000100 c95abd88=0A=
> [    2.406669] GPR16: 00000000 c05569d4 00000001 00000010 c95abc88 c06156=
64 00000004 00000000=0A=
> [    2.406669] GPR24: 00000010 c95abc88 c95abc88 00000000 c61ae210 c7ff6d=
40 c61ae210 00003d68=0A=
> [    2.441559] NIP [c000c540] dma_nommu_map_page+0x44/0xd4=0A=
> [    2.446720] LR [c000c584] dma_nommu_map_page+0x88/0xd4=0A=
> [    2.451762] Call Trace:=0A=
> [    2.454195] [c95abb60] [82000808] 0x82000808 (unreliable)=0A=
> [    2.459572] [c95abb80] [c02f2244] talitos_edesc_alloc+0xbc/0x3c8=0A=
> [    2.465493] [c95abbb0] [c02f2600] ablkcipher_edesc_alloc+0x4c/0x5c=0A=
> [    2.471606] [c95abbd0] [c02f4ed0] ablkcipher_encrypt+0x20/0x64=0A=
> [    2.477389] [c95abbe0] [c02023b0] __test_skcipher+0x4bc/0xa08=0A=
> [    2.483049] [c95abe00] [c0204b60] test_skcipher+0x2c/0xcc=0A=
> [    2.488385] [c95abe20] [c0204c48] alg_test_skcipher+0x48/0xbc=0A=
> [    2.494064] [c95abe40] [c0205cec] alg_test+0x164/0x2e8=0A=
> [    2.499142] [c95abf00] [c0200dec] cryptomgr_test+0x48/0x50=0A=
> [    2.504558] [c95abf10] [c0039ff4] kthread+0xe4/0x110=0A=
> [    2.509471] [c95abf40] [c000e1d0] ret_from_kernel_thread+0x14/0x1c=0A=
> [    2.515532] Instruction dump:=0A=
> [    2.518468] 7c7e1b78 7c9d2378 7cbf2b78 41820054 3d20c076 8089c200 3d20=
c076 7c84e850=0A=
> [    2.526127] 8129c204 7c842e70 7f844840 419c0008 <0fe00000> 2f9e0000 54=
847022 7c84fa14=0A=
> [    2.533960] ---[ end trace bf78d94af73fe3b8 ]---=0A=
> [    2.539123] talitos ff020000.crypto: master data transfer error=0A=
> [    2.544775] talitos ff020000.crypto: TEA error: ISR 0x20000000_0000004=
0=0A=
> [    2.551625] alg: skcipher: encryption failed on test 1 for ecb-aes-tal=
itos: ret=3D22=0A=
> =0A=
> IV cannot be on stack when CONFIG_VMAP_STACK is selected because the stac=
k=0A=
> cannot be DMA mapped anymore.=0A=
> =0A=
Same failure could happen for aead.=0A=
=0A=
> This patch copies the IV from areq->info into the request context.=0A=
> =0A=
There is already a per-request structure - talitos_edesc - that should be u=
sed=0A=
to save the IV.=0A=
=0A=
The best approach to fix the issue (both for ablkcipher and aead) would be =
to=0A=
update talitos_edesc_alloc().=0A=
=0A=
Thanks,=0A=
Horia=0A=
