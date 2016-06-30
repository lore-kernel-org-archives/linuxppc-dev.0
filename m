Return-Path: <yuantian.tang@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0097.outbound.protection.outlook.com [157.55.234.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg48664TwzDqmX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:01:58 +1000 (AEST)
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
Date: Thu, 30 Jun 2016 03:01:50 +0000
Message-ID: <DBXPR04MB4951CA4EFB4FB5A2BDE7542F0240@DBXPR04MB495.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <2091721.Cm4CVR1ptK@vostro.rjw.lan>
 <DBXPR04MB4958B5147DAA4F05BED4884F0240@DBXPR04MB495.eurprd04.prod.outlook.com>
 <2040199.AxgevOCPID@vostro.rjw.lan>
In-Reply-To: <2040199.AxgevOCPID@vostro.rjw.lan>
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
NiAxMDoyNCBBTQ0KPiBUbzogWXVhbnRpYW4gVGFuZyA8eXVhbnRpYW4udGFuZ0BueHAuY29tPg0K
PiBDYzogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47IFJ1c3NlbGwgS2luZyA8bGludXhA
YXJtbGludXgub3JnLnVrPjsNCj4gTWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0dGVAYmF5bGli
cmUuY29tPjsgU3RlcGhlbiBCb3lkDQo+IDxzYm95ZEBjb2RlYXVyb3JhLm9yZz47IFZpcmVzaCBL
dW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0NCj4gZGV2QGxpc3RzLm96
bGFicy5vcmc7IFlhbmctTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBYaWFvZmVuZyBSZW4N
Cj4gPHhpYW9mZW5nLnJlbkBueHAuY29tPjsgU2NvdHQgV29vZCA8c2NvdHR3b29kQGZyZWVzY2Fs
ZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBjbGs6IEFkZCBjb25zdW1lciBB
UElzIGZvciBkaXNjb3ZlcmluZyBwb3NzaWJsZQ0KPiBwYXJlbnQgY2xvY2tzDQo+IA0KPiBPbiBU
aHVyc2RheSwgSnVuZSAzMCwgMjAxNiAwMTo0NzowOSBBTSBZdWFudGlhbiBUYW5nIHdyb3RlOg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFJhZmFlbCBKLiBX
eXNvY2tpIFttYWlsdG86cmp3QHJqd3lzb2NraS5uZXRdDQo+ID4gPiBTZW50OiBUaHVyc2RheSwg
SnVuZSAzMCwgMjAxNiA5OjQ3IEFNDQo+ID4gPiBUbzogWXVhbnRpYW4gVGFuZyA8eXVhbnRpYW4u
dGFuZ0BueHAuY29tPg0KPiA+ID4gQ2M6IFNjb3R0IFdvb2QgPG9zc0BidXNlcnJvci5uZXQ+OyBS
dXNzZWxsIEtpbmcNCj4gPiA+IDxsaW51eEBhcm1saW51eC5vcmcudWs+OyBNaWNoYWVsIFR1cnF1
ZXR0ZQ0KPiA+ID4gPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgU3RlcGhlbiBCb3lkIDxzYm95
ZEBjb2RlYXVyb3JhLm9yZz47DQo+ID4gPiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5h
cm8ub3JnPjsgbGludXgtIGNsa0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4cHBjLSBkZXZAbGlzdHMub3psYWJzLm9yZzsgWWFuZy1MZW8NCj4g
PiA+IExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBYaWFvZmVuZyBSZW4gPHhpYW9mZW5nLnJlbkBu
eHAuY29tPjsgU2NvdHQNCj4gPiA+IFdvb2QgPHNjb3R0d29vZEBmcmVlc2NhbGUuY29tPg0KPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIGNsazogQWRkIGNvbnN1bWVyIEFQSXMgZm9y
IGRpc2NvdmVyaW5nDQo+ID4gPiBwb3NzaWJsZSBwYXJlbnQgY2xvY2tzDQo+ID4gPg0KPiA+ID4g
T24gV2VkbmVzZGF5LCBKdW5lIDI5LCAyMDE2IDA1OjUwOjI2IEFNIFl1YW50aWFuIFRhbmcgd3Jv
dGU6DQo+ID4gPiA+IEhpLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIGlzIGFja2VkIGJ5
IGNsb2NrIG1haW50YWluZXIuIElmIG5vIGNvbW1lbnRzIGZyb20NCj4gPiA+ID4gYW55b25lIGVs
c2UsDQo+ID4gPiB3ZSB3aWxsIG1lcmdlIGl0IGluIG5leHQgd2Vlay4NCj4gPiA+DQo+ID4gPiBU
aGVyZSBpcyBhIGNwdWZyZXEgY29tbWl0IGRlcGVuZGluZyBvbiBpdC4gIEFyZSB5b3UgZ29pbmcg
dG8gaGFuZGxlDQo+ID4gPiB0aGF0IG9uZSB0b28/DQo+ID4gPg0KPiA+IFRoYXQgb25lIGhhcyBi
ZWVuIGFja2VkIGJ5IGNwdWZyZXEgbWFpbnRhaW5lci4gWW91IGNhbiBnZXQgdGhpcyBmcm9tDQo+
IHBhdGNoIGNvbW1lbnRzLg0KPiANCj4gSSBrbm93IHRoYXQgaXQgaGFzIGJlZW4gQUNLZWQuDQo+
IA0KPiBNeSBxdWVzdGlvbiBpcyB3aGV0aGVyIG9yIG5vdCB5b3UgYXJlIGdvaW5nIHRvIGFwcGx5
IGl0IGFsb25nIHRoZSBbMS8yXS4NCj4gDQo+IElmIG5vdCwgaXQgd2lsbCBoYXZlIHRvIGJlIGRl
ZmVycmVkIHVudGlsIHRoZSBbMS8yXSBpcyBtZXJnZWQgYW5kIHRoZW4gYXBwbGllZA0KPiB3aGlj
aCBtYXkgbm90IGJlIGRlc2lyYWJsZS4NCj4gDQpJIGhvcGUgd2UgY2FuIGFwcGx5IGJvdGggYXQg
c2FtZSB0aW1lLiBTZWVtcyBTY290dCBoYXMgYSBmZXcgY29uY2VybnMuDQoNCldoYXQgeW91IHRo
aW5rIGFib3V0IHRoaXMgcGF0Y2g/IENhbiB5b3UgYXBwbHkgaXQ/DQpJZiB5b3UgaGF2ZSBhcHBs
aWVkIHRoaXMgcGF0Y2gsIHRoZW4gSSBjYW4gcHVzaCBDUFVmcmVxIG1haW50YWluZXIgdG8gYXBw
bHkgYW5vdGhlciBvbmUgd2hpY2ggd2lsbCBiZSBkZWxheWVkLg0KDQpSZWdhcmRzLA0KWXVhbnRp
YW4NCg0KPiBUaGFua3MsDQo+IFJhZmFlbA0KDQo=
