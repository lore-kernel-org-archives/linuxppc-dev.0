Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD6C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 06:11:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE4420851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 06:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE4420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gDGm2qcwzDqlZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 17:11:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=202.248.49.38; helo=mx.socionext.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
X-Greylist: delayed 629 seconds by postgrey-1.36 at bilbo;
 Thu, 17 Jan 2019 17:09:39 AEDT
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by lists.ozlabs.org (Postfix) with ESMTP id 43gDDz1mdlzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 17:09:38 +1100 (AEDT)
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 17 Jan 2019 14:59:04 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id CEB8360062;
 Thu, 17 Jan 2019 14:59:04 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP;
 Thu, 17 Jan 2019 14:59:04 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Thu, 17 Jan 2019 14:59:04 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Thu, 17 Jan 2019 14:59:04 +0900
From: <yamada.masahiro@socionext.com>
To: <aik@ozlabs.ru>, <linux-kbuild@vger.kernel.org>
Subject: RE: [PATCH 2/3] kbuild: add real-prereqs shorthand for $(filter-out
 FORCE, $^)
Thread-Topic: [PATCH 2/3] kbuild: add real-prereqs shorthand for $(filter-out
 FORCE, $^)
Thread-Index: AQHUrhxEUYXvMJEkIEyeKkRKmK6traWy9b3g
Date: Thu, 17 Jan 2019 05:59:03 +0000
Message-ID: <bf7380ec3fa145958c3f7b3e3551a395@SOC-EX01V.e01.socionext.com>
References: <1547698231-20985-1-git-send-email-yamada.masahiro@socionext.com>
 <1547698231-20985-2-git-send-email-yamada.masahiro@socionext.com>
 <71a0e80a-c587-4973-cfc3-9c74b2b3a16c@ozlabs.ru>
In-Reply-To: <71a0e80a-c587-4973-cfc3-9c74b2b3a16c@ozlabs.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY190117
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, michal.lkml@markovi.net,
 keescook@chromium.org, maurosr@linux.vnet.ibm.com, jhogan@kernel.org,
 ralf@linux-mips.org, x86@kernel.org, mgreer@animalcreek.com, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com,
 mingo@redhat.com, paulus@samba.org, joel@jms.id.au, hpa@zytor.com,
 bp@alien8.de, tglx@linutronix.de, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgQWxleGV5LA0KDQo+IFdoYXQgaXMgdGhpcyBzZXJpZXMgbWFkZSBvbiB0b3Agb2Y/IFRoaXMg
ZG9lcyBub3QgYXBwbHkgb24gdG9wIG9mIG1hc3Rlcg0KPiBmcm9tDQo+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LTIuNi5naXQN
Cg0KDQpJZiB5b3Ugd2FudCB0byBhcHBseSB0aGlzIHNlcmllcyBjbGVhbmx5LCBwbGVhc2UgYXBw
bHkgdGhlIGZvbGxvd2luZyBmaXJzdDoNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC8xMDc2MTYyNS8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA3Njcx
OTMvDQoNCg0KDQpUaGUgY29uZmxpY3RzIGFyZSBub3Qgc2lnbmlmaWNhbnQuDQpZb3UgY2FuIHVz
ZSAnZ2l0IGFtIC1DMScgaWYgeW91IHdhbnQgdG8gYXBwbHkgdGhpcyBzZXJpZXMNCmRpcmVjdGx5
IHRvIExpbnVzIHRyZWUuDQoNCk1hc2FoaXJvDQoNCg==
