Return-Path: <mmlnx@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7C302B7BD9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 08:42:45 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 050C0DDDA2
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 08:42:44 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UMers6009603
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 16:40:53 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UMgf1h197630
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 16:42:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UMgfGB006668
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 16:42:41 -0600
Message-ID: <4A7221DF.5040402@us.ibm.com>
Date: Thu, 30 Jul 2009 15:42:39 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org, linasvepstas@gmail.com,
	benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] Support for PCI Express reset type
References: <4A722121.4010307@us.ibm.com>
In-Reply-To: <4A722121.4010307@us.ibm.com>
Content-Type: multipart/mixed; boundary="------------030805050604000501020405"
Cc: Richard Lary <rlary@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030805050604000501020405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is the third of three patches that implement a bit field that PCI Express device drivers can use to indicate they need a fundamental reset during error recovery.

By default, the EEH framework on powerpc does what's known as a "hot reset" during recovery of a PCI Express device.  We've found a case where the device needs a "fundamental reset" to recover properly.  The current PCI error recovery and EEH frameworks do not support this distinction.

The attached patch makes changes to EEH to utilize the new bit field.

These patches supersede the previously submitted patch that implemented a fundamental reset bit field.

Please review and let me know of any concerns.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
Signed-off-by: Richard Lary <rlary@us.ibm.com>


--------------030805050604000501020405
Content-Type: text/plain;
 name="eeh_fundamental_reset.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="eeh_fundamental_reset.patch"

ZGlmZiAtdU5ycCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvcGNpXzY0LmMgYi9hcmNoL3Bvd2Vy
cGMva2VybmVsL3BjaV82NC5jDQotLS0gYS9hcmNoL3Bvd2VycGMva2VybmVsL3BjaV82NC5j
CTIwMDktMDctMTMgMTQ6MjU6MjQuMDAwMDAwMDAwIC0wNzAwDQorKysgYi9hcmNoL3Bvd2Vy
cGMva2VybmVsL3BjaV82NC5jCTIwMDktMDctMTUgMTA6MjY6MjYuMDAwMDAwMDAwIC0wNzAw
DQpAQCAtMTQzLDYgKzE0Myw3IEBAIHN0cnVjdCBwY2lfZGV2ICpvZl9jcmVhdGVfcGNpX2Rl
dihzdHJ1Y3QNCiAJZGV2LT5kZXYuYnVzID0gJnBjaV9idXNfdHlwZTsNCiAJZGV2LT5kZXZm
biA9IGRldmZuOw0KIAlkZXYtPm11bHRpZnVuY3Rpb24gPSAwOwkJLyogbWF5YmUgYSBsaWU/
ICovDQorCWRldi0+bmVlZHNfZnJlc2V0ID0gMDsgICAgICAgLyogcGNpZSBmdW5kYW1lbnRh
bCByZXNldCByZXF1aXJlZCAqLw0KDQogCWRldi0+dmVuZG9yID0gZ2V0X2ludF9wcm9wKG5v
ZGUsICJ2ZW5kb3ItaWQiLCAweGZmZmYpOw0KIAlkZXYtPmRldmljZSA9IGdldF9pbnRfcHJv
cChub2RlLCAiZGV2aWNlLWlkIiwgMHhmZmZmKTsNCmRpZmYgLXVOcnAgYS9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL3BzZXJpZXMvZWVoLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bz
ZXJpZXMvZWVoLmMNCi0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9lZWgu
YwkyMDA5LTA2LTA5IDIwOjA1OjI3LjAwMDAwMDAwMCAtMDcwMA0KKysrIGIvYXJjaC9wb3dl
cnBjL3BsYXRmb3Jtcy9wc2VyaWVzL2VlaC5jCTIwMDktMDctMTUgMTA6Mjk6MDQuMDAwMDAw
MDAwIC0wNzAwDQpAQCAtNzQ0LDcgKzc0NCwxNSBAQCBpbnQgcGNpYmlvc19zZXRfcGNpZV9y
ZXNldF9zdGF0ZShzdHJ1Y3QNCg0KIHN0YXRpYyB2b2lkIF9fcnRhc19zZXRfc2xvdF9yZXNl
dChzdHJ1Y3QgcGNpX2RuICpwZG4pDQogew0KLQlydGFzX3BjaV9zbG90X3Jlc2V0IChwZG4s
IDEpOw0KKwlzdHJ1Y3QgcGNpX2RldiAqZGV2ID0gcGRuLT5wY2lkZXY7DQorDQorCS8qIERl
dGVybWluZSB0eXBlIG9mIEVFSCByZXNldCByZXF1aXJlZCBieSBkZXZpY2UsDQorCSAqIGRl
ZmF1bHQgaG90IHJlc2V0IG9yIGZ1bmRhbWVudGFsIHJlc2V0DQorCSAqLw0KKwlpZiAoZGV2
LT5uZWVkc19mcmVzZXQpDQorCQlydGFzX3BjaV9zbG90X3Jlc2V0KHBkbiwgMyk7DQorCWVs
c2UNCisJCXJ0YXNfcGNpX3Nsb3RfcmVzZXQocGRuLCAxKTsNCg0KIAkvKiBUaGUgUENJIGJ1
cyByZXF1aXJlcyB0aGF0IHRoZSByZXNldCBiZSBoZWxkIGhpZ2ggZm9yIGF0IGxlYXN0DQog
CSAqIGEgMTAwIG1pbGxpc2Vjb25kcy4gV2Ugd2FpdCBhIGJpdCBsb25nZXIgJ2p1c3QgaW4g
Y2FzZScuICAqLw==
--------------030805050604000501020405--
