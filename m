Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 1FA5A14008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 23:00:39 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 15728-07 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 26 Mar 2014 12:00:34 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicolin Chen' <Guangyu.Chen@freescale.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Wed, 26 Mar 2014 11:59:53 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E958E@AcuExch.aculab.com>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
In-Reply-To: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogTmljb2xpbiBDaGVuDQo+IEl0J3MgcXVpdGUgY3JpY2lhbCB0byBjbGVhciBlcnJvciBm
bGFncyBiZWNhdXNlIFNBSSBtaWdodCBoYW5nIGlmIGdldHRpbmcNCj4gRklGTyB1bmRlcnJ1biBk
dXJpbmcgcGxheWJhY2sgKEkgaGF2ZW4ndCBjb25maXJtZWQgdGhlIHNhbWUgaXNzdWUgb24gUngN
Cj4gb3ZlcmZsb3cgdGhvdWdoKS4NCj4gDQo+IFNvIHRoaXMgcGF0Y2ggZW5hYmxlcyB0aG9zZSBp
cnEgYW5kIGFkZHMgaXNyKCkgdG8gY2xlYXIgdGhlIGZsYWdzIHNvIGFzIHRvDQo+IGtlZXAgcGxh
eWJhY2sgZW50aXJlbHkgc2FmZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8
R3Vhbmd5dS5DaGVuQGZyZWVzY2FsZS5jb20+DQo+IC0tLQ0KPiAgc291bmQvc29jL2ZzbC9mc2xf
c2FpLmMgfCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tDQo+ICBzb3VuZC9zb2MvZnNsL2ZzbF9zYWkuaCB8ICA5ICsrKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQo+
IGluZGV4IGM0YTQyMzEuLjVmOTFhZmYgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9mc2wvZnNs
X3NhaS5jDQo+ICsrKyBiL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQo+IEBAIC0yMyw2ICsyMyw1
NSBAQA0KPiANCj4gICNpbmNsdWRlICJmc2xfc2FpLmgiDQo+IA0KPiArI2RlZmluZSBGU0xfU0FJ
X0ZMQUdTIChGU0xfU0FJX0NTUl9TRUlFIHxcDQo+ICsJCSAgICAgICBGU0xfU0FJX0NTUl9GRUlF
IHxcDQo+ICsJCSAgICAgICBGU0xfU0FJX0NTUl9GV0lFKQ0KPiArDQo+ICtzdGF0aWMgaXJxcmV0
dXJuX3QgZnNsX3NhaV9pc3IoaW50IGlycSwgdm9pZCAqZGV2aWQpDQo+ICt7DQo+ICsJc3RydWN0
IGZzbF9zYWkgKnNhaSA9IChzdHJ1Y3QgZnNsX3NhaSAqKWRldmlkOw0KPiArCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZzYWktPnBkZXYtPmRldjsNCj4gKwl1MzIgeGNzcjsNCj4gKw0KPiArCXJlZ21h
cF9yZWFkKHNhaS0+cmVnbWFwLCBGU0xfU0FJX1RDU1IsICZ4Y3NyKTsNCj4gKwlyZWdtYXBfd3Jp
dGUoc2FpLT5yZWdtYXAsIEZTTF9TQUlfVENTUiwgeGNzcik7DQoNCkFzc3VtaW5nIHRoZXNlIGFy
ZSAnd3JpdGUgdG8gY2xlYXInIGJpdHMsIHlvdSBtaWdodCB3YW50DQp0byBtYWtlIHRoZSB3cml0
ZSAoYWJvdmUpIGFuZCBhbGwgdGhlIHRyYWNlcyAoYmVsb3cpDQpjb25kaXRpb25hbCBvbiB0aGUg
dmFsdWUgYmVpbmcgbm9uLXplcm8uDQoNCj4gKwlpZiAoeGNzciAmIEZTTF9TQUlfQ1NSX1dTRikN
Cj4gKwkJZGV2X2RiZyhkZXYsICJpc3I6IFN0YXJ0IG9mIFR4IHdvcmQgZGV0ZWN0ZWRcbiIpOw0K
PiArDQo+ICsJaWYgKHhjc3IgJiBGU0xfU0FJX0NTUl9TRUYpDQo+ICsJCWRldl9kYmcoZGV2LCAi
aXNyOiBUeCBGcmFtZSBzeW5jIGVycm9yIGRldGVjdGVkXG4iKTsNCj4gKw0KPiArCWlmICh4Y3Ny
ICYgRlNMX1NBSV9DU1JfRkVGKQ0KPiArCQlkZXZfZGJnKGRldiwgImlzcjogVHJhbnNtaXQgdW5k
ZXJydW4gZGV0ZWN0ZWRcbiIpOw0KPiArDQo+ICsJaWYgKHhjc3IgJiBGU0xfU0FJX0NTUl9GV0Yp
DQo+ICsJCWRldl9kYmcoZGV2LCAiaXNyOiBFbmFibGVkIHRyYW5zbWl0IEZJRk8gaXMgZW1wdHlc
biIpOw0KPiArDQo+ICsJaWYgKHhjc3IgJiBGU0xfU0FJX0NTUl9GUkYpDQo+ICsJCWRldl9kYmco
ZGV2LCAiaXNyOiBUcmFuc21pdCBGSUZPIHdhdGVybWFyayBoYXMgYmVlbiByZWFjaGVkXG4iKTsN
Cg0KU29tZSBvZiB0aG9zZSBsb29rIGxpa2UgJ25vcm1hbCcgaW50ZXJydXB0cywgb3RoZXJzIGFy
ZSBjbGVhcmx5DQphYm5vcm1hbCBjb25kaXRpb25zLg0KTWF5YmUgdGhlIHRyYWNpbmcgc2hvdWxk
IHJlZmxlY3QgdGhpcy4NCg0KPiArDQo+ICsJcmVnbWFwX3JlYWQoc2FpLT5yZWdtYXAsIEZTTF9T
QUlfUkNTUiwgJnhjc3IpOw0KPiArCXJlZ21hcF93cml0ZShzYWktPnJlZ21hcCwgRlNMX1NBSV9S
Q1NSLCB4Y3NyKTsNCg0KU2FtZSBjb21tZW50cyBhcHBseS4uLg0KDQoJRGF2aWQNCg0K
