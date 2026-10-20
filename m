Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93C606A319
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RCnjv+vU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j862d6KHXz2xg3;
	Tue, 20 Oct 2026 20:05:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792484633;
	cv=none; b=UA0W2e4hAl8iRn4SkDWDqL72ZUTd3NiWyy7tgYK7RXkbBBd054O1p/T2SM6lsd2AHxWKHvjGjtBnSdC6h63SZQh7OK5OH+VSwXHBf2n64bp/Bale7LpPD2FRarrs/MIennwoFrHmTZphjg4oSKiybrDxpiMRaaL8SB9JCozYYyWPgDIOtBmRsGnBaUIFJ/vTwMgcUNUbSpyfgQq+6779T2pvVG7kwaxwFLYgZKs2G5AtDz0TavrVxbijGfSr7VPR7fj/QufoCE99HJRVWzjgfR4NIaP4iaw1HZRMkq6H2yJ1LrBW5awtBDmWUkhCCpDpqdhCh7KtT2wb3tw8JGQHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792484633; c=relaxed/relaxed;
	bh=aEsK9vnGIWgdQWg/4/gp+ERqdPLdZK75eQSfT/gO9Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BtmcCw6tHn9d5hskGR0LhAU0Y7bF0XKBOpoqMDGuuMUsqQalHg0eu40XtJXzga44jBab1YVLv7eZzkfwKrTIyWLEu3NvcCch1wKJCtoYRcTANL7a13ZbaNhpeQOhpBGgGAREvElRc8g5cp/WVA7vb5J9SeraOHVN5zl9Cz/hMwIZkaX0aOIs4DQr4zijUXczoaIgy2xgBE6dE7YoK1gDOJJY6FOWo6IEpF8a2b2CH28BN+9PiGP61lPUDenC6MJqRzFZQBKAk3xLUCwU0FuyY77i0j7fJyYhNHX6rNQVJrmpbx05CtABLyHxub7kEwOzkjS9MkHSHjqcAJCqSdcI+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RCnjv+vU; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=19888972804@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RCnjv+vU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=19888972804@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 661 seconds by postgrey-1.37 at boromir; Tue, 20 Oct 2026 19:23:49 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j856F0sTPz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 19:23:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=aEsK9vnGIWgdQWg/4/gp+ERqdPLdZK75eQSfT/gO9Pk=; b=R
	Cnjv+vUw17RM25HbbvPqMuGddLQAMNXJ0irypFTfWPLOd6+HOf3gwWx8a2uP2SmB
	iDAziIByqccqzbaF9irRVvpqnnVhRrfSP0844asw+laXL975n8MmReJ8/wccS40t
	dwd/tu0cxmXnt80jgfrZdR4QRYqABLnulyXy8r/pSc=
