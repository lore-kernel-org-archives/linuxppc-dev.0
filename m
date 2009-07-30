Return-Path: <mmlnx@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62EBBB7BC9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 08:33:29 +1000 (EST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1631DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 08:33:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UMSfFh027872
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 16:28:41 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UMXOD9116892
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 16:33:24 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UMXNN9017700
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 16:33:24 -0600
Message-ID: <4A721FB1.4040903@us.ibm.com>
Date: Thu, 30 Jul 2009 15:33:21 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org, linasvepstas@gmail.com,
	benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] Support for PCI Express reset type
Content-Type: multipart/mixed; boundary="------------060005030804020901050303"
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
--------------060005030804020901050303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is the first of three patches that implement a bit field that PCI Express device drivers can use to indicate they need a fundamental reset during error recovery.

By default, the EEH framework on powerpc does what's known as a "hot reset" during recovery of a PCI Express device.  We've found a case where the device needs a "fundamental reset" to recover properly.  The current PCI error recovery and EEH frameworks do not support this distinction.

The attached patch (courtesy of Richard Lary) adds a bit field to pci_dev that indicates whether the device requires a fundamental reset during recovery.

These patches supersede the previously submitted patch that implemented a fundamental reset bit field. 

Please review and let me know of any concerns.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
Signed-off-by: Richard Lary <rlary@us.ibm.com>
 


--------------060005030804020901050303
Content-Type: text/plain;
 name="pci_fundamental_reset.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pci_fundamental_reset.patch"

ZGlmZiAtdU5ycCBhL2luY2x1ZGUvbGludXgvcGNpLmggYi9pbmNsdWRlL2xpbnV4L3BjaS5o
DQotLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oCTIwMDktMDctMTMgMTQ6MjU6MzcuMDAwMDAw
MDAwIC0wNzAwDQorKysgYi9pbmNsdWRlL2xpbnV4L3BjaS5oCTIwMDktMDctMTUgMTA6MjU6
MzcuMDAwMDAwMDAwIC0wNzAwDQpAQCAtMjczLDYgKzI3Myw3IEBAIHN0cnVjdCBwY2lfZGV2
IHsNCiAJdW5zaWduZWQgaW50CWFyaV9lbmFibGVkOjE7CS8qIEFSSSBmb3J3YXJkaW5nICov
DQogCXVuc2lnbmVkIGludAlpc19tYW5hZ2VkOjE7DQogCXVuc2lnbmVkIGludAlpc19wY2ll
OjE7DQorCXVuc2lnbmVkIGludCAgICBuZWVkc19mcmVzZXQ6MTsgLyogRGV2IHJlcXVpcmVz
IGZ1bmRhbWVudGFsIHJlc2V0ICovDQogCXVuc2lnbmVkIGludAlzdGF0ZV9zYXZlZDoxOw0K
IAl1bnNpZ25lZCBpbnQJaXNfcGh5c2ZuOjE7DQogCXVuc2lnbmVkIGludAlpc192aXJ0Zm46
MTsNCg==
--------------060005030804020901050303--
