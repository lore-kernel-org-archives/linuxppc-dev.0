Message-ID: <3F869E9B.9020208@siemens.com>
Date: Fri, 10 Oct 2003 13:57:15 +0200
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: cfi_cmdset_0002.c: MTD do_write_oneword(): Wacky!  Unable to decode
 failure status
Content-Type: multipart/mixed;
 boundary="------------090707010003080007070708"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090707010003080007070708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm using the 2.4.20 kernel running on a TQM8260 board,
with FUJITSU 29LV652UE90 flash chips.

Sometimes a have seen the following problem inside MTD's
do_write_oneword() and do_erase_oneblock() functions:

    + After starting the erase/write operation, the function
      waits until the flash chips have indicated the end of
      the operation (via dq6 or dq7).

    + After that, the function makes some kind of control read
      in order to check the correctness of the operation.

    + Sometimes this control read fails.


When I make the control read more lazy and try it multiple times (see attached patch),
the problem disappears. The contents of the flash is always correct.

As far as I know, the control read is not performed by the PPCboot.

Has anybody seen the same problem ?


Thanks

--


--------------------------------------------------------------

Steffen Rumler
ICN CP D NT SW 7
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------





--------------090707010003080007070708
Content-Type: text/plain;
 name="cfi_cmdset_0002.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cfi_cmdset_0002.patch"