Date: Tue, 20 Oct 2026 16:10:32 +0800 (CST)
From: "jiale yao" <19888972804@163.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Frank Li" <Frank.Li@kernel.org>, "Zhang Wei" <zw@zh-kernel.org>,
	"Sascha Hauer" <s.hauer@pengutronix.de>,
	"Pengutronix Kernel Team" <kernel@pengutronix.de>,
	"Fabio Estevam" <festevam@gmail.com>,
	"Linus Walleij" <linusw@kernel.org>,
	"H Hartley Sweeten" <hsweeten@visionengravers.com>,
	"Ryan Mallon" <rmallon@gmail.com>,
	"Mika Westerberg" <mika.westerberg@iki.fi>,
	"Ebony Zhu" <ebony.zhu@freescale.com>,
	"Kumar Gala" <galak@gate.crashing.org>,
	"Dan Williams" <djbw@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Zhangfei Gao" <zhangfei.gao@marvell.com>,
	"Arnd Bergmann" <arnd@arndb.de>, "Qiao Zhou" <zhouqiao@marvell.com>,
	"Leo Yan" <leoy@marvell.com>,
	"Lennert Buytenhek" <buytenh@marvell.com>,
	"Nicolas Pitre" <nico@marvell.com>,
	"Saeed Bishara" <saeed@marvell.com>,
	"Maciej Sosnowski" <maciej.sosnowski@intel.com>,
	"Shawn Guo" <shawn.guo@freescale.com>,
	"Srinidh Kasagar" <srinidhi.kasagar@stericsson.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re:Re: [PATCH 0/7] dmaengine: drain completion tasklets during
 teardown
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261020073620.224795-1-peng.fan@oss.nxp.com>
References: <20261020073620.224795-1-peng.fan@oss.nxp.com>
X-NTES-SC: AL_Qu2SAPiTvEAo5CabY+kcn08ShO49XMOyvfoi2YFTc+MEpyPT/CwnXV1dJHjX9MKlLySpjjK2QjZX0MN8TZd4HI2VUqoFvXudLFbzFGVQoQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID: <3d4b1cde.711e.1a1585cb34c.Coremail.19888972804@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgCnV_34IddqIc9cAA--.879W
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhgXUWrXIfhxlAAA3R
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgUGVuZywKCkF0IDIwMjYtMTAtMjAgMTU6MzY6MTksICJQZW5nIEZhbiAoT1NTKSIgPHBlbmcu
ZmFuQG9zcy5ueHAuY29tPiB3cm90ZToKPk9uIFN1biwgMTggT2N0IDIwMjYgMTI6MDc6MTYgKzA4
MDAgSmlhbGUgWWFvIDx5YW9qaWFsZTAyQDE2My5jb20+IHdyb3RlOgo+Cj4+IFNldmVyYWwgRE1B
ZW5naW5lIGRyaXZlcnMgZGVmZXIgaW50ZXJydXB0IGNvbXBsZXRpb24gcHJvY2Vzc2luZyB0bwo+
PiB0YXNrbGV0cywgYnV0IHJlbGVhc2UgY2hhbm5lbCByZXNvdXJjZXMgd2l0aG91dCBkcmFpbmlu
ZyB0YXNrbGV0cyB0aGF0Cj4+IHdlcmUgYWxyZWFkeSBxdWV1ZWQuIFN0b3BwaW5nIG9yIHJlbGVh
c2luZyBhbiBJUlEgcHJldmVudHMgbmV3IGhhcmQgSVJRCj4+IGhhbmRsZXJzLCBidXQgZG9lcyBu
b3Qgc3luY2hyb25pemUgdGhlIGRlZmVycmVkIHRhc2tsZXQuCj4+IAo+PiBEZXBlbmRpbmcgb24g
dGhlIGRyaXZlciwgYSBsYXRlIHRhc2tsZXQgY2FuIGFjY2VzcyBmcmVlZCBkZXNjcmlwdG9yCj4+
IHN0b3JhZ2Ugb3IgaW52b2tlIGEgY29tcGxldGlvbiBjYWxsYmFjayBhZnRlciBpdHMgY2xpZW50
IGRhdGEgaGFzIGJlZW4KPj4gcmVsZWFzZWQuIEVuc3VyZSBlYWNoIHByb2R1Y2VyIGlzIHN0b3Bw
ZWQgYmVmb3JlIGtpbGxpbmcgdGhlIHRhc2tsZXQgYW5kCj4+IGZyZWVpbmcgdGhlIHJlc291cmNl
cyBpdCBjYW4gYWNjZXNzLgo+PiAKPj4gRWFjaCBwYXRjaCBpcyBpbmRlcGVuZGVudCBhbmQga2Vl
cHMgdGhlIHN5bmNocm9uaXphdGlvbiBsb2NhbCB0byBvbmUKPj4gZHJpdmVyJ3MgY2hhbm5lbCBv
ciBkZXZpY2UgdGVhcmRvd24gcGF0aC4KPj4gCj4+IEppYWxlIFlhbyAoNyk6Cj4+ICAgZG1hZW5n
aW5lOiBlcDkzeHg6IGRyYWluIHRhc2tsZXQgYmVmb3JlIGZyZWVpbmcgY2hhbm5lbCByZXNvdXJj
ZXMKPj4gICBkbWFlbmdpbmU6IGZzbGRtYTogZHJhaW4gY2hhbm5lbCB0YXNrbGV0IGR1cmluZyBy
ZW1vdmFsCj4+ICAgZG1hZW5naW5lOiBtbXBfcGRtYTogZHJhaW4gY2hhbm5lbCB0YXNrbGV0cyBk
dXJpbmcgcmVtb3ZhbAo+PiAgIGRtYWVuZ2luZTogbW1wX3RkbWE6IHN5bmNocm9uaXplIHRhc2ts
ZXQgd2hlbiBmcmVlaW5nIGEgY2hhbm5lbAo+PiAgIGRtYWVuZ2luZTogbXZfeG9yOiBkcmFpbiBJ
UlEgdGFza2xldCBiZWZvcmUgZnJlZWluZyBjaGFubmVsIG1lbW9yeQo+PiAgIGRtYWVuZ2luZTog
bXhzLWRtYTogc3luY2hyb25pemUgdGFza2xldCB3aGVuIGZyZWVpbmcgYSBjaGFubmVsCj4+ICAg
ZG1hZW5naW5lOiBzdGVfZG1hNDA6IHN5bmNocm9uaXplIHRhc2tsZXQgd2hlbiByZWxlYXNpbmcg
YSBjaGFubmVsCj4+IAo+PiAgZHJpdmVycy9kbWEvZXA5M3h4X2RtYS5jIHwgNCArKystCj4+ICBk
cml2ZXJzL2RtYS9mc2xkbWEuYyAgICAgfCAxICsKPj4gIGRyaXZlcnMvZG1hL21tcF9wZG1hLmMg
ICB8IDQgKysrKwo+PiAgZHJpdmVycy9kbWEvbW1wX3RkbWEuYyAgIHwgMiArKwo+PiAgZHJpdmVy
cy9kbWEvbXZfeG9yLmMgICAgIHwgNiArKysrLS0KPj4gIGRyaXZlcnMvZG1hL214cy1kbWEuYyAg
ICB8IDEgKwo+PiAgZHJpdmVycy9kbWEvc3RlX2RtYTQwLmMgIHwgMiArKwo+Cj5Zb3UgbWlnaHQg
bmVlZCB0byBhZGQgYSBiaXQgbW9yZSBjb250ZXh0IG9uIHRoZSBpc3N1ZXMuCj4KPlRha2luZyBt
eHMtZG1hIGZvciBleGFtcGxlLCBpdCBpcyBub24tU01QIHByb2Nlc3Nvci4KPgo+VGhlIG5vcm1h
bCBjb21wbGV0aW9uIHBhdGggaXM6Cj4xLiBETUEgaGFyZGlycSBmaXJlcyAtPiBteHNfZG1hX2lu
dF9oYW5kbGVyKCkgLT4gdGFza2xldF9zY2hlZHVsZSgpIC0+IHJhaXNlcyBUQVNLTEVUX1NPRlRJ
UlEKPjIuIGlycV9leGl0KCkgLT4gc29mdGlycSBwcm9jZXNzaW5nIC0+IHRhc2tsZXRfYWN0aW9u
KCkgLT4gbXhzX2RtYV90YXNrbGV0KCkgcnVucwo+My4gUmV0dXJuIHRvIHByb2Nlc3MgY29udGV4
dAo+Cj5UaGUgdGFza2xldCBhbG1vc3QgYWx3YXlzIGNvbXBsZXRlcyBiZWZvcmUgcHJvY2VzcyBj
b250ZXh0IHJlc3VtZXMuCj5UaGUgb25seSB3YXkgdG8gaGl0IHRoZSByYWNlIG9uIFVQIGlzIGlm
IHNvZnRpcnEgcHJvY2Vzc2luZyBnZXRzIGRlZmVycmVkCj50byBrc29mdGlycWQsIGFuZCB0aGVu
Ogo+SW4gUFJFRU1QVF9SVCBjYXNlOiBUYXNrbGV0cyBiZWNvbWUgdGhyZWFkZWQgYW5kIGNhbiBp
bnRlcmxlYXZlLgo+SXMgdGhlcmUgYSBjaGFuY2UgdGhhdCBpbiBub24tUlQgY2FzZSwgY291bGQg
d2UgaGl0IGlzc3VlcyBvbiBVUCBwcm9jZXNzb3I/Cj4KPk9yIEkgbWF5IHVuZGVyc3RhbmQgd3Jv
bmc/CgpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBhbmFseXNpcy4KClRoZSBub3JtYWwgVVAvbm9u
LVJUIHBhdGggdXN1YWxseSBydW5zIHRoZSB0YXNrbGV0IGZyb20gaXJxX2V4aXQoKSwgYXMKeW91
IGRlc2NyaWJlZC4gSG93ZXZlciwgaWYgdGhlIERNQSBJUlEgcmFpc2VzIFRBU0tMRVRfU09GVElS
USBhZnRlciB0aGF0CnZlY3RvciBoYXMgYWxyZWFkeSBiZWVuIHByb2Nlc3NlZCBpbiB0aGUgY3Vy
cmVudCBzb2Z0aXJxIHBhc3MsCm5lZWRfcmVzY2hlZCgpIG9yIHRoZSBzb2Z0aXJxIHRpbWUvcmVz
dGFydCBsaW1pdHMgY2FuIGRlZmVyIGl0IHRvCmtzb2Z0aXJxZC4gUHJvY2VzcyBjb250ZXh0IG1h
eSB0aGVuIHJlbGVhc2UgdGhlIGNoYW5uZWwgYmVmb3JlIHRoZQp0YXNrbGV0IHJ1bnMuCgpBIHNp
bWlsYXIgdGVhcmRvd24gaXNzdWUgd2FzIGZpeGVkIGJ5IGNvbW1pdCAwY2E3OTk3OTM4NGYKKCJS
RE1BL2VyZG1hOiBGaXggQ0VRIHRhc2tsZXQgdXNlLWFmdGVyLWZyZWUgb24gcmVtb3ZhbCIpLiBm
cmVlX2lycSgpCnN5bmNocm9uaXplcyB0aGUgaGFyZCBJUlEgaGFuZGxlciwgYnV0IGRvZXMgbm90
IGRyYWluIGFuIGFscmVhZHkgcXVldWVkCnRhc2tsZXQuCgpGb3IgbXhzLWRtYSwgdGhlIGRlZmVy
cmVkIHRhc2tsZXQgbWF5IGludm9rZSB0aGUgY29tcGxldGlvbiBjYWxsYmFjawphZnRlciBpdHMg
Y2xpZW50IGRhdGEgaGFzIGJlZW4gcmVsZWFzZWQuIFRoZXJlZm9yZSB0aGlzIGNhbiBhbHNvIGhh
cHBlbgpvbiBVUC9ub24tUlQsIGFsdGhvdWdoIHRoZSB3aW5kb3cgaXMgbmFycm93LgoKPgo+UmVn
YXJkcwo+UGVuZwo+Cj4+ICA3IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4+IAo+PiAtLSAKPj4gMi4zNC4xCj4KPlNlbnQgdXNpbmcgaGttbCAoaHR0cHM6
Ly9naXRodWIuY29tL3NqcDM4L2hhY2tlcm1haWwpCgoKVGhhbmtzLApKaWFsZQo=

