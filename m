Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id D8B202C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 23:00:41 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 04007-02 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 20 Mar 2014 12:00:35 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kevin Hao' <haokexin@gmail.com>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
Date: Thu, 20 Mar 2014 11:59:14 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E33AE@AcuExch.aculab.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
 <1394646185.13761.145.camel@snotra.buserror.net>
 <20140313074613.GD26692@pek-khao-d1.corp.ad.wrs.com>
 <1394835987.12479.119.camel@snotra.buserror.net>
 <20140316045801.GA32188@pek-khao-d1.corp.ad.wrs.com>
 <1395184734.12479.250.camel@snotra.buserror.net>
 <20140320114735.GD10182@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20140320114735.GD10182@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Chenhui
 Zhao <chenhui.zhao@freescale.com>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogS2V2aW4gSGFvDQo+IFNlbnQ6IDIwIE1hcmNoIDIwMTQgMTE6NDgNCj4gVG86IFNjb3R0
IFdvb2QNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBDaGVuaHVpIFpoYW87
IEphc29uLkppbkBmcmVlc2NhbGUuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggOS85XSBwb3dlcnBjL3BtOiBzdXBwb3J0IGRlZXAgc2xlZXAg
ZmVhdHVyZSBvbiBUMTA0MA0KPiANCj4gT24gVHVlLCBNYXIgMTgsIDIwMTQgYXQgMDY6MTg6NTRQ
TSAtMDUwMCwgU2NvdHQgV29vZCB3cm90ZToNCj4gPiA+ICBUaGUgc2VxdWVuY2UgIndyaXRlLCBy
ZWFkYmFjaywgc3luYyIgd2lsbCBndWFyYW50ZWUgdGhpcyBhY2NvcmRpbmcgdG8gdGhlIG1hbnVh
bC4NCj4gPg0KPiA+IElmIHlvdSdyZSByZWZlcnJpbmcgdG8gdGhlIHNlY3Rpb24geW91IHF1b3Rl
ZCBhYm92ZSwgdGhlIG1hbnVhbCBkb2VzIG5vdA0KPiA+IHNheSB0aGF0LiAgSXQgb25seSB0YWxr
cyBhYm91dCB3aGVuIGFjY2Vzc2VzICJ0byBtZW1vcnkgcmVnaW9ucyBhZmZlY3RlZA0KPiA+IGJ5
IHRoZSBjb25maWd1cmF0aW9uIHJlZ2lzdGVyIHdyaXRlIiBjYW4gYmUgc2FmZWx5IG1hZGUuDQo+
IA0KPiAgIFRvIGd1YXJhbnRlZSB0aGF0IHRoZSByZXN1bHRzIG9mIGFueSBzZXF1ZW5jZSBvZiB3
cml0ZXMgdG8gY29uZmlndXJhdGlvbg0KPiAgIHJlZ2lzdGVycyBhcmUgaW4gZWZmZWN0LCB0aGUg
ZmluYWwgY29uZmlndXJhdGlvbiByZWdpc3RlciB3cml0ZSBzaG91bGQgYmUNCj4gICBpbW1lZGlh
dGVseSBmb2xsb3dlZCBieSBhIHJlYWQgb2YgdGhlIHNhbWUgcmVnaXN0ZXIsIGFuZCB0aGF0IHNo
b3VsZCBiZQ0KPiAgIGZvbGxvd2VkIGJ5IGEgU1lOQyBpbnN0cnVjdGlvbi4gVGhlbiBhY2Nlc3Nl
cyBjYW4gc2FmZWx5IGJlIG1hZGUgdG8gbWVtb3J5DQo+ICAgcmVnaW9ucyBhZmZlY3RlZCBieSB0
aGUgY29uZmlndXJhdGlvbiByZWdpc3RlciB3cml0ZS4NCg0KVGhhdCBzb3J0IG9mIHNlcXVlbmNl
IGlzIG5lZWQgdG8gZm9yY2UgdGhlIG9wZXJhdGlvbnMgdGhyb3VnaCBhbnkNCmV4dGVybmFsIGJ1
cyAtIGFmdGVyIHRoZSBjcHUgaXRzZWxmIGhhcyBpc3N1ZWQgdGhlIGJ1cyBjeWNsZXMuDQpNb3N0
bHkgcmVxdWlyZWQgYmVjYXVzZSB3cml0ZXMgYXJlIG9mdGVuICdwb3N0ZWQnIChpZSBhZGRyZXNz
IGFuZCBkYXRhDQpsYXRjaGVkLCBhbmQgdGhlbiBwZXJmb3JtZWQgc3luY2hyb25vdXNseSkuDQoN
Cj4gQWNjb3JkaW5nIHRvIHRoZSBhYm92ZSBkZXNjcmlwdGlvbiBpbiB0NDI0MCBSTSBtYW51YWwg
KDIuNi4xIEFjY2Vzc2luZyBDQ1NSDQo+IE1lbW9yeSBmcm9tIHRoZSBMb2NhbCBQcm9jZXNzb3Ip
LCB0aGF0IHRoZSB3cml0aW5nIHRvIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXINCj4gdGFrZXMgZWZm
ZWN0IGlzIGEgcHJlcmVxdWlzaXRlIGZvciB0aGUgbWVtb3J5IGFjY2VzcyB0byB0aGUgYWZmZWN0
ZWQgcmVnaW9ucy4NCi4uLg0KPiBPSywgc28gdGhlIGludGVudGlvbiBvZiAndHdpLCBpc3luYycg
Zm9sbG93aW5nIHRoZSBsb2FkIGlzIG5vdCB0byBvcmRlciB0aGUNCj4gZm9sbG93aW5nIHN0b3Jh
Z2UgYWNjZXNzLCBidXQgb3JkZXIgdGhlIGZvbGxvd2luZyBkZWxheSBsb29wIGluc3RydWN0aW9u
cywNCj4gcmlnaHQNCg0KSSB0cmllZCB0byB3b3JrIG91dCB3aGF0IHRoZSAndHdpLCBpc3luYycg
aW5zdHJ1Y3Rpb25zIHdlcmUgZm9yIChpbiBpbl9sZTMyKCkpLg0KVGhlIGJlc3QgSSBjb3VsZCBj
b21lIHVwIHdpdGggd2FzIHRvIGVuc3VyZSBhIHN5bmNocm9ub3VzIGJ1cy1mYXVsdC4NCkJ1dCBi
dXMgZmF1bHRzIGFyZSBwcm9iYWJseSBvbmx5IGV4cGVjdGVkIGR1cmluZyBkZXZpY2UgcHJvYmlu
ZyAtIG5vdA0Kbm9ybWFsIG9wZXJhdGlvbiwgYW5kIHRoZSBpbnN0cnVjdGlvbnMgd2lsbCBoYXZl
IGEgc2lnbmlmaWNhbnQgY29zdC4NCg0KQWRkaXRpb25hbGx5IGluX2xlMzIoKSBhbmQgb3V0X2xl
MzIoKSBib3RoIHN0YXJ0IHdpdGggYSAnc3luYycgaW5zdHJ1Y3Rpb24uDQpJbiBtYW55IGNhc2Vz
IHRoYXQgaXNuJ3QgbmVlZGVkIGVpdGhlciAtIGFuIGV4cGxpY2l0IGlvc3luYygpIGNhbiBiZQ0K
dXNlZCBhZnRlciBncm91cHMgb2YgaW5zdHJ1Y3Rpb25zLg0KDQoJRGF2aWQNCg0KDQo=
