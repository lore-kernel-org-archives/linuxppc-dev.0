Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A29CC4332F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Nov 2022 15:26:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N4yr34wfZz3dvL
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Nov 2022 02:26:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=jari.cn (client-ip=218.92.28.115; helo=jari.cn; envelope-from=wangkailong@jari.cn; receiver=<UNKNOWN>)
Received: from jari.cn (unknown [218.92.28.115])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N4yqH4ryWz3bbb
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2022 02:24:44 +1100 (AEDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 23:18:35 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date: Sun, 6 Nov 2022 23:18:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: wangkailong@jari.cn
To: benh@kernel.crashing.org, christophe.leroy@csgroup.eu, 
	mpe@ellerman.id.au
Subject: [PATCH] macintosh: Fix warning comparing pointer to 0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <c31207c.c3.1844d85a6aa.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+FL0GdjB4wBAA--.52W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CzgAFsW
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9tYWNpbnRvc2gv
bWFjaW8tYWRiLmM6MTAzOjEzLTE0OiBXQVJOSU5HIGNvbXBhcmluZyBwb2ludGVyIHRvIDAuCgpT
aWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJp
dmVycy9tYWNpbnRvc2gvbWFjaW8tYWRiLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21hY2ludG9zaC9t
YWNpby1hZGIuYyBiL2RyaXZlcnMvbWFjaW50b3NoL21hY2lvLWFkYi5jCmluZGV4IDliNjNiZDI1
NTFjNi4uMWMxYzM3NWE4MTdkIDEwMDY0NAotLS0gYS9kcml2ZXJzL21hY2ludG9zaC9tYWNpby1h
ZGIuYworKysgYi9kcml2ZXJzL21hY2ludG9zaC9tYWNpby1hZGIuYwpAQCAtMTAwLDcgKzEwMCw3
IEBAIGludCBtYWNpb19pbml0KHZvaWQpCiAJdW5zaWduZWQgaW50IGlycTsKIAogCWFkYnMgPSBv
Zl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCAiYWRiIiwgImNocnAsYWRiMCIpOwotCWlmIChh
ZGJzID09IDApCisJaWYgKGFkYnMpCiAJCXJldHVybiAtRU5YSU87CiAKIAlpZiAob2ZfYWRkcmVz
c190b19yZXNvdXJjZShhZGJzLCAwLCAmcikpIHsKLS0gCjIuMjUuMQo=
