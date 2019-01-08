Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92A0C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:51:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253782087F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uvXZVwIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253782087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YnZl1PRHzDqND
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:51:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.51; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=horia.geanta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="uvXZVwIA"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40051.outbound.protection.outlook.com [40.107.4.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YnWB5MXqzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:48:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIie7g4g9PTUdNhH2XjdJYgs5ujUqWKjTmQCLjCzRXI=;
 b=uvXZVwIA0AC9uueiblPb+XHEyQsz/hvseGRp2svbG4IBq5jGgvhlxJXYaIX2SaMimgbdAsNOlTnCR6yN+YdbvJpjnB/O04XE6JiLx06i3q6bBaJws11d98s9WrCJMEV/ocbc9ClrrdPa7l/aqsyKN1UTl1nyZacLJG7XqBhuGRA=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3824.eurprd04.prod.outlook.com (52.134.16.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.10; Tue, 8 Jan 2019 09:48:01 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::9c4e:17cb:deff:1c18%5]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:48:01 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 2/2] crypto: talitos - fix ablkcipher for
 CONFIG_VMAP_STACK
Thread-Topic: [PATCH v4 2/2] crypto: talitos - fix ablkcipher for
 CONFIG_VMAP_STACK
Thread-Index: AQHUpx9UGW7+aEGULEyypSrTXfCdLw==
Date: Tue, 8 Jan 2019 09:48:01 +0000
Message-ID: <VI1PR0402MB348598283A66F0F2C39A437E988A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <5ed91db5e2976a4c260465c3d027acc9affd2d2b.1545445924.git.christophe.leroy@c-s.fr>
 <e082265fba04b4a4c17003a73820844c8feb5017.1545445924.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3824;
 6:qTQM9Llue9GfJLe8OU0e4ZxxUDKLwVUTUtz7fEaKiKkuSqgGAmAeRG6G0ALPPxiwOh6nQCIN3l14QUKPLINJsUw4iBNER1xaiY6EqokVqcuDJRU9aafyURM8w3J11WV64MUuT2frYJ7KC1ifdIGx+Ox8Aj/U+CSsawm5r6txFqb1A2F+4YmJGsaD/bW4xOUJxdKyc5aE3GJLzlncZ0V5lTKhWFNAhHjITqAgtyPL+Xsg+KDNgpwNOcjynaA3HqwAOYG2sx3CfydUfpg6l4ofcph/NueHOLdcfNNaRgqILyOM815zAI2LTZcBm1av2pzleaMnf7PpYlK4x7Gqe6aCDIezwJaSLpgD0GpD75eUJxI04rG68ZIp6M3JMu51oGEgHoGxN187RPjUS5BxnVeqXSRryPShYkf+4G6rgcdECXhfe9VeqzcnJN//iaVOVn0dZ1t65quhBY5pvjvRgvQIeg==;
 5:aNph5HysEZRGdKMgTW2zy6unRh6BIvvWh5kOCHesjsqfrgIHdmoNAJlOuB1c46+WGfD6zFwmS1/IJne98YKQNyP5rcu8VJJhXs9AevtjBTaNbGbwZ3dKM8Xniw9xeI5Pz1/NKcR2L/ZeYy0uzXlKW4bmIWz4+yD1xwj4gfNRuDkDO0lmhC9PdrXjM7Cjh9JDuP+P5CTOMoU5J8rZEVlYPA==;
 7:CVgXtY2JWBNWZnl8AtD95I8x1W8vNCYYUnx5GO+kIl9yg9RitoqlBjVg+YPig/nRw7T0nmQvmxTFM1yi/W/cpV8oTd0eB7qed61wF/djbc5m/rycDNlxO9QRXV8WoMfnm080vimO+kn2qsf/PMhBcA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6fae2ea9-b6f9-4610-9fe0-08d6754e60dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3824; 
x-ms-traffictypediagnostic: VI1PR0402MB3824:
x-microsoft-antispam-prvs: <VI1PR0402MB38241F20F5BF28F5D4F51059988A0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3824; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3824; 
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(55016002)(5660300001)(102836004)(486006)(110136005)(229853002)(97736004)(54906003)(7696005)(74316002)(186003)(6506007)(53546011)(68736007)(99286004)(86362001)(316002)(575784001)(71200400001)(71190400001)(6436002)(3846002)(76176011)(14444005)(81156014)(8936002)(8676002)(106356001)(476003)(81166006)(14454004)(33656002)(256004)(2906002)(478600001)(446003)(105586002)(6246003)(6116002)(26005)(9686003)(44832011)(4326008)(53936002)(25786009)(66066001)(305945005)(7736002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3824;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kmTRncY7Co4WbIx/oDyOvHVomYjOEBG2Lbpp7TgDlZmLsVJXDT+/3UEfTfJPwVYM/JD2qtj1O6AwwBqsoBtYdmQpN82ayLyMKgt3krNridJ2QVJTQl2qTGOLIFl65VqFp922oF7ufmqO7MjVTyP+Jps7WX9lLB1w1EIOVnoAMxnxbpIoqhzJZMWx3ttppo8ReK0+aLtpy6uVp4LBhvzhO+ybIpt3Vnmu88mIMUsh+buxA9aCUFS8ET5XToGTimGVtbLkOJXUYMAfOWfat9MXnP/KEzyL8lfKFPm1D/hUZajWa+xYvgfpVjq6FouIpAnR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fae2ea9-b6f9-4610-9fe0-08d6754e60dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:48:01.1759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3824
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
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/8/2019 8:56 AM, Christophe Leroy wrote:=0A=
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
> This patch copies the IV into the extended descriptor.=0A=
> =0A=
> Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=
