Return-Path: <SRS0=Si2p=DV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4529C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 07:39:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F96420878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 07:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F96420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CB46z5jtCzDqgZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 18:39:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=zte.com.cn (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=wang.yi59@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zte.com.cn
X-Greylist: delayed 926 seconds by postgrey-1.36 at bilbo;
 Wed, 14 Oct 2020 18:37:38 AEDT
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CB44y1BydzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2020 18:37:36 +1100 (AEDT)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 317529D58780FE449193;
 Wed, 14 Oct 2020 15:21:55 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
 by mse-fl2.zte.com.cn with SMTP id 09E7LrQ3056847;
 Wed, 14 Oct 2020 15:21:53 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain (unknown [10.234.72.110])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2020 15:21:53 +0800
X-Zmail-TransId: 3e885f86a710005-b53e2
From: Yi Wang <wang.yi59@zte.com.cn>
To: Roy.Pledge@nxp.com
Subject: [PATCH] soc: fsl: dpio: Change 'cpumask_t mask' to global variable
Date: Wed, 14 Oct 2020 15:27:33 +0800
Message-Id: <20201014072733.15175-1-wang.yi59@zte.com.cn>
X-Mailer: X-Zmail-Txt
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 09E7LrQ3056847
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
Cc: wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn, Hao Si <si.hao@zte.com.cn>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, xue.zhihong@zte.com.cn,
 Lin Chen <chen.lin5@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogSGFvIFNpIDxzaS5oYW9AenRlLmNvbS5jbj4NCg0KVGhlIGxvY2FsIHZhcmlhYmxlICdj
cHVtYXNrX3QgbWFzaycgaXMgaW4gdGhlIHN0YWNrIG1lbW9yeSwgYW5kIGl0cyBhZGRyZXNzDQpp
cyBhc3NpZ25lZCB0byAnZGVzYy0+YWZmaW5pdHknIGluICdpcnFfc2V0X2FmZmluaXR5X2hpbnQo
KScuDQpCdXQgdGhlIG1lbW9yeSBhcmVhIHdoZXJlIHRoaXMgdmFyaWFibGUgaXMgbG9jYXRlZCBp
cyBhdCByaXNrIG9mIGJlaW5nDQptb2RpZmllZC4NCg0KRHVyaW5nIExUUCB0ZXN0aW5nLCB0aGUg
Zm9sbG93aW5nIGVycm9yIHdhcyBnZW5lcmF0ZWQ6DQoNClVuYWJsZSB0byBoYW5kbGUga2VybmVs
IHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBmZmZmMDAwMDEyZTliNzkwDQpNZW0g
YWJvcnQgaW5mbzoNCiAgRVNSID0gMHg5NjAwMDAwNw0KICBFeGNlcHRpb24gY2xhc3MgPSBEQUJU
IChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQogIFNFVCA9IDAsIEZuViA9IDANCiAgRUEgPSAw
LCBTMVBUVyA9IDANCkRhdGEgYWJvcnQgaW5mbzoNCiAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAw
Nw0KICBDTSA9IDAsIFduUiA9IDANCnN3YXBwZXIgcGd0YWJsZTogNGsgcGFnZXMsIDQ4LWJpdCBW
QXMsIHBnZHAgPSAwMDAwMDAwMDc1YWM1ZTA3DQpbZmZmZjAwMDAxMmU5Yjc5MF0gcGdkPTAwMDAw
MDI3ZGJmZmUwMDMsIHB1ZD0wMDAwMDAyN2RiZmZkMDAzLA0KcG1kPTAwMDAwMDI3YjZkNjEwMDMs
IHB0ZT0wMDAwMDAwMDAwMDAwMDAwDQpJbnRlcm5hbCBlcnJvcjogT29wczogOTYwMDAwMDcgWyMx
XSBQUkVFTVBUIFNNUA0KTW9kdWxlcyBsaW5rZWQgaW46IHh0X2Nvbm50cmFjaw0KUHJvY2VzcyBy
ZWFkX2FsbCAocGlkOiAyMDE3MSwgc3RhY2sgbGltaXQgPSAweDAwMDAwMDAwNDRlYTQwOTUpDQpD
UFU6IDE0IFBJRDogMjAxNzEgQ29tbTogcmVhZF9hbGwgVGFpbnRlZDogRyAgICBCICAgVw0KSGFy
ZHdhcmUgbmFtZTogTlhQIExheWVyc2NhcGUgTFgyMTYwQVJEQiAoRFQpDQpwc3RhdGU6IDgwMDAw
MDg1IChOemN2IGRhSWYgLVBBTiAtVUFPKQ0KcGMgOiBpcnFfYWZmaW5pdHlfaGludF9wcm9jX3No
b3crMHg1NC8weGIwDQpsciA6IGlycV9hZmZpbml0eV9oaW50X3Byb2Nfc2hvdysweDRjLzB4YjAN
CnNwIDogZmZmZjAwMDAxMTM4YmMxMA0KeDI5OiBmZmZmMDAwMDExMzhiYzEwIHgyODogMDAwMGZm
ZmZkMTMxZDFlMA0KeDI3OiAwMDAwMDAwMDAwNzAwMGMwIHgyNjogZmZmZjgwMjViOTQ4MGRjMA0K
eDI1OiBmZmZmODAyNWI5NDgwZGE4IHgyNDogMDAwMDAwMDAwMDAwMDNmZg0KeDIzOiBmZmZmODAy
NzMzNGY4MzAwIHgyMjogZmZmZjgwMjcyZTk3ZDAwMA0KeDIxOiBmZmZmODAyNzJlOTdkMGIwIHgy
MDogZmZmZjgwMjViOTQ4MGQ4MA0KeDE5OiBmZmZmMDAwMDA5YTQ5MDAwIHgxODogMDAwMDAwMDAw
MDAwMDAwMA0KeDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAwMA0KeDE1
OiAwMDAwMDAwMDAwMDAwMDAwIHgxNDogMDAwMDAwMDAwMDAwMDAwMA0KeDEzOiAwMDAwMDAwMDAw
MDAwMDAwIHgxMjogMDAwMDAwMDAwMDAwMDA0MA0KeDExOiAwMDAwMDAwMDAwMDAwMDAwIHgxMDog
ZmZmZjgwMjczNWI3OWI4OA0KeDkgOiAwMDAwMDAwMDAwMDAwMDAwIHg4IDogMDAwMDAwMDAwMDAw
MDAwMA0KeDcgOiBmZmZmMDAwMDA5YTQ5ODQ4IHg2IDogMDAwMDAwMDAwMDAwMDAwMw0KeDUgOiAw
MDAwMDAwMDAwMDAwMDAwIHg0IDogZmZmZjAwMDAwODE1N2Q2Yw0KeDMgOiBmZmZmMDAwMDExMzhi
YzEwIHgyIDogZmZmZjAwMDAxMmU5Yjc5MA0KeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogMDAw
MDAwMDAwMDAwMDAwMA0KQ2FsbCB0cmFjZToNCiBpcnFfYWZmaW5pdHlfaGludF9wcm9jX3Nob3cr
MHg1NC8weGIwDQogc2VxX3JlYWQrMHgxYjAvMHg0NDANCiBwcm9jX3JlZ19yZWFkKzB4ODAvMHhk
OA0KIF9fdmZzX3JlYWQrMHg2MC8weDE3OA0KIHZmc19yZWFkKzB4OTQvMHgxNTANCiBrc3lzX3Jl
YWQrMHg3NC8weGYwDQogX19hcm02NF9zeXNfcmVhZCsweDI0LzB4MzANCiBlbDBfc3ZjX2NvbW1v
bi5jb25zdHByb3AuMCsweGQ4LzB4MWEwDQogZWwwX3N2Y19oYW5kbGVyKzB4MzQvMHg4OA0KIGVs
MF9zdmMrMHgxMC8weDE0DQpDb2RlOiBmOTAwMWJiZiA5NDNlMDczMiBmOTQwNjZjMiBiNDAwMDA2
MiAoZjk0MDAwNDEpDQotLS1bIGVuZCB0cmFjZSBiNDk1YmRjYjBiM2I3MzJiIF0tLS0NCktlcm5l
bCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24NClNNUDogc3RvcHBpbmcgc2Vj
b25kYXJ5IENQVXMNClNNUDogZmFpbGVkIHRvIHN0b3Agc2Vjb25kYXJ5IENQVXMgMCwyLTQsNiw4
LDExLDEzLTE1DQpLZXJuZWwgT2Zmc2V0OiBkaXNhYmxlZA0KQ1BVIGZlYXR1cmVzOiAweDAsMjEw
MDYwMDgNCk1lbW9yeSBMaW1pdDogbm9uZQ0KLS0tWyBlbmQgS2VybmVsIHBhbmljIC0gbm90IHN5
bmNpbmc6IEZhdGFsIGV4Y2VwdGlvbiBdLS0tDQoNCkZpeCBpdCBieSBjaGFuZ2luZyAnY3B1bWFz
a190IG1hc2snIHRvIGdsb2JhbCB2YXJpYWJsZS4NCg0KU2lnbmVkLW9mZi1ieTogSGFvIFNpIDxz
aS5oYW9AenRlLmNvbS5jbj4NClNpZ25lZC1vZmYtYnk6IExpbiBDaGVuIDxjaGVuLmxpbjVAenRl
LmNvbS5jbj4NClNpZ25lZC1vZmYtYnk6IFlpIFdhbmcgPHdhbmcueWk1OUB6dGUuY29tLmNuPg0K
LS0tDQogZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc29jL2ZzbC9kcGlvL2RwaW8tZHJpdmVyLmMgYi9kcml2ZXJzL3NvYy9mc2wvZHBpby9k
cGlvLWRyaXZlci5jDQppbmRleCA3YjY0MmMzLi5iMzFlYzUzIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvZnNsL2RwaW8v
ZHBpby1kcml2ZXIuYw0KQEAgLTMxLDYgKzMxLDcgQEAgc3RydWN0IGRwaW9fcHJpdiB7DQogCXN0
cnVjdCBkcGFhMl9pbyAqaW87DQogfTsNCiANCitzdGF0aWMgY3B1bWFza190IG1hc2s7DQogc3Rh
dGljIGNwdW1hc2tfdmFyX3QgY3B1c191bnVzZWRfbWFzazsNCiANCiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNvY19kZXZpY2VfYXR0cmlidXRlIGxzMTA4OGFfc29jW10gPSB7DQpAQCAtOTUsNyArOTYs
NiBAQCBzdGF0aWMgaW50IHJlZ2lzdGVyX2RwaW9faXJxX2hhbmRsZXJzKHN0cnVjdCBmc2xfbWNf
ZGV2aWNlICpkcGlvX2RldiwgaW50IGNwdSkNCiB7DQogCWludCBlcnJvcjsNCiAJc3RydWN0IGZz
bF9tY19kZXZpY2VfaXJxICppcnE7DQotCWNwdW1hc2tfdCBtYXNrOw0KIA0KIAlpcnEgPSBkcGlv
X2Rldi0+aXJxc1swXTsNCiAJZXJyb3IgPSBkZXZtX3JlcXVlc3RfaXJxKCZkcGlvX2Rldi0+ZGV2
LA0KLS0gDQoyLjE1LjI=


--=====_003_next=====--

--=====_001_next=====--

