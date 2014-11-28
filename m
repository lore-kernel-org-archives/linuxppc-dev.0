Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 117E31A0BC5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 21:54:31 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 00875-05 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 28 Nov 2014 10:54:20 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Benjamin Herrenschmidt' <benh@au1.ibm.com>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>
Subject: RE: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
Date: Fri, 28 Nov 2014 10:53:12 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9FE54E@AcuExch.aculab.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
 <1417136200.2852.14.camel@kernel.crashing.org>
 <5477E8C1.9030600@linux.vnet.ibm.com> <1417144874.2852.21.camel@au1.ibm.com>
In-Reply-To: <1417144874.2852.21.camel@au1.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQmVuamFtaW4gSGVycmVuc2NobWlkdA0KPiBPbiBGcmksIDIwMTQtMTEtMjggYXQgMDg6
NDUgKzA1MzAsIE1hZGhhdmFuIFNyaW5pdmFzYW4gd3JvdGU6DQo+ID4gPiBDYW4ndCB3ZSBqdXN0
IHVuY29uZGl0aW9uYWxseSBjbGVhciBhdCBhcyBsb25nIGFzIHdlIGRvIHRoYXQgYWZ0ZXIgd2Un
dmUNCj4gPiA+IHNhdmVkIGl0ID8gSW4gdGhhdCBjYXNlLCBpdCdzIGp1c3QgYSBtYXR0ZXIgZm9y
IHRoZSBmaXh1cCBjb2RlIHRvIGNoZWNrDQo+ID4gPiB0aGUgc2F2ZWQgdmVyc2lvbiByYXRoZXIg
dGhhbiB0aGUgYWN0dWFsIENSLi4NCj4gPiA+DQo+ID4gSSB1c2UgQ1IgYml0IHNldHRpbmcgaW4g
dGhlIGludGVycnVwdCByZXR1cm4gcGF0aCB0byBlbnRlciB0aGUgZml4dXANCj4gPiBzZWN0aW9u
IHNlYXJjaC4gSWYgd2UgdW5jb25kaXRpb25hbGx5IGNsZWFyIGl0LCB3ZSB3aWxsIGhhdmUgdG8g
ZW50ZXINCj4gPiB0aGUgZml4dXAgc2VjdGlvbiBmb3IgZXZlcnkga2VybmVsIHJldHVybiBuaXAg
cmlnaHQ/DQo+IA0KPiBBcyBJIHNhaWQgYWJvdmUuIENhbid0IHdlIGxvb2sgYXQgdGhlIHNhdmVk
IHZlcnNpb24gPw0KPiANCj4gSUUuDQo+IA0KPiAgLSBPbiBpbnRlcnJ1cHQgZW50cnk6DQo+IA0K
PiAJKiBTYXZlIENSIHRvIENDUihyMSkNCj4gCSogY2xlYXIgQ1I1DQo+IA0KPiAgLSBPbiBleGl0
DQo+IA0KPiAJKiBDaGVjayBDQ1IocjEpJ3MgQ1I1IGZpZWxkDQo+IAkqIHJlc3RvcmUgQ1INCg0K
QWN0dWFsbHkgdGhlcmUgaXMgbm8gcmVhbCByZWFzb24gd2h5IHRoZSAnZml4dXAnIGNhbid0IGJl
IGRvbmUNCmR1cmluZyBpbnRlcnJ1cHQgZW50cnkuDQoNCglEYXZpZA0KDQo=
