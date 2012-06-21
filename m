Return-Path: <21cnbao@gmail.com>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5924BB6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 11:16:59 +1000 (EST)
Received: by ghbg24 with SMTP id g24so67276ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2012 18:16:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Jun 2012 09:16:35 +0800
Message-ID: <CAGsJ_4xZM0DYV6YLLUyQ1fd-s9DOvKAZ94UcNwGaUN3xTR97Yw@mail.gmail.com>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Cc: Viresh Kumar <viresh.kumar@st.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Haojian Zhuang <haojian.zhuang@marvell.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org,
 Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>,
 Olof Johansson <olof@lixom.net>, Deepak Sikri <deepak.sikri@st.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
 Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>,
 "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
 Magnus Damm <damm@opensource.se>, Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 linux-arm-kernel@lists.infradead.org, Jiri Kosina <jkosina@suse.cz>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>,
 Dirk Brandewie <dirk.brandewie@gmail.com>, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MjAxMi82LzE0IFdvbGZyYW0gU2FuZyA8dy5zYW5nQHBlbmd1dHJvbml4LmRlPjoKPiBDdXJyZW50
bHksIGV2ZXJ5IGRyaXZlciBoYXMgdG8gZG8gaXQgb24gaXRzIG93biwgYnV0IGl0IHNob3VsZCBi
ZSBkb25lCj4gaW4gdGhlIGNvcmUsIGxpa2Ugd2UgYWxyZWFkeSBkbyB3aXRoIGJvYXJkX2luZm8g
c3RydWN0cy4KPgo+IFNpZ25lZC1vZmYtYnk6IFdvbGZyYW0gU2FuZyA8dy5zYW5nQHBlbmd1dHJv
bml4LmRlPgoKQWNrZWQtYnk6IEJhcnJ5IFNvbmcgPGJhcnJ5LnNvbmdAbGlhbmxhYi5vcmc+Cgo+
IC0tLQo+Cj4gQmFzZWQgb24gdjMuNS1yYzIuIE9ubHkgYnVpbGQgdGVzdGVkLCBJIGRvbid0IGhh
dmUgYSBPRiBiYXNlZCBkZXZpY2UKPiBhcm91bmQgYXQgdGhlIG1vbWVudC4KPgo+IEBQZXRlcjog
V2h5IGRvZXMgb2NvcmVzIGRvIHRoZSBkZXZpY2UgcmVnaXN0cmF0aW9uIG1hbnVhbGx5IHZpYQo+
IHBsYXRmb3JtX2RhdGEgaW5zdGVhZCBvZiB1c2luZyBib2FyZF9pbmZvPwo+Cj4gwqBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLWNwbS5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDUgLS0t
LS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZGVzaWdud2FyZS1wbGF0ZHJ2LmMgfCDCoCDC
oDEgLQo+IMKgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1ncGlvLmMgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfCDCoCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaWJtX2lpYy5jIMKgIMKg
IMKgIMKgIMKgIMKgfCDCoCDCoDMgLS0tCj4gwqBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5j
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nl
cy9pMmMtbXBjLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMSAtCj4gwqBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLW14cy5jIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgLS0K
PiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb2NvcmVzLmMgwqAgwqAgwqAgwqAgwqAgwqAgfCDC
oCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHwgwqAgwqAyIC0tCj4gwqBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXBueC5jIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgLS0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
cHhhLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMSAtCj4gwqBkcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLXMzYzI0MTAuYyDCoCDCoCDCoCDCoCDCoCDCoHwgwqAgwqAxIC0KPiDCoGRyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtc2hfbW9iaWxlLmMgwqAgwqAgwqAgwqAgwqB8IMKgIMKgMSAtCj4g
wqBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKg
IMKgMiAtLQo+IMKgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy12ZXJzYXRpbGUuYyDCoCDCoCDCoCDC
oCDCoHwgwqAgwqAxIC0KPiDCoGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMteGlpYy5jIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHwgwqAgwqAyIC0tCj4gwqBkcml2ZXJzL2kyYy9pMmMtY29yZS5jIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDMgKysrCj4gwqAxNyBmaWxlcyBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQoKLWJhcnJ5Cg==
