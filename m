Date: Mon, 24 May 2004 11:53:29 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fixup for DEC 21154 bridge to allow CardBus support
In-Reply-To: <1085381211.24948.60.camel@gaston>
Message-ID: <Pine.LNX.4.60.0405241147300.7700@marabou.research.att.com>
References: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
 <1085363158.15315.11.camel@gaston>  <Pine.LNX.4.58.0405240031200.2676@portland.hansa.lan>
  <1085376973.14969.47.camel@gaston>  <Pine.LNX.4.58.0405240227210.3182@portland.hansa.lan>
 <1085381211.24948.60.camel@gaston>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-504042749-1085414009=:7700"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-504042749-1085414009=:7700
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello!

The improved patch is attached.  The bridge is configured to handle buses
from 1 to 255.  Since both the PCI ID and the machine type are checked and
255 is the maximal value, it should be safe not to read the original value
of the upper limit.  The quirk has been renamed to
pmac_pci_fixup_bus_range(), which describes better what is does.

--
Regards,
Pavel Roskin
--8323328-504042749-1085414009=:7700
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bus_range_fixup.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0405241153290.7700@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="bus_range_fixup.diff"

LS0tIGxpbnV4Lm9yaWcvYXJjaC9wcGMva2VybmVsL3BjaS5jDQorKysgbGlu
dXgvYXJjaC9wcGMva2VybmVsL3BjaS5jDQpAQCAtNDksNiArNDksNyBAQCBz
dGF0aWMgdm9pZCBmaXh1cF9jcGM3MTBfcGNpNjQoc3RydWN0IHBjDQogZXh0
ZXJuIHZvaWQgcG1hY19wY2lfZml4dXBfY2FyZGJ1cyhzdHJ1Y3QgcGNpX2Rl
diogZGV2KTsNCiBleHRlcm4gdm9pZCBwbWFjX3BjaV9maXh1cF9wY2lhdGEo
c3RydWN0IHBjaV9kZXYqIGRldik7DQogZXh0ZXJuIHZvaWQgcG1hY19wY2lf
Zml4dXBfazJfc2F0YShzdHJ1Y3QgcGNpX2RldiogZGV2KTsNCitleHRlcm4g
dm9pZCBwbWFjX3BjaV9maXh1cF9idXNfcmFuZ2Uoc3RydWN0IHBjaV9kZXYq
IGRldik7DQogI2VuZGlmDQogI2lmZGVmIENPTkZJR19QUENfT0YNCiBzdGF0
aWMgdTgqIHBjaV90b19PRl9idXNfbWFwOw0KQEAgLTcyLDYgKzczLDcgQEAg
c3RydWN0IHBjaV9maXh1cCBwY2liaW9zX2ZpeHVwc1tdID0gew0KICNpZmRl
ZiBDT05GSUdfUFBDX1BNQUMNCiAJLyogV2Ugc2hvdWxkIGFkZCBwZXItbWFj
aGluZSBmaXh1cCBzdXBwb3J0IGluIHh4eF9zZXR1cC5jIG9yIHh4eF9wY2ku
YyAqLw0KIAl7IFBDSV9GSVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9USSwJ
UENJX0FOWV9JRCwJCQlwbWFjX3BjaV9maXh1cF9jYXJkYnVzIH0sDQorCXsg
UENJX0ZJWFVQX0ZJTkFMLAlQQ0lfVkVORE9SX0lEX0RFQywJUENJX0RFVklD
RV9JRF9ERUNfMjExNTQsCXBtYWNfcGNpX2ZpeHVwX2J1c19yYW5nZSB9LA0K
IAl7IFBDSV9GSVhVUF9GSU5BTCwJUENJX0FOWV9JRCwJCVBDSV9BTllfSUQs
CQkJcG1hY19wY2lfZml4dXBfcGNpYXRhIH0sDQogCXsgUENJX0ZJWFVQX0hF
QURFUiwJUENJX1ZFTkRPUl9JRF9TRVJWRVJXT1JLUywgMHgwMjQwLAkJCXBt
YWNfcGNpX2ZpeHVwX2syX3NhdGEgfSwNCiAjZW5kaWYgLyogQ09ORklHX1BQ
Q19QTUFDICovDQotLS0gbGludXgub3JpZy9hcmNoL3BwYy9wbGF0Zm9ybXMv
cG1hY19wY2kuYw0KKysrIGxpbnV4L2FyY2gvcHBjL3BsYXRmb3Jtcy9wbWFj
X3BjaS5jDQpAQCAtMTAzNCw2ICsxMDM0LDE3IEBAIHZvaWQgcG1hY19wY2lf
Zml4dXBfY2FyZGJ1cyhzdHJ1Y3QgcGNpX2QNCiAJfQ0KIH0NCiANCisvKiBC
eSBkZWZhdWx0IHRoZSBQQ0kgYnJpZGdlIG9uIEJsdWUmV2hpdGUgRzMgb25s
eSBoYW5kbGVzIGJ1cyAxLiAgIFRoaXMNCisgKiBmaXh1cCBhbGxvd3MgYWNj
ZXNzIHRvIGhpZ2hlciBidXNlcyBpbiBjYXNlIGlmIFBDSSBvciBDYXJkYnVz
IGJyaWRnZQ0KKyAqIGlzIGFkZGVkIHRvIHRoZSBzeXN0ZW0uICAqLw0KK3Zv
aWQgcG1hY19wY2lfZml4dXBfYnVzX3JhbmdlKHN0cnVjdCBwY2lfZGV2KiBk
ZXYpDQorew0KKwlpZiAoIW1hY2hpbmVfaXNfY29tcGF0aWJsZSgiUG93ZXJN
YWMxLDEiKSkNCisJCXJldHVybjsNCisNCisJcGNpX3dyaXRlX2NvbmZpZ19i
eXRlKGRldiwgUENJX1NVQk9SRElOQVRFX0JVUywgMjU1KTsNCit9DQorDQog
dm9pZCBwbWFjX3BjaV9maXh1cF9wY2lhdGEoc3RydWN0IHBjaV9kZXYqIGRl
dikNCiB7DQogICAgICAgIHU4IHByb2dpZiA9IDA7DQo=

--8323328-504042749-1085414009=:7700--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
