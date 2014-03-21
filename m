Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 30C102C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 20:23:25 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 09444-08 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 21 Mar 2014 09:23:21 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Wood' <scottwood@freescale.com>
Subject: RE: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
Date: Fri, 21 Mar 2014 09:21:56 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E40C4@AcuExch.aculab.com>
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
 <063D6719AE5E284EB5DD2968C1650D6D0F6E33AE@AcuExch.aculab.com>
 <1395353279.12479.335.camel@snotra.buserror.net>
In-Reply-To: <1395353279.12479.335.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 'Kevin Hao' <haokexin@gmail.com>, Chenhui Zhao <chenhui.zhao@freescale.com>,
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

RnJvbTogU2NvdHQgV29vZCBbbWFpbHRvOnNjb3R0d29vZEBmcmVlc2NhbGUuY29tXQ0KPiBPbiBU
aHUsIDIwMTQtMDMtMjAgYXQgMTE6NTkgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBJ
IHRyaWVkIHRvIHdvcmsgb3V0IHdoYXQgdGhlICd0d2ksIGlzeW5jJyBpbnN0cnVjdGlvbnMgd2Vy
ZSBmb3IgKGluIGluX2xlMzIoKSkuDQo+ID4gVGhlIGJlc3QgSSBjb3VsZCBjb21lIHVwIHdpdGgg
d2FzIHRvIGVuc3VyZSBhIHN5bmNocm9ub3VzIGJ1cy1mYXVsdC4NCj4gPiBCdXQgYnVzIGZhdWx0
cyBhcmUgcHJvYmFibHkgb25seSBleHBlY3RlZCBkdXJpbmcgZGV2aWNlIHByb2JpbmcgLSBub3QN
Cj4gPiBub3JtYWwgb3BlcmF0aW9uLCBhbmQgdGhlIGluc3RydWN0aW9ucyB3aWxsIGhhdmUgYSBz
aWduaWZpY2FudCBjb3N0Lg0KPiA+DQo+ID4gQWRkaXRpb25hbGx5IGluX2xlMzIoKSBhbmQgb3V0
X2xlMzIoKSBib3RoIHN0YXJ0IHdpdGggYSAnc3luYycgaW5zdHJ1Y3Rpb24uDQo+ID4gSW4gbWFu
eSBjYXNlcyB0aGF0IGlzbid0IG5lZWRlZCBlaXRoZXIgLSBhbiBleHBsaWNpdCBpb3N5bmMoKSBj
YW4gYmUNCj4gPiB1c2VkIGFmdGVyIGdyb3VwcyBvZiBpbnN0cnVjdGlvbnMuDQo+IA0KPiBUaGUg
aWRlYSBpcyB0aGF0IGl0J3MgYmV0dGVyIHRvIGJlIG1heGltYWxseSBzYWZlIGJ5IGRlZmF1bHQs
IGFuZCBsZXQNCj4gcGVyZm9ybWFuY2UgY3JpdGljYWwgc2VjdGlvbnMgYmUgb3B0aW1pemVkIHVz
aW5nIHJhdyBhY2Nlc3NvcnMgYW5kDQo+IGV4cGxpY2l0IHN5bmNocm9uaXphdGlvbiBpZiBuZWVk
ZWQsIHRoYW4gdG8gaGF2ZSBoYXJkLXRvLWRlYnVnIGJ1Z3MgZHVlDQo+IHRvIG1pc3Npbmcvd3Jv
bmcgc3luYy4gIEEgbG90IG9mIEkvTyBpcyBzbG93IGVub3VnaCB0aGF0IHRoZSBwZXJmb3JtYW5j
ZQ0KPiBpbXBhY3QgZG9lc24ndCByZWFsbHkgbWF0dGVyLCBidXQgdGhlIGJyYWluLXRpbWUgY29z
dCBvZiBnZXR0aW5nIHRoZQ0KPiBzeW5jIHJpZ2h0IGlzIHN0aWxsIHRoZXJlLg0KDQpIbW1tLi4u
Lg0KDQpUaGF0IG1pZ2h0IGJlIGFuIGV4Y3VzZSBmb3IgdGhlICdzeW5jJywgYnV0IG5vdCB0aGUg
dHdpIGFuZCBpc3luYy4NCg0KSSB3YXMgc2V0dGluZyB1cCBhIGRtYSByZXF1ZXN0IChmb3IgdGhl
IHBwYyA4M3h4IFBDSWUgYnJpZGdlKSBhbmQNCndhcyBkb2luZyBiYWNrIHRvIGJhY2sgbGl0dGxl
LWVuZGlhbiB3cml0ZXMgaW50byBtZW1vcnkuDQpJIGhhZCBkaWZmaWN1bHR5IGZpbmRpbmcgYW5k
IGluY2x1ZGluZyBoZWFkZXIgZmlsZXMgY29udGFpbmluZw0KdGhlIGRlZmluaXRpb25zIGZvciBi
eXRlc3dhcHBlZCBhY2Nlc3NlcyBJIG5lZWRlZC4NCmFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9z
d2FiLmggY29udGFpbnMgc29tZSAtIGJ1dCBJIGNvdWxkbid0DQp3b3JrIG91dCBob3cgdG8gZ2V0
IGl0IGluY2x1ZGVkIChhcGFydCBmcm9tIGdpdmluZyB0aGUgZnVsbCBwYXRoKS4NCg0KSW4gYW55
IGNhc2UgeW91IG5lZWQgdG8gdW5kZXJzdGFuZCB3aGVuIHN5bmNocm9uaXNhdGlvbiBpcw0KcmVx
dWlyZWQgLSBvdGhlcndpc2UgeW91IHdpbGwgZ2V0IGl0IHdyb25nLg0KRXNwZWNpYWxseSBzaW5j
ZSBub24tYnl0ZXN3YXBwZWQgYWNjZXNzZXMgYXJlIGRvbmUgYnkgZGlyZWN0DQphY2Nlc3MuDQoN
CglEYXZpZA0KDQo=
