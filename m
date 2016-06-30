Return-Path: <yuantian.tang@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0078.outbound.protection.outlook.com [157.55.234.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg2Tv4PjYzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:47:15 +1000 (AEST)
From: Yuantian Tang <yuantian.tang@nxp.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Scott Wood <oss@buserror.net>, Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li
 <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH v3 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
Date: Thu, 30 Jun 2016 01:47:09 +0000
Message-ID: <DBXPR04MB4958B5147DAA4F05BED4884F0240@DBXPR04MB495.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <DBXPR04MB49546917495DA33834B05D7F0230@DBXPR04MB495.eurprd04.prod.outlook.com>
 <2091721.Cm4CVR1ptK@vostro.rjw.lan>
In-Reply-To: <2091721.Cm4CVR1ptK@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSBb
bWFpbHRvOnJqd0Byand5c29ja2kubmV0XQ0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAzMCwgMjAx
NiA5OjQ3IEFNDQo+IFRvOiBZdWFudGlhbiBUYW5nIDx5dWFudGlhbi50YW5nQG54cC5jb20+DQo+
IENjOiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0PjsgUnVzc2VsbCBLaW5nIDxsaW51eEBh
cm1saW51eC5vcmcudWs+Ow0KPiBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJy
ZS5jb20+OyBTdGVwaGVuIEJveWQNCj4gPHNib3lkQGNvZGVhdXJvcmEub3JnPjsgVmlyZXNoIEt1
bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3ps
YWJzLm9yZzsgWWFuZy1MZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IFhpYW9mZW5nIFJlbg0K
PiA8eGlhb2ZlbmcucmVuQG54cC5jb20+OyBTY290dCBXb29kIDxzY290dHdvb2RAZnJlZXNjYWxl
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIGNsazogQWRkIGNvbnN1bWVyIEFQ
SXMgZm9yIGRpc2NvdmVyaW5nIHBvc3NpYmxlDQo+IHBhcmVudCBjbG9ja3MNCj4gDQo+IE9uIFdl
ZG5lc2RheSwgSnVuZSAyOSwgMjAxNiAwNTo1MDoyNiBBTSBZdWFudGlhbiBUYW5nIHdyb3RlOg0K
PiA+IEhpLA0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBhY2tlZCBieSBjbG9jayBtYWludGFpbmVy
LiBJZiBubyBjb21tZW50cyBmcm9tIGFueW9uZSBlbHNlLA0KPiB3ZSB3aWxsIG1lcmdlIGl0IGlu
IG5leHQgd2Vlay4NCj4gDQo+IFRoZXJlIGlzIGEgY3B1ZnJlcSBjb21taXQgZGVwZW5kaW5nIG9u
IGl0LiAgQXJlIHlvdSBnb2luZyB0byBoYW5kbGUgdGhhdCBvbmUNCj4gdG9vPw0KPiANClRoYXQg
b25lIGhhcyBiZWVuIGFja2VkIGJ5IGNwdWZyZXEgbWFpbnRhaW5lci4gWW91IGNhbiBnZXQgdGhp
cyBmcm9tIHBhdGNoIGNvbW1lbnRzLg0KDQpSZWdhcmRzLA0KWXVhbnRpYW4NCg0KUmUNCj4gVGhh
bmtzLA0KPiBSYWZhZWwNCg0K