ZGlmZiAtTmF1ciBvbGQvY2ZpX2NtZHNldF8wMDAyLmMgbmV3L2NmaV9jbWRzZXRfMDAwMi5j
Ci0tLSBvbGQvY2ZpX2NtZHNldF8wMDAyLmMJRnJpIE9jdCAxMCAxMzo0NjoyMiAyMDAzCisr
KyBuZXcvY2ZpX2NtZHNldF8wMDAyLmMJRnJpIE9jdCAxMCAxMzo0NTo1OCAyMDAzCkBAIC00
NzIsNiArNDcyLDcgQEAKIAogCWNmaV93b3JkIG9sZHN0YXR1cywgc3RhdHVzLCBwcmV2X29s
ZHN0YXR1cywgcHJldl9zdGF0dXM7CiAJY2ZpX3dvcmQgZHE2OworICAgICAgICBpbnQgaTsK
IAogICAgIC8qIFdlIHVzZSBhIDFtcyArIDEgamlmZmllcyBnZW5lcmljIHRpbWVvdXQgZm9y
IHdyaXRlcyAobW9zdCBkZXZpY2VzIGhhdmUKICAgICAgICBhIG1heCB3cml0ZSB0aW1lIG9m
IGEgZmV3IGh1bmRyZWRzIHVzZWMpLiBIb3dldmVyLCB3ZSBzaG91bGQgdXNlIHRoZQpAQCAt
NjE4LDE3ICs2MTksMjEgQEAKIAkgKiBiaXRzIGFyZW4ndCBzdGlsbCBjaGFuZ2luZyAgYW5k
IHRoYXQgdGhlIHN0YXR1cwogCSAqIGJpdHMgZXJyb25lb3VzbHkgbWF0Y2ggdGhlIGRhdHVt
IHRoYXQgd2FzIHdyaXR0ZW4uCiAJICovCi0JcHJldl9vbGRzdGF0dXMgPSBvbGRzdGF0dXM7
Ci0JcHJldl9zdGF0dXMgPSBzdGF0dXM7Ci0Jb2xkc3RhdHVzID0gY2ZpX3JlYWQobWFwLCBh
ZHIpOwotCXN0YXR1cyA9IGNmaV9yZWFkKG1hcCwgYWRyKTsKLQlERUJVRyggTVREX0RFQlVH
X0xFVkVMMywgIk1URCAlcygpOiBDaGVjayAweCUuOHggMHglLjh4XG4iLAotCSAgICAgICBf
X2Z1bmNfXywgb2xkc3RhdHVzLCBzdGF0dXMgKTsKLQotCWlmICggb2xkc3RhdHVzID09IGRh
dHVtICYmIHN0YXR1cyA9PSBkYXR1bSApIHsKLQkJLyogc3VjY2VzcyAtIGRvIG5vdGhpbmcg
Ki8KLQkJZ290byB3cml0ZV9kb25lOwotCX0KKyAgICAgICAgZm9yKGk9MDsgaTwxMDsgaSsr
KXsKKyAgICAgICAgICAgIAorICAgICAgICAgICAgcHJldl9vbGRzdGF0dXMgPSBvbGRzdGF0
dXM7CisgICAgICAgICAgICBwcmV2X3N0YXR1cyA9IHN0YXR1czsKKyAgICAgICAgICAgIG9s
ZHN0YXR1cyA9IGNmaV9yZWFkKG1hcCwgYWRyKTsKKyAgICAgICAgICAgIHN0YXR1cyA9IGNm
aV9yZWFkKG1hcCwgYWRyKTsKKyAgICAgICAgICAgIERFQlVHKCBNVERfREVCVUdfTEVWRUwz
LCAiTVREICVzKCk6IENoZWNrIDB4JS44eCAweCUuOHhcbiIsCisgICAgICAgICAgICAgICAg
ICAgIF9fZnVuY19fLCBvbGRzdGF0dXMsIHN0YXR1cyApOworCisgICAgICAgICAgICBpZiAo
IG9sZHN0YXR1cyA9PSBkYXR1bSAmJiBzdGF0dXMgPT0gZGF0dW0gKSB7CisgICAgICAgICAg
ICAgICAgLyogc3VjY2VzcyAtIGRvIG5vdGhpbmcgKi8KKyAgICAgICAgICAgICAgICBnb3Rv
IHdyaXRlX2RvbmU7CisgICAgICAgICAgICB9CisgICAgICAgICAgICB1ZGVsYXkoMSk7Cisg
ICAgICAgIH0KIAogCWlmICggdGEgKSB7CiAJCWNmaV93b3JkIGRxNW1hc2sgPSAoICggc3Rh
dHVzIF4gb2xkc3RhdHVzICkgJiBkcTYgKSA+PiAxOwpAQCAtMTEyNSw3ICsxMTMwLDYgQEAK
IAkgICAgICAgX19mdW5jX18sIHN0YXR1cyApOwogCiAJd2hpbGUoICgoc3RhdHVzICYgZHE3
KSAhPSBkcTcpICYmIAotCSAgICAgICAoKHN0YXR1cyAmIGRxNSkgIT0gZHE1KSAmJgogCQkh
KCB0YSA9IHRpbWVfYWZ0ZXIoamlmZmllcywgdGltZW8pICkpIHsKIAkJaW50IHdhaXRfcmVw
czsKIApAQCAtMTE3NCwyOSArMTE3OCwzNCBAQAogCQlERUJVRyggTVREX0RFQlVHX0xFVkVM
MywgIk1URCAlcygpOiBDaGVjayAweCUuOHhcbiIsCiAJCSAgICAgICBfX2Z1bmNfXywgc3Rh
dHVzICk7CiAJfQotCXByZXZfc3RhdHVzICAgICA9IHN0YXR1czsKLQlzdGF0dXMgICAgICAg
ICAgPSBjZmlfcmVhZChtYXAsIGFkcik7CiAKLQlERUJVRyggTVREX0RFQlVHX0xFVkVMMywg
Ik1URCAlcygpOiBDaGVjayAweCUuOHhcbiIsCi0JICAgICAgIF9fZnVuY19fLCBzdGF0dXMg
KTsKKyAgICAgICAgZm9yKGk9MDsgaTwxMDsgaSsrKXsKIAotCWlmICggY2ZpX2J1c3dpZHRo
X2lzXzEoKSApIHsKLQkJb25lcyA9ICAoX191OCl+MDsKLQl9IGVsc2UgaWYgKCBjZmlfYnVz
d2lkdGhfaXNfMigpICkgewotCQlvbmVzID0gKF9fdTE2KX4wOwotCX0gZWxzZSBpZiAoIGNm
aV9idXN3aWR0aF9pc180KCkgKSB7Ci0JCW9uZXMgPSAoX191MzIpfjA7Ci0JfSBlbHNlIGlm
ICggY2ZpX2J1c3dpZHRoX2lzXzgoKSApIHsKLQkJb25lcyA9IChfX3U2NCl+MDsKLQl9IGVs
c2UgewotCQlwcmludGsoS0VSTl9XQVJOSU5HICJVbnN1cHBvcnRlZCBidXN3aWR0aCAlZFxu
IixDRklERVZfQlVTV0lEVEgpOwotCQlnb3RvIGVyYXNlX2ZhaWxlZDsKLQl9CisgICAgICAg
ICAgICBwcmV2X3N0YXR1cyAgICAgPSBzdGF0dXM7CisgICAgICAgICAgICBzdGF0dXMgICAg
ICAgICAgPSBjZmlfcmVhZChtYXAsIGFkcik7CiAKLQlpZiAoIHByZXZfc3RhdHVzID09IG9u
ZXMgJiYgc3RhdHVzID09IG9uZXMgKSB7Ci0JCS8qIHN1Y2Nlc3MgLSBkbyBub3RoaW5nICov
Ci0JCWdvdG8gZXJhc2VfZG9uZTsKLQl9CisgICAgICAgICAgICBERUJVRyggTVREX0RFQlVH
X0xFVkVMMywgIk1URCAlcygpOiBDaGVjayAweCUuOHhcbiIsCisgICAgICAgICAgICAgICAg
ICAgIF9fZnVuY19fLCBzdGF0dXMgKTsKKworICAgICAgICAgICAgaWYgKCBjZmlfYnVzd2lk
dGhfaXNfMSgpICkgeworICAgICAgICAgICAgICAgIG9uZXMgPSAgKF9fdTgpfjA7CisgICAg
ICAgICAgICB9IGVsc2UgaWYgKCBjZmlfYnVzd2lkdGhfaXNfMigpICkgeworICAgICAgICAg
ICAgICAgIG9uZXMgPSAoX191MTYpfjA7CisgICAgICAgICAgICB9IGVsc2UgaWYgKCBjZmlf
YnVzd2lkdGhfaXNfNCgpICkgeworICAgICAgICAgICAgICAgIG9uZXMgPSAoX191MzIpfjA7
CisgICAgICAgICAgICB9IGVsc2UgaWYgKCBjZmlfYnVzd2lkdGhfaXNfOCgpICkgeworICAg
ICAgICAgICAgICAgIG9uZXMgPSAoX191NjQpfjA7CisgICAgICAgICAgICB9IGVsc2Ugewor
ICAgICAgICAgICAgICAgIHByaW50ayhLRVJOX1dBUk5JTkcgIlVuc3VwcG9ydGVkIGJ1c3dp
ZHRoICVkXG4iLENGSURFVl9CVVNXSURUSCk7CisgICAgICAgICAgICAgICAgZ290byBlcmFz
ZV9mYWlsZWQ7CisgICAgICAgICAgICB9CisKKyAgICAgICAgICAgIGlmICggcHJldl9zdGF0
dXMgPT0gb25lcyAmJiBzdGF0dXMgPT0gb25lcyApIHsKKyAgICAgICAgICAgICAgICAvKiBz
dWNjZXNzIC0gZG8gbm90aGluZyAqLworICAgICAgICAgICAgICAgIGdvdG8gZXJhc2VfZG9u
ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgICAgIHVkZWxheSgxKTsKKyAgICAgICAgfQog
CiAJaWYgKCB0YSApIHsKIAkJY2ZpX3dvcmQgZHE1bWFzayA9ICggKCBzdGF0dXMgXiBwcmV2
X3N0YXR1cyApICYgZHE3ICkgPj4gMjsK
--------------090707010003080007070708--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
