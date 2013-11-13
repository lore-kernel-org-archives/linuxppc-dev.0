Return-Path: <Shaohui.Xie@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A4CC2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 13:02:05 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 1/4] phylib: Add Clause 45 read/write functions
Date: Wed, 13 Nov 2013 02:01:55 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9151248F9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
 <1384293487.1403.67.camel@snotra.buserror.net>
 <ED492CCEAF882048BC2237DE806547C91512489F@039-SN2MPN1-013.039d.mgd.msft.net>
 <1384307679.1403.122.camel@snotra.buserror.net>
In-Reply-To: <1384307679.1403.122.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "shh.xie@gmail.com" <shh.xie@gmail.com>,
 Shruti Kanetkar <Shruti@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBPbiBUdWUsIDIwMTMtMTEtMTIgYXQgMTk6NTEgLTA2MDAsIFhpZSBTaGFvaHVpLUIyMTk4OSB3
cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBXb29k
IFNjb3R0LUIwNzQyMQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAxMyA1
OjU4IEFNDQo+ID4gPiBUbzogc2hoLnhpZUBnbWFpbC5jb20NCj4gPiA+IENjOiBsaW51eHBwYy1k
ZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+
IEthbmV0a2FyIFNocnV0aS1CNDQ0NTQ7IFhpZSBTaGFvaHVpLUIyMTk4OTsgQnVjdXINCj4gPiA+
IE1hZGFsaW4tQ3Jpc3RpYW4tQjMyNzE2DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0g
cGh5bGliOiBBZGQgQ2xhdXNlIDQ1IHJlYWQvd3JpdGUgZnVuY3Rpb25zDQo+ID4gPg0KPiA+ID4g
T24gTW9uLCAyMDEzLTExLTExIGF0IDE5OjA0ICswODAwLCBzaGgueGllQGdtYWlsLmNvbSB3cm90
ZToNCj4gPiA+ID4gRnJvbTogQW5keSBGbGVtaW5nDQo+ID4gPiA+DQo+ID4gPiA+IFlvdSBuZWVk
IGFuIGV4dHJhIHBhcmFtZXRlciB0byByZWFkIG9yIHdyaXRlIENsYXVzZSA0NSBQSFlzLCBzbyB3
ZQ0KPiA+ID4gPiBuZWVkIGEgZGlmZmVyZW50IEFQSSB3aXRoIHRoZSBleHRyYSBwYXJhbWV0ZXIu
DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHkgRmxlbWluZw0KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBTaGFvaHVpIFhpZSA8U2hhb2h1aS5YaWVAZnJlZXNjYWxlLmNvbT4NCj4g
PiA+DQo+ID4gPiBXaHkgZGlkIHlvdSByZW1vdmUgQW5keSdzIGUtbWFpbCBhZGRyZXNzPyAgRXZl
biB0aG91Z2ggaXQncyBubw0KPiA+ID4gbG9uZ2VyIHZhbGlkLCBpdCBoZWxwcyBpZGVudGlmeSB3
aGljaCBzcGVjaWZpYyBwZXJzb24geW91J3JlIHRhbGtpbmcgYWJvdXQuDQo+ID4gPg0KPiA+IFtT
LkhdIEFuZHkncyBlLW1haWwgYWRkcmVzcyBpcyBub3QgdmFsaWQgYW5kIGdpdC1zZW5kLW1haWwg
d2lsbCBmYWlsLCBJIGhhdmUNCj4gdG8gcmVtb3ZlIGl0IHRvIG1ha2UgZ2l0IHdvcmsuDQo+IA0K
PiBUZWxsIGdpdCBzZW5kLWVtYWlsIHRvIG5vdCBpbmNsdWRlIHRoYXQgYWRkcmVzcywgZS5nLiB1
c2luZyAtLXN1cHByZXNzLWNjLCAtLW5vLQ0KPiBzaWduZWQtb2ZmLWJ5LWNjLCAtLXN1cHByZXNz
LWZyb20sIGV0Yy4NCj4gDQpbUy5IXSBPSy4gVGhhbmsgeW91IQ0KDQoNCkJlc3QgUmVnYXJkcywg
DQpTaGFvaHVpIFhpZQ0K
